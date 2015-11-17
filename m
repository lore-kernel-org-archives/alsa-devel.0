From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-sai: don't set bclk for Tx/Rx
	Synchronous with another SAI mode" to the asoc tree
Date: Tue, 17 Nov 2015 18:54:45 +0000
Message-ID: <E1ZylOv-00040G-QG@debutante>
References: <b1cf60241eab0069250d00e47e80bb04ce676412.1447066811.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EBBA2652E7
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:55 +0100 (CET)
In-Reply-To: <b1cf60241eab0069250d00e47e80bb04ce676412.1447066811.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-sai: don't set bclk for Tx/Rx Synchronous with another SAI mode

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9cc58712358cbfe51248ef369fc50671149b60fc Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Mon, 9 Nov 2015 19:02:29 +0800
Subject: [PATCH] ASoC: fsl-sai: don't set bclk for Tx/Rx Synchronous with
 another SAI mode

In fsl_sai_set_bclk function, we should not set bclk for Tx/Rx Synchronous
with another SAI mode.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a4435f5e3be9..7e421a97c090 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -354,13 +354,25 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		return -EINVAL;
 	}
 
-	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
+	/*
+	 * 1) For Asynchronous mode, we must set RCR2 register for capture, and
+	 *    set TCR2 register for playback.
+	 * 2) For Tx sync with Rx clock, we must set RCR2 register for playback
+	 *    and capture.
+	 * 3) For Rx sync with Tx clock, we must set TCR2 register for playback
+	 *    and capture.
+	 * 4) For Tx and Rx are both Synchronous with another SAI, we just
+	 *    ignore it.
+	 */
+	if ((sai->synchronous[TX] && !sai->synchronous[RX]) ||
+	    (!tx && !sai->synchronous[RX])) {
 		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
 				   FSL_SAI_CR2_MSEL_MASK,
 				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
 		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
 				   FSL_SAI_CR2_DIV_MASK, savediv - 1);
-	} else {
+	} else if ((sai->synchronous[RX] && !sai->synchronous[TX]) ||
+		   (tx && !sai->synchronous[TX])) {
 		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
 				   FSL_SAI_CR2_MSEL_MASK,
 				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
-- 
2.6.2
