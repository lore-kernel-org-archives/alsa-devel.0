From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [PATCH] ASoC: Samsung: Added to support mono recording
Date: Fri, 16 Mar 2012 15:40:53 +0900
Message-ID: <0c1f01cd033f$bc35fc50$34a1f4f0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E7C12414E
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 07:41:05 +0100 (CET)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0M0Y00D5XT7PK590@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 16 Mar 2012 15:40:56 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.118.225])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0M0Y00CKLT8DGH40@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Fri, 16 Mar 2012 15:41:02 +0900 (KST)
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>, alsa-devel@alsa-project.org
Cc: sangsu4u.park@samsung.com, sbkim01@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Sangsu Park <sangsu4u.park@samsung.com>

The dma size will be changed by requested number of
channel(mono/stereo) from platform. For mono recording,
channels_min value should be 1.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/i2s.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6553b19..6ac7b82 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -559,6 +559,17 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 		mod |= MOD_DC1_EN;
 		break;
 	case 2:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			i2s->dma_playback.dma_size = 4;
+		else
+			i2s->dma_capture.dma_size = 4;
+		break;
+	case 1:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			i2s->dma_playback.dma_size = 2;
+		else
+			i2s->dma_capture.dma_size = 2;
+
 		break;
 	default:
 		dev_err(&i2s->pdev->dev, "%d channels not supported\n",
@@ -963,7 +974,7 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	i2s->i2s_dai_drv.playback.formats = SAMSUNG_I2S_FMTS;
 
 	if (!sec) {
-		i2s->i2s_dai_drv.capture.channels_min = 2;
+		i2s->i2s_dai_drv.capture.channels_min = 1;
 		i2s->i2s_dai_drv.capture.channels_max = 2;
 		i2s->i2s_dai_drv.capture.rates = SAMSUNG_I2S_RATES;
 		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
-- 
1.7.1
