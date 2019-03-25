From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Remove mclk references"
	to the asoc tree
Date: Mon, 25 Mar 2019 16:11:25 +0000 (GMT)
Message-ID: <20190325161125.A176411288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A4F1F801D9
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:11:26 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Remove mclk references

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 78f2d58a289302e56a7def96a783a7686ebf27e2 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Thu, 21 Mar 2019 17:58:53 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Remove mclk references

mclk is not used by anything anymore.  Remove support for it.
All that information now comes from the clock tree.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 289bf411e60e..a5457d3de1b1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -53,7 +53,6 @@ struct aic32x4_priv {
 	u32 micpga_routing;
 	bool swapdacs;
 	int rstn_gpio;
-	struct clk *mclk;
 	const char *mclk_name;
 
 	struct regulator *supply_ldo;
@@ -1190,12 +1189,6 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		aic32x4->mclk_name = "mclk";
 	}
 
-	aic32x4->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(aic32x4->mclk)) {
-		dev_err(dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
-		return PTR_ERR(aic32x4->mclk);
-	}
-
 	ret = aic32x4_register_clocks(dev, aic32x4->mclk_name);
 	if (ret)
 		return ret;
-- 
2.20.1
