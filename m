From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: fix mic jack initialization" to the asoc tree
Date: Fri, 19 May 2017 18:03:27 +0100
Message-ID: <E1dBlJH-0003a2-KL@debutante>
References: <20170515210031.9983-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170515210031.9983-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgkuninori.morimoto.gx@renesas.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: fix mic jack initialization

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

>From f746aa5e8636c83e53bbb2d988bb614f732b2b80 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Mon, 15 May 2017 14:00:31 -0700
Subject: [PATCH] ASoC: simple-card: fix mic jack initialization

Initialize asoc_simple_card_init_mic with the correct struct
asoc_simple_jack.

Fixes: 9eac361877b3 ("ASoC: simple-card: add new asoc_simple_jack and use it")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2c9dedab5184..bc136d2bd7cd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -202,7 +202,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->hp_jack, PREFIX);
+	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
 	if (ret < 0)
 		return ret;
 
-- 
2.11.0
