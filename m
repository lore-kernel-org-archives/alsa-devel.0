From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: fsl: Update set_tdm_slot() semantics
Date: Sat, 10 Jan 2015 11:52:35 +0100
Message-ID: <1420887157-18593-3-git-send-email-lars@metafoo.de>
References: <1420887157-18593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-105.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B2FA2606A8
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 11:52:42 +0100 (CET)
In-Reply-To: <1420887157-18593-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The fsl-esai, fsl-ssi and imx-ssi drivers use inverted semantics for the
tx_mask and rx_mask parameter of the set_tdm_slot() callback compared to
rest of ASoC. This patch updates the driver's semantics to be consistent
with the rest of ASoC, i.e. a set bit means a active slot and a cleared bit
means a inactive slot.  This will allow us to use the set_tdm_slot() API in
a more generic way.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/eukrea-tlv320.c | 2 +-
 sound/soc/fsl/fsl_esai.c      | 3 +++
 sound/soc/fsl/fsl_ssi.c       | 4 ++--
 sound/soc/fsl/fsl_utils.c     | 6 +++---
 sound/soc/fsl/imx-mc13783.c   | 2 +-
 sound/soc/fsl/imx-ssi.c       | 4 ++--
 sound/soc/fsl/wm1133-ev1.c    | 4 ++--
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 8c9e900..e1aa3834 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -50,7 +50,7 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
+	snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 0);
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c75971..12ed857 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -347,6 +347,9 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 
+	tx_mask = ~tx_mask;
+	rx_mask = ~rx_mask;
+
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
 
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 65400be..791cdb3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -992,8 +992,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN,
 			CCSR_SSI_SCR_SSIEN);
 
-	regmap_write(regs, CCSR_SSI_STMSK, tx_mask);
-	regmap_write(regs, CCSR_SSI_SRMSK, rx_mask);
+	regmap_write(regs, CCSR_SSI_STMSK, ~tx_mask);
+	regmap_write(regs, CCSR_SSI_SRMSK, ~rx_mask);
 
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 2ac7755..5fd4463 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -94,7 +94,7 @@ EXPORT_SYMBOL(fsl_asoc_get_dma_channel);
  * @rx_mask: bitmask representing active RX slots.
  *
  * This function used to generate the TDM slot TX/RX mask. And the TX/RX
- * mask will use a 0 bit for an active slot as default, and the default
+ * mask will use a 1 bit for an active slot as default, and the default
  * active bits are at the LSB of the mask value.
  */
 int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
@@ -105,9 +105,9 @@ int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
 		return -EINVAL;
 
 	if (tx_mask)
-		*tx_mask = ~((1 << slots) - 1);
+		*tx_mask = ((1 << slots) - 1);
 	if (rx_mask)
-		*rx_mask = ~((1 << slots) - 1);
+		*rx_mask = ((1 << slots) - 1);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9589452..9e6493d 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -45,7 +45,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x0, 0xfffffffc, 2, 16);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index fa801e1..6aeaac3 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -74,8 +74,8 @@ static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	sccr |= SSI_STCCR_DC(slots - 1);
 	writel(sccr, ssi->base + SSI_SRCCR);
 
-	writel(tx_mask, ssi->base + SSI_STMSK);
-	writel(rx_mask, ssi->base + SSI_SRMSK);
+	writel(~tx_mask, ssi->base + SSI_STMSK);
+	writel(~rx_mask, ssi->base + SSI_SRMSK);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index d072bd1..a958937 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -106,10 +106,10 @@ static int wm1133_ev1_hw_params(struct snd_pcm_substream *substream,
 	/* TODO: The SSI driver should figure this out for us */
 	switch (channels) {
 	case 2:
-		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
+		snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 0);
 		break;
 	case 1:
-		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffe, 0xffffffe, 1, 0);
+		snd_soc_dai_set_tdm_slot(cpu_dai, 0x1, 0x1, 1, 0);
 		break;
 	default:
 		return -EINVAL;
-- 
1.8.0
