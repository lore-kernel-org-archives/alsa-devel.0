From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 05/11] ASoC: DaVinci: i2s,
	only start sample generator if needed
Date: Sat,  4 Jul 2009 19:29:55 -0700
Message-ID: <1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id C5CBC103847
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:10 +0200 (CEST)
In-Reply-To: <1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
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

Only start sample generator if needed, and more
cleanup on davinci_mcbsp_start.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-i2s.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 73a0fd8..4260965 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -146,11 +146,14 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 				spcr & ~mask);
 		toggle_clock(dev, playback);
 	}
-	/* Start the sample generator and enable transmitter/receiver */
-	spcr |= DAVINCI_MCBSP_SPCR_GRST;
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
+			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
+		/* Start the sample generator */
+		spcr |= DAVINCI_MCBSP_SPCR_GRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (playback) {
 		/* Stop the DMA to avoid data loss */
 		/* while the transmitter is out of reset to handle XSYNCERR */
 		if (platform->pcm_ops->trigger) {
@@ -181,23 +184,16 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
 		}
-		/* Enable the transmitter */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr |= DAVINCI_MCBSP_SPCR_XRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-
-	} else {
-
-		/* Enable the reciever */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr |= DAVINCI_MCBSP_SPCR_RRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
-
-	/* Start frame sync */
+	/* Enable transmitter or receiver */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	spcr |= DAVINCI_MCBSP_SPCR_FRST;
+	spcr |= mask;
+
+	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM)) {
+		/* Start frame sync */
+		spcr |= DAVINCI_MCBSP_SPCR_FRST;
+	}
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 }
 
-- 
1.5.6.3
