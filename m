From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: Uninitialized variable in probe()" to the asoc tree
Date: Fri, 25 Nov 2016 13:09:58 +0000
Message-ID: <E1cAGGM-00054x-Q1@debutante>
References: <20161123222906.GA27895@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161123222906.GA27895@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: Uninitialized variable in probe()

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

>From 999982ef7c7f8aa131d32ef551897804443a40a1 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 24 Nov 2016 01:29:06 +0300
Subject: [PATCH] ASoC: sunxi: Uninitialized variable in probe()

Oddly enough, my version of GCC misses this uninitialized variable.

Fixes: ba2ff3027b5a ("ASoC: sunxi: Add support for A23/A33/H3 codec's analog path controls")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 222bbd440b1e..af02290ebe49 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -589,7 +589,7 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 	}
 
 	if (quirks->has_hmic) {
-		sun8i_codec_add_hmic(cmpnt);
+		ret = sun8i_codec_add_hmic(cmpnt);
 		if (ret)
 			return ret;
 	}
-- 
2.10.2

