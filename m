From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 09/11] ASoC: DaVinci: i2s,
	add davinci_i2s_prepare and shutdown
Date: Sat,  4 Jul 2009 19:29:59 -0700
Message-ID: <1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FCA210384F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:12 +0200 (CEST)
In-Reply-To: <1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

If the codec is master then prepare should call
mcbsp_start, not trigger.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index a2ad53e..f3e7bf8 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -470,6 +470,20 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	davinci_mcbsp_stop(dev, playback);
+	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0) {
+		/* codec is master */
+		davinci_mcbsp_start(dev, substream);
+	}
+	return 0;
+}
+
 static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
@@ -477,6 +491,8 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0)
+		return 0;	/* return if codec is master */
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -492,10 +508,18 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	default:
 		ret = -EINVAL;
 	}
-
 	return ret;
 }
 
+static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	davinci_mcbsp_stop(dev, playback);
+}
+
 static int davinci_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
@@ -581,6 +605,8 @@ static void davinci_i2s_remove(struct platform_device *pdev,
 
 static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 	.startup	= davinci_i2s_startup,
+	.shutdown	= davinci_i2s_shutdown,
+	.prepare	= davinci_i2s_prepare,
 	.trigger	= davinci_i2s_trigger,
 	.hw_params	= davinci_i2s_hw_params,
 	.set_fmt	= davinci_i2s_set_dai_fmt,
-- 
1.5.6.3
