From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use 32bit TDM width as default"
	to the asoc tree
Date: Wed, 10 Oct 2018 15:37:29 +0100 (BST)
Message-ID: <20181010143729.8BED31122395@debutante.sirena.org.uk>
References: <87a7nm1rdx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33E27267901
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 16:37:30 +0200 (CEST)
In-Reply-To: <87a7nm1rdx.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use 32bit TDM width as default

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

>From 82ab7e9a4d3fcec27f745be04063e17da1881dda Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Oct 2018 02:20:42 +0000
Subject: [PATCH] ASoC: rsnd: use 32bit TDM width as default

commit fb2815f44a9e ("ASoC: rsnd: add support for 16/24 bit slot widths")
added TDM width check, and return error if it was not 16/24/32 bit.
But it is too strict. This patch uses 32bit same as default.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 40d7dc4f7839..f930f51b686f 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -744,8 +744,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	case 32:
 		break;
 	default:
-		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
-		return -EINVAL;
+		/* use default */
+		slot_width = 32;
 	}
 
 	switch (slots) {
-- 
2.19.0.rc2
