From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Update users of
	readable_register()/volatile_register()
Date: Thu, 13 Jan 2011 12:15:04 +0000
Message-ID: <1294920905-6560-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1294920905-6560-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CDBA103838
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 13:15:13 +0100 (CET)
In-Reply-To: <1294920905-6560-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h         |    4 ++--
 sound/soc/codecs/cs4270.c   |    4 ++--
 sound/soc/codecs/max98088.c |    2 +-
 sound/soc/codecs/wm8523.c   |    2 +-
 sound/soc/codecs/wm8804.c   |    2 +-
 sound/soc/codecs/wm8900.c   |    2 +-
 sound/soc/codecs/wm8903.c   |    2 +-
 sound/soc/codecs/wm8904.c   |    2 +-
 sound/soc/codecs/wm8961.c   |    2 +-
 sound/soc/codecs/wm8962.c   |    4 ++--
 sound/soc/codecs/wm8993.c   |    2 +-
 sound/soc/codecs/wm8994.c   |   10 +++++-----
 sound/soc/codecs/wm8995.c   |    2 +-
 sound/soc/codecs/wm9081.c   |    2 +-
 sound/soc/codecs/wm9090.c   |    4 ++--
 sound/soc/soc-core.c        |    5 +++--
 16 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b8acf99..97d1832 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -529,8 +529,8 @@ struct snd_soc_codec_driver {
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	int (*display_register)(struct snd_soc_codec *, char *,
 				size_t, unsigned int);
-	int (*volatile_register)(unsigned int);
-	int (*readable_register)(unsigned int);
+	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
+	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 	short reg_cache_size;
 	short reg_cache_step;
 	short reg_word_size;
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 8b51245..c0fccad 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -193,12 +193,12 @@ static struct cs4270_mode_ratios cs4270_mode_ratios[] = {
 /* The number of MCLK/LRCK ratios supported by the CS4270 */
 #define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
-static int cs4270_reg_is_readable(unsigned int reg)
+static int cs4270_reg_is_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
 	return (reg >= CS4270_FIRSTREG) && (reg <= CS4270_LASTREG);
 }
 
-static int cs4270_reg_is_volatile(unsigned int reg)
+static int cs4270_reg_is_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	/* Unreadable registers are considered volatile */
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 37133c4..b6ecc7e 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -608,7 +608,7 @@ static struct {
        { 0xFF, 0x00, 1 }, /* FF */
 };
 
-static int max98088_volatile_register(unsigned int reg)
+static int max98088_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
        return max98088_access[reg].vol;
 }
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 5eb2f50..83e86f0 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -58,7 +58,7 @@ static const u16 wm8523_reg[WM8523_REGISTER_COUNT] = {
 	0x0000,     /* R8 - ZERO_DETECT */
 };
 
-static int wm8523_volatile_register(unsigned int reg)
+static int wm8523_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8523_DEVICE_ID:
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 6dae1b4..6785688 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -175,7 +175,7 @@ static int txsrc_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int wm8804_volatile(unsigned int reg)
+static int wm8804_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8804_RST_DEVID1:
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index cd09599..449ea09 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -180,7 +180,7 @@ static const u16 wm8900_reg_defaults[WM8900_MAXREG] = {
 	/* Remaining registers all zero */
 };
 
-static int wm8900_volatile_register(unsigned int reg)
+static int wm8900_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8900_REG_ID:
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 987476a..a2a446c 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -232,7 +232,7 @@ struct wm8903_priv {
 	int mic_delay;
 };
 
-static int wm8903_volatile_register(unsigned int reg)
+static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8903_SW_RESET_AND_ID:
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 9de44a4..17a8fe9 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -596,7 +596,7 @@ static struct {
 	{ 0x003F, 0x003F, 0 }, /* R248 - FLL NCO Test 1 */
 };
 
-static int wm8904_volatile_register(unsigned int reg)
+static int wm8904_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	return wm8904_access[reg].vol;
 }
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 55252e7..cdee810 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -291,7 +291,7 @@ struct wm8961_priv {
 	int sysclk;
 };
 
-static int wm8961_volatile_register(unsigned int reg)
+static int wm8961_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8961_SOFTWARE_RESET:
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b9cb1fc..7c02924 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1938,7 +1938,7 @@ static const struct wm8962_reg_access {
 	[21139] = { 0xFFFF, 0xFFFF, 0x0000 }, /* R21139 - VSS_XTS32_0 */
 };
 
-static int wm8962_volatile_register(unsigned int reg)
+static int wm8962_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	if (wm8962_reg_access[reg].vol)
 		return 1;
@@ -1946,7 +1946,7 @@ static int wm8962_volatile_register(unsigned int reg)
 		return 0;
 }
 
-static int wm8962_readable_register(unsigned int reg)
+static int wm8962_readable_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	if (wm8962_reg_access[reg].read)
 		return 1;
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 18c0d9c..379fa22 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -242,7 +242,7 @@ struct wm8993_priv {
 	int fll_src;
 };
 
-static int wm8993_volatile(unsigned int reg)
+static int wm8993_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8993_SOFTWARE_RESET:
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 247a6a9..0bb0bb4 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -109,7 +109,7 @@ struct wm8994_priv {
 	struct wm8994_pdata *pdata;
 };
 
-static int wm8994_readable(unsigned int reg)
+static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM8994_GPIO_1:
@@ -136,7 +136,7 @@ static int wm8994_readable(unsigned int reg)
 	return wm8994_access_masks[reg].readable != 0;
 }
 
-static int wm8994_volatile(unsigned int reg)
+static int wm8994_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	if (reg >= WM8994_CACHE_SIZE)
 		return 1;
@@ -164,7 +164,7 @@ static int wm8994_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	BUG_ON(reg > WM8994_MAX_REGISTER);
 
-	if (!wm8994_volatile(reg)) {
+	if (!wm8994_volatile(codec, reg)) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret != 0)
 			dev_err(codec->dev, "Cache write to %x failed: %d\n",
@@ -182,7 +182,7 @@ static unsigned int wm8994_read(struct snd_soc_codec *codec,
 
 	BUG_ON(reg > WM8994_MAX_REGISTER);
 
-	if (!wm8994_volatile(reg) && wm8994_readable(reg) &&
+	if (!wm8994_volatile(codec, reg) && wm8994_readable(codec, reg) &&
 	    reg < codec->driver->reg_cache_size) {
 		ret = snd_soc_cache_read(codec, reg, &val);
 		if (ret >= 0)
@@ -2943,7 +2943,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	/* Read our current status back from the chip - we don't want to
 	 * reset as this may interfere with the GPIO or LDO operation. */
 	for (i = 0; i < WM8994_CACHE_SIZE; i++) {
-		if (!wm8994_readable(i) || wm8994_volatile(i))
+		if (!wm8994_readable(codec, i) || wm8994_volatile(codec, i))
 			continue;
 
 		ret = wm8994_reg_read(codec->control_data, i);
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 96e0dc0..82b7e28 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -909,7 +909,7 @@ static const struct snd_soc_dapm_route wm8995_intercon[] = {
 	{ "SPK2R", NULL, "SPK2R Driver" }
 };
 
-static int wm8995_volatile(unsigned int reg)
+static int wm8995_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	/* out of bounds registers are generally considered
 	 * volatile to support register banks that are partially
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 43825b2..5c224dd 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -169,7 +169,7 @@ struct wm9081_priv {
 	struct wm9081_retune_mobile_config *retune;
 };
 
-static int wm9081_volatile_register(unsigned int reg)
+static int wm9081_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM9081_SOFTWARE_RESET:
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index a788c42..d40bfc9 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -144,7 +144,7 @@ struct wm9090_priv {
 	void *control_data;
 };
 
-static int wm9090_volatile(unsigned int reg)
+static int wm9090_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	switch (reg) {
 	case WM9090_SOFTWARE_RESET:
@@ -518,7 +518,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 			for (i = 1; i < codec->driver->reg_cache_size; i++) {
 				if (reg_cache[i] == wm9090_reg_defaults[i])
 					continue;
-				if (wm9090_volatile(i))
+				if (wm9090_volatile(codec, i))
 					continue;
 
 				ret = snd_soc_write(codec, i, reg_cache[i]);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cbac50b..a20a1e9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -22,6 +22,7 @@
  *   o Support TDM on PCM and I2S
  */
 
+#define DEBUG
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -84,7 +85,7 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 
 	count += sprintf(buf, "%s registers\n", codec->name);
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
-		if (codec->driver->readable_register && !codec->driver->readable_register(i))
+		if (codec->driver->readable_register && !codec->driver->readable_register(codec, i))
 			continue;
 
 		count += sprintf(buf + count, "%2x: ", i);
@@ -2030,7 +2031,7 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
 {
 	if (codec->driver->volatile_register)
-		return codec->driver->volatile_register(reg);
+		return codec->driver->volatile_register(codec, reg);
 	else
 		return 0;
 }
-- 
1.7.3.5
