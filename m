From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Fix potential
	uninitialized variable" to the asoc tree
Date: Wed, 10 Apr 2019 13:26:45 +0100 (BST)
Message-ID: <20190410122645.CEA4C1128ED2@debutante.sirena.org.uk>
References: <20190409044159.17202-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4700BF8971D
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 14:26:47 +0200 (CEST)
In-Reply-To: <20190409044159.17202-1-nh6z@nh6z.net>
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
Cc: team@nwdigitalradio.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Fix potential uninitialized variable

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

>From c243796d070676e9c38c34046a44b1cd3f3fe030 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Mon, 8 Apr 2019 21:41:59 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Fix potential uninitialized variable

Fix compiler warning about uninitialized variable reported by
Stephen Rothwell <sfr@canb.auug.org.au>.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 9e4899eb1d8e..156c153c12ab 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -82,7 +82,7 @@ static int clk_aic32x4_pll_get_muldiv(struct clk_aic32x4 *pll,
 	int ret;
 
 	ret = regmap_read(pll->regmap, AIC32X4_PLLPR, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	settings->r = val & AIC32X4_PLL_R_MASK;
 	settings->p = (val & AIC32X4_PLL_P_MASK) >> AIC32X4_PLL_P_SHIFT;
-- 
2.20.1
