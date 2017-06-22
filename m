From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: make array ni_div static const" to the asoc tree
Date: Thu, 22 Jun 2017 15:18:31 +0100
Message-ID: <E1dO2wJ-0007YV-09@debutante>
References: <20170622093231.11389-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170622093231.11389-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: make array ni_div static const

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

>From 1943b0661184a5d17f31624dc8ac2c02a086c998 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 22 Jun 2017 10:32:31 +0100
Subject: [PATCH] ASoC: max9867: make array ni_div static const

The array ni_div does not need to be in global scope and is not
modified, so make it static const.

Cleans up sparse warning:
"symbol 'ni_div' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 0247edc9c84e..2a40a69a7513 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -132,7 +132,7 @@ enum rates {
 	pcm_rate_48, max_pcm_rate,
 };
 
-struct ni_div_rates {
+static const struct ni_div_rates {
 	u32 mclk;
 	u16 ni[max_pcm_rate];
 } ni_div[] = {
-- 
2.11.0
