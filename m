From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix clicking noise on Thinkpad
	T61/R61i
Date: Wed, 12 Dec 2012 18:02:04 +0100
Message-ID: <1355331724-2758-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FC6260202
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 18:02:08 +0100 (CET)
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
Cc: 886975@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The bug reporter reports that setting the speaker pin to
D3 before turning off its pinctl fixes the clicking noise on
powersave for Thinkpad T61.

Thanks to c4pp4 for doing most of the work with this bug, including
reporting and testing, and writing preliminary patches.

BugLink: https://bugs.launchpad.net/bugs/886975
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

Note: c4pp4 pointed out that in his case, only the speaker needed to go to
D3 before pinctl, but noticed no regressions from the below implementation,
so I made the fixup more generic (easier to reuse later).

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a3a2263..27e6ca7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -144,6 +144,7 @@ struct conexant_spec {
 	unsigned int asus:1;
 	unsigned int pin_eapd_ctrls:1;
 	unsigned int fixup_stereo_dmic:1;
+	unsigned int d3_before_shutup:1; /* Needs speaker to go to D3 before pinctl */
 
 	unsigned int adc_switching:1;
 
@@ -558,13 +559,22 @@ static int conexant_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int conexant_suspend(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
+
+	if (spec->d3_before_shutup)
+		snd_hda_codec_set_power_to_all(codec, codec->afg, AC_PWRST_D3,
+					       false);
 	snd_hda_shutup_pins(codec);
 	return 0;
 }
-#endif
+
+static void conexant_reboot_notify(struct hda_codec *codec)
+{
+	conexant_suspend(codec);
+}
+
 
 static const struct hda_codec_ops conexant_patch_ops = {
 	.build_controls = conexant_build_controls,
@@ -575,7 +585,7 @@ static const struct hda_codec_ops conexant_patch_ops = {
 #ifdef CONFIG_PM
 	.suspend = conexant_suspend,
 #endif
-	.reboot_notify = snd_hda_shutup_pins,
+	.reboot_notify = conexant_reboot_notify,
 };
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
@@ -4408,7 +4418,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 #ifdef CONFIG_PM
 	.suspend = conexant_suspend,
 #endif
-	.reboot_notify = snd_hda_shutup_pins,
+	.reboot_notify = conexant_reboot_notify,
 };
 
 /*
@@ -4421,6 +4431,7 @@ enum {
 	CXT_PINCFG_LEMOTE_A1205,
 	CXT_FIXUP_STEREO_DMIC,
 	CXT_FIXUP_INC_MIC_BOOST,
+	CXT_FIXUP_D3_BEFORE_SHUTUP,
 };
 
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
@@ -4430,6 +4441,13 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 	spec->fixup_stereo_dmic = 1;
 }
 
+static void cxt_fixup_d3_before_shutup(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+	spec->d3_before_shutup = 1;
+}
+
 static void cxt5066_increase_mic_boost(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
@@ -4499,6 +4517,15 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt5066_increase_mic_boost,
 	},
+	[CXT_FIXUP_D3_BEFORE_SHUTUP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_d3_before_shutup,
+	},
+};
+
+static const struct snd_pci_quirk cxt5045_fixups[] = {
+	SND_PCI_QUIRK(0x17aa, 0x20ac, "Lenovo T61/R61i", CXT_FIXUP_D3_BEFORE_SHUTUP),
+	{}
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
@@ -4553,6 +4580,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	switch (codec->vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
+		snd_hda_pick_fixup(codec, NULL, cxt5045_fixups, cxt_fixups);
 		break;
 	case 0x14f15051:
 		add_cx5051_fake_mutes(codec);
-- 
1.7.9.5
