From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: add symmetric_rates flag" to
	the asoc tree
Date: Wed, 26 Jul 2017 15:17:18 +0100
Message-ID: <E1daN7m-0003bo-AD@debutante>
References: <1501054106-25264-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BE3326746B
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:27 +0200 (CEST)
In-Reply-To: <1501054106-25264-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: add symmetric_rates flag

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

>From 8215313c8bf487b6b15839be3c18fdd1598b1e79 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 26 Jul 2017 15:28:26 +0800
Subject: [PATCH] ASoC: rt5670: add symmetric_rates flag

rt5670 requires symmetric rate of capture and playback.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0ec7985ed306..174141fefc79 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2743,6 +2743,7 @@ static struct snd_soc_dai_driver rt5670_dai[] = {
 			.formats = RT5670_FORMATS,
 		},
 		.ops = &rt5670_aif_dai_ops,
+		.symmetric_rates = 1,
 	},
 	{
 		.name = "rt5670-aif2",
@@ -2762,6 +2763,7 @@ static struct snd_soc_dai_driver rt5670_dai[] = {
 			.formats = RT5670_FORMATS,
 		},
 		.ops = &rt5670_aif_dai_ops,
+		.symmetric_rates = 1,
 	},
 };
 
-- 
2.13.2
