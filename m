From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:41 +0000 (GMT)
Message-ID: <20190218184941.E31E11128008@debutante.sirena.org.uk>
References: <20190217224830.17355-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217224830.17355-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"

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

>From cb8cdb6f3344bcb472640d2f5f956dbde0bfd509 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sun, 17 Feb 2019 22:48:30 +0000
Subject: [PATCH] ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index aa7e902f0c02..db929b00ae5e 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -780,7 +780,7 @@ static int fsi_clk_init(struct device *dev,
 			return -EINVAL;
 		}
 		if (clock->div == clock->own) {
-			dev_err(dev, "cpu doens't support div clock\n");
+			dev_err(dev, "cpu doesn't support div clock\n");
 			return -EINVAL;
 		}
 	}
-- 
2.20.1
