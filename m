From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Sun, 17 Jan 2016 00:56:23 +0100
Message-ID: <569AD8A7.7080803@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>	<CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>	<CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>	<5693B4C1.4060400@maciej.szmigiero.name>
 <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D9C826044E
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 00:56:34 +0100 (CET)
In-Reply-To: <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 11.01.2016 15:05, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Mon, Jan 11, 2016 at 11:57 AM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> Hi Fabio,
> 
>> This will disable register cache so it isn't right.
>> Could you try REGCACHE_FLAT instead, please?
> 
> Yes, with REGCACHE_FLAT I don't get the warning.
> 
> Regards,

Is it possible for you to test the following updated patch?

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 40dfd8a36484..16ee5745c992 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -112,20 +112,6 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val tx;
 };
 
-static const struct reg_default fsl_ssi_reg_defaults[] = {
-	{CCSR_SSI_SCR,     0x00000000},
-	{CCSR_SSI_SIER,    0x00003003},
-	{CCSR_SSI_STCR,    0x00000200},
-	{CCSR_SSI_SRCR,    0x00000200},
-	{CCSR_SSI_STCCR,   0x00040000},
-	{CCSR_SSI_SRCCR,   0x00040000},
-	{CCSR_SSI_SACNT,   0x00000000},
-	{CCSR_SSI_STMSK,   0x00000000},
-	{CCSR_SSI_SRMSK,   0x00000000},
-	{CCSR_SSI_SACCEN,  0x00000000},
-	{CCSR_SSI_SACCDIS, 0x00000000},
-};
-
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -184,14 +170,27 @@ static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct regmap_config fsl_ssi_regconfig_imx21 = {
+	.max_register = CCSR_SSI_SRMSK,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.num_reg_defaults_raw = CCSR_SSI_SRMSK / 4 + 1,
+	.readable_reg = fsl_ssi_readable_reg,
+	.volatile_reg = fsl_ssi_volatile_reg,
+	.precious_reg = fsl_ssi_precious_reg,
+	.writeable_reg = fsl_ssi_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static const struct regmap_config fsl_ssi_regconfig = {
 	.max_register = CCSR_SSI_SACCDIS,
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.reg_defaults = fsl_ssi_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
+	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / 4 + 1,
 	.readable_reg = fsl_ssi_readable_reg,
 	.volatile_reg = fsl_ssi_volatile_reg,
 	.precious_reg = fsl_ssi_precious_reg,
@@ -201,6 +200,7 @@ static const struct regmap_config fsl_ssi_regconfig = {
 
 struct fsl_ssi_soc_data {
 	bool imx;
+	bool imx21regs;
 	bool offline_config;
 	u32 sisr_write_mask;
 };
@@ -295,6 +295,7 @@ struct fsl_ssi_private {
 
 static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
 	.imx = false,
+	.imx21regs = false,
 	.offline_config = true,
 	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
 			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
@@ -303,12 +304,14 @@ static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
 
 static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
 	.imx = true,
+	.imx21regs = true,
 	.offline_config = true,
 	.sisr_write_mask = 0,
 };
 
 static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
 	.imx = true,
+	.imx21regs = false,
 	.offline_config = true,
 	.sisr_write_mask = CCSR_SSI_SISR_RFRC | CCSR_SSI_SISR_TFRC |
 			CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
@@ -317,6 +320,7 @@ static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
 
 static struct fsl_ssi_soc_data fsl_ssi_imx51 = {
 	.imx = true,
+	.imx21regs = false,
 	.offline_config = false,
 	.sisr_write_mask = CCSR_SSI_SISR_ROE0 | CCSR_SSI_SISR_ROE1 |
 		CCSR_SSI_SISR_TUE0 | CCSR_SSI_SISR_TUE1,
@@ -586,8 +590,11 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	 */
 	regmap_write(regs, CCSR_SSI_SACNT,
 			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
-	regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
-	regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
+
+	if (!ssi_private->soc->imx21regs) {
+		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
+	}
 
 	/*
 	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
@@ -1397,6 +1404,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
+	const struct regmap_config *regconfig;
 
 	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
 	if (!of_id || !of_id->data)
@@ -1444,15 +1452,21 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return PTR_ERR(iomem);
 	ssi_private->ssi_phys = res->start;
 
+	if (ssi_private->soc->imx21regs)
+		regconfig = &fsl_ssi_regconfig_imx21;
+	else
+		regconfig = &fsl_ssi_regconfig;
+
 	ret = of_property_match_string(np, "clock-names", "ipg");
 	if (ret < 0) {
 		ssi_private->has_ipg_clk_name = false;
 		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
-			&fsl_ssi_regconfig);
+							  regconfig);
 	} else {
 		ssi_private->has_ipg_clk_name = true;
 		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
-			"ipg", iomem, &fsl_ssi_regconfig);
+							      "ipg", iomem,
+							      regconfig);
 	}
 	if (IS_ERR(ssi_private->regs)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");


You'll also need to apply regmap fix from
http://www.spinics.net/lists/kernel/msg2161934.html to make it work.

Thanks in advance.

> Fabio Estevam

Best regards,
Maciej Szmigiero

 
