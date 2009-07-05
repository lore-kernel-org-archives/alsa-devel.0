From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 03/11] ASoc: DaVinci: i2s, minor cleanup
Date: Sat,  4 Jul 2009 19:29:53 -0700
Message-ID: <1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F802103822
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:04 +0200 (CEST)
In-Reply-To: <1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
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

Add davinci_mcbsp_dev as argument to davinci_mcbsp_start
and davinci_mcbsp_stop.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index dd44167..f7d7e4c 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -130,10 +130,10 @@ static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, dev->pcr);
 }
 
-static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
+static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
+		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_platform *platform = socdev->card->platform;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
@@ -202,12 +202,9 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 }
 
-static void davinci_mcbsp_stop(struct snd_pcm_substream *substream)
+static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	u32 spcr;
-	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
@@ -427,18 +424,21 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
 	int ret = 0;
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		davinci_mcbsp_start(substream);
+		davinci_mcbsp_start(dev, substream);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		davinci_mcbsp_stop(substream);
+		davinci_mcbsp_stop(dev, playback);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.5.6.3
