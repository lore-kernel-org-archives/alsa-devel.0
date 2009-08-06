From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/5] ASoC: DaVinci: i2s: don't bounce through
	rtd to get dai
Date: Thu,  6 Aug 2009 16:55:31 -0700
Message-ID: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C3FC10380E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 01:55:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

dai is a parameter to the functions, so use it instead of
looking it up.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index e5cd97b..2a56fb7 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -353,9 +353,8 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
+	struct davinci_mcbsp_dev *dev = dai->private_data;
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length;
 	unsigned int rcr, xcr, srgr;
@@ -425,8 +424,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = dai->private_data;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0) {
@@ -439,8 +437,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = dai->private_data;
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0)
@@ -466,8 +463,7 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct davinci_mcbsp_dev *dev = dai->private_data;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
 }
-- 
1.5.6.3
