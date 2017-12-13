From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Use AIC32X4_REG macro
	for all register definitions" to the asoc tree
Date: Wed, 13 Dec 2017 15:46:07 +0000
Message-ID: <E1eP9EV-0002OQ-FO@debutante>
References: <20171212224311.24045-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CE3C26797B
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:46:10 +0100 (CET)
In-Reply-To: <20171212224311.24045-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Use AIC32X4_REG macro for all register definitions

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1714196c7ec540292324d9022c43b5f281dbf74c Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 12 Dec 2017 16:43:03 -0600
Subject: [PATCH] ASoC: tlv320aic32x4: Use AIC32X4_REG macro for all register
 definitions

All register definitions should use the AIC32X4_REG macro, even the ones
in page 0. This makes datasheet lookup more consistent and helps with
alignment both in this file and across other tlv320aic* drivers.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.h | 152 ++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index da7cec482bcb..936bb7a1b5c8 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -19,81 +19,83 @@ int aic32x4_remove(struct device *dev);
 
 /* tlv320aic32x4 register space (in decimal to match datasheet) */
 
-#define AIC32X4_PAGE1		128
-
-#define	AIC32X4_PSEL		0
-#define	AIC32X4_RESET		1
-#define	AIC32X4_CLKMUX		4
-#define	AIC32X4_PLLPR		5
-#define	AIC32X4_PLLJ		6
-#define	AIC32X4_PLLDMSB		7
-#define	AIC32X4_PLLDLSB		8
-#define	AIC32X4_NDAC		11
-#define	AIC32X4_MDAC		12
-#define AIC32X4_DOSRMSB		13
-#define AIC32X4_DOSRLSB		14
-#define	AIC32X4_NADC		18
-#define	AIC32X4_MADC		19
-#define AIC32X4_AOSR		20
-#define AIC32X4_CLKMUX2		25
-#define AIC32X4_CLKOUTM		26
-#define AIC32X4_IFACE1		27
-#define AIC32X4_IFACE2		28
-#define AIC32X4_IFACE3		29
-#define AIC32X4_BCLKN		30
-#define AIC32X4_IFACE4		31
-#define AIC32X4_IFACE5		32
-#define AIC32X4_IFACE6		33
-#define AIC32X4_GPIOCTL		52
-#define AIC32X4_DOUTCTL		53
-#define AIC32X4_DINCTL		54
-#define AIC32X4_MISOCTL		55
-#define AIC32X4_SCLKCTL		56
-#define AIC32X4_DACSPB		60
-#define AIC32X4_ADCSPB		61
-#define AIC32X4_DACSETUP	63
-#define AIC32X4_DACMUTE		64
-#define AIC32X4_LDACVOL		65
-#define AIC32X4_RDACVOL		66
-#define AIC32X4_ADCSETUP	81
-#define	AIC32X4_ADCFGA		82
-#define AIC32X4_LADCVOL		83
-#define AIC32X4_RADCVOL		84
-#define AIC32X4_LAGC1		86
-#define AIC32X4_LAGC2		87
-#define AIC32X4_LAGC3		88
-#define AIC32X4_LAGC4		89
-#define AIC32X4_LAGC5		90
-#define AIC32X4_LAGC6		91
-#define AIC32X4_LAGC7		92
-#define AIC32X4_RAGC1		94
-#define AIC32X4_RAGC2		95
-#define AIC32X4_RAGC3		96
-#define AIC32X4_RAGC4		97
-#define AIC32X4_RAGC5		98
-#define AIC32X4_RAGC6		99
-#define AIC32X4_RAGC7		100
-#define AIC32X4_PWRCFG		(AIC32X4_PAGE1 + 1)
-#define AIC32X4_LDOCTL		(AIC32X4_PAGE1 + 2)
-#define AIC32X4_OUTPWRCTL	(AIC32X4_PAGE1 + 9)
-#define AIC32X4_CMMODE		(AIC32X4_PAGE1 + 10)
-#define AIC32X4_HPLROUTE	(AIC32X4_PAGE1 + 12)
-#define AIC32X4_HPRROUTE	(AIC32X4_PAGE1 + 13)
-#define AIC32X4_LOLROUTE	(AIC32X4_PAGE1 + 14)
-#define AIC32X4_LORROUTE	(AIC32X4_PAGE1 + 15)
-#define	AIC32X4_HPLGAIN		(AIC32X4_PAGE1 + 16)
-#define	AIC32X4_HPRGAIN		(AIC32X4_PAGE1 + 17)
-#define	AIC32X4_LOLGAIN		(AIC32X4_PAGE1 + 18)
-#define	AIC32X4_LORGAIN		(AIC32X4_PAGE1 + 19)
-#define AIC32X4_HEADSTART	(AIC32X4_PAGE1 + 20)
-#define AIC32X4_MICBIAS		(AIC32X4_PAGE1 + 51)
-#define AIC32X4_LMICPGAPIN	(AIC32X4_PAGE1 + 52)
-#define AIC32X4_LMICPGANIN	(AIC32X4_PAGE1 + 54)
-#define AIC32X4_RMICPGAPIN	(AIC32X4_PAGE1 + 55)
-#define AIC32X4_RMICPGANIN	(AIC32X4_PAGE1 + 57)
-#define AIC32X4_FLOATINGINPUT	(AIC32X4_PAGE1 + 58)
-#define AIC32X4_LMICPGAVOL	(AIC32X4_PAGE1 + 59)
-#define AIC32X4_RMICPGAVOL	(AIC32X4_PAGE1 + 60)
+#define AIC32X4_REG(page, reg)	((page * 128) + reg)
+
+#define	AIC32X4_PSEL		AIC32X4_REG(0, 0)
+
+#define	AIC32X4_RESET		AIC32X4_REG(0, 1)
+#define	AIC32X4_CLKMUX		AIC32X4_REG(0, 4)
+#define	AIC32X4_PLLPR		AIC32X4_REG(0, 5)
+#define	AIC32X4_PLLJ		AIC32X4_REG(0, 6)
+#define	AIC32X4_PLLDMSB		AIC32X4_REG(0, 7)
+#define	AIC32X4_PLLDLSB		AIC32X4_REG(0, 8)
+#define	AIC32X4_NDAC		AIC32X4_REG(0, 11)
+#define	AIC32X4_MDAC		AIC32X4_REG(0, 12)
+#define AIC32X4_DOSRMSB		AIC32X4_REG(0, 13)
+#define AIC32X4_DOSRLSB		AIC32X4_REG(0, 14)
+#define	AIC32X4_NADC		AIC32X4_REG(0, 18)
+#define	AIC32X4_MADC		AIC32X4_REG(0, 19)
+#define AIC32X4_AOSR		AIC32X4_REG(0, 20)
+#define AIC32X4_CLKMUX2		AIC32X4_REG(0, 25)
+#define AIC32X4_CLKOUTM		AIC32X4_REG(0, 26)
+#define AIC32X4_IFACE1		AIC32X4_REG(0, 27)
+#define AIC32X4_IFACE2		AIC32X4_REG(0, 28)
+#define AIC32X4_IFACE3		AIC32X4_REG(0, 29)
+#define AIC32X4_BCLKN		AIC32X4_REG(0, 30)
+#define AIC32X4_IFACE4		AIC32X4_REG(0, 31)
+#define AIC32X4_IFACE5		AIC32X4_REG(0, 32)
+#define AIC32X4_IFACE6		AIC32X4_REG(0, 33)
+#define AIC32X4_GPIOCTL		AIC32X4_REG(0, 52)
+#define AIC32X4_DOUTCTL		AIC32X4_REG(0, 53)
+#define AIC32X4_DINCTL		AIC32X4_REG(0, 54)
+#define AIC32X4_MISOCTL		AIC32X4_REG(0, 55)
+#define AIC32X4_SCLKCTL		AIC32X4_REG(0, 56)
+#define AIC32X4_DACSPB		AIC32X4_REG(0, 60)
+#define AIC32X4_ADCSPB		AIC32X4_REG(0, 61)
+#define AIC32X4_DACSETUP	AIC32X4_REG(0, 63)
+#define AIC32X4_DACMUTE		AIC32X4_REG(0, 64)
+#define AIC32X4_LDACVOL		AIC32X4_REG(0, 65)
+#define AIC32X4_RDACVOL		AIC32X4_REG(0, 66)
+#define AIC32X4_ADCSETUP	AIC32X4_REG(0, 81)
+#define	AIC32X4_ADCFGA		AIC32X4_REG(0, 82)
+#define AIC32X4_LADCVOL		AIC32X4_REG(0, 83)
+#define AIC32X4_RADCVOL		AIC32X4_REG(0, 84)
+#define AIC32X4_LAGC1		AIC32X4_REG(0, 86)
+#define AIC32X4_LAGC2		AIC32X4_REG(0, 87)
+#define AIC32X4_LAGC3		AIC32X4_REG(0, 88)
+#define AIC32X4_LAGC4		AIC32X4_REG(0, 89)
+#define AIC32X4_LAGC5		AIC32X4_REG(0, 90)
+#define AIC32X4_LAGC6		AIC32X4_REG(0, 91)
+#define AIC32X4_LAGC7		AIC32X4_REG(0, 92)
+#define AIC32X4_RAGC1		AIC32X4_REG(0, 94)
+#define AIC32X4_RAGC2		AIC32X4_REG(0, 95)
+#define AIC32X4_RAGC3		AIC32X4_REG(0, 96)
+#define AIC32X4_RAGC4		AIC32X4_REG(0, 97)
+#define AIC32X4_RAGC5		AIC32X4_REG(0, 98)
+#define AIC32X4_RAGC6		AIC32X4_REG(0, 99)
+#define AIC32X4_RAGC7		AIC32X4_REG(0, 100)
+
+#define AIC32X4_PWRCFG		AIC32X4_REG(1, 1)
+#define AIC32X4_LDOCTL		AIC32X4_REG(1, 2)
+#define AIC32X4_OUTPWRCTL	AIC32X4_REG(1, 9)
+#define AIC32X4_CMMODE		AIC32X4_REG(1, 10)
+#define AIC32X4_HPLROUTE	AIC32X4_REG(1, 12)
+#define AIC32X4_HPRROUTE	AIC32X4_REG(1, 13)
+#define AIC32X4_LOLROUTE	AIC32X4_REG(1, 14)
+#define AIC32X4_LORROUTE	AIC32X4_REG(1, 15)
+#define	AIC32X4_HPLGAIN		AIC32X4_REG(1, 16)
+#define	AIC32X4_HPRGAIN		AIC32X4_REG(1, 17)
+#define	AIC32X4_LOLGAIN		AIC32X4_REG(1, 18)
+#define	AIC32X4_LORGAIN		AIC32X4_REG(1, 19)
+#define AIC32X4_HEADSTART	AIC32X4_REG(1, 20)
+#define AIC32X4_MICBIAS		AIC32X4_REG(1, 51)
+#define AIC32X4_LMICPGAPIN	AIC32X4_REG(1, 52)
+#define AIC32X4_LMICPGANIN	AIC32X4_REG(1, 54)
+#define AIC32X4_RMICPGAPIN	AIC32X4_REG(1, 55)
+#define AIC32X4_RMICPGANIN	AIC32X4_REG(1, 57)
+#define AIC32X4_FLOATINGINPUT	AIC32X4_REG(1, 58)
+#define AIC32X4_LMICPGAVOL	AIC32X4_REG(1, 59)
+#define AIC32X4_RMICPGAVOL	AIC32X4_REG(1, 60)
 
 #define AIC32X4_FREQ_12000000 12000000
 #define AIC32X4_FREQ_24000000 24000000
-- 
2.15.1
