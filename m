From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: On OMAP1 and OMAP2420 only
	16bit format is supported" to the asoc tree
Date: Mon,  5 Nov 2018 11:58:12 +0000 (GMT)
Message-ID: <20181105115812.756121124D98@debutante.sirena.org.uk>
References: <20181025134824.16527-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D2A24267A64
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:58:13 +0100 (CET)
In-Reply-To: <20181025134824.16527-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jarkko.nikula@bitmer.com, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: On OMAP1 and OMAP2420 only 16bit format is supported

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

>From 61f18dc78a6b70c409134d0f4d873e9253565e05 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 25 Oct 2018 16:48:24 +0300
Subject: [PATCH] ASoC: omap-mcbsp: On OMAP1 and OMAP2420 only 16bit format is
 supported

For samples sizes of 20/24/32 bit the DRR2/DXR2 registers must be used to
receive or transmit the most significant part of the 32bit sample.
We can not trick the system by using the DRR2/DXR2 register offset and use
32bit element size since these (and other McBSP) registers are 16bit ones.

We would need support for port_window in cyclic mode from the sDMA driver,
but it is not straight forward as we would need to have the sDMA frame to
cover the 32bit (DRR2+DRR1/DXR2+DXR1), but the frames must cover the ALSA
period to be able to receive periodic interrupts.

Since the 32bit samples are not working (DMA timeout), just remove it in
case we have McBSP with reg_size of 2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-mcbsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d0ebb6b9bfac..caa24c463b3e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -862,6 +862,11 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (mcbsp->pdata->reg_size == 2) {
+		omap_mcbsp_dai.playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		omap_mcbsp_dai.capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &omap_mcbsp_component,
 					      &omap_mcbsp_dai, 1);
-- 
2.19.0.rc2
