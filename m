From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/2] ALSA: ASoC: support more sample rates on
	raumfeld devices
Date: Fri, 15 Jan 2010 17:36:49 +0100
Message-ID: <1263573409-30863-2-git-send-email-daniel@caiaq.de>
References: <20100113162749.GA26519@sirena.org.uk>
	<1263573409-30863-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FE3010392D
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 17:37:11 +0100 (CET)
In-Reply-To: <1263573409-30863-1-git-send-email-daniel@caiaq.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Add support for sample rates other than 44100Khz on raumfeld audio
devices. At startup time, call snd_soc_dai_set_sysclk() with 0 as 'freq'
argument so it offers all the sample rates. Later, the function is
called again to give proper constraints.

Use the external audio clock generator to provide double data rate
clocks as the PXA's internal baud generator does anything but what's
described in the datasheets.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
---
 sound/soc/pxa/raumfeld.c |   61 ++++++++++++++++++++++++++++++----------------
 1 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index e713181..66e0dd8 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -41,7 +41,9 @@ static struct i2c_board_info max9486_hwmon_info = {
 };
 
 #define MAX9485_MCLK_FREQ_112896 0x22
-#define	MAX9485_MCLK_FREQ_122880 0x23
+#define MAX9485_MCLK_FREQ_122880 0x23
+#define MAX9485_MCLK_FREQ_225792 0x32
+#define MAX9485_MCLK_FREQ_245760 0x33
 
 static void set_max9485_clk(char clk)
 {
@@ -71,9 +73,17 @@ static int raumfeld_cs4270_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 
-	set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+	/* set freq to 0 to enable all possible codec sample rates */
+	return snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
+}
 
-	return snd_soc_dai_set_sysclk(codec_dai, 0, 11289600, 0);
+static void raumfeld_cs4270_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	/* set freq to 0 to enable all possible codec sample rates */
+	snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
 }
 
 static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
@@ -86,20 +96,24 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
+	case 44100:
+		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+		clk = 11289600;
+		break;
 	case 48000:
-	case 96000:
 		set_max9485_clk(MAX9485_MCLK_FREQ_122880);
 		clk = 12288000;
 		break;
-	case 11025:
-	case 22050:
-	case 44100:
 	case 88200:
-		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
-		clk = 11289600;
+		set_max9485_clk(MAX9485_MCLK_FREQ_225792);
+		clk = 22579200;
 		break;
+	case 96000:
+		set_max9485_clk(MAX9485_MCLK_FREQ_245760);
+		clk = 24576000;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	fmt = SND_SOC_DAIFMT_I2S |
@@ -128,7 +142,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, 0, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
 	if (ret < 0)
 		return ret;
 
@@ -137,6 +151,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 
 static struct snd_soc_ops raumfeld_cs4270_ops = {
 	.startup = raumfeld_cs4270_startup,
+	.shutdown = raumfeld_cs4270_shutdown,
 	.hw_params = raumfeld_cs4270_hw_params,
 };
 
@@ -181,20 +196,24 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 	int fmt, ret = 0, clk = 0;
 
 	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
+	case 44100:
+		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
+		clk = 11289600;
+		break;
 	case 48000:
-	case 96000:
 		set_max9485_clk(MAX9485_MCLK_FREQ_122880);
 		clk = 12288000;
 		break;
-	case 11025:
-	case 22050:
-	case 44100:
 	case 88200:
-		set_max9485_clk(MAX9485_MCLK_FREQ_112896);
-		clk = 11289600;
+		set_max9485_clk(MAX9485_MCLK_FREQ_225792);
+		clk = 22579200;
+		break;
+	case 96000:
+		set_max9485_clk(MAX9485_MCLK_FREQ_245760);
+		clk = 24576000;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
@@ -217,7 +236,7 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, 0, 1);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_EXT, clk, 1);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.5.2
