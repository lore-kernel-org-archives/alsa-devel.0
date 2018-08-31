From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Add support for FIFO
	usage caused delay reporting" to the asoc tree
Date: Fri, 31 Aug 2018 16:41:00 +0100 (BST)
Message-ID: <20180831154100.7E66011226FE@debutante.sirena.org.uk>
References: <20180831082456.5091-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 18376267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:41:01 +0200 (CEST)
In-Reply-To: <20180831082456.5091-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Add support for FIFO usage caused delay reporting

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5fcb457ac2fdc62c5ff6d3962c958b1301bc5ea1 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 31 Aug 2018 11:24:56 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Add support for FIFO usage caused delay
 reporting

McASP have write and read FIFO, each 64 words deep.

>From the WFIFOS/RFIFOS registers we can read the amount of data currently
in the FIFO which can be directly reported as delay.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f70db8412c7c..267aee776b2d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1041,6 +1041,42 @@ static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
 	return error_ppm;
 }
 
+static inline u32 davinci_mcasp_tx_delay(struct davinci_mcasp *mcasp)
+{
+	if (!mcasp->txnumevt)
+		return 0;
+
+	return mcasp_get_reg(mcasp, mcasp->fifo_base + MCASP_WFIFOSTS_OFFSET);
+}
+
+static inline u32 davinci_mcasp_rx_delay(struct davinci_mcasp *mcasp)
+{
+	if (!mcasp->rxnumevt)
+		return 0;
+
+	return mcasp_get_reg(mcasp, mcasp->fifo_base + MCASP_RFIFOSTS_OFFSET);
+}
+
+static snd_pcm_sframes_t davinci_mcasp_delay(
+			struct snd_pcm_substream *substream,
+			struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 fifo_use;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		fifo_use = davinci_mcasp_tx_delay(mcasp);
+	else
+		fifo_use = davinci_mcasp_rx_delay(mcasp);
+
+	/*
+	 * Divide the used locations with the channel count to get the
+	 * FIFO usage in samples (don't care about partial samples in the
+	 * buffer).
+	 */
+	return fifo_use / substream->runtime->channels;
+}
+
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
@@ -1365,6 +1401,7 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.startup	= davinci_mcasp_startup,
 	.shutdown	= davinci_mcasp_shutdown,
 	.trigger	= davinci_mcasp_trigger,
+	.delay		= davinci_mcasp_delay,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
 	.set_clkdiv	= davinci_mcasp_set_clkdiv,
-- 
2.19.0.rc1
