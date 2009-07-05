From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 04/11] ASoC: DaVinci: i2s cleanup
Date: Sat,  4 Jul 2009 19:29:54 -0700
Message-ID: <1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CAE310381B
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:04 +0200 (CEST)
In-Reply-To: <1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
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

Move variable declaration closer to use.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index f7d7e4c..73a0fd8 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -138,7 +138,6 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 	struct snd_soc_platform *platform = socdev->card->platform;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
-	int ret;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (spcr & mask) {
@@ -155,7 +154,7 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		/* Stop the DMA to avoid data loss */
 		/* while the transmitter is out of reset to handle XSYNCERR */
 		if (platform->pcm_ops->trigger) {
-			ret = platform->pcm_ops->trigger(substream,
+			int ret = platform->pcm_ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_STOP);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA stop failed\n");
@@ -177,7 +176,7 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 
 		/* Restart the DMA */
 		if (platform->pcm_ops->trigger) {
-			ret = platform->pcm_ops->trigger(substream,
+			int ret = platform->pcm_ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_START);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
-- 
1.5.6.3
