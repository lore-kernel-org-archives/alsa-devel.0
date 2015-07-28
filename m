From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8983: Get rid of wm8983_access_masks
	table
Date: Tue, 28 Jul 2015 13:39:01 +0800
Message-ID: <1438061941.22357.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4039A2652AD
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:39:07 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so64514958pdr.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 22:39:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The max8983_access table is used for look up readable/writable
attributes of registers. The writable registers are mostly in continuous
ranges, so we can replace max8983_access table by using case range.
The read fields are all 0, so just drop implement of .readable callback.

Also set .max_register setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8983.c | 80 +++++++++--------------------------------------
 1 file changed, 14 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index f6861cc..f3193fb 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -84,66 +84,6 @@ static const struct reg_default wm8983_defaults[] = {
 	{ 0x3D, 0x0000 },      /* R61 - BIAS CTRL */
 };
 
-static const struct wm8983_reg_access {
-	u16 read; /* Mask of readable bits */
-	u16 write; /* Mask of writable bits */
-} wm8983_access_masks[WM8983_MAX_REGISTER + 1] = {
-	[0x00] = { 0x0000, 0x01FF }, /* R0  - Software Reset */
-	[0x01] = { 0x0000, 0x01FF }, /* R1  - Power management 1 */
-	[0x02] = { 0x0000, 0x01FF }, /* R2  - Power management 2 */
-	[0x03] = { 0x0000, 0x01EF }, /* R3  - Power management 3 */
-	[0x04] = { 0x0000, 0x01FF }, /* R4  - Audio Interface */
-	[0x05] = { 0x0000, 0x003F }, /* R5  - Companding control */
-	[0x06] = { 0x0000, 0x01FD }, /* R6  - Clock Gen control */
-	[0x07] = { 0x0000, 0x000F }, /* R7  - Additional control */
-	[0x08] = { 0x0000, 0x003F }, /* R8  - GPIO Control */
-	[0x09] = { 0x0000, 0x0070 }, /* R9  - Jack Detect Control 1 */
-	[0x0A] = { 0x0000, 0x004F }, /* R10 - DAC Control */
-	[0x0B] = { 0x0000, 0x01FF }, /* R11 - Left DAC digital Vol */
-	[0x0C] = { 0x0000, 0x01FF }, /* R12 - Right DAC digital vol */
-	[0x0D] = { 0x0000, 0x00FF }, /* R13 - Jack Detect Control 2 */
-	[0x0E] = { 0x0000, 0x01FB }, /* R14 - ADC Control */
-	[0x0F] = { 0x0000, 0x01FF }, /* R15 - Left ADC Digital Vol */
-	[0x10] = { 0x0000, 0x01FF }, /* R16 - Right ADC Digital Vol */
-	[0x12] = { 0x0000, 0x017F }, /* R18 - EQ1 - low shelf */
-	[0x13] = { 0x0000, 0x017F }, /* R19 - EQ2 - peak 1 */
-	[0x14] = { 0x0000, 0x017F }, /* R20 - EQ3 - peak 2 */
-	[0x15] = { 0x0000, 0x017F }, /* R21 - EQ4 - peak 3 */
-	[0x16] = { 0x0000, 0x007F }, /* R22 - EQ5 - high shelf */
-	[0x18] = { 0x0000, 0x01FF }, /* R24 - DAC Limiter 1 */
-	[0x19] = { 0x0000, 0x007F }, /* R25 - DAC Limiter 2 */
-	[0x1B] = { 0x0000, 0x01FF }, /* R27 - Notch Filter 1 */
-	[0x1C] = { 0x0000, 0x017F }, /* R28 - Notch Filter 2 */
-	[0x1D] = { 0x0000, 0x017F }, /* R29 - Notch Filter 3 */
-	[0x1E] = { 0x0000, 0x017F }, /* R30 - Notch Filter 4 */
-	[0x20] = { 0x0000, 0x01BF }, /* R32 - ALC control 1 */
-	[0x21] = { 0x0000, 0x00FF }, /* R33 - ALC control 2 */
-	[0x22] = { 0x0000, 0x01FF }, /* R34 - ALC control 3 */
-	[0x23] = { 0x0000, 0x000F }, /* R35 - Noise Gate */
-	[0x24] = { 0x0000, 0x001F }, /* R36 - PLL N */
-	[0x25] = { 0x0000, 0x003F }, /* R37 - PLL K 1 */
-	[0x26] = { 0x0000, 0x01FF }, /* R38 - PLL K 2 */
-	[0x27] = { 0x0000, 0x01FF }, /* R39 - PLL K 3 */
-	[0x29] = { 0x0000, 0x000F }, /* R41 - 3D control */
-	[0x2A] = { 0x0000, 0x01E7 }, /* R42 - OUT4 to ADC */
-	[0x2B] = { 0x0000, 0x01BF }, /* R43 - Beep control */
-	[0x2C] = { 0x0000, 0x0177 }, /* R44 - Input ctrl */
-	[0x2D] = { 0x0000, 0x01FF }, /* R45 - Left INP PGA gain ctrl */
-	[0x2E] = { 0x0000, 0x01FF }, /* R46 - Right INP PGA gain ctrl */
-	[0x2F] = { 0x0000, 0x0177 }, /* R47 - Left ADC BOOST ctrl */
-	[0x30] = { 0x0000, 0x0177 }, /* R48 - Right ADC BOOST ctrl */
-	[0x31] = { 0x0000, 0x007F }, /* R49 - Output ctrl */
-	[0x32] = { 0x0000, 0x01FF }, /* R50 - Left mixer ctrl */
-	[0x33] = { 0x0000, 0x01FF }, /* R51 - Right mixer ctrl */
-	[0x34] = { 0x0000, 0x01FF }, /* R52 - LOUT1 (HP) volume ctrl */
-	[0x35] = { 0x0000, 0x01FF }, /* R53 - ROUT1 (HP) volume ctrl */
-	[0x36] = { 0x0000, 0x01FF }, /* R54 - LOUT2 (SPK) volume ctrl */
-	[0x37] = { 0x0000, 0x01FF }, /* R55 - ROUT2 (SPK) volume ctrl */
-	[0x38] = { 0x0000, 0x004F }, /* R56 - OUT3 mixer ctrl */
-	[0x39] = { 0x0000, 0x00FF }, /* R57 - OUT4 (MONO) mix ctrl */
-	[0x3D] = { 0x0000, 0x0100 }  /* R61 - BIAS CTRL */
-};
-
 /* vol/gain update regs */
 static const int vol_update_regs[] = {
 	WM8983_LEFT_DAC_DIGITAL_VOL,
@@ -605,12 +545,19 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static bool wm8983_readable(struct device *dev, unsigned int reg)
+static bool wm8983_writeable(struct device *dev, unsigned int reg)
 {
-	if (reg > WM8983_MAX_REGISTER)
-		return 0;
-
-	return wm8983_access_masks[reg].read != 0;
+	switch (reg) {
+	case WM8983_SOFTWARE_RESET ... WM8983_RIGHT_ADC_DIGITAL_VOL:
+	case WM8983_EQ1_LOW_SHELF ... WM8983_DAC_LIMITER_2:
+	case WM8983_NOTCH_FILTER_1 ... WM8983_NOTCH_FILTER_4:
+	case WM8983_ALC_CONTROL_1 ... WM8983_PLL_K_3:
+	case WM8983_3D_CONTROL ... WM8983_OUT4_MONO_MIX_CTRL:
+	case WM8983_BIAS_CTRL:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static int wm8983_dac_mute(struct snd_soc_dai *dai, int mute)
@@ -1048,8 +995,9 @@ static const struct regmap_config wm8983_regmap = {
 	.reg_defaults = wm8983_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8983_defaults),
 	.cache_type = REGCACHE_RBTREE,
+	.max_register = WM8983_MAX_REGISTER,
 
-	.readable_reg = wm8983_readable,
+	.writeable_reg = wm8983_writeable,
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
2.1.0
