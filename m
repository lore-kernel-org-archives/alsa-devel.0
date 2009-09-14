From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] use set_channel_map api to reorder channels
	for AD1938 and AD1836
Date: Mon, 14 Sep 2009 14:13:07 +0800
Message-ID: <1252908787-32078-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 398F6243B2
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 08:12:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <Barry.Song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <Barry.Song@analog.com>

---
 sound/soc/blackfin/bf5xx-ad1836.c  |    7 +++++++
 sound/soc/blackfin/bf5xx-ad1938.c  |    9 ++++++++-
 sound/soc/blackfin/bf5xx-tdm-pcm.c |    7 +++++--
 sound/soc/blackfin/bf5xx-tdm.c     |   28 ++++++++++++++++++++--------
 sound/soc/blackfin/bf5xx-tdm.h     |   11 +++++++++++
 5 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index cd361e3..d3b41b7 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -52,6 +52,7 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int channel_map[8] = {0, 4, 1, 5, 2, 6, 3, 7};
 	int ret = 0;
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
@@ -65,6 +66,12 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/* set cpu DAI channel mapping */
+	ret = snd_soc_dai_set_channel_map(cpu_dai, 8, channel_map,
+			8, channel_map);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
diff --git a/sound/soc/blackfin/bf5xx-ad1938.c b/sound/soc/blackfin/bf5xx-ad1938.c
index 08269e9..686e84c 100644
--- a/sound/soc/blackfin/bf5xx-ad1938.c
+++ b/sound/soc/blackfin/bf5xx-ad1938.c
@@ -61,6 +61,7 @@ static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int channel_map[8] = {0, 1, 2, 3, 4, 5, 6, 7};
 	int ret = 0;
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
@@ -75,7 +76,13 @@ static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* set codec DAI slots, 8 channels, all channels are enabled */
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 8);
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI channel mapping */
+	ret = snd_soc_dai_set_channel_map(cpu_dai, 8, channel_map,
+			8, channel_map);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index ccb5e82..881a1d9 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -177,6 +177,9 @@ out:
 static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 	snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sport_device *sport = runtime->private_data;
+	struct bf5xx_tdm_port *tdm_port = sport->private_data;
 	unsigned int *src;
 	unsigned int *dst;
 	int i;
@@ -188,7 +191,7 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 		dst += pos * 8;
 		while (count--) {
 			for (i = 0; i < substream->runtime->channels; i++)
-				*(dst + i) = *src++;
+				*(dst + tdm_port->tx_map[i]) = *src++;
 			dst += 8;
 		}
 	} else {
@@ -198,7 +201,7 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 		src += pos * 8;
 		while (count--) {
 			for (i = 0; i < substream->runtime->channels; i++)
-				*dst++ = *(src+i);
+				*dst++ = *(src + tdm_port->rx_map[i]);
 			src += 8;
 		}
 	}
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 3096bad..6995d5b 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -46,14 +46,6 @@
 #include "bf5xx-sport.h"
 #include "bf5xx-tdm.h"
 
-struct bf5xx_tdm_port {
-	u16 tcr1;
-	u16 rcr1;
-	u16 tcr2;
-	u16 rcr2;
-	int configured;
-};
-
 static struct bf5xx_tdm_port bf5xx_tdm;
 static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
 
@@ -181,6 +173,23 @@ static void bf5xx_tdm_shutdown(struct snd_pcm_substream *substream,
 		bf5xx_tdm.configured = 0;
 }
 
+static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
+		unsigned int tx_num, unsigned int *tx_slot,
+		unsigned int rx_num, unsigned int *rx_slot)
+{
+	int i;
+
+	if ((tx_num > MAX_TDM_SLOTS) || (rx_num > MAX_TDM_SLOTS))
+		return -EINVAL;
+
+	for (i = 0; i < tx_num; i++)
+		bf5xx_tdm.tx_map[i] = tx_slot[i];
+	for (i = 0; i < rx_num; i++)
+		bf5xx_tdm.rx_map[i] = rx_slot[i];
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 {
@@ -235,6 +244,7 @@ static struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
 	.hw_params      = bf5xx_tdm_hw_params,
 	.set_fmt        = bf5xx_tdm_set_dai_fmt,
 	.shutdown       = bf5xx_tdm_shutdown,
+	.set_channel_map   = bf5xx_tdm_set_channel_map,
 };
 
 struct snd_soc_dai bf5xx_tdm_dai = {
@@ -300,6 +310,8 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		pr_err("Failed to register DAI: %d\n", ret);
 		goto sport_config_err;
 	}
+
+	sport_handle->private_data = &bf5xx_tdm;
 	return 0;
 
 sport_config_err:
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
index 618ec3d..f85790a 100644
--- a/sound/soc/blackfin/bf5xx-tdm.h
+++ b/sound/soc/blackfin/bf5xx-tdm.h
@@ -9,6 +9,17 @@
 #ifndef _BF5XX_TDM_H
 #define _BF5XX_TDM_H
 
+#define MAX_TDM_SLOTS 8
+struct bf5xx_tdm_port {
+	u16 tcr1;
+	u16 rcr1;
+	u16 tcr2;
+	u16 rcr2;
+	unsigned int tx_map[MAX_TDM_SLOTS];
+	unsigned int rx_map[MAX_TDM_SLOTS];
+	int configured;
+};
+
 extern struct snd_soc_dai bf5xx_tdm_dai;
 
 #endif
-- 
1.5.6.3
