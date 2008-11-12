From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: DaVinci: Audio: Fix swapping of
	channels at start of stereo playback
Date: Wed, 12 Nov 2008 11:55:49 +0000
Message-ID: <1226490949-22360-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
	<1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECB16243E2
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:55:50 +0100 (CET)
In-Reply-To: <1226490949-22360-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh Medisetty <naresh@ti.com>

Fixes swapping of channels at start of stereo playback.

Channel swap can be observed while playing left-only or right-only audio data. The channel
swap is fixed by handling the XSYNCERR condition.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-i2s.c |   49 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index d814ec8..8c1bf87 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -111,16 +111,59 @@ static void davinci_mcbsp_start(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_mcbsp_dev *dev = rtd->dai->cpu_dai->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_platform *platform = socdev->platform;
 	u32 w;
+	int ret;
 
 	/* Start the sample generator and enable transmitter/receiver */
 	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_GRST, 1);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* Stop the DMA to avoid data loss */
+		/* while the transmitter is out of reset to handle XSYNCERR */
+		if (platform->pcm_ops->trigger) {
+			ret = platform->pcm_ops->trigger(substream,
+				SNDRV_PCM_TRIGGER_STOP);
+			if (ret < 0)
+				printk(KERN_DEBUG "Playback DMA stop failed\n");
+		}
+
+		/* Enable the transmitter */
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 1);
-	else
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+
+		/* wait for any unexpected frame sync error to occur */
+		udelay(100);
+
+		/* Disable the transmitter to clear any outstanding XSYNCERR */
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 0);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+
+		/* Restart the DMA */
+		if (platform->pcm_ops->trigger) {
+			ret = platform->pcm_ops->trigger(substream,
+				SNDRV_PCM_TRIGGER_START);
+			if (ret < 0)
+				printk(KERN_DEBUG "Playback DMA start failed\n");
+		}
+		/* Enable the transmitter */
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_XRST, 1);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+
+	} else {
+
+		/* Enable the reciever */
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 		MOD_REG_BIT(w, DAVINCI_MCBSP_SPCR_RRST, 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+	}
+
 
 	/* Start frame sync */
 	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-- 
1.5.6.5
