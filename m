From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 4/6] add support for analog loopback to
	STAC9204/9205/922x/927x
Date: Mon, 3 Sep 2007 15:19:47 +0300
Message-ID: <200709031519.47667.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id E521210391D
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:20:16 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1483258fka
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:20:16 -0700 (PDT)
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

>From ea1a7a5a8113f8c39db8391226adbbe383f03355 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:18:17 +0300
Subject: [PATCH] add support for analog loopback to STAC9204/9205/922x/927x

The analog loopback routes the sound just before it enters ADC0 to output of DAC0

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/patch_sigmatel.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 297f740..c94775c 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -147,6 +147,7 @@ struct sigmatel_spec {
 	/* i/o switches */
 	unsigned int io_switch[2];
 	unsigned int clfe_swap;
+	unsigned int aloopback;
 
 	struct hda_pcm pcm_rec[2];	/* PCM information */
 
@@ -296,6 +297,49 @@ static int stac92xx_mux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 				     spec->mux_nids[adc_idx], &spec->cur_mux[adc_idx]);
 }
 
+#define stac92xx_aloopback_info snd_ctl_boolean_mono_info
+
+static int stac92xx_aloopback_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	ucontrol->value.integer.value[0] = spec->aloopback;
+	return 0;
+}
+
+static int stac92xx_aloopback_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int dac_mode;
+
+	if (spec->aloopback == ucontrol->value.integer.value[0])
+		return 0;
+
+	spec->aloopback = ucontrol->value.integer.value[0];
+
+
+	dac_mode = snd_hda_codec_read(codec, codec->afg, 0,
+		kcontrol->private_value & 0xFFFF, 0x0);
+
+	if (spec->aloopback) {
+		snd_hda_power_up(codec);
+		dac_mode |= 0x40;
+	} else {
+		snd_hda_power_down(codec);
+		dac_mode &= ~0x40;
+	}
+
+	snd_hda_codec_write_cache(codec, codec->afg, 0,
+		kcontrol->private_value >> 16, dac_mode);
+
+	return 1;
+}
+
+
 static struct hda_verb stac9200_core_init[] = {
 	/* set dac0mux for dac converter */
 	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
@@ -346,6 +390,17 @@ static struct hda_verb stac9205_core_init[] = {
 		.put = stac92xx_mux_enum_put, \
 	}
 
+#define STAC_ANALOG_LOOPBACK(verb_read,verb_write) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name  = "Analog Loopback", \
+		.count = 1, \
+		.info  = stac92xx_aloopback_info, \
+		.get   = stac92xx_aloopback_get, \
+		.put   = stac92xx_aloopback_put, \
+		.private_value = verb_read | (verb_write << 16), \
+	}
+
 
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
@@ -377,6 +432,7 @@ static struct snd_kcontrol_new stac922x_mixer[] = {
 /* This needs to be generated dynamically based on sequence */
 static struct snd_kcontrol_new stac9227_mixer[] = {
 	STAC_INPUT_SOURCE,
+	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
 	{ } /* end */
@@ -384,6 +440,7 @@ static struct snd_kcontrol_new stac9227_mixer[] = {
 
 static struct snd_kcontrol_new stac927x_mixer[] = {
 	STAC_INPUT_SOURCE,
+	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
 	HDA_CODEC_VOLUME("InMux Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
@@ -400,6 +457,7 @@ static struct snd_kcontrol_new stac9205_mixer[] = {
 		.put = stac92xx_dmux_enum_put,
 	},
 	STAC_INPUT_SOURCE,
+	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
 	HDA_CODEC_VOLUME("InMux Capture Volume", 0x19, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("InVol Capture Volume", 0x1b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1d, 0x0, HDA_OUTPUT),
-- 
1.5.2.3
