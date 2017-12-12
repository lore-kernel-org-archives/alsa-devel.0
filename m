From: "Chen.Liu" <chen.liu.opensource@gmail.com>
Subject: [PATCH] ASOC: wm8960: Add multiple MCLK frequency support
Date: Tue, 12 Dec 2017 19:58:56 +0800
Message-ID: <1513079936-163297-1-git-send-email-chen.liu.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shengjiu.wang@freescale.com, chen.liu.opensource@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: "Chen.Liu" <chen.liu.opensource@gmail.com>

Issue:
 MCLK=24MHZ,SYSCLOCK=12.288MHZ.
 When the 'wm8960_set_dai_pll' function is called,the driver will
 prompted "WM8960 PLL: unsupported N = 4" error message.
 However,the value of PLLN should be 8 based on the table45(
 PLL Frequency Examples) of the wm8960 chip manuanl.

Reason:
 The intergrated PLL can be used to generate SYSCLK for the wm8960.
 The pll_factors function in the wm8974.c file is mainly responsible
 for setting the divider factor of the PLL divider with reference to
 MCLK clock frequency to obtain the required SYSCLK clock frequency.
 The configure diagram for this function can be seen below.

 MCLK-->[f/2]-->[R=f2/f1]-->[f/4]-->[f/N](1)-->SYSCLOCK

 The configuration of the PLL divider in above diagram is applicable to
 MCLK clock frequency is less than or equal to 14.4MHZ.
 examples:
 (1)MCLK=12MHz, required clock = 12.288MHz.
 R should be chosen to ensure 5 < PLLN < 13. There is a fixed divide by
 4 in the PLL and a selectable divide by N after the PLL which should
 be set to divide by 1 to meet this requirement.
 Enabling the divide by 1 sets the required f2 = 4 x 1 x 12.288MHz =
 49.152MHz.

 	R = 49.152 / (12 / 2) = 8.192
 	PLLN = int R = 8

 (2)MCLK=24MHz, required clock = 12.288MHz.
 Enabling the divide by 1 sets the required f2 = 4 x 1 x 12.288MHZ =
 49.152MHZ.

 	R = 49.152 / (24 / 2) = 4.096
 	PLLN = int R = 4

 And if the [f/N] reg is set to 2,then the required f2 = 4x2x12.288MHZ
 = 98.304MHZ.

 	R = 98.304 / (24 / 2) = 8.192
 	PLLN = int R = 8

 Because the [f/N] reg is fixed divide by 1,that's why driver prompted
 error message.

Solution:
 The purpose of this patch is when the conditions(5 < PLLN < 13) is
 false, set the register[f/N] to be 2, and the recalculate the divide
 factor of the PLL divider.

 MCLK-->[f/2]-->[R=f2/f1]-->[f/4]-->[f/N](2)-->SYSCLOCK

Signed-off-by: Chen.Liu <chen.liu.opensource@gmail.com>
---
 sound/soc/codecs/wm8960.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 997c446..49a27b1 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1036,17 +1036,25 @@ static bool is_pll_freq_available(unsigned int source, unsigned int target)
  * to allow rounding later */
 #define FIXED_PLL_SIZE ((1 << 24) * 10)
 
-static int pll_factors(unsigned int source, unsigned int target,
+static int pll_factors(struct snd_soc_codec *codec,
+		unsigned int source, unsigned int target,
 		       struct _pll_div *pll_div)
 {
 	unsigned long long Kpart;
 	unsigned int K, Ndiv, Nmod;
+	int unsupport = 0;
+	u16 reg;
 
 	pr_debug("WM8960 PLL: setting %dHz->%dHz\n", source, target);
 
 	/* Scale up target to PLL operating frequency */
 	target *= 4;
 
+retry:
+	if (unsupport) {
+		target *= 2;
+		unsupport += 1;
+	}
 	Ndiv = target / source;
 	if (Ndiv < 6) {
 		source >>= 1;
@@ -1056,8 +1064,12 @@ static int pll_factors(unsigned int source, unsigned int target,
 		pll_div->pre_div = 0;
 
 	if ((Ndiv < 6) || (Ndiv > 12)) {
-		pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
-		return -EINVAL;
+		if (unsupport == 2) {
+			pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
+			return -EINVAL;
+		}
+		unsupport = 1;
+		goto retry;
 	}
 
 	pll_div->n = Ndiv;
@@ -1077,6 +1089,11 @@ static int pll_factors(unsigned int source, unsigned int target,
 
 	pll_div->k = K;
 
+	if (unsupport) {
+		reg = snd_soc_read(codec, WM8960_CLOCK1) | WM8960_SYSCLK_DIV_2;
+		snd_soc_write(codec, WM8960_CLOCK1, reg);
+	}
+
 	pr_debug("WM8960 PLL: N=%x K=%x pre_div=%d\n",
 		 pll_div->n, pll_div->k, pll_div->pre_div);
 
@@ -1091,7 +1108,7 @@ static int wm8960_set_pll(struct snd_soc_codec *codec,
 	int ret;
 
 	if (freq_in && freq_out) {
-		ret = pll_factors(freq_in, freq_out, &pll_div);
+		ret = pll_factors(codec, freq_in, freq_out, &pll_div);
 		if (ret != 0)
 			return ret;
 	}
-- 
1.8.3.1
