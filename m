From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8983: Get rid of wm8983_access_masks
	table" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:16 +0100
Message-ID: <E1ZKS6e-0004bb-4n@finisterre>
References: <1438061941.22357.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A2126592C
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:27 +0200 (CEST)
In-Reply-To: <1438061941.22357.5.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8983: Get rid of wm8983_access_masks table

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

>From 85e7118412fea31464b62d00bcf4a65fa8904dcc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 28 Jul 2015 13:39:01 +0800
Subject: [PATCH] ASoC: wm8983: Get rid of wm8983_access_masks table

The max8983_access table is used for look up readable/writable
attributes of registers. The writable registers are mostly in continuous
ranges, so we can replace max8983_access table by using case range.
The read fields are all 0, so just drop implement of .readable callback.

Also set .max_register setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8983.c | 80 +++++++++--------------------------------------
 1 file changed, 14 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 2fdd2c6..84c8586 100644
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
2.1.4
