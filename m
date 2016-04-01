From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: correct typo errors" to the asoc
	tree
Date: Fri, 01 Apr 2016 09:12:47 -0700
Message-ID: <E1am1gl-00019c-NH@finisterre>
References: <1459440058-12234-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1322D261536
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 18:13:00 +0200 (CEST)
In-Reply-To: <1459440058-12234-2-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: correct typo errors

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

>From 5ba10dd4a1727714faaac9a48f6aa69d8ee33248 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 31 Mar 2016 18:00:55 +0200
Subject: [PATCH] ASoC: sti: correct typo errors

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  4 ++--
 sound/soc/sti/uniperif.h                           | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 028fa1c82f50..f546dd914812 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -65,7 +65,7 @@ Example:
 		reg = <0x8D82000 0x158>;
 		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 4 0 1>;
-		dai-name = "Uni Player #1 (DAC)";
+		dai-name = "Uni Player #2 (DAC)";
 		dma-names = "tx";
 		uniperiph-id = <2>;
 		version = <5>;
@@ -82,7 +82,7 @@ Example:
 		interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 		dmas = <&fdma0 7 0 1>;
 		dma-names = "tx";
-		dai-name = "Uni Player #1 (PIO)";
+		dai-name = "Uni Player #3 (SPDIF)";
 		uniperiph-id = <3>;
 		version = <5>;
 		mode = "SPDIF";
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index f0fd5a9944e9..1f82faafb869 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -25,7 +25,7 @@
 	writel_relaxed((((value) & mask) << shift), ip->base + offset)
 
 /*
- * AUD_UNIPERIF_SOFT_RST reg
+ * UNIPERIF_SOFT_RST reg
  */
 
 #define UNIPERIF_SOFT_RST_OFFSET(ip) 0x0000
@@ -50,7 +50,7 @@
 		UNIPERIF_SOFT_RST_SOFT_RST_MASK(ip))
 
 /*
- * AUD_UNIPERIF_FIFO_DATA reg
+ * UNIPERIF_FIFO_DATA reg
  */
 
 #define UNIPERIF_FIFO_DATA_OFFSET(ip) 0x0004
@@ -58,7 +58,7 @@
 	writel_relaxed(value, ip->base + UNIPERIF_FIFO_DATA_OFFSET(ip))
 
 /*
- * AUD_UNIPERIF_CHANNEL_STA_REGN reg
+ * UNIPERIF_CHANNEL_STA_REGN reg
  */
 
 #define UNIPERIF_CHANNEL_STA_REGN(ip, n) (0x0060 + (4 * n))
@@ -105,7 +105,7 @@
 	writel_relaxed(value, ip->base + UNIPERIF_CHANNEL_STA_REG5_OFFSET(ip))
 
 /*
- *  AUD_UNIPERIF_ITS reg
+ *  UNIPERIF_ITS reg
  */
 
 #define UNIPERIF_ITS_OFFSET(ip) 0x000C
@@ -143,7 +143,7 @@
 		0 : (BIT(UNIPERIF_ITS_UNDERFLOW_REC_FAILED_SHIFT(ip))))
 
 /*
- *  AUD_UNIPERIF_ITS_BCLR reg
+ *  UNIPERIF_ITS_BCLR reg
  */
 
 /* FIFO_ERROR */
@@ -160,7 +160,7 @@
 	writel_relaxed(value, ip->base + UNIPERIF_ITS_BCLR_OFFSET(ip))
 
 /*
- *  AUD_UNIPERIF_ITM reg
+ *  UNIPERIF_ITM reg
  */
 
 #define UNIPERIF_ITM_OFFSET(ip) 0x0018
@@ -188,7 +188,7 @@
 		0 : (BIT(UNIPERIF_ITM_UNDERFLOW_REC_FAILED_SHIFT(ip))))
 
 /*
- *  AUD_UNIPERIF_ITM_BCLR reg
+ *  UNIPERIF_ITM_BCLR reg
  */
 
 #define UNIPERIF_ITM_BCLR_OFFSET(ip) 0x001c
@@ -213,7 +213,7 @@
 		UNIPERIF_ITM_BCLR_DMA_ERROR_MASK(ip))
 
 /*
- *  AUD_UNIPERIF_ITM_BSET reg
+ *  UNIPERIF_ITM_BSET reg
  */
 
 #define UNIPERIF_ITM_BSET_OFFSET(ip) 0x0020
@@ -767,7 +767,7 @@
 	SET_UNIPERIF_REG(ip, \
 		UNIPERIF_CTRL_OFFSET(ip), \
 		UNIPERIF_CTRL_READER_OUT_SEL_SHIFT(ip), \
-		CORAUD_UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip), 1)
+		UNIPERIF_CTRL_READER_OUT_SEL_MASK(ip), 1)
 
 /* UNDERFLOW_REC_WINDOW */
 #define UNIPERIF_CTRL_UNDERFLOW_REC_WINDOW_SHIFT(ip) 20
@@ -1046,7 +1046,7 @@
 		UNIPERIF_STATUS_1_UNDERFLOW_DURATION_MASK(ip), value)
 
 /*
- * AUD_UNIPERIF_CHANNEL_STA_REGN reg
+ * UNIPERIF_CHANNEL_STA_REGN reg
  */
 
 #define UNIPERIF_CHANNEL_STA_REGN(ip, n) (0x0060 + (4 * n))
@@ -1057,7 +1057,7 @@
 			UNIPERIF_CHANNEL_STA_REGN(ip, n))
 
 /*
- * AUD_UNIPERIF_USER_VALIDITY reg
+ * UNIPERIF_USER_VALIDITY reg
  */
 
 #define UNIPERIF_USER_VALIDITY_OFFSET(ip) 0x0090
-- 
2.8.0.rc3
