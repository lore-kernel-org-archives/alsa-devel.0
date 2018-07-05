From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: Use 64-bit arithmetic
	instead of 32-bit" to the asoc tree
Date: Thu, 05 Jul 2018 11:08:39 +0100
Message-ID: <E1fb1Bn-0002vz-Tf@debutante>
References: <20180704141833.GA6702@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D96DF267214
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 12:09:09 +0200 (CEST)
In-Reply-To: <20180704141833.GA6702@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: Use 64-bit arithmetic instead of 32-bit

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

>From b999a7a9e72bd2d37b5d03772cedfc4dd45875bf Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 4 Jul 2018 09:18:33 -0500
Subject: [PATCH] ASoC: fsl_spdif: Use 64-bit arithmetic instead of 32-bit

Add suffix ULL to constant 64 in order to give the compiler complete
information about the proper arithmetic to use.

Notice that such constant is used in a context that expects an
expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

rate[index] * txclk_df * 64

Addresses-Coverity-ID: 1222129 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 9b59d87b61bf..740b90df44bb 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1118,7 +1118,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 
 	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
 		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
-			rate_ideal = rate[index] * txclk_df * 64;
+			rate_ideal = rate[index] * txclk_df * 64ULL;
 			if (round)
 				rate_actual = clk_round_rate(clk, rate_ideal);
 			else
-- 
2.18.0.rc2
