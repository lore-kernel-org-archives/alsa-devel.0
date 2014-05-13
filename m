From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Add a new quirk match based on
	default pin configuration
Date: Tue, 13 May 2014 10:36:46 +0200
Message-ID: <1399970206-10269-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C2A726538B
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 10:36:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, hui.wang@canonical.com, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Normally, we match on pci ssid only. This works but needs new code
for every machine. To catch more machines in the same quirk, let's add
a new type of quirk, where we match on
 1) PCI Subvendor ID (i e, not device, just vendor)
 2) Codec ID
 3) Pin configuration default

If all these three match, we could be reasonably certain that the
quirk should apply to the machine even though it might not be the
exact same device.

In case a quirk matches both the pci ssid quirk and this type of quirk,
then the pci ssid quirk is chosen.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Hi Takashi,

Do you think this could be working? If so I'll ask Hui to move some machines over
and come up with a patch for that. Two questions:

 1) I'm unsure if the "name" entry makes sense here - I mean, since the same quirk
    hopefully matches many machines, we can't use the machine name here. Should I
    just skip it?

 2) Should I make a macro (like SND_PCI_QUIRK) to make the actual pinquirk tables look
    more compact?

 sound/pci/hda/hda_auto_parser.c | 39 ++++++++++++++++++++++++++++++++++-----
 sound/pci/hda/hda_local.h       | 27 +++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 90d2fda..6904779 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -839,10 +839,22 @@ void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 }
 EXPORT_SYMBOL_GPL(snd_hda_apply_fixup);
 
-void snd_hda_pick_fixup(struct hda_codec *codec,
-			const struct hda_model_fixup *models,
-			const struct snd_pci_quirk *quirk,
-			const struct hda_fixup *fixlist)
+static bool pin_config_match(struct hda_codec *codec,
+			     const struct hda_pintbl *pins)
+{
+	for (; pins->nid; pins++) {
+		u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
+		if (pins->val != def_conf)
+			return false;
+	}
+	return true;
+}
+
+void snd_hda_pick_pin_fixup(struct hda_codec *codec,
+			    const struct hda_model_fixup *models,
+			    const struct snd_pci_quirk *quirk,
+			    const struct snd_hda_pin_quirk *pin_quirk,
+			    const struct hda_fixup *fixlist)
 {
 	const struct snd_pci_quirk *q;
 	int id = -1;
@@ -889,10 +901,27 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		}
 	}
 
+	if (id < 0 && pin_quirk) {
+		const struct snd_hda_pin_quirk *pq;
+		for (pq = pin_quirk; pq->subvendor; pq++) {
+			if (codec->bus->pci->subsystem_vendor != pq->subvendor)
+				continue;
+			if (codec->vendor_id != pq->codec)
+				continue;
+			if (pin_config_match(codec, pq->pins)) {
+				id = pq->value;
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+				name = pq->name;
+#endif
+				break;
+			}
+		}
+	}
+
 	codec->fixup_id = id;
 	if (id >= 0) {
 		codec->fixup_list = fixlist;
 		codec->fixup_name = name;
 	}
 }
-EXPORT_SYMBOL_GPL(snd_hda_pick_fixup);
+EXPORT_SYMBOL_GPL(snd_hda_pick_pin_fixup);
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index e51d155..41a6817 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -425,15 +425,34 @@ enum {
 	HDA_FIXUP_ACT_FREE,
 };
 
+struct snd_hda_pin_quirk {
+	unsigned int codec;             /* Codec vendor/device ID */
+	unsigned short subvendor;	/* PCI subvendor ID */
+	const struct hda_pintbl *pins;  /* list of matching pins */
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+	const char *name;
+#endif
+	int value;			/* quirk value */
+};
+
 int snd_hda_add_verbs(struct hda_codec *codec, const struct hda_verb *list);
 void snd_hda_apply_verbs(struct hda_codec *codec);
 void snd_hda_apply_pincfgs(struct hda_codec *codec,
 			   const struct hda_pintbl *cfg);
 void snd_hda_apply_fixup(struct hda_codec *codec, int action);
-void snd_hda_pick_fixup(struct hda_codec *codec,
-			const struct hda_model_fixup *models,
-			const struct snd_pci_quirk *quirk,
-			const struct hda_fixup *fixlist);
+void snd_hda_pick_pin_fixup(struct hda_codec *codec,
+			    const struct hda_model_fixup *models,
+			    const struct snd_pci_quirk *quirk,
+			    const struct snd_hda_pin_quirk *pin_quirk,
+			    const struct hda_fixup *fixlist);
+
+static inline void snd_hda_pick_fixup(struct hda_codec *codec,
+				      const struct hda_model_fixup *models,
+				      const struct snd_pci_quirk *quirk,
+				      const struct hda_fixup *fixlist)
+{
+	snd_hda_pick_pin_fixup(codec, models, quirk, NULL, fixlist);
+}
 
 /*
  * unsolicited event handler
-- 
1.9.1
