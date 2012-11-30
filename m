From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: hda - Add Auto-Mic Mode enum to
	Realtek codecs
Date: Fri, 30 Nov 2012 09:16:00 +0100
Message-ID: <1354263363-25398-3-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354263363-25398-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 99258265CA4
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:16:22 +0100 (CET)
In-Reply-To: <1354263363-25398-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Add another enum control to allow user explicitly enabling/disabling
the automatic capture source selection via jack detection.
This is a pretty similar like Auto-Mute Mode, but for inputs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 909a623..aa32dd9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -924,6 +924,57 @@ static const struct snd_kcontrol_new alc_automute_mode_enum = {
 	.put = alc_automute_mode_put,
 };
 
+/*
+ * Auto-Mic mode mixer enum support
+ */
+static int alc_automic_mode_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = {
+		"Disabled", "Enabled"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int alc_automic_mode_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->auto_mic;
+	return 0;
+}
+
+static int alc_automic_mode_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	unsigned int val = !!ucontrol->value.enumerated.item[0];
+
+	if (spec->auto_mic == val)
+		return 0;
+	spec->auto_mic = val;
+	alc_mic_automute(codec, NULL);
+	return 1;
+}
+
+static const struct snd_kcontrol_new alc_automic_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Auto-Mic Mode",
+	.info = alc_automic_mode_info,
+	.get = alc_automic_mode_get,
+	.put = alc_automic_mode_put,
+};
+
 static struct snd_kcontrol_new *
 alc_kcontrol_new(struct alc_spec *spec, const char *name,
 		 const struct snd_kcontrol_new *temp)
@@ -1185,6 +1236,8 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 		    spec->am_entry[0].pin,
 		    spec->am_entry[1].pin,
 		    spec->am_entry[2].pin);
+
+	alc_kcontrol_new(spec, "Auto-Mic Mode", &alc_automic_mode_enum);
 }
 
 /* check the availabilities of auto-mute and auto-mic switches */
-- 
1.8.0.1
