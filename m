From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Remove .num_reg_defaults_raw
	from regmap_config" to the asoc tree
Date: Wed, 21 Sep 2016 13:55:55 +0100
Message-ID: <E1bmh47-0001Vf-UO@debutante>
References: <20160919193029.8119-5-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97FCB2606F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 14:56:09 +0200 (CEST)
In-Reply-To: <20160919193029.8119-5-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Remove .num_reg_defaults_raw from regmap_config

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

>From 7de2763d9b325ee5e7e24ac513c93394406cfefa Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Mon, 19 Sep 2016 21:30:29 +0200
Subject: [PATCH] ASoC: fsl_ssi: Remove .num_reg_defaults_raw from
 regmap_config

This driver provides no .reg_defaults_raw in regmap_config, so
the .num_reg_defaults_raw is useless, and, in fact harmful. It
triggers kernel crash in regmap_init which tries to access the
register defaults.

Signed-off-by: Marek Vasut <marex@denx.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 50349437d961..b73c102f1cf2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -177,7 +177,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / sizeof(uint32_t) + 1,
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
@@ -1501,8 +1500,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 * don't have SACC{ST,EN,DIS} regs.
 		 */
 		regconfig.max_register = CCSR_SSI_SRMSK;
-		regconfig.num_reg_defaults_raw =
-			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
 	}
 
 	ret = of_property_match_string(np, "clock-names", "ipg");
-- 
2.8.1
