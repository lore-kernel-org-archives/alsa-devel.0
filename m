From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-i2s: Move the XSYNCERR
	workaround to .prepare callback" to the asoc tree
Date: Fri, 30 Aug 2019 12:45:19 +0100 (BST)
Message-ID: <20190830114519.308882742CA7@ypsilon.sirena.org.uk>
References: <20190830103841.25128-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 233B3F8038F
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:45:20 +0200 (CEST)
In-Reply-To: <20190830103841.25128-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, nsekhar@ti.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-i2s: Move the XSYNCERR workaround to .prepare callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a2dc6f82fd86fa165222f6062e2478fd122f9f1c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 30 Aug 2019 13:38:39 +0300
Subject: [PATCH] ASoC: ti: davinci-i2s: Move the XSYNCERR workaround to
 .prepare callback

Currently the driver uses snd_soc_rtdcom_lookup() in it's mcbsp_start
function to try to stop/restart the DMA as the initial XSYNCERR workaround
need to be done before the DMA is armed.

There are couple of things wrong with this:
- the driver crashes with NULL pointer dereference as the
  component->driver->ops is actually NULL
- the driver should not use snd_soc_rtdcom_lookup() in the first place
- Fiddling with DMA is never a good thing

Move the workaround handling to .prepare which is called before the DMA is
armed, so it complies with the requirements.

Reported-by (usage of snd_soc_rtdcom_lookup): Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190830103841.25128-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-i2s.c | 82 ++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 92c1bdc69086..27afdbb9adf3 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -187,57 +187,9 @@ static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
 static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
-	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	if (spcr & mask) {
-		/* start off disabled */
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
-				spcr & ~mask);
-		toggle_clock(dev, playback);
-	}
-	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
-			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
-		/* Start the sample generator */
-		spcr |= DAVINCI_MCBSP_SPCR_GRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-	}
-
-	if (playback) {
-		/* Stop the DMA to avoid data loss */
-		/* while the transmitter is out of reset to handle XSYNCERR */
-		if (component->driver->ops->trigger) {
-			int ret = component->driver->ops->trigger(substream,
-				SNDRV_PCM_TRIGGER_STOP);
-			if (ret < 0)
-				printk(KERN_DEBUG "Playback DMA stop failed\n");
-		}
-
-		/* Enable the transmitter */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr |= DAVINCI_MCBSP_SPCR_XRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-
-		/* wait for any unexpected frame sync error to occur */
-		udelay(100);
-
-		/* Disable the transmitter to clear any outstanding XSYNCERR */
-		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
-		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-		toggle_clock(dev, playback);
-
-		/* Restart the DMA */
-		if (component->driver->ops->trigger) {
-			int ret = component->driver->ops->trigger(substream,
-				SNDRV_PCM_TRIGGER_START);
-			if (ret < 0)
-				printk(KERN_DEBUG "Playback DMA start failed\n");
-		}
-	}
 
 	/* Enable transmitter or receiver */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
@@ -575,7 +527,41 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 {
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	u32 spcr;
+	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
+
 	davinci_mcbsp_stop(dev, playback);
+
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (spcr & mask) {
+		/* start off disabled */
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
+					spcr & ~mask);
+		toggle_clock(dev, playback);
+	}
+	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
+			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
+		/* Start the sample generator */
+		spcr |= DAVINCI_MCBSP_SPCR_GRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+	}
+
+	if (playback) {
+		/* Enable the transmitter */
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr |= DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+
+		/* wait for any unexpected frame sync error to occur */
+		udelay(100);
+
+		/* Disable the transmitter to clear any outstanding XSYNCERR */
+		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+		toggle_clock(dev, playback);
+	}
+
 	return 0;
 }
 
-- 
2.20.1
