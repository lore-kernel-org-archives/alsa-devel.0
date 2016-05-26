From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Make the register values
	human readable
Date: Thu, 26 May 2016 10:36:35 +0300
Message-ID: <20160526073635.6709-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E3D2651D1
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 09:36:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The datasheet uses decimal numbers for the register addresses, convert the
register values from hexadecimal to decimal and introduce macro for the
register definitions. This way it is easier to look up registers in the
documentation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.h | 134 ++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index fe16c34607bb..ac9b146526eb 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -38,141 +38,143 @@ struct aic31xx_pdata {
 	int micbias_vg;
 };
 
+#define AIC31XX_REG(page, reg)	((page * 128) + reg)
+
 /* Page Control Register */
-#define AIC31XX_PAGECTL				0x00
+#define AIC31XX_PAGECTL		AIC31XX_REG(0, 0)
 
 /* Page 0 Registers */
 /* Software reset register */
-#define AIC31XX_RESET				0x01
+#define AIC31XX_RESET		AIC31XX_REG(0, 1)
 /* OT FLAG register */
-#define AIC31XX_OT_FLAG				0x03
+#define AIC31XX_OT_FLAG		AIC31XX_REG(0, 3)
 /* Clock clock Gen muxing, Multiplexers*/
-#define AIC31XX_CLKMUX				0x04
+#define AIC31XX_CLKMUX		AIC31XX_REG(0, 4)
 /* PLL P and R-VAL register */
-#define AIC31XX_PLLPR				0x05
+#define AIC31XX_PLLPR		AIC31XX_REG(0, 5)
 /* PLL J-VAL register */
-#define AIC31XX_PLLJ				0x06
+#define AIC31XX_PLLJ		AIC31XX_REG(0, 6)
 /* PLL D-VAL MSB register */
-#define AIC31XX_PLLDMSB				0x07
+#define AIC31XX_PLLDMSB		AIC31XX_REG(0, 7)
 /* PLL D-VAL LSB register */
-#define AIC31XX_PLLDLSB				0x08
+#define AIC31XX_PLLDLSB		AIC31XX_REG(0, 8)
 /* DAC NDAC_VAL register*/
-#define AIC31XX_NDAC				0x0B
+#define AIC31XX_NDAC		AIC31XX_REG(0, 11)
 /* DAC MDAC_VAL register */
-#define AIC31XX_MDAC				0x0C
+#define AIC31XX_MDAC		AIC31XX_REG(0, 12)
 /* DAC OSR setting register 1, MSB value */
-#define AIC31XX_DOSRMSB				0x0D
+#define AIC31XX_DOSRMSB		AIC31XX_REG(0, 13)
 /* DAC OSR setting register 2, LSB value */
-#define AIC31XX_DOSRLSB				0x0E
-#define AIC31XX_MINI_DSP_INPOL			0x10
+#define AIC31XX_DOSRLSB		AIC31XX_REG(0, 14)
+#define AIC31XX_MINI_DSP_INPOL	AIC31XX_REG(0, 16)
 /* Clock setting register 8, PLL */
-#define AIC31XX_NADC				0x12
+#define AIC31XX_NADC		AIC31XX_REG(0, 18)
 /* Clock setting register 9, PLL */
-#define AIC31XX_MADC				0x13
+#define AIC31XX_MADC		AIC31XX_REG(0, 19)
 /* ADC Oversampling (AOSR) Register */
-#define AIC31XX_AOSR				0x14
+#define AIC31XX_AOSR		AIC31XX_REG(0, 20)
 /* Clock setting register 9, Multiplexers */
-#define AIC31XX_CLKOUTMUX			0x19
+#define AIC31XX_CLKOUTMUX	AIC31XX_REG(0, 25)
 /* Clock setting register 10, CLOCKOUT M divider value */
-#define AIC31XX_CLKOUTMVAL			0x1A
+#define AIC31XX_CLKOUTMVAL	AIC31XX_REG(0, 26)
 /* Audio Interface Setting Register 1 */
-#define AIC31XX_IFACE1				0x1B
+#define AIC31XX_IFACE1		AIC31XX_REG(0, 27)
 /* Audio Data Slot Offset Programming */
-#define AIC31XX_DATA_OFFSET			0x1C
+#define AIC31XX_DATA_OFFSET	AIC31XX_REG(0, 28)
 /* Audio Interface Setting Register 2 */
-#define AIC31XX_IFACE2				0x1D
+#define AIC31XX_IFACE2		AIC31XX_REG(0, 29)
 /* Clock setting register 11, BCLK N Divider */
-#define AIC31XX_BCLKN				0x1E
+#define AIC31XX_BCLKN		AIC31XX_REG(0, 30)
 /* Audio Interface Setting Register 3, Secondary Audio Interface */
-#define AIC31XX_IFACESEC1			0x1F
+#define AIC31XX_IFACESEC1	AIC31XX_REG(0, 31)
 /* Audio Interface Setting Register 4 */
-#define AIC31XX_IFACESEC2			0x20
+#define AIC31XX_IFACESEC2	AIC31XX_REG(0, 32)
 /* Audio Interface Setting Register 5 */
-#define AIC31XX_IFACESEC3			0x21
+#define AIC31XX_IFACESEC3	AIC31XX_REG(0, 33)
 /* I2C Bus Condition */
-#define AIC31XX_I2C				0x22
+#define AIC31XX_I2C		AIC31XX_REG(0, 34)
 /* ADC FLAG */
-#define AIC31XX_ADCFLAG				0x24
+#define AIC31XX_ADCFLAG		AIC31XX_REG(0, 36)
 /* DAC Flag Registers */
-#define AIC31XX_DACFLAG1			0x25
-#define AIC31XX_DACFLAG2			0x26
+#define AIC31XX_DACFLAG1	AIC31XX_REG(0, 37)
+#define AIC31XX_DACFLAG2	AIC31XX_REG(0, 38)
 /* Sticky Interrupt flag (overflow) */
-#define AIC31XX_OFFLAG				0x27
+#define AIC31XX_OFFLAG		AIC31XX_REG(0, 39)
 /* Sticy DAC Interrupt flags */
-#define AIC31XX_INTRDACFLAG			0x2C
+#define AIC31XX_INTRDACFLAG	AIC31XX_REG(0, 44)
 /* Sticy ADC Interrupt flags */
-#define AIC31XX_INTRADCFLAG			0x2D
+#define AIC31XX_INTRADCFLAG	AIC31XX_REG(0, 45)
 /* DAC Interrupt flags 2 */
-#define AIC31XX_INTRDACFLAG2			0x2E
+#define AIC31XX_INTRDACFLAG2	AIC31XX_REG(0, 46)
 /* ADC Interrupt flags 2 */
-#define AIC31XX_INTRADCFLAG2			0x2F
+#define AIC31XX_INTRADCFLAG2	AIC31XX_REG(0, 47)
 /* INT1 interrupt control */
-#define AIC31XX_INT1CTRL			0x30
+#define AIC31XX_INT1CTRL	AIC31XX_REG(0, 48)
 /* INT2 interrupt control */
-#define AIC31XX_INT2CTRL			0x31
+#define AIC31XX_INT2CTRL	AIC31XX_REG(0, 49)
 /* GPIO1 control */
-#define AIC31XX_GPIO1				0x33
+#define AIC31XX_GPIO1		AIC31XX_REG(0, 50)
 
-#define AIC31XX_DACPRB				0x3C
+#define AIC31XX_DACPRB		AIC31XX_REG(0, 60)
 /* ADC Instruction Set Register */
-#define AIC31XX_ADCPRB				0x3D
+#define AIC31XX_ADCPRB		AIC31XX_REG(0, 61)
 /* DAC channel setup register */
-#define AIC31XX_DACSETUP			0x3F
+#define AIC31XX_DACSETUP	AIC31XX_REG(0, 63)
 /* DAC Mute and volume control register */
-#define AIC31XX_DACMUTE				0x40
+#define AIC31XX_DACMUTE		AIC31XX_REG(0, 64)
 /* Left DAC channel digital volume control */
-#define AIC31XX_LDACVOL				0x41
+#define AIC31XX_LDACVOL		AIC31XX_REG(0, 65)
 /* Right DAC channel digital volume control */
-#define AIC31XX_RDACVOL				0x42
+#define AIC31XX_RDACVOL		AIC31XX_REG(0, 66)
 /* Headset detection */
-#define AIC31XX_HSDETECT			0x43
+#define AIC31XX_HSDETECT	AIC31XX_REG(0, 67)
 /* ADC Digital Mic */
-#define AIC31XX_ADCSETUP			0x51
+#define AIC31XX_ADCSETUP	AIC31XX_REG(0, 81)
 /* ADC Digital Volume Control Fine Adjust */
-#define AIC31XX_ADCFGA				0x52
+#define AIC31XX_ADCFGA		AIC31XX_REG(0, 82)
 /* ADC Digital Volume Control Coarse Adjust */
-#define AIC31XX_ADCVOL				0x53
+#define AIC31XX_ADCVOL		AIC31XX_REG(0, 83)
 
 
 /* Page 1 Registers */
 /* Headphone drivers */
-#define AIC31XX_HPDRIVER			0x9F
+#define AIC31XX_HPDRIVER	AIC31XX_REG(1, 31)
 /* Class-D Speakear Amplifier */
-#define AIC31XX_SPKAMP				0xA0
+#define AIC31XX_SPKAMP		AIC31XX_REG(1, 32)
 /* HP Output Drivers POP Removal Settings */
-#define AIC31XX_HPPOP				0xA1
+#define AIC31XX_HPPOP		AIC31XX_REG(1, 33)
 /* Output Driver PGA Ramp-Down Period Control */
-#define AIC31XX_SPPGARAMP			0xA2
+#define AIC31XX_SPPGARAMP	AIC31XX_REG(1, 34)
 /* DAC_L and DAC_R Output Mixer Routing */
-#define AIC31XX_DACMIXERROUTE			0xA3
+#define AIC31XX_DACMIXERROUTE	AIC31XX_REG(1, 35)
 /* Left Analog Vol to HPL */
-#define AIC31XX_LANALOGHPL			0xA4
+#define AIC31XX_LANALOGHPL	AIC31XX_REG(1, 36)
 /* Right Analog Vol to HPR */
-#define AIC31XX_RANALOGHPR			0xA5
+#define AIC31XX_RANALOGHPR	AIC31XX_REG(1, 37)
 /* Left Analog Vol to SPL */
-#define AIC31XX_LANALOGSPL			0xA6
+#define AIC31XX_LANALOGSPL	AIC31XX_REG(1, 38)
 /* Right Analog Vol to SPR */
-#define AIC31XX_RANALOGSPR			0xA7
+#define AIC31XX_RANALOGSPR	AIC31XX_REG(1, 39)
 /* HPL Driver */
-#define AIC31XX_HPLGAIN				0xA8
+#define AIC31XX_HPLGAIN		AIC31XX_REG(1, 40)
 /* HPR Driver */
-#define AIC31XX_HPRGAIN				0xA9
+#define AIC31XX_HPRGAIN		AIC31XX_REG(1, 41)
 /* SPL Driver */
-#define AIC31XX_SPLGAIN				0xAA
+#define AIC31XX_SPLGAIN		AIC31XX_REG(1, 42)
 /* SPR Driver */
-#define AIC31XX_SPRGAIN				0xAB
+#define AIC31XX_SPRGAIN		AIC31XX_REG(1, 43)
 /* HP Driver Control */
-#define AIC31XX_HPCONTROL			0xAC
+#define AIC31XX_HPCONTROL	AIC31XX_REG(1, 44)
 /* MIC Bias Control */
-#define AIC31XX_MICBIAS				0xAE
+#define AIC31XX_MICBIAS		AIC31XX_REG(1, 46)
 /* MIC PGA*/
-#define AIC31XX_MICPGA				0xAF
+#define AIC31XX_MICPGA		AIC31XX_REG(1, 47)
 /* Delta-Sigma Mono ADC Channel Fine-Gain Input Selection for P-Terminal */
-#define AIC31XX_MICPGAPI			0xB0
+#define AIC31XX_MICPGAPI	AIC31XX_REG(1, 48)
 /* ADC Input Selection for M-Terminal */
-#define AIC31XX_MICPGAMI			0xB1
+#define AIC31XX_MICPGAMI	AIC31XX_REG(1, 49)
 /* Input CM Settings */
-#define AIC31XX_MICPGACM			0xB2
+#define AIC31XX_MICPGACM	AIC31XX_REG(1, 50)
 
 /* Bits, masks and shifts */
 
-- 
2.8.3
