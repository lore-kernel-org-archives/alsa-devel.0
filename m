From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/17] ASoC: Intel: bytcr_rt5640: add SSP2_AIF2
	routing
Date: Fri, 12 Aug 2016 16:27:50 -0500
Message-ID: <1471037280-17433-8-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C56C2266011
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:47 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Add quirk to model routing on Baytrail-CR devices

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 54 +++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 085e57f..6c6f673 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -42,6 +42,7 @@ enum {
 #define BYT_RT5640_DMIC_EN	BIT(16)
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
 #define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
+#define BYT_RT5640_SSP2_AIF2     BIT(19) /* default is using AIF1  */
 
 static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_DMIC_EN;
@@ -54,13 +55,6 @@ static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
-	{"AIF1 Playback", NULL, "ssp2 Tx"},
-	{"ssp2 Tx", NULL, "codec_out0"},
-	{"ssp2 Tx", NULL, "codec_out1"},
-	{"codec_in0", NULL, "ssp2 Rx"},
-	{"codec_in1", NULL, "ssp2 Rx"},
-	{"ssp2 Rx", NULL, "AIF1 Capture"},
-
 	{"Headset Mic", NULL, "MICBIAS1"},
 	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
@@ -80,6 +74,26 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif1_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif2_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"AIF2 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Rx", NULL, "AIF2 Capture"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_stereo_spk_map[] = {
 	{"Speaker", NULL, "SPOLP"},
 	{"Speaker", NULL, "SPOLN"},
@@ -213,6 +227,18 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_ssp2_aif2_map,
+					ARRAY_SIZE(byt_rt5640_ssp2_aif2_map));
+	} else {
+		ret = snd_soc_dapm_add_routes(&card->dapm,
+					byt_rt5640_ssp2_aif1_map,
+					ARRAY_SIZE(byt_rt5640_ssp2_aif1_map));
+	}
+	if (ret)
+		return ret;
+
 	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) {
 		ret = snd_soc_dapm_add_routes(&card->dapm,
 					byt_rt5640_mono_spk_map,
@@ -346,7 +372,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
-		.codec_dai_name = "rt5640-aif1",
+		.codec_dai_name = "rt5640-aif1", /* changed w/ quirk */
 		.codec_name = "i2c-10EC5640:00", /* overwritten with HID */
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
@@ -373,6 +399,7 @@ static struct snd_soc_card byt_rt5640_card = {
 };
 
 static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
@@ -407,6 +434,17 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 
+	if (byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) {
+
+		/* fixup codec aif name */
+		snprintf(byt_rt5640_codec_aif_name,
+			sizeof(byt_rt5640_codec_aif_name),
+			"%s", "rt5640-aif2");
+
+		byt_rt5640_dais[dai_index].codec_dai_name =
+			byt_rt5640_codec_aif_name;
+	}
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
2.5.0
