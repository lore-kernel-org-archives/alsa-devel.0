From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-sai: add default register map for
	regmap cache" to the asoc tree
Date: Wed, 28 Oct 2015 10:09:16 +0900
Message-ID: <E1ZrFEq-0000up-8s@finisterre>
References: <1445843945-13319-2-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D61902659D3
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 02:09:27 +0100 (CET)
In-Reply-To: <1445843945-13319-2-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-sai: add default register map for regmap cache

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

>From b9b21722ff2e431c85d33bcc950327093cf9a991 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Mon, 26 Oct 2015 15:19:03 +0800
Subject: [PATCH] ASoC: fsl-sai: add default register map for regmap cache

FSL_SAI_TDR register is writable and not readable. According to
regmap_volatile() function, if FSL_SAI_TDR want to be volatile,
it should be readable. So we should remove FSL_SAI_TDR from volatile
register list.

If the flat cache don't have default register map, when do regcache_sync
operation, the non volatile and writable registers will be synchronised
to 0. FSL_SAI_TDR reigster will be written a 0 and cause channel swap.
So add default register map for flat cache, and such register will not
be written.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a4435f5..987fc54 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -608,6 +608,22 @@ static const struct snd_soc_component_driver fsl_component = {
 	.name           = "fsl-sai",
 };
 
+static struct reg_default fsl_sai_reg_defaults[] = {
+	{FSL_SAI_TCR1, 0},
+	{FSL_SAI_TCR2, 0},
+	{FSL_SAI_TCR3, 0},
+	{FSL_SAI_TCR4, 0},
+	{FSL_SAI_TCR5, 0},
+	{FSL_SAI_TDR,  0},
+	{FSL_SAI_TMR,  0},
+	{FSL_SAI_RCR1, 0},
+	{FSL_SAI_RCR2, 0},
+	{FSL_SAI_RCR3, 0},
+	{FSL_SAI_RCR4, 0},
+	{FSL_SAI_RCR5, 0},
+	{FSL_SAI_RMR,  0},
+};
+
 static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -641,13 +657,11 @@ static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 	case FSL_SAI_RCSR:
 	case FSL_SAI_TFR:
 	case FSL_SAI_RFR:
-	case FSL_SAI_TDR:
 	case FSL_SAI_RDR:
 		return true;
 	default:
 		return false;
 	}
-
 }
 
 static bool fsl_sai_writeable_reg(struct device *dev, unsigned int reg)
@@ -680,6 +694,8 @@ static const struct regmap_config fsl_sai_regmap_config = {
 	.val_bits = 32,
 
 	.max_register = FSL_SAI_RMR,
+	.reg_defaults = fsl_sai_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(fsl_sai_reg_defaults),
 	.readable_reg = fsl_sai_readable_reg,
 	.volatile_reg = fsl_sai_volatile_reg,
 	.writeable_reg = fsl_sai_writeable_reg,
-- 
2.6.1
