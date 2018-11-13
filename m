From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Move out the FIFO check
	from set_threshold and get_delay" to the asoc tree
Date: Tue, 13 Nov 2018 18:32:25 +0000 (GMT)
Message-ID: <20181113183225.2A2F2440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A37972677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:32:31 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Move out the FIFO check from set_threshold and get_delay

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

>From be51c576e8495fd2cffbababad6de7e0a0a562ba Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 8 Nov 2018 09:29:57 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Move out the FIFO check from set_threshold
 and get_delay

Check if the McBSP have FIFO in the omap_mcbsp_set_threshold() and
omap_mcbsp_dai_delay() delay function to skip calling the lower layer if
it is not needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c      | 12 ------------
 sound/soc/omap/omap-mcbsp.c |  8 ++++++++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 7ff22561f00f..b19168f5c110 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -450,9 +450,6 @@ int omap_st_is_enabled(struct omap_mcbsp *mcbsp)
  */
 void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 {
-	if (mcbsp->pdata->buffer_size == 0)
-		return;
-
 	if (threshold && threshold <= mcbsp->max_tx_thres)
 		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
 }
@@ -464,9 +461,6 @@ void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
  */
 void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 {
-	if (mcbsp->pdata->buffer_size == 0)
-		return;
-
 	if (threshold && threshold <= mcbsp->max_rx_thres)
 		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
 }
@@ -478,9 +472,6 @@ u16 omap_mcbsp_get_tx_delay(struct omap_mcbsp *mcbsp)
 {
 	u16 buffstat;
 
-	if (mcbsp->pdata->buffer_size == 0)
-		return 0;
-
 	/* Returns the number of free locations in the buffer */
 	buffstat = MCBSP_READ(mcbsp, XBUFFSTAT);
 
@@ -496,9 +487,6 @@ u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp)
 {
 	u16 buffstat, threshold;
 
-	if (mcbsp->pdata->buffer_size == 0)
-		return 0;
-
 	/* Returns the number of used locations in the buffer */
 	buffstat = MCBSP_READ(mcbsp, RBUFFSTAT);
 	/* RX threshold */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a18b7ecc3a2e..69a6b8ad6d42 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -71,6 +71,10 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream,
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 	int words;
 
+	/* No need to proceed further if McBSP does not have FIFO */
+	if (mcbsp->pdata->buffer_size == 0)
+		return;
+
 	/*
 	 * Configure McBSP threshold based on either:
 	 * packet_size, when the sDMA is in packet mode, or based on the
@@ -233,6 +237,10 @@ static snd_pcm_sframes_t omap_mcbsp_dai_delay(
 	u16 fifo_use;
 	snd_pcm_sframes_t delay;
 
+	/* No need to proceed further if McBSP does not have FIFO */
+	if (mcbsp->pdata->buffer_size == 0)
+		return 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_use = omap_mcbsp_get_tx_delay(mcbsp);
 	else
-- 
2.19.1
