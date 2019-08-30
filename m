From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: fix space issues" to
	the asoc tree
Date: Fri, 30 Aug 2019 17:06:08 +0100 (BST)
Message-ID: <20190830160608.0EFC22742CA7@ypsilon.sirena.org.uk>
References: <20190830074240.195166-5-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C392BF800D1
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 18:06:09 +0200 (CEST)
In-Reply-To: <20190830074240.195166-5-tzungbi@google.com>
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

   ASoC: mediatek: mt8183: fix space issues

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

>From e5b3ae3e8c4772106713698075a87bff1e86e710 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 30 Aug 2019 15:42:40 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: fix space issues

Fix space issues:
- No space before ';'.
- No trailing blank line.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20190830074240.195166-5-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 30a7735c4af3..bb9cdc0d6552 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -471,7 +471,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->pinctrl);
 	}
 
-	for (i = 0 ; i < PIN_STATE_MAX ; i++) {
+	for (i = 0; i < PIN_STATE_MAX; i++) {
 		priv->pin_states[i] = pinctrl_lookup_state(priv->pinctrl,
 							   mt8183_pin_str[i]);
 		if (IS_ERR(priv->pin_states[i])) {
@@ -526,4 +526,3 @@ MODULE_DESCRIPTION("MT8183-MT6358-TS3A227-MAX98357 ALSA SoC machine driver");
 MODULE_AUTHOR("Shunli Wang <shunli.wang@mediatek.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("mt8183_mt6358_ts3a227_max98357 soc card");
-
-- 
2.20.1
