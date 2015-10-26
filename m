From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: fix Rx synchrounous mode" to
	the asoc tree
Date: Mon, 26 Oct 2015 16:36:33 +0900
Message-ID: <E1ZqcKX-0002Di-2f@finisterre>
References: <1445301743-24173-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3DB02604A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:36:56 +0100 (CET)
In-Reply-To: <1445301743-24173-1-git-send-email-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: fix Rx synchrounous mode

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

>From 3cc7780b6fc04318ab08d84f739503989200cf55 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Mon, 19 Oct 2015 17:42:23 -0700
Subject: [PATCH] ASoC: fsl_sai: fix Rx synchrounous mode

When using the Rx clock for both, transmitter and receiver, the
transmitter needs to be set to synchronous with receiver.

This reverts 855675f6e6a6 ("ASoC: fsl_sai: Set SYNC bit of TCR2 to
Asynchronous Mode"), which, judiging from the commit log, seems to
mixed up between the two synchronous modes: The boolean
sai->synchronous[TX] is indicating wheather the SAI should work in
Rx synchronous mode (sync Tx with Rx), hence if the value is true,
the SYNC field of TCR2 needs to be set to 0x1 ("Synchronous with
receiver").

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a18fd92..1f0e552 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -454,7 +454,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	 * Rx sync with Tx clocks: Clear SYNC for Tx, set it for Rx.
 	 * Tx sync with Rx clocks: Clear SYNC for Rx, set it for Tx.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
+		           sai->synchronous[TX] ? FSL_SAI_CR2_SYNC : 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
 			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
 
-- 
2.6.1
