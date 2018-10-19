From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup SSICR::SWSP for TDM" to
	the asoc tree
Date: Fri, 19 Oct 2018 13:34:34 +0100 (BST)
Message-ID: <20181019123434.609DC1122548@debutante.sirena.org.uk>
References: <87k1mhz6m6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C343B267A71
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:34:34 +0200 (CEST)
In-Reply-To: <87k1mhz6m6.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup SSICR::SWSP for TDM

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

>From 2eaa6e233091f51d8a629e423ad0bc080ffcb5d6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Oct 2018 01:55:57 +0000
Subject: [PATCH] ASoC: rsnd: tidyup SSICR::SWSP for TDM

R-Car datasheet is indicating that WS output settings of SSICR::SWSP
is inverted on TDM mode from non TDM mode settings.
But, it is meaning that TDM should use 0 here.
Without this patch, sound input/output 1ch will be 2ch, 2ch will be 3ch
..., be jumbled on I2S + TDM settings. This patch fixup it.
This patch is tested on R-Car H3 ulcb-kf board, SSI3/4 TDM sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index b42a0e0feab7..fcb4df23248c 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -392,7 +392,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
-	if (rdai->frm_clk_inv ^ is_tdm)
+	if (rdai->frm_clk_inv && !is_tdm)
 		cr_own |= SWSP;
 	if (rdai->data_alignment)
 		cr_own |= SDTA;
-- 
2.19.0.rc2
