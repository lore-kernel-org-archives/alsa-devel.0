From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: add missing registers
	and bits
Date: Wed,  4 Jul 2012 08:12:50 +0200
Message-ID: <1341382371-4515-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id DCDEF1042FC
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 08:13:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
List-Id: alsa-devel@alsa-project.org

Adds register and bit shift definitions in header file.
Changes are for TLV320AIC310x based on data sheet.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.h |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 06a1978..586c5d5 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -13,7 +13,7 @@
 #define _AIC3X_H
 
 /* AIC3X register space */
-#define AIC3X_CACHEREGNUM		103
+#define AIC3X_CACHEREGNUM		110
 
 /* Page select register */
 #define AIC3X_PAGE_SELECT		0
@@ -74,6 +74,8 @@
 #define HPLCOM_CFG			37
 /* Right High Power Output control registers */
 #define HPRCOM_CFG			38
+/* High Power Output Stage Control Register */
+#define HPOUT_SC			40
 /* DAC Output Switching control registers */
 #define DAC_LINE_MUX			41
 /* High Power Output Driver Pop Reduction registers */
@@ -148,6 +150,17 @@
 #define AIC3X_GPIOB_REG			101
 /* Clock generation control register */
 #define AIC3X_CLKGEN_CTRL_REG		102
+/* New AGC registers */
+#define LAGCN_ATTACK			103
+#define LAGCN_DECAY			104
+#define RAGCN_ATTACK			105
+#define RAGCN_DECAY			106
+/* New Programmable ADC Digital Path and I2C Bus Condition Register */
+#define NEW_ADC_DIGITALPATH		107
+/* Passive Analog Signal Bypass Selection During Powerdown Register */
+#define PASSIVE_BYPASS			108
+/* DAC Quiescent Current Adjustment Register */
+#define DAC_ICC_ADJ			109
 
 /* Page select register bits */
 #define PAGE0_SELECT		0
@@ -163,6 +176,10 @@
 #define DUAL_RATE_MODE		((1 << 5) | (1 << 6))
 #define LDAC2LCH		(0x1 << 3)
 #define RDAC2RCH		(0x1 << 1)
+#define LDAC2RCH		(0x2 << 3)
+#define RDAC2LCH		(0x2 << 1)
+#define LDAC2MONOMIX		(0x3 << 3)
+#define RDAC2MONOMIX		(0x3 << 1)
 
 /* PLL registers bitfields */
 #define PLLP_SHIFT		0
-- 
1.7.7
