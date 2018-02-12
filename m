From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove rtd->platform checck" to the asoc tree
Date: Mon, 12 Feb 2018 12:32:54 +0000
Message-ID: <E1elDHy-0003UN-ST@debutante>
References: <87shhl5f0o.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shhl5f0o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove rtd->platform checck

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

>From bbf4d71aa9e21e8ee05e16cbb2cd2999252ce930 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:40:28 +0000
Subject: [PATCH] ASoC: remove rtd->platform checck

Now, we are ready to replace rtd->platform to rtdcom list.
>From this patch, rtd->platform check is no longer needed.
It will be replaced into rtdcom.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..9558125b448d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1162,11 +1162,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 		rtd->platform = platform;
 	}
-	if (!rtd->platform) {
-		dev_err(card->dev, "ASoC: platform %s not registered\n",
-			dai_link->platform_name);
-		goto _err_defer;
-	}
 
 	soc_add_pcm_runtime(card, rtd);
 	return 0;
-- 
2.16.1
