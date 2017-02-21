From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: drop useles self-assignments" to
	the asoc tree
Date: Tue, 21 Feb 2017 15:05:11 -0800
Message-ID: <E1cgJUd-0004mU-BN@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DDF126680A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 00:05:24 +0100 (CET)
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
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: drop useles self-assignments

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

>From 34157f7bec8276b4296cf2ec172fc13385ac8af7 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 20 Feb 2017 21:58:34 +0100
Subject: [PATCH] ASoC: rsnd: drop useles self-assignments

Coverity reported (CID 1397992) this self-assignment. I think the code
stays readable even with the assignments removed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 948c5ec87980..72966bdd3daa 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -674,12 +674,10 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	/* set clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_IF:
-		rdai->bit_clk_inv =  rdai->bit_clk_inv;
 		rdai->frm_clk_inv = !rdai->frm_clk_inv;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		rdai->bit_clk_inv = !rdai->bit_clk_inv;
-		rdai->frm_clk_inv =  rdai->frm_clk_inv;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		rdai->bit_clk_inv = !rdai->bit_clk_inv;
-- 
2.11.0
