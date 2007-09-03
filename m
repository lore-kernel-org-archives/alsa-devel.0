From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 5/6] make volume knob,
	the master volume for sigmatel codecs that support it
Date: Mon, 3 Sep 2007 15:20:26 +0300
Message-ID: <200709031520.26546.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A274110391F
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:20:53 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id d21so1439837nfb
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:20:52 -0700 (PDT)
In-Reply-To: <200709031514.57875.maximlevitsky@gmail.com>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

>From f1a1841750108ec025c807f1ae3718d55baa8d00 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:24:47 +0300
Subject: [PATCH] make volume knob, the master volume for sigmatel codecs that support it

VolumeKnob is present on most sigmatel codecs, it allows to decrease volume of all DACs at once,
it is a kind of post-procesing volume.
Note that all output amps of sigmatel only decrease volume, and all input amps only increase volume

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/patch_sigmatel.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index c94775c..a2b1dd5 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -339,6 +339,39 @@ static int stac92xx_aloopback_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static int stac92xx_volknob_info(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 127;
+	return 0;
+}
+
+static int stac92xx_volknob_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+	return 0;
+}
+
+static int stac92xx_volknob_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	if (kcontrol->private_value == ucontrol->value.integer.value[0])
+		return 0;
+
+	kcontrol->private_value = ucontrol->value.integer.value[0];
+
+	snd_hda_codec_write_cache(codec, 0x24, 0,
+		AC_VERB_SET_VOLUME_KNOB_CONTROL,
+			kcontrol->private_value | 0x80);
+	return 1;
+}
+
 
 static struct hda_verb stac9200_core_init[] = {
 	/* set dac0mux for dac converter */
@@ -401,6 +434,17 @@ static struct hda_verb stac9205_core_init[] = {
 		.private_value = verb_read | (verb_write << 16), \
 	}
 
+#define STAC_VOLKNOB \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name  = "Master Playback Volume", \
+		.count = 1, \
+		.info  = stac92xx_volknob_info, \
+		.get   = stac92xx_volknob_get, \
+		.put   = stac92xx_volknob_put, \
+		.private_value = 127, \
+	}
+
 
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
@@ -423,6 +467,7 @@ static struct snd_kcontrol_new stac925x_mixer[] = {
 /* This needs to be generated dynamically based on sequence */
 static struct snd_kcontrol_new stac922x_mixer[] = {
 	STAC_INPUT_SOURCE,
+	STAC_VOLKNOB,
 	HDA_CODEC_VOLUME("Capture Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mux Capture Volume", 0x12, 0x0, HDA_OUTPUT),
@@ -432,6 +477,7 @@ static struct snd_kcontrol_new stac922x_mixer[] = {
 /* This needs to be generated dynamically based on sequence */
 static struct snd_kcontrol_new stac9227_mixer[] = {
 	STAC_INPUT_SOURCE,
+	STAC_VOLKNOB,
 	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
@@ -440,6 +486,7 @@ static struct snd_kcontrol_new stac9227_mixer[] = {
 
 static struct snd_kcontrol_new stac927x_mixer[] = {
 	STAC_INPUT_SOURCE,
+	STAC_VOLKNOB,
 	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
 	HDA_CODEC_VOLUME("InMux Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
@@ -458,6 +505,7 @@ static struct snd_kcontrol_new stac9205_mixer[] = {
 	},
 	STAC_INPUT_SOURCE,
 	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
+	STAC_VOLKNOB,
 	HDA_CODEC_VOLUME("InMux Capture Volume", 0x19, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("InVol Capture Volume", 0x1b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1d, 0x0, HDA_OUTPUT),
-- 
1.5.2.3
