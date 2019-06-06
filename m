From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: rt1011: Mark format integer literals as unsigned
Date: Wed,  5 Jun 2019 22:12:27 -0700
Message-ID: <20190606051227.90944-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuming Fan <shumingf@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: alsa-devel@alsa-project.org

Clang warns:

sound/soc/codecs/rt1011.c:1291:12: warning: integer literal is too large
to be represented in type 'long', interpreting as 'unsigned long' per
C89; this literal will have type 'long long' in C99 onwards
[-Wc99-compat]
                format = 2147483648; /* 2^24 * 128 */
                         ^
sound/soc/codecs/rt1011.c:2123:13: warning: integer literal is too large
to be represented in type 'long', interpreting as 'unsigned long' per
C89; this literal will have type 'long long' in C99 onwards
[-Wc99-compat]
                        format = 2147483648; /* 2^24 * 128 */
                                 ^
2 warnings generated.

Mark the integer literals as unsigned explicitly so that if the kernel
does ever bump the C standard it uses, the behavior is consitent.

Fixes: d6e65bb7ff0d ("ASoC: rt1011: Add RT1011 amplifier driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/506
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/rt1011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 349d6db7ecd4..3a0ae80c5ee0 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1288,7 +1288,7 @@ static int rt1011_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 		rt1011->r0_reg = ucontrol->value.integer.value[0];
 
-		format = 2147483648; /* 2^24 * 128 */
+		format = 2147483648U; /* 2^24 * 128 */
 		r0_integer = format / rt1011->r0_reg / 128;
 		r0_factor = ((format / rt1011->r0_reg * 100) / 128)
 						- (r0_integer * 100);
@@ -2120,7 +2120,7 @@ static int rt1011_calibrate(struct rt1011_priv *rt1011, unsigned char cali_flag)
 			dev_err(dev,	"Calibrate R0 Failure\n");
 			ret = -EAGAIN;
 		} else {
-			format = 2147483648; /* 2^24 * 128 */
+			format = 2147483648U; /* 2^24 * 128 */
 			r0_integer = format / r0[0] / 128;
 			r0_factor = ((format / r0[0] * 100) / 128)
 							- (r0_integer * 100);
-- 
2.22.0.rc3
