From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: lowland: Support digital link for WM9081
Date: Tue,  8 May 2012 11:16:38 +0100
Message-ID: <1336472198-16444-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D59F42414C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 12:20:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM9081 on Lowland is connected to AIF3 on the WM5100.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/lowland.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 6cac1e9..6abf341 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -74,6 +74,25 @@ static int lowland_wm5100_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int lowland_wm9081_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+
+	snd_soc_dapm_nc_pin(&codec->dapm, "LINEOUT");
+
+	/* At any time the WM9081 is active it will have this clock */
+	return snd_soc_codec_set_sysclk(codec, WM9081_SYSCLK_MCLK, 0,
+					CLKOUT_RATE, 0);
+}
+
+static const struct snd_soc_pcm_stream sub_params = {
+	.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	.rate_min = 44100,
+	.rate_max = 44100,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
 static struct snd_soc_dai_link lowland_dai[] = {
 	{
 		.name = "CPU",
@@ -96,21 +115,16 @@ static struct snd_soc_dai_link lowland_dai[] = {
 				SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
 	},
-};
-
-static int lowland_wm9081_init(struct snd_soc_dapm_context *dapm)
-{
-	snd_soc_dapm_nc_pin(dapm, "LINEOUT");
-
-	/* At any time the WM9081 is active it will have this clock */
-	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
-					CLKOUT_RATE, 0);
-}
-
-static struct snd_soc_aux_dev lowland_aux_dev[] = {
 	{
-		.name = "wm9081",
+		.name = "Sub Speaker",
+		.stream_name = "Sub Speaker",
+		.cpu_dai_name = "wm5100-aif3",
+		.codec_dai_name = "wm9081-hifi",
 		.codec_name = "wm9081.1-006c",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBM_CFM,
+		.ignore_suspend = 1,
+		.params = &sub_params,
 		.init = lowland_wm9081_init,
 	},
 };
@@ -155,8 +169,6 @@ static struct snd_soc_card lowland = {
 	.owner = THIS_MODULE,
 	.dai_link = lowland_dai,
 	.num_links = ARRAY_SIZE(lowland_dai),
-	.aux_dev = lowland_aux_dev,
-	.num_aux_devs = ARRAY_SIZE(lowland_aux_dev),
 	.codec_conf = lowland_codec_conf,
 	.num_configs = ARRAY_SIZE(lowland_codec_conf),
 
-- 
1.7.10
