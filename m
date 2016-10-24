From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for array" to the asoc tree
Date: Mon, 24 Oct 2016 19:03:39 +0100
Message-ID: <E1byjb1-00014S-QV@debutante>
References: <20161017220256.32008-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017220256.32008-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>Vinod Koul <vinod.koul@intel.com>, Yong Zhi <yong.zhi@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for array

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

>From 89c03ddbb9aafe370e7d1ebe07258ae755588bdc Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 17 Oct 2016 23:02:56 +0100
Subject: [PATCH] ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for
 array

Smatch reports below warnings:

    bxt_da7219_max98357a.c:352:9: warning: obsolete array initializer,
    use C99 syntax

An earlier commit cleaned up similar warnings, however, a recent
commit 43c02ede76a60de ("ASoC: Intel: Add DMIC channel constraint for
bxt machine") re-introduced the older initializer style. So fix
this warning to make the code consistent.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 865a21e557cc..bff80b467262 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -348,7 +348,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dynamic = 1,
 		.ops = &broxton_refcap_ops,
 	},
-	[BXT_DPCM_AUDIO_DMIC_CP]
+	[BXT_DPCM_AUDIO_DMIC_CP] =
 	{
 		.name = "Bxt Audio DMIC cap",
 		.stream_name = "dmiccap",
-- 
2.8.1
