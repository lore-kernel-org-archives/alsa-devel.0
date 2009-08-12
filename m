From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] add set_tdm_slot in tdm dai to define the
	relationship between audio channel and tdm slot
Date: Wed, 12 Aug 2009 12:32:53 +0800
Message-ID: <1250051574-25119-3-git-send-email-21cnbao@gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 2577024DD7
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 06:31:07 +0200 (CEST)
In-Reply-To: <1250051574-25119-2-git-send-email-21cnbao@gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

For ad1938, the audio channel n just uses slot n, but for ad1836, it's
different, channel 0 uses slot 0, channel 1 uses slot 4, channels 2 uses
slot1, ... So add set_tdm_slot entry and use the mask field to define
the relationship between audio channel and slot number.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad1938.c  |    5 +++++
 sound/soc/blackfin/bf5xx-tdm-pcm.c |   12 +++++++++---
 sound/soc/blackfin/bf5xx-tdm.c     |   18 ++++++++++--------
 sound/soc/blackfin/bf5xx-tdm.h     |   10 ++++++++++
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1938.c b/sound/soc/blackfin/bf5xx-ad1938.c
index 08269e9..6844098 100644
--- a/sound/soc/blackfin/bf5xx-ad1938.c
+++ b/sound/soc/blackfin/bf5xx-ad1938.c
@@ -73,6 +73,11 @@ static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
 		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
+	
+	/* set cpu DAI slots, 8 channels, mask is defined as slot seq */
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x76543210, 8);
+	if (ret < 0)
+		return ret;
 
 	/* set codec DAI slots, 8 channels, all channels are enabled */
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 8);
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index ccb5e82..044ef45 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -43,7 +43,7 @@
 #include "bf5xx-tdm.h"
 #include "bf5xx-sport.h"
 
-#define PCM_BUFFER_MAX  0x10000
+#define PCM_BUFFER_MAX  0x8000
 #define FRAGMENT_SIZE_MIN  (4*1024)
 #define FRAGMENTS_MIN  2
 #define FRAGMENTS_MAX  32
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
@@ -186,9 +189,11 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 		dst = (unsigned int *)substream->runtime->dma_area;
 
 		dst += pos * 8;
+
 		while (count--) {
 			for (i = 0; i < substream->runtime->channels; i++)
-				*(dst + i) = *src++;
+				*(dst + (((tdm_port->slot_seq >>
+					(4 * i)) & 0xF))) = *src++;
 			dst += 8;
 		}
 	} else {
@@ -198,7 +203,8 @@ static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
 		src += pos * 8;
 		while (count--) {
 			for (i = 0; i < substream->runtime->channels; i++)
-				*dst++ = *(src+i);
+				*dst++ = *(src + (((tdm_port->slot_seq >>
+					(4 * i)) & 0xF)));
 			src += 8;
 		}
 	}
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 3096bad..091e178 100644
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
 
@@ -181,6 +173,13 @@ static void bf5xx_tdm_shutdown(struct snd_pcm_substream *substream,
 		bf5xx_tdm.configured = 0;
 }
 
+static int bf5xx_tdm_set_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int mask, int slots)
+{
+	bf5xx_tdm.slot_seq = mask;
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 {
@@ -235,6 +234,7 @@ static struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
 	.hw_params      = bf5xx_tdm_hw_params,
 	.set_fmt        = bf5xx_tdm_set_dai_fmt,
 	.shutdown       = bf5xx_tdm_shutdown,
+	.set_tdm_slot   = bf5xx_tdm_set_tdm_slot,
 };
 
 struct snd_soc_dai bf5xx_tdm_dai = {
@@ -300,6 +300,8 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		pr_err("Failed to register DAI: %d\n", ret);
 		goto sport_config_err;
 	}
+
+	sport_handle->private_data = &bf5xx_tdm;
 	return 0;
 
 sport_config_err:
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
index 618ec3d..701c769 100644
--- a/sound/soc/blackfin/bf5xx-tdm.h
+++ b/sound/soc/blackfin/bf5xx-tdm.h
@@ -9,6 +9,16 @@
 #ifndef _BF5XX_TDM_H
 #define _BF5XX_TDM_H
 
+struct bf5xx_tdm_port {
+	u16 tcr1;
+	u16 rcr1;
+	u16 tcr2;
+	u16 rcr2;
+	/* which slot used for the corresponding audio channel? */
+	int slot_seq;
+	int configured;
+};
+
 extern struct snd_soc_dai bf5xx_tdm_dai;
 
 #endif
-- 
1.5.6.3
