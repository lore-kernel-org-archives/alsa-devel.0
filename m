From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Go back to explicit register
	defaults" to the asoc tree
Date: Mon, 22 Feb 2016 12:14:50 +0900
Message-ID: <E1aXgxW-0005tF-B1@finisterre>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244809363051858412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EE4B2606C3
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:15:01 +0100 (CET)
In-Reply-To: <1456065300-23752-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1244809363051858412==
Content-Type: text/plain

The patch

   ASoC: fsl_ssi: Go back to explicit register defaults

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

>From 56e5fd8feb286ab71f4ca7674505b0d17967376d Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 21 Feb 2016 11:35:00 -0300
Subject: [PATCH] ASoC: fsl_ssi: Go back to explicit register defaults
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 5c408fee2546 ("ASoC: fsl_ssi: remove explicit register defaults")
causes the driver to fail to probe:

fsl-ssi-dai 2028000.ssi: No cache defaults, reading back from HW
fsl-ssi-dai 2028000.ssi: Failed to init register map
fsl-ssi-dai: probe of 2028000.ssi failed with error -22

, so revert this commit.

Reported-by: Mika Penttilä <mika.penttila@nextfour.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ed8de10..40dfd8a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -112,6 +112,20 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val tx;
 };
 
+static const struct reg_default fsl_ssi_reg_defaults[] = {
+	{CCSR_SSI_SCR,     0x00000000},
+	{CCSR_SSI_SIER,    0x00003003},
+	{CCSR_SSI_STCR,    0x00000200},
+	{CCSR_SSI_SRCR,    0x00000200},
+	{CCSR_SSI_STCCR,   0x00040000},
+	{CCSR_SSI_SRCCR,   0x00040000},
+	{CCSR_SSI_SACNT,   0x00000000},
+	{CCSR_SSI_STMSK,   0x00000000},
+	{CCSR_SSI_SRMSK,   0x00000000},
+	{CCSR_SSI_SACCEN,  0x00000000},
+	{CCSR_SSI_SACCDIS, 0x00000000},
+};
+
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -176,7 +190,8 @@ static const struct regmap_config fsl_ssi_regconfig = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / sizeof(uint32_t) + 1,
+	.reg_defaults = fsl_ssi_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
@@ -186,7 +201,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
 
 struct fsl_ssi_soc_data {
 	bool imx;
-	bool imx21regs; /* imx21-class SSI - no SACC{ST,EN,DIS} regs */
 	bool offline_config;
 	u32 sisr_write_mask;
 };
@@ -289,7 +303,6 @@ static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
 
 static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
 	.imx = true,
-	.imx21regs = true,
 	.offline_config = true,
 	.sisr_write_mask = 0,
 };
@@ -573,12 +586,8 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	 */
 	regmap_write(regs, CCSR_SSI_SACNT,
 			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
-
-	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
-	if (!ssi_private->soc->imx21regs) {
-		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
-		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
-	}
+	regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+	regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
 
 	/*
 	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
@@ -1388,7 +1397,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
-	struct regmap_config regconfig = fsl_ssi_regconfig;
 
 	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
 	if (!of_id || !of_id->data)
@@ -1436,25 +1444,15 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return PTR_ERR(iomem);
 	ssi_private->ssi_phys = res->start;
 
-	if (ssi_private->soc->imx21regs) {
-		/*
-		 * According to datasheet imx21-class SSI
-		 * don't have SACC{ST,EN,DIS} regs.
-		 */
-		regconfig.max_register = CCSR_SSI_SRMSK;
-		regconfig.num_reg_defaults_raw =
-			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
-	}
-
 	ret = of_property_match_string(np, "clock-names", "ipg");
 	if (ret < 0) {
 		ssi_private->has_ipg_clk_name = false;
 		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
-			&regconfig);
+			&fsl_ssi_regconfig);
 	} else {
 		ssi_private->has_ipg_clk_name = true;
 		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
-			"ipg", iomem, &regconfig);
+			"ipg", iomem, &fsl_ssi_regconfig);
 	}
 	if (IS_ERR(ssi_private->regs)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");
-- 
2.7.0


--===============1244809363051858412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1244809363051858412==--
