From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: add missing 64000 in ak4613_dai_hw_params()" to the asoc tree
Date: Wed, 14 Jun 2017 11:12:47 +0100
Message-ID: <E1dL5I7-0007dd-Ib@debutante>
References: <87fuf39zzs.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87fuf39zzs.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: add missing 64000 in ak4613_dai_hw_params()

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

>From a83ac4860925e1d0a7e38e7bea331fd2f2e0460d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jun 2017 00:31:06 +0000
Subject: [PATCH] ASoC: ak4613: add missing 64000 in ak4613_dai_hw_params()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index e3121ca3d1a2..d5beca008dea 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -321,6 +321,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		ctrl2 = DFS_NORMAL_SPEED;
 		break;
+	case 64000:
 	case 88200:
 	case 96000:
 		ctrl2 = DFS_DOUBLE_SPEED;
-- 
2.11.0
