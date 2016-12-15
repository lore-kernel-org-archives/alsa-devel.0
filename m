From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't double free kctrl" to the asoc tree
Date: Thu, 15 Dec 2016 12:22:00 +0000
Message-ID: <E1cHV2u-0000yP-5r@debutante>
References: <20161208130543.11560-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161208130543.11560-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't double free kctrl

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

>From 0ea617a298dcdc2251b4e10f83ac3f3e627b66e3 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 8 Dec 2016 13:05:43 +0000
Subject: [PATCH] ASoC: rsnd: don't double free kctrl

On an error, snd_ctl_add already free's kctrl, so calling snd_ctl_free_one
to free it again leads to a double free error.  Fix this by removing
the extraneous snd_ctl_free_one call.

Issue found using static analysis with CoverityScan, CID 1372908

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4bd68de76130..99b5b0835c1e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1030,10 +1030,8 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 		return -ENOMEM;
 
 	ret = snd_ctl_add(card, kctrl);
-	if (ret < 0) {
-		snd_ctl_free_one(kctrl);
+	if (ret < 0)
 		return ret;
-	}
 
 	cfg->update = update;
 	cfg->card = card;
-- 
2.11.0
