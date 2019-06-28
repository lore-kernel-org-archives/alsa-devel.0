From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-card: remove useless check on codec" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Message-ID: <20190628165628.0CCBA44004B@finisterre.sirena.org.uk>
References: <20190628081708.22039-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190628081708.22039-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-card: remove useless check on codec

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

>From 8fc22fa4b2cd983e4c542d1841b3d2212ad18ed4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 28 Jun 2019 10:17:08 +0200
Subject: [PATCH] ASoC: meson: axg-card: remove useless check on codec

While checking cpus before dereferencing the pointer is required, it is
not necessary for codecs. 'codec' can't possibly be NULL in the loop

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 70bb0cbad233..14a8321744da 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -118,8 +118,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 			if (link->cpus)
 				of_node_put(link->cpus->of_node);
 			for_each_link_codecs(link, j, codec)
-				if (codec)
-					of_node_put(codec->of_node);
+				of_node_put(codec->of_node);
 		}
 	}
 
-- 
2.20.1
