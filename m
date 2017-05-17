From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: check src mod pointer for rsnd_mod_id()" to the asoc tree
Date: Wed, 17 May 2017 10:51:59 +0100
Message-ID: <E1dAvcd-0006kc-Hw@debutante>
References: <87fug43rs6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fug43rs6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>Mark Brown <broonie@kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: check src mod pointer for rsnd_mod_id()

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

>From 374503c6109e60f48fa9b11341b14466f07bd3f4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 May 2017 06:50:32 +0000
Subject: [PATCH] ASoC: rsnd: check src mod pointer for rsnd_mod_id()

Without this patch, gcc 4.9.x says

    sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
    sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below array\
	bounds [-Warray-bounds]
	data = path[rsnd_mod_id(src)] |

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 7d92a24b7cfa..98835e9d1d7d 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -82,6 +82,9 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 			[9] = 0x2,
 		};
 
+		if (unlikely(!src))
+			return -EIO;
+
 		data = path[rsnd_mod_id(src)] |
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
-- 
2.11.0
