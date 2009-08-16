From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: enable speaker output of HP 2510p
Date: Sun, 16 Aug 2009 17:05:13 +0800
Message-ID: <20090816090513.GA25325@localhost>
References: <20090816085317.GA23959@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 16AAD24368
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 11:11:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090816085317.GA23959@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Speaker/HP volumes of 2510p is binded, so shall the mute state.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_analog.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_analog.c	2009-08-16 16:59:20.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_analog.c	2009-08-16 17:01:34.000000000 +0800
@@ -1512,7 +1512,7 @@ static struct hda_verb ad1981_hp_init_ve
 	{}
 };
 
-/* turn on/off EAPD (+ mute HP) as a master switch */
+/* turn on/off EAPD (+ mute Speaker/HP) as a master switch */
 static int ad1981_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
@@ -1525,7 +1525,10 @@ static int ad1981_hp_master_sw_put(struc
 	snd_hda_codec_write(codec, 0x05, 0,
 			    AC_VERB_SET_PIN_WIDGET_CONTROL,
 			    spec->cur_eapd ? PIN_OUT : 0);
-	/* toggle HP mute appropriately */
+	/* toggle Speaker/HP mute appropriately */
+	snd_hda_codec_amp_stereo(codec, 0x05, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE,
+				 spec->cur_eapd ? 0 : HDA_AMP_MUTE);
 	snd_hda_codec_amp_stereo(codec, 0x06, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE,
 				 spec->cur_eapd ? 0 : HDA_AMP_MUTE);
@@ -1724,6 +1727,7 @@ static struct snd_pci_quirk ad1981_cfg_t
 	SND_PCI_QUIRK(0x1014, 0x0597, "Lenovo Z60", AD1981_THINKPAD),
 	SND_PCI_QUIRK(0x1014, 0x05b7, "Lenovo Z60m", AD1981_THINKPAD),
 	/* All HP models */
+	SND_PCI_QUIRK(0x103c, 0x30c9, "HP 2510p", AD1981_HP),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP nx", AD1981_HP),
 	SND_PCI_QUIRK(0x1179, 0x0001, "Toshiba U205", AD1981_TOSHIBA),
 	/* Lenovo Thinkpad T60/X60/Z6xx */
