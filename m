From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssiu: correct shift bit for ssiu9" to the asoc tree
Date: Thu,  7 Feb 2019 12:16:09 +0000 (GMT)
Message-ID: <20190207121609.993E51127EF9@debutante.sirena.org.uk>
References: <20190204134105.15243-1-jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204134105.15243-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.comkuninori.morimoto.gx@renesas.com, jiada_wang@mentor.com, twischer@de.adit-jv.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssiu: correct shift bit for ssiu9

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

>From 76379dfbfd7c8fd7dd29eea3f828cf85c884829e Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 4 Feb 2019 22:41:05 +0900
Subject: [PATCH] ASoC: rsnd: ssiu: correct shift bit for ssiu9

Currently "0xf << 36" is used to
clear SSIU-9 internal buffer state, which overflows 32-bit value
according to user reference manual, it is always bit4 ~ bit7
of SSI_SYS_STATUS[1,3,5,7] registers indicate
SSIU-9's buffer state, so "0xf << 4" should be used.

This patch fix incorrect shifting issue in SSIU-9 case

Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c5934adcfd01..c74991dd18ab 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -79,7 +79,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		break;
 	case 9:
 		for (i = 0; i < 4; i++)
-			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << (id * 4));
+			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << 4);
 		break;
 	}
 
-- 
2.20.1
