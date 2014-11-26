From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] ASoC: cq93vc: Remove unused state struct
Date: Wed, 26 Nov 2014 20:57:50 +0100
Message-ID: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5910D265DC3
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:28:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

While two of the fields in the cq93vc driver state struct are initialized
none of them are ever acutally read again. So remove the whole struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/mfd/davinci_voicecodec.h | 7 -------
 sound/soc/codecs/cq93vc.c              | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
index cb01496..8e1cdbe 100644
--- a/include/linux/mfd/davinci_voicecodec.h
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -99,12 +99,6 @@ struct davinci_vcif {
 	dma_addr_t dma_rx_addr;
 };
 
-struct cq93vc {
-	struct platform_device *pdev;
-	struct snd_soc_codec *codec;
-	u32 sysclk;
-};
-
 struct davinci_vc;
 
 struct davinci_vc {
@@ -122,7 +116,6 @@ struct davinci_vc {
 
 	/* Client devices */
 	struct davinci_vcif davinci_vcif;
-	struct cq93vc cq93vc;
 };
 
 #endif
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 537327c..036a877 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -62,14 +62,10 @@ static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
 static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct davinci_vc *davinci_vc = codec->dev->platform_data;
-
 	switch (freq) {
 	case 22579200:
 	case 27000000:
 	case 33868800:
-		davinci_vc->cq93vc.sysclk = freq;
 		return 0;
 	}
 
@@ -135,10 +131,6 @@ static int cq93vc_resume(struct snd_soc_codec *codec)
 
 static int cq93vc_probe(struct snd_soc_codec *codec)
 {
-	struct davinci_vc *davinci_vc = codec->dev->platform_data;
-
-	davinci_vc->cq93vc.codec = codec;
-
 	/* Off, with power on */
 	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.8.0
