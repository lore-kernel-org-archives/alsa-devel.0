From: Kevin Cheng <kevin.cheng@intel.com>
Subject: [PATCH v2 1/2] ASoC: Intel: Add Kabylake machine
	driver for RT5663
Date: Thu, 27 Jul 2017 16:38:36 +0800
Message-ID: <20170727083837.3793-2-kevin.cheng@intel.com>
References: <20170727083837.3793-1-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B681C266D87
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 10:38:50 +0200 (CEST)
In-Reply-To: <20170727083837.3793-1-kevin.cheng@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: kevin.cheng@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds Kabylake I2S machine driver which uses
RT5663 as headset on ssp1.

Signed-off-by: Kevin Cheng <kevin.cheng@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 246 +++++++++++++++++++++++----
 1 file changed, 209 insertions(+), 37 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index f9ba97788157..090331bd6900 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -34,7 +34,7 @@
 #define MAXIM_DEV0_NAME "i2c-MX98927:00"
 #define MAXIM_DEV1_NAME "i2c-MX98927:01"
 
-static struct snd_soc_card kabylake_audio_card;
+static struct snd_soc_card *kabylake_audio_card;
 static const struct snd_pcm_hw_constraint_list *dmic_constraints;
 static struct snd_soc_jack skylake_hdmi[3];
 
@@ -117,6 +117,49 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "iDisp1 Tx", NULL, "iDisp1_out"},
 };
 
+enum {
+	KBL_DPCM_AUDIO_5663_PB = 0,
+	KBL_DPCM_AUDIO_5663_CP,
+	KBL_DPCM_AUDIO_5663_HDMI1_PB,
+	KBL_DPCM_AUDIO_5663_HDMI2_PB,
+};
+
+static const struct snd_kcontrol_new kabylake_5663_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget kabylake_5663_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("DP", NULL),
+	SND_SOC_DAPM_SPK("HDMI", NULL),
+};
+
+static const struct snd_soc_dapm_route kabylake_5663_map[] = {
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+
+	/* other jacks */
+	{ "IN1P", NULL, "Headset Mic" },
+	{ "IN1N", NULL, "Headset Mic" },
+
+	{ "HDMI", NULL, "hif5 Output" },
+	{ "DP", NULL, "hif6 Output" },
+
+	/* CODEC BE connections */
+	{ "AIF Playback", NULL, "ssp1 Tx" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
+
+	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "ssp1 Rx", NULL, "AIF Capture" },
+
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+};
+
 static struct snd_soc_codec_conf max98927_codec_conf[] = {
 	{
 		.dev_name = MAXIM_DEV0_NAME,
@@ -165,7 +208,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 * Headset buttons map to the google Reference headset.
 	 * These can be configured by userspace.
 	 */
-	ret = snd_soc_card_jack_new(&kabylake_audio_card, "Headset Jack",
+	ret = snd_soc_card_jack_new(kabylake_audio_card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 			SND_JACK_BTN_2 | SND_JACK_BTN_3, &ctx->kabylake_headset,
 			NULL, 0);
@@ -173,8 +216,18 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
 	}
-
 	rt5663_set_jack_detect(codec, &ctx->kabylake_headset);
+	return ret;
+}
+
+static int kabylake_rt5663_max98927_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+
+	ret = kabylake_rt5663_codec_init(rtd);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
 	if (ret) {
 		dev_err(rtd->dev, "SoC DMIC ignore suspend failed %d\n", ret);
@@ -184,7 +237,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+static int kabylake_hdmi_init(struct snd_soc_pcm_runtime *rtd, int device)
 {
 	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai = rtd->codec_dai;
@@ -194,7 +247,7 @@ static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	if (!pcm)
 		return -ENOMEM;
 
-	pcm->device = KBL_DPCM_AUDIO_HDMI1_PB;
+	pcm->device = device;
 	pcm->codec_dai = dai;
 
 	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
@@ -202,40 +255,29 @@ static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int kabylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+static int kabylake_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct kbl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = KBL_DPCM_AUDIO_HDMI2_PB;
-	pcm->codec_dai = dai;
-
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI1_PB);
+}
 
-	return 0;
+static int kabylake_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI2_PB);
 }
 
 static int kabylake_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct kbl_hdmi_pcm *pcm;
-
-	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
-	if (!pcm)
-		return -ENOMEM;
-
-	pcm->device = KBL_DPCM_AUDIO_HDMI3_PB;
-	pcm->codec_dai = dai;
+	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_HDMI3_PB);
+}
 
-	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+static int kabylake_5663_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_5663_HDMI1_PB);
+}
 
-	return 0;
+static int kabylake_5663_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return kabylake_hdmi_init(rtd, KBL_DPCM_AUDIO_5663_HDMI2_PB);
 }
 
 static unsigned int rates[] = {
@@ -538,7 +580,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.no_pcm = 1,
 		.codec_name = "i2c-10EC5663:00",
 		.codec_dai_name = KBL_REALTEK_CODEC_DAI,
-		.init = kabylake_rt5663_codec_init,
+		.init = kabylake_rt5663_max98927_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
@@ -594,6 +636,108 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 	},
 };
 
+static struct snd_soc_dai_link kabylake_5663_dais[] = {
+	/* Front End DAI links */
+	[KBL_DPCM_AUDIO_5663_PB] = {
+		.name = "Kbl Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+		.ops = &kabylake_rt5663_fe_ops,
+	},
+	[KBL_DPCM_AUDIO_5663_CP] = {
+		.name = "Kbl Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+		.ops = &kabylake_rt5663_fe_ops,
+	},
+	[KBL_DPCM_AUDIO_5663_HDMI1_PB] = {
+		.name = "Kbl HDMI Port1",
+		.stream_name = "Hdmi1",
+		.cpu_dai_name = "HDMI1 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[KBL_DPCM_AUDIO_5663_HDMI2_PB] = {
+		.name = "Kbl HDMI Port2",
+		.stream_name = "Hdmi2",
+		.cpu_dai_name = "HDMI2 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP1 - Codec */
+		.name = "SSP1-Codec",
+		.id = 0,
+		.cpu_dai_name = "SSP1 Pin",
+		.platform_name = "0000:00:1f.3",
+		.no_pcm = 1,
+		.codec_name = "i2c-10EC5663:00",
+		.codec_dai_name = KBL_REALTEK_CODEC_DAI,
+		.init = kabylake_rt5663_codec_init,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = kabylake_ssp_fixup,
+		.ops = &kabylake_rt5663_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "iDisp1",
+		.id = 1,
+		.cpu_dai_name = "iDisp1 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = kabylake_5663_hdmi1_init,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp2",
+		.id = 2,
+		.cpu_dai_name = "iDisp2 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi2",
+		.platform_name = "0000:00:1f.3",
+		.init = kabylake_5663_hdmi2_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+};
+
 #define NAME_SIZE	32
 static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
@@ -624,7 +768,7 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 }
 
 /* kabylake audio machine driver for SPT + RT5663 */
-static struct snd_soc_card kabylake_audio_card = {
+static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.name = "kblrt5663max",
 	.owner = THIS_MODULE,
 	.dai_link = kabylake_dais,
@@ -641,6 +785,22 @@ static struct snd_soc_card kabylake_audio_card = {
 	.late_probe = kabylake_card_late_probe,
 };
 
+/* kabylake audio machine driver for RT5663 */
+static struct snd_soc_card kabylake_audio_card_rt5663 = {
+	.name = "kblrt5663",
+	.owner = THIS_MODULE,
+	.dai_link = kabylake_5663_dais,
+	.num_links = ARRAY_SIZE(kabylake_5663_dais),
+	.controls = kabylake_5663_controls,
+	.num_controls = ARRAY_SIZE(kabylake_5663_controls),
+	.dapm_widgets = kabylake_5663_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(kabylake_5663_widgets),
+	.dapm_routes = kabylake_5663_map,
+	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
+	.fully_routed = true,
+	.late_probe = kabylake_card_late_probe,
+};
+
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_rt5663_private *ctx;
@@ -652,19 +812,30 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	kabylake_audio_card.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&kabylake_audio_card, ctx);
+	kabylake_audio_card =
+		(struct snd_soc_card *)pdev->id_entry->driver_data;
+
+	kabylake_audio_card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
 	pdata = dev_get_drvdata(&pdev->dev);
 	if (pdata)
 		dmic_constraints = pdata->dmic_num == 2 ?
 			&constraints_dmic_2ch : &constraints_dmic_channels;
 
-	return devm_snd_soc_register_card(&pdev->dev, &kabylake_audio_card);
+	return devm_snd_soc_register_card(&pdev->dev, kabylake_audio_card);
 }
 
 static const struct platform_device_id kbl_board_ids[] = {
-	{ .name = "kbl_rt5663_m98927" },
+	{
+		.name = "kbl_rt5663",
+		.driver_data = (kernel_ulong_t)&kabylake_audio_card_rt5663,
+	},
+	{
+		.name = "kbl_rt5663_m98927",
+		.driver_data =
+			(kernel_ulong_t)&kabylake_audio_card_rt5663_m98927,
+	},
 	{ }
 };
 
@@ -684,4 +855,5 @@ MODULE_DESCRIPTION("Audio Machine driver-RT5663 & MAX98927 in I2S mode");
 MODULE_AUTHOR("Naveen M <naveen.m@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:kbl_rt5663");
 MODULE_ALIAS("platform:kbl_rt5663_m98927");
-- 
2.12.2
