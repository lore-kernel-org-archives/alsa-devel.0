From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl-sai: add default register map for
	regmap cache
Date: Mon, 26 Oct 2015 15:19:03 +0800
Message-ID: <1445843945-13319-2-git-send-email-zidan.wang@freescale.com>
References: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 935D92604A4
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:17:18 +0100 (CET)
In-Reply-To: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/fsl/fsl_sai.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 784725b..18101b9 100644
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
1.9.1
