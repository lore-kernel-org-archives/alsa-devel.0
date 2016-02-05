From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: add cs4271 and cs4272
	support" to the asoc tree
Date: Fri, 05 Feb 2016 13:35:13 +0000
Message-ID: <E1aRgXZ-00012P-Uv@finisterre>
References: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 434F32605F2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 14:35:32 +0100 (CET)
In-Reply-To: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: add cs4271 and cs4272 support

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

>From 57e756d30268a0373cce97165bd57331554f4bfd Mon Sep 17 00:00:00 2001
From: "Felipe F. Tonello" <eu@felipetonello.com>
Date: Fri, 29 Jan 2016 11:01:00 +0000
Subject: [PATCH] ASoC: fsl-asoc-card: add cs4271 and cs4272 support

add cs4271 and cs42727 support for fsl-asoc-card

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 9 +++++++++
 sound/soc/fsl/Kconfig                                     | 4 ++--
 sound/soc/fsl/fsl-asoc-card.c                             | 7 +++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index ce55c0a..943b36d 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -24,6 +24,9 @@ The compatible list for this generic sound card currently:
 
  "fsl,imx-audio-cs42888"
 
+ "fsl,imx-audio-cs427x"
+ (compatible with CS4271 and CS4272)
+
  "fsl,imx-audio-wm8962"
  (compatible with Documentation/devicetree/bindings/sound/imx-audio-wm8962.txt)
 
@@ -61,6 +64,12 @@ Optional properties:
   - audio-asrc		: The phandle of ASRC. It can be absent if there's no
 			  need to add ASRC support via DPCM.
 
+Optional unless SSI is selected as a CPU DAI:
+
+  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
+
+  - mux-ext-port	: The external port of the i.MX audio muxer
+
 Example:
 sound-cs42888 {
 	compatible = "fsl,imx-audio-cs42888";
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 14dfdee..35aabf9 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -292,8 +292,8 @@ config SND_SOC_FSL_ASOC_CARD
 	select SND_SOC_FSL_SSI
 	help
 	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
-	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
-	 and SGTL5000.
+	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
+	 CS4271, CS4272 and SGTL5000.
 	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
 
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3d40797..dffd549 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -28,6 +28,8 @@
 #include "../codecs/wm8962.h"
 #include "../codecs/wm8960.h"
 
+#define CS427x_SYSCLK_MCLK 0
+
 #define RX 0
 #define TX 1
 
@@ -535,6 +537,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
+		codec_dai_name = "cs4271-hifi";
+		priv->codec_priv.mclk_id = CS427x_SYSCLK_MCLK;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
 		codec_dai_name = "sgtl5000";
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
@@ -692,6 +698,7 @@ fail:
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-ac97", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
+	{ .compatible = "fsl,imx-audio-cs427x", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ .compatible = "fsl,imx-audio-wm8960", },
-- 
2.6.4
