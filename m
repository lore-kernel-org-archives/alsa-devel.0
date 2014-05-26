From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/5] ALSA: hda - Add a new quirk match based on
	default pin configuration
Date: Mon, 26 May 2014 16:22:41 +0800
Message-ID: <1401092564-14293-2-git-send-email-hui.wang@canonical.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D00D926087D
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 10:23:17 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so7370795pbb.17
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 01:23:16 -0700 (PDT)
In-Reply-To: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

From: David Henningsson <david.henningsson@canonical.com>

Normally, we match on pci ssid only. This works but needs new code
for every machine. To catch more machines in the same quirk, let's add
a new type of quirk, where we match on
 1) PCI Subvendor ID (i e, not device, just vendor)
 2) Codec ID
 3) Pin configuration default

If all these three match, we could be reasonably certain that the
quirk should apply to the machine even though it might not be the
exact same device.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 37 +++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_local.h       | 14 ++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 36961ab..a142753 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -839,6 +839,43 @@ void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 }
 EXPORT_SYMBOL_GPL(snd_hda_apply_fixup);
 
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
+			    const struct snd_hda_pin_quirk *pin_quirk,
+			    const struct hda_fixup *fixlist)
+{
+	const struct snd_hda_pin_quirk *pq;
+
+	if (codec->fixup_forced)
+		return;
+
+	for (pq = pin_quirk; pq->subvendor; pq++) {
+		if (codec->bus->pci->subsystem_vendor != pq->subvendor)
+			continue;
+		if (codec->vendor_id != pq->codec)
+			continue;
+		if (pin_config_match(codec, pq->pins)) {
+			codec->fixup_id = pq->value;
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+			codec->fixup_name = pq->name;
+#endif
+			codec->fixup_list = fixlist;
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hda_pick_pin_fixup);
+
 void snd_hda_pick_fixup(struct hda_codec *codec,
 			const struct hda_model_fixup *models,
 			const struct snd_pci_quirk *quirk,
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index e51d155..ebd1fa6 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -407,6 +407,16 @@ struct hda_fixup {
 	} v;
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
 /* fixup types */
 enum {
 	HDA_FIXUP_INVALID,
@@ -434,6 +444,10 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			const struct hda_model_fixup *models,
 			const struct snd_pci_quirk *quirk,
 			const struct hda_fixup *fixlist);
+void snd_hda_pick_pin_fixup(struct hda_codec *codec,
+			    const struct snd_hda_pin_quirk *pin_quirk,
+			    const struct hda_fixup *fixlist);
+
 
 /*
  * unsolicited event handler
-- 
1.8.1.2
