From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: [PATCH v2] ASoC: tlv320aic3x: add missing registers
	and bits
Date: Wed, 27 Jun 2012 08:06:59 +0200
Message-ID: <4FEAA303.5020806@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 22EA22454D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 08:07:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, mr.swami.reddy@ti.com, peter.ujfalusi@ti.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, sudhakar.raj@ti.com, nsekhar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Second version of patch keeping formatting.
Adds missing register default values to cache.
Adds register and bits definitions in header file.
Changes are for TLV320AIC310x based on data sheet.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

--- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c.orig
+++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c.new
@@ -122,7 +122,9 @@
  	0x00, 0x00, 0x00, 0x00,	/* 88 */
  	0x00, 0x00, 0x00, 0x00,	/* 92 */
  	0x00, 0x00, 0x00, 0x00,	/* 96 */
-	0x00, 0x00, 0x02,	/* 100 */
+	0x00, 0x00, 0x02, 0x00,	/* 100 */
+	0x00, 0x00, 0x00, 0x00,	/* 104 */
+	0x00, 0x00,             /* 108 */
  };

--- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.h
+++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.h.new
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
