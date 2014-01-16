From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/2] ASoC: core: Add signed register volume
	control logic
Date: Thu, 16 Jan 2014 16:02:10 +0100
Message-ID: <1389884531-19429-2-git-send-email-mpa@pengutronix.de>
References: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 61B93261723
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:02:52 +0100 (CET)
In-Reply-To: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
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
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Some codecs use signed volume control representation with non standard
register sizes, e.g. 6 or 7 bit signed integers.

This patch adds generic signed register volume control logic to
soc-core. Instead of a fixed width signed register control, this
implementation uses a 'min' value and the signed bit location to translate
it to an absolute volume. Using the 'sign_bit' we can calculate a
correct mask for the register values and translate it back into signed
integers of standard size.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-core.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1f741cb..5907583 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1053,6 +1053,7 @@ struct soc_mixer_control {
 	int min, max, platform_max;
 	int reg, rreg;
 	unsigned int shift, rshift;
+	unsigned int sign_bit;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a66783e..de61159 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2715,6 +2715,48 @@ int snd_soc_put_value_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_value_enum_double);
 
 /**
+ * snd_soc_read_signed - Read a codec register and interprete as signed value
+ * @codec: codec
+ * @reg: Register to read
+ * @mask: Mask to use after shifting the register value
+ * @shift: Right shift of register value
+ * @sign_bit: Bit that describes if a number is negative or not.
+ *
+ * This functions reads a codec register. The register value is shifted right
+ * by 'shift' bits and masked with the given 'mask'. Afterwards it translates
+ * the given registervalue into a signed integer if sign_bit is non-zero.
+ *
+ * Returns the register value as signed int.
+ */
+static int snd_soc_read_signed(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int mask, unsigned int shift, unsigned int sign_bit)
+{
+	int ret;
+	unsigned int val;
+
+	val = (snd_soc_read(codec, reg) >> shift) & mask;
+
+	if (!sign_bit)
+		return val;
+
+	/* non-negative number */
+	if (!(val & BIT(sign_bit)))
+		return val;
+
+	ret = val;
+
+	/*
+	 * The register most probably does not contain a full-sized int.
+	 * Instead we have an arbitrary number of bits in a signed
+	 * representation which has to be translated into a full-sized int.
+	 * This is done by filling up all bits above the sign-bit.
+	 */
+	ret |= ~((int)(BIT(sign_bit) - 1));
+
+	return ret;
+}
+
+/**
  * snd_soc_info_volsw - single mixer info callback
  * @kcontrol: mixer control
  * @uinfo: control element information
@@ -2742,7 +2784,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 
 	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = platform_max;
+	uinfo->value.integer.max = platform_max - mc->min;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
@@ -2768,11 +2810,16 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
+	int min = mc->min;
+	int sign_bit = mc->sign_bit;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 
-	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+	if (sign_bit)
+		mask = BIT(sign_bit + 1) - 1;
+
+	ucontrol->value.integer.value[0] = snd_soc_read_signed(codec, reg, mask,
+			shift, sign_bit) - min;
 	if (invert)
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
@@ -2780,10 +2827,12 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	if (snd_soc_volsw_is_stereo(mc)) {
 		if (reg == reg2)
 			ucontrol->value.integer.value[1] =
-				(snd_soc_read(codec, reg) >> rshift) & mask;
+				snd_soc_read_signed(codec, reg, mask, rshift,
+						sign_bit) - min;
 		else
 			ucontrol->value.integer.value[1] =
-				(snd_soc_read(codec, reg2) >> shift) & mask;
+				snd_soc_read_signed(codec, reg2, mask, shift,
+						sign_bit) - min;
 		if (invert)
 			ucontrol->value.integer.value[1] =
 				max - ucontrol->value.integer.value[1];
@@ -2814,6 +2863,8 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
+	int min = mc->min;
+	unsigned int sign_bit = mc->sign_bit;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	int err;
@@ -2821,13 +2872,16 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val2 = 0;
 	unsigned int val, val_mask;
 
-	val = (ucontrol->value.integer.value[0] & mask);
+	if (sign_bit)
+		mask = BIT(sign_bit + 1) - 1;
+
+	val = ((ucontrol->value.integer.value[0] + min) & mask);
 	if (invert)
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (snd_soc_volsw_is_stereo(mc)) {
-		val2 = (ucontrol->value.integer.value[1] & mask);
+		val2 = ((ucontrol->value.integer.value[1] + min) & mask);
 		if (invert)
 			val2 = max - val2;
 		if (reg == reg2) {
-- 
1.8.5.2
