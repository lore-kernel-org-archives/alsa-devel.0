From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 1/2] ASoC: STA32x: Add mixer controls for
	biquad coefficients
Date: Mon, 11 Jul 2011 17:01:23 +0200
Message-ID: <1310396484-23371-2-git-send-email-js@sig21.net>
References: <1310396484-23371-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id B6CDF1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 17:01:46 +0200 (CEST)
In-Reply-To: <1310396484-23371-1-git-send-email-js@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The STA32x has a number of preset EQ settings, but also
allows full user control of the biquad filter coeffcients
(when "Automode EQ" is set to "User").
Each biquad has five signed, 24bit, fixed-point coefficients
representing the range -1...1.  The five biquad coefficients
can be uploaded in one atomic operation into on-chip
coefficient RAM.
There are also a few prescale, postscale and mixing
coefficients, in the same numeric format and range
(a negative coefficient inverts phase).

These coefficients are made available as SNDRV_CTL_ELEM_TYPE_BYTES
mixer controls.

Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 sound/soc/codecs/sta32x.c |  124 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 124 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 486628a..9bf944c 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -177,6 +177,95 @@ static const struct soc_enum sta32x_limiter1_release_rate_enum =
 static const struct soc_enum sta32x_limiter2_release_rate_enum =
 	SOC_ENUM_SINGLE(STA32X_L2AR, STA32X_LxR_SHIFT,
 			16, sta32x_limiter_release_rate);
+
+/* byte array controls for setting biquad, mixer, scaling coefficients;
+ * for biquads all five coefficients need to be set in one go,
+ * mixer and pre/postscale coefs can be set individually;
+ * each coef is 24bit, the bytes are ordered in the same way
+ * as given in the STA32x data sheet (big endian; b1, b2, a1, a2, b0)
+ */
+
+static int sta32x_coefficient_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	int numcoef = kcontrol->private_value >> 16;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = 3 * numcoef;
+	return 0;
+}
+
+static int sta32x_coefficient_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+	unsigned int cfud;
+	int i;
+
+	/* preserve reserved bits in STA32X_CFUD */
+	cfud = snd_soc_read(codec, STA32X_CFUD) & 0xf0;
+	/* chip documentation does not say if the bits are self clearing,
+	 * so do it explicitly */
+	snd_soc_write(codec, STA32X_CFUD, cfud);
+
+	snd_soc_write(codec, STA32X_CFADDR2, index);
+	if (numcoef == 1)
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x04);
+	else if (numcoef == 5)
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x08);
+	else
+		return -EINVAL;
+	for (i = 0; i < 3 * numcoef; i++)
+		ucontrol->value.bytes.data[i] =
+			snd_soc_read(codec, STA32X_B1CF1 + i);
+
+	return 0;
+}
+
+static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+	unsigned int cfud;
+	int i;
+
+	/* preserve reserved bits in STA32X_CFUD */
+	cfud = snd_soc_read(codec, STA32X_CFUD) & 0xf0;
+	/* chip documentation does not say if the bits are self clearing,
+	 * so do it explicitly */
+	snd_soc_write(codec, STA32X_CFUD, cfud);
+
+	snd_soc_write(codec, STA32X_CFADDR2, index);
+	for (i = 0; i < 3 * numcoef; i++)
+		snd_soc_write(codec, STA32X_B1CF1 + i,
+			      ucontrol->value.bytes.data[i]);
+	if (numcoef == 1)
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x01);
+	else if (numcoef == 5)
+		snd_soc_write(codec, STA32X_CFUD, cfud | 0x02);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+#define SINGLE_COEF(xname, index) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sta32x_coefficient_info, \
+	.get = sta32x_coefficient_get,\
+	.put = sta32x_coefficient_put, \
+	.private_value = index | (1 << 16) }
+
+#define BIQUAD_COEFS(xname, index) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sta32x_coefficient_info, \
+	.get = sta32x_coefficient_get,\
+	.put = sta32x_coefficient_put, \
+	.private_value = index | (5 << 16) }
+
 static const struct snd_kcontrol_new sta32x_snd_controls[] = {
 SOC_SINGLE_TLV("Master Volume", STA32X_MVOL, 0, 0xff, 1, mvol_tlv),
 SOC_SINGLE("Master Switch", STA32X_MMUTE, 0, 1, 1),
@@ -232,6 +321,29 @@ SOC_SINGLE_TLV("Limiter1 Release Threshold (DRC Mode)", STA32X_L1ATRT, STA32X_Lx
 	       16, 0, sta32x_limiter_drc_release_tlv),
 SOC_SINGLE_TLV("Limiter2 Release Threshold (DRC Mode)", STA32X_L2ATRT, STA32X_LxR_SHIFT,
 	       16, 0, sta32x_limiter_drc_release_tlv),
+
+BIQUAD_COEFS("Ch1 - Biquad 1", 0),
+BIQUAD_COEFS("Ch1 - Biquad 2", 5),
+BIQUAD_COEFS("Ch1 - Biquad 3", 10),
+BIQUAD_COEFS("Ch1 - Biquad 4", 15),
+BIQUAD_COEFS("Ch2 - Biquad 1", 20),
+BIQUAD_COEFS("Ch2 - Biquad 2", 25),
+BIQUAD_COEFS("Ch2 - Biquad 3", 30),
+BIQUAD_COEFS("Ch2 - Biquad 4", 35),
+BIQUAD_COEFS("High-pass", 40),
+BIQUAD_COEFS("Low-pass", 45),
+SINGLE_COEF("Ch1 - Prescale", 50),
+SINGLE_COEF("Ch2 - Prescale", 51),
+SINGLE_COEF("Ch1 - Postscale", 52),
+SINGLE_COEF("Ch2 - Postscale", 53),
+SINGLE_COEF("Ch3 - Postscale", 54),
+SINGLE_COEF("Thermal warning - Postscale", 55),
+SINGLE_COEF("Ch1 - Mix 1", 56),
+SINGLE_COEF("Ch1 - Mix 2", 57),
+SINGLE_COEF("Ch2 - Mix 1", 58),
+SINGLE_COEF("Ch2 - Mix 2", 59),
+SINGLE_COEF("Ch3 - Mix 1", 60),
+SINGLE_COEF("Ch3 - Mix 2", 61),
 };
 
 static const struct snd_soc_dapm_widget sta32x_dapm_widgets[] = {
@@ -686,6 +798,17 @@ static int sta32x_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int sta32x_reg_is_volatile(struct snd_soc_codec *codec,
+				  unsigned int reg)
+{
+	switch (reg) {
+	case STA32X_CONFA ... STA32X_L2ATRT:
+	case STA32X_MPCC1 ... STA32X_FDRC2:
+		return 0;
+	}
+	return 1;
+}
+
 static const struct snd_soc_codec_driver sta32x_codec = {
 	.probe =		sta32x_probe,
 	.remove =		sta32x_remove,
@@ -693,6 +816,7 @@ static const struct snd_soc_codec_driver sta32x_codec = {
 	.resume =		sta32x_resume,
 	.reg_cache_size =	STA32X_REGISTER_COUNT,
 	.reg_word_size =	sizeof(u8),
+	.volatile_register =	sta32x_reg_is_volatile,
 	.set_bias_level =	sta32x_set_bias_level,
 	.controls =		sta32x_snd_controls,
 	.num_controls =		ARRAY_SIZE(sta32x_snd_controls),
-- 
1.7.5.4
