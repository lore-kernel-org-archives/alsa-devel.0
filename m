From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/2] ASoC: DaVinci: Fix divide by zero error
	during 1st execution
Date: Fri, 11 Sep 2009 14:29:02 -0700
Message-ID: <1252704543-25580-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 877E12438D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 23:28:50 +0200 (CEST)
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
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

When both playback and capture stream were open
davinci_i2s_hw_params was setting parameters for
the wrong stream. The fix for davinci_i2s_hw_params
is sufficient, but it looks like a race still happens
in davici_pcm_open. This patch also makes the race smaller
but the next patch provides a better fix.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |    3 ++-
 sound/soc/davinci/davinci-pcm.c |   12 +++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 12a6c54..d32e197 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -353,8 +353,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
 	struct davinci_mcbsp_dev *dev = dai->private_data;
+	struct davinci_pcm_dma_params *dma_params =
+					dev->dma_params[substream->stream];
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length;
 	unsigned int rcr, xcr, srgr;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 091dacb..002808b 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -126,16 +126,9 @@ static void davinci_pcm_dma_irq(unsigned lch, u16 ch_status, void *data)
 static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
 	struct edmacc_param p_ram;
 	int ret;
 
-	if (!dma_data)
-		return -ENODEV;
-
-	prtd->params = dma_data;
-
 	/* Request master DMA channel */
 	ret = edma_alloc_channel(prtd->params->channel,
 				  davinci_pcm_dma_irq, substream,
@@ -244,6 +237,10 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd;
 	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_pcm_dma_params *params = rtd->dai->cpu_dai->dma_data;
+	if (!params)
+		return -ENODEV;
 
 	snd_soc_set_runtime_hwparams(substream, &davinci_pcm_hardware);
 	/* ensure that buffer size is a multiple of period size */
@@ -257,6 +254,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 
 	spin_lock_init(&prtd->lock);
+	prtd->params = params;
 
 	runtime->private_data = prtd;
 
-- 
1.5.6.3
