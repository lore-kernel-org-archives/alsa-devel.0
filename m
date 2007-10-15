From: zhejiang <zhe.jiang@intel.com>
Subject: intel-hda patch for sigmatel codec volume knob
Date: Mon, 15 Oct 2007 15:29:30 +0800
Message-ID: <1192433370.10218.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E466D24562
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 09:30:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

I found that STAC_VOLKNOB hardwired the KNOB nid to 0x24.
It is okay for stac9205 and stac927x.
But the VolumeKnob nid of stac9220-9221 is 0x16.


diff -Nur a/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
b/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
--- a/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
2007-09-21 16:41:28.000000000 +0800
+++ b/alsa-driver-1.0.15rc3/alsa-kernel/pci/hda/patch_sigmatel.c
2007-10-15 15:13:14.000000000 +0800
@@ -351,7 +351,7 @@
 static int stac92xx_volknob_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	ucontrol->value.integer.value[0] = kcontrol->private_value;
+	ucontrol->value.integer.value[0] = kcontrol->private_value & 0xFFFF;
 	return 0;
 }
 
@@ -360,14 +360,15 @@
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 
-	if (kcontrol->private_value == ucontrol->value.integer.value[0])
+	if ((kcontrol->private_value & 0xFFFF) ==
ucontrol->value.integer.value[0])
 		return 0;
 
-	kcontrol->private_value = ucontrol->value.integer.value[0];
+	kcontrol->private_value &= 0xFFFF0000;
+	kcontrol->private_value += ucontrol->value.integer.value[0];
 
-	snd_hda_codec_write_cache(codec, 0x24, 0,
+	snd_hda_codec_write_cache(codec, kcontrol->private_value >> 16, 0,
 		AC_VERB_SET_VOLUME_KNOB_CONTROL,
-			kcontrol->private_value | 0x80);
+			(kcontrol->private_value & 0xFFFF) | 0x80);
 	return 1;
 }
 
@@ -433,7 +434,7 @@
 		.private_value = verb_read | (verb_write << 16), \
 	}
 
-#define STAC_VOLKNOB \
+#define STAC_VOLKNOB(knob_nid) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 		.name  = "Master Playback Volume", \
@@ -441,7 +442,7 @@
 		.info  = stac92xx_volknob_info, \
 		.get   = stac92xx_volknob_get, \
 		.put   = stac92xx_volknob_put, \
-		.private_value = 127, \
+		.private_value = 127 | (knob_nid << 16), \
 	}
 
 
@@ -474,7 +475,7 @@
 	},
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
-	STAC_VOLKNOB,
+	STAC_VOLKNOB(0x24),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1d, 0x0, HDA_OUTPUT),
@@ -490,7 +491,7 @@
 /* This needs to be generated dynamically based on sequence */
 static struct snd_kcontrol_new stac922x_mixer[] = {
 	STAC_INPUT_SOURCE(2),
-	STAC_VOLKNOB,
+	STAC_VOLKNOB(0x16),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x0, 0x12, 0x0,
HDA_OUTPUT),
@@ -504,7 +505,7 @@
 
 static struct snd_kcontrol_new stac927x_mixer[] = {
 	STAC_INPUT_SOURCE(3),
-	STAC_VOLKNOB,
+	STAC_VOLKNOB(0x24),
 	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x18, 0x0, HDA_INPUT),
