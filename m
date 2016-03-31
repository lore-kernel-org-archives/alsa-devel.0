From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 1/4] ASoC: sti: correct typo errors
Date: Thu, 31 Mar 2016 18:00:55 +0200
Message-ID: <1459440058-12234-2-git-send-email-moise.gergaud@st.com>
References: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 94161261ACD
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 18:01:22 +0200 (CEST)
In-Reply-To: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt |  4 ++--
 sound/soc/sti/uniperif.h                           | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index 028fa1c..f546dd9 100644
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
index f0fd5a9..1f82faa 100644
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
1.9.1
