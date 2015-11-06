From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup SCU_SYS_INT_EN1 address" to the asoc tree
Date: Fri, 06 Nov 2015 12:09:32 +0000
Message-ID: <E1Zufpk-00056I-B9@finisterre>
References: <87io5gj9en.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87io5gj9en.wl%kuninori.morimoto.gx@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup SCU_SYS_INT_EN1 address

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

>From 021c5d9469960b8c68aa1d1825f7bfd8d61e157d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 5 Nov 2015 23:53:03 +0000
Subject: [PATCH] ASoC: rsnd: fixup SCU_SYS_INT_EN1 address

cfcefe0126 ("ASoC: rsnd: add recovery support for under/over flow
error on SRC") added SCU_SYS_INT_EN1 address, but it should be
0x1d4, not 0x1c4. This patch fixup it.

Fixes: cfcefe0126 ("ASoC: rsnd: add recovery support for under/over flow error on SRC")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/sh/rcar/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index f04d17b..916b38d 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -231,7 +231,7 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 		RSND_GEN_S_REG(SCU_SYS_STATUS0,	0x1c8),
 		RSND_GEN_S_REG(SCU_SYS_INT_EN0,	0x1cc),
 		RSND_GEN_S_REG(SCU_SYS_STATUS1,	0x1d0),
-		RSND_GEN_S_REG(SCU_SYS_INT_EN1,	0x1c4),
+		RSND_GEN_S_REG(SCU_SYS_INT_EN1,	0x1d4),
 		RSND_GEN_M_REG(SRC_SWRSR,	0x200,	0x40),
 		RSND_GEN_M_REG(SRC_SRCIR,	0x204,	0x40),
 		RSND_GEN_M_REG(SRC_ADINR,	0x214,	0x40),
-- 
2.6.1
