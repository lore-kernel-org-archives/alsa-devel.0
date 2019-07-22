From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: make headset codec
	optional" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:07 +0100 (BST)
Message-ID: <20190722122207.DD56927429FC@ypsilon.sirena.org.uk>
References: <20190716032417.19015-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC53CF800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 14:22:09 +0200 (CEST)
In-Reply-To: <20190716032417.19015-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: make headset codec optional

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 2d7df506d176265d97bece4b55faa60ce7926970 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 16 Jul 2019 11:24:17 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: make headset codec optional

Make headset codec optional because some variant machines may not
have an audio jack.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190716032417.19015-1-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 887c932229d0..4c816c86844b 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -352,8 +352,6 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.owner = THIS_MODULE,
 	.dai_link = mt8183_mt6358_ts3a227_max98357_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dai_links),
-	.aux_dev = &mt8183_mt6358_ts3a227_max98357_headset_dev,
-	.num_aux_devs = 1,
 };
 
 static int
@@ -404,10 +402,9 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "mediatek,headset-codec", 0);
-	if (!mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'mediatek,headset-codec' missing/invalid\n");
-		return -EINVAL;
+	if (mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node) {
+		card->aux_dev = &mt8183_mt6358_ts3a227_max98357_headset_dev;
+		card->num_aux_devs = 1;
 	}
 
 	default_pins =
-- 
2.20.1
