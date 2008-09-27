From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ASoC Blackfin: add I2S DAI support for
	AD73311
Date: Sat, 27 Sep 2008 22:30:15 +0800
Message-ID: <1222525815-3688-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 29272243C0
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 16:29:51 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so552174tid.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 07:29:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   47 ++++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 43a4092..827587f 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -70,6 +70,13 @@ static struct sport_param sport_params[2] = {
 	}
 };
 
+static u16 sport_req[][7] = {
+		{ P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
+		  P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0},
+		{ P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS,
+		  P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0},
+};
+
 static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -78,6 +85,14 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* interface format:support I2S,slave mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+		bf5xx_i2s.tcr1 |= TFSR | TCKFE;
+		bf5xx_i2s.rcr1 |= RFSR | RCKFE;
+		bf5xx_i2s.tcr2 |= TSFSE;
+		bf5xx_i2s.rcr2 |= RSFSE;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		bf5xx_i2s.tcr1 |= TFSR;
+		bf5xx_i2s.rcr1 |= RFSR;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		ret = -EINVAL;
@@ -127,14 +142,17 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bf5xx_i2s.tcr2 |= 15;
 		bf5xx_i2s.rcr2 |= 15;
+		sport_handle->wdsize = 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		bf5xx_i2s.tcr2 |= 23;
 		bf5xx_i2s.rcr2 |= 23;
+		sport_handle->wdsize = 3;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		bf5xx_i2s.tcr2 |= 31;
 		bf5xx_i2s.rcr2 |= 31;
+		sport_handle->wdsize = 4;
 		break;
 	}
 
@@ -145,17 +163,17 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		 * need to configure both of them at the time when the first
 		 * stream is opened.
 		 *
-		 * CPU DAI format:I2S, slave mode.
+		 * CPU DAI:slave mode.
 		 */
-		ret = sport_config_rx(sport_handle, RFSR | RCKFE,
-				      RSFSE|bf5xx_i2s.rcr2, 0, 0);
+		ret = sport_config_rx(sport_handle, bf5xx_i2s.rcr1,
+				      bf5xx_i2s.rcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
 
-		ret = sport_config_tx(sport_handle, TFSR | TCKFE,
-				      TSFSE|bf5xx_i2s.tcr2, 0, 0);
+		ret = sport_config_tx(sport_handle, bf5xx_i2s.tcr1,
+				      bf5xx_i2s.tcr2, 0, 0);
 		if (ret) {
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
@@ -174,13 +192,6 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream)
 static int bf5xx_i2s_probe(struct platform_device *pdev,
 			   struct snd_soc_dai *dai)
 {
-	u16 sport_req[][7] = {
-		{ P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-		  P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0},
-		{ P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS,
-		  P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0},
-	};
-
 	pr_debug("%s enter\n", __func__);
 	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
 		pr_err("Requesting Peripherals failed\n");
@@ -198,6 +209,13 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static void bf5xx_i2s_remove(struct platform_device *pdev,
+			   struct snd_soc_dai *dai)
+{
+	pr_debug("%s enter\n", __func__);
+	peripheral_free_list(&sport_req[sport_num][0]);
+}
+
 #ifdef CONFIG_PM
 static int bf5xx_i2s_suspend(struct platform_device *dev,
 			     struct snd_soc_dai *dai)
@@ -263,15 +281,16 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
 	.probe = bf5xx_i2s_probe,
+	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
 	.resume = bf5xx_i2s_resume,
 	.playback = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = BF5XX_I2S_RATES,
 		.formats = BF5XX_I2S_FORMATS,},
-- 
1.5.6
