From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: move card
	registration to the end of probe" to the asoc tree
Date: Thu, 23 May 2019 14:48:53 +0100 (BST)
Message-ID: <20190523134853.9FB631126D24@debutante.sirena.org.uk>
References: <20190522145402.256102-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35542F89715
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 15:49:00 +0200 (CEST)
In-Reply-To: <20190522145402.256102-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: move card registration to the end of probe

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

>From 63ba8e4d04ab921f8aaa89227d2e0f7ad79725be Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 22 May 2019 22:54:02 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: move card registration to the end of
 probe

mt8183_mt6358_ts3a227_max98357_dev_probe() does not return immediately
if devm_snd_soc_register_card() returns fail.  As a result, the rest of
code still get executed.

Two options to fix:
1. add an extra return statement if devm_snd_soc_register_card()
   returns fail
2. move devm_snd_soc_register_card() to the end of probe

Adopt option 2 which is more clear and common.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 1ba7aa58e4b6..23c422f13808 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -331,7 +331,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	struct device_node *platform_node;
 	struct snd_soc_dai_link *dai_link;
 	struct pinctrl *default_pins;
-	int ret, i;
+	int i;
 
 	card->dev = &pdev->dev;
 
@@ -366,11 +366,6 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-			__func__, ret);
-
 	default_pins =
 		devm_pinctrl_get_select(&pdev->dev, PINCTRL_STATE_DEFAULT);
 	if (IS_ERR(default_pins)) {
@@ -379,7 +374,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(default_pins);
 	}
 
-	return ret;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 #ifdef CONFIG_OF
-- 
2.20.1
