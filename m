From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: pci: cthw20k2: Replace mdelay() with msleep() and usleep_range()
Date: Fri, 27 Jul 2018 17:01:43 +0800
Message-ID: <20180727090143.18686-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: alsa-devel@alsa-project.org

hw_pll_init(), hw_dac_stop(), hw_dac_start() and hw_adc_init() 
are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/ctxfi/cthw20k2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index b866d6b2c923..3c966fafc754 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -1316,12 +1316,12 @@ static int hw_pll_init(struct hw *hw, unsigned int rsr)
 	set_field(&pllctl, PLLCTL_FD, 48000 == rsr ? 16 - 4 : 147 - 4);
 	set_field(&pllctl, PLLCTL_RD, 48000 == rsr ? 1 - 1 : 10 - 1);
 	hw_write_20kx(hw, PLL_CTL, pllctl);
-	mdelay(40);
+	msleep(40);
 
 	pllctl = hw_read_20kx(hw, PLL_CTL);
 	set_field(&pllctl, PLLCTL_FD, 48000 == rsr ? 16 - 2 : 147 - 2);
 	hw_write_20kx(hw, PLL_CTL, pllctl);
-	mdelay(40);
+	msleep(40);
 
 	for (i = 0; i < 1000; i++) {
 		pllstat = hw_read_20kx(hw, PLL_STAT);
@@ -1584,7 +1584,7 @@ static void hw_dac_stop(struct hw *hw)
 	data = hw_read_20kx(hw, GPIO_DATA);
 	data &= 0xFFFFFFFD;
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(10);
+	usleep_range(10000, 11000);
 }
 
 static void hw_dac_start(struct hw *hw)
@@ -1593,7 +1593,7 @@ static void hw_dac_start(struct hw *hw)
 	data = hw_read_20kx(hw, GPIO_DATA);
 	data |= 0x2;
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(50);
+	msleep(50);
 }
 
 static void hw_dac_reset(struct hw *hw)
@@ -1864,11 +1864,11 @@ static int hw_adc_init(struct hw *hw, const struct adc_conf *info)
 		hw_write_20kx(hw, GPIO_DATA, data);
 	}
 
-	mdelay(10);
+	usleep_range(10000, 11000);
 	/* Return the ADC to normal operation. */
 	data |= (0x1 << 15);
 	hw_write_20kx(hw, GPIO_DATA, data);
-	mdelay(50);
+	msleep(50);
 
 	/* I2C write to register offset 0x0B to set ADC LRCLK polarity */
 	/* invert bit, interface format to I2S, word length to 24-bit, */
-- 
2.17.0
