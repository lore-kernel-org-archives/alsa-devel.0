From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: defer card registration if codec component is missing" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Message-ID: <20190628165628.3FB8B44004C@finisterre.sirena.org.uk>
References: <20190627121350.21027-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627121350.21027-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: defer card registration if codec component is missing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From af18b13fedae4637b439d1265038b30929ca5a4c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 27 Jun 2019 14:13:49 +0200
Subject: [PATCH] ASoC: soc-core: defer card registration if codec component is
 missing

Like cpus and platforms, defer sound card initialization if the codec
component is missing when initializing the dai_link

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 05cd710273b6..b5f3c09311c3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1071,12 +1071,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 				link->name);
 			return -EINVAL;
 		}
+
 		/* Codec DAI name must be specified */
 		if (!codec->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
+
+		/*
+		 * Defer card registration if codec component is not added to
+		 * component list.
+		 */
+		if (!soc_find_component(codec))
+			return -EPROBE_DEFER;
 	}
 
 	/*
-- 
2.20.1
