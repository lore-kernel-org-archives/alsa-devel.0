From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 6/6] Fix support for sigmatel codecs that have
	2 or more ADCs
Date: Mon, 3 Sep 2007 15:21:01 +0300
Message-ID: <200709031521.01592.maximlevitsky@gmail.com>
References: <200709031514.57875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F40103925
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 15:21:30 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so642728wri
	for <alsa-devel@alsa-project.org>; Mon, 03 Sep 2007 06:21:29 -0700 (PDT)
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

>From a9771c6b2f84583c5154cdc8e266cdaab3076720 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Mon, 3 Sep 2007 14:27:57 +0300
Subject: [PATCH] Fix support for sigmatel codecs that have 2 or more ADCs

1) Create seperate mixer controls for each ADC
2) Make number of substreams of capture PCM device be equal to number of ADCs

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 pci/hda/patch_sigmatel.c |   97 +++++++++++++++++++++++++++-------------------
 1 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index a2b1dd5..6dffa54 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -413,11 +413,11 @@ static struct hda_verb stac9205_core_init[] = {
 	{}
 };
 
-#define STAC_INPUT_SOURCE \
+#define STAC_INPUT_SOURCE(cnt) \
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 		.name = "Input Source", \
-		.count = 1, \
+		.count = cnt, \
 		.info = stac92xx_mux_enum_info, \
 		.get = stac92xx_mux_enum_get, \
 		.put = stac92xx_mux_enum_put, \
@@ -449,7 +449,7 @@ static struct hda_verb stac9205_core_init[] = {
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
-	STAC_INPUT_SOURCE,
+	STAC_INPUT_SOURCE(1),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
@@ -457,58 +457,68 @@ static struct snd_kcontrol_new stac9200_mixer[] = {
 };
 
 static struct snd_kcontrol_new stac925x_mixer[] = {
-	STAC_INPUT_SOURCE,
+	STAC_INPUT_SOURCE(1),
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
 	{ } /* end */
 };
 
-/* This needs to be generated dynamically based on sequence */
-static struct snd_kcontrol_new stac922x_mixer[] = {
-	STAC_INPUT_SOURCE,
+static struct snd_kcontrol_new stac9205_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Digital Input Source",
+		.count = 1,
+		.info = stac92xx_dmux_enum_info,
+		.get = stac92xx_dmux_enum_get,
+		.put = stac92xx_dmux_enum_put,
+	},
+	STAC_INPUT_SOURCE(2),
+	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
 	STAC_VOLKNOB,
-	HDA_CODEC_VOLUME("Capture Volume", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mux Capture Volume", 0x12, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x0, 0x19, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1c, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1e, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x1, 0x1A, 0x0, HDA_OUTPUT),
+
 	{ } /* end */
 };
 
 /* This needs to be generated dynamically based on sequence */
-static struct snd_kcontrol_new stac9227_mixer[] = {
-	STAC_INPUT_SOURCE,
+static struct snd_kcontrol_new stac922x_mixer[] = {
+	STAC_INPUT_SOURCE(2),
 	STAC_VOLKNOB,
-	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
-	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x0, 0x12, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x1, 0x13, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
+
 static struct snd_kcontrol_new stac927x_mixer[] = {
-	STAC_INPUT_SOURCE,
+	STAC_INPUT_SOURCE(3),
 	STAC_VOLKNOB,
 	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
-	HDA_CODEC_VOLUME("InMux Capture Volume", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
-	{ } /* end */
-};
 
-static struct snd_kcontrol_new stac9205_mixer[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Digital Input Source",
-		.count = 1,
-		.info = stac92xx_dmux_enum_info,
-		.get = stac92xx_dmux_enum_get,
-		.put = stac92xx_dmux_enum_put,
-	},
-	STAC_INPUT_SOURCE,
-	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
-	STAC_VOLKNOB,
-	HDA_CODEC_VOLUME("InMux Capture Volume", 0x19, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("InVol Capture Volume", 0x1b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1b, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x0, 0x15, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x19, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x1, 0x16, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x2, 0x1A, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x2, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x2, 0x17, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -1410,10 +1420,9 @@ static struct hda_pcm_stream stac92xx_pcm_analog_alt_playback = {
 };
 
 static struct hda_pcm_stream stac92xx_pcm_analog_capture = {
-	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
-	/* NID is set in stac92xx_build_pcms */
+	/* NID + .substreams is set in stac92xx_build_pcms */
 	.ops = {
 		.prepare = stac92xx_capture_pcm_prepare,
 		.cleanup = stac92xx_capture_pcm_cleanup
@@ -1432,6 +1441,7 @@ static int stac92xx_build_pcms(struct hda_codec *codec)
 	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = stac92xx_pcm_analog_playback;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE] = stac92xx_pcm_analog_capture;
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = spec->num_adcs;
 
 	if (spec->alt_switch) {
 		codec->num_pcms++;
@@ -2478,6 +2488,7 @@ static int patch_stac9200(struct hda_codec *codec)
 	spec->mux_nids = stac9200_mux_nids;
 	spec->num_muxes = 1;
 	spec->num_dmics = 0;
+	spec->num_adcs = 1;
 
 	spec->init = stac9200_core_init;
 	spec->mixer = stac9200_mixer;
@@ -2529,6 +2540,7 @@ static int patch_stac925x(struct hda_codec *codec)
 	spec->adc_nids = stac925x_adc_nids;
 	spec->mux_nids = stac925x_mux_nids;
 	spec->num_muxes = 1;
+	spec->num_adcs = 1;
 	switch (codec->vendor_id) {
 	case 0x83847632: /* STAC9202  */
 	case 0x83847633: /* STAC9202D */
@@ -2632,6 +2644,7 @@ static int patch_stac922x(struct hda_codec *codec)
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
 	spec->num_muxes = ARRAY_SIZE(stac922x_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac922x_adc_nids);
 	spec->num_dmics = 0;
 
 	spec->init = stac922x_core_init;
@@ -2700,22 +2713,25 @@ static int patch_stac927x(struct hda_codec *codec)
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
+		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
 		spec->num_dmics = 0;
 		spec->init = d965_core_init;
-		spec->mixer = stac9227_mixer;
+		spec->mixer = stac927x_mixer;
 		break;
 	case STAC_D965_5ST:
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
+		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
 		spec->num_dmics = 0;
 		spec->init = d965_core_init;
-		spec->mixer = stac9227_mixer;
+		spec->mixer = stac927x_mixer;
 		break;
 	default:
 		spec->adc_nids = stac927x_adc_nids;
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
+		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
 		spec->num_dmics = 0;
 		spec->init = stac927x_core_init;
 		spec->mixer = stac927x_mixer;
@@ -2776,6 +2792,7 @@ static int patch_stac9205(struct hda_codec *codec)
 	}
 
 	spec->adc_nids = stac9205_adc_nids;
+	spec->num_adcs = ARRAY_SIZE(stac9205_adc_nids);
 	spec->mux_nids = stac9205_mux_nids;
 	spec->num_muxes = ARRAY_SIZE(stac9205_mux_nids);
 	spec->dmic_nids = stac9205_dmic_nids;
-- 
1.5.2.3
