From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH 2/2] ASoC: tas571x: add biquads for TAS5717/19
Date: Thu, 26 May 2016 19:26:17 +0200
Message-ID: <1464283577-29552-2-git-send-email-brain@jikos.cz>
References: <1464283577-29552-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep28.mx.upcmail.net (fep28.mx.upcmail.net [62.179.121.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4652616B9
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 19:26:44 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep28-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20160526172644.NOHS24402.viefep28-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2016 19:26:44 +0200
In-Reply-To: <1464283577-29552-1-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, cernekee@chromium.org
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

TAS571x features multiple biquad filters. Their coefficients
are stored in 20-byte registers, which cannot be supported by
regmap.

This patch adds read and write functions for multi-word (32-bit) register
access and mixer controls for the biquads. The multi-word read/write
functions can be used in the future to implement other features like DRC or
output mixer.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 170 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index b8d19b7..bc1fbaf 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -28,6 +28,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
+#include <asm/unaligned.h>
 
 #include "tas571x.h"
 
@@ -135,6 +136,129 @@ static int tas571x_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+/*
+ * register write for 8- and 20-byte registers
+ */
+static int tas571x_reg_write_multiword(struct i2c_client *client,
+		unsigned int reg, const long values[], size_t len)
+{
+	size_t i;
+	uint8_t *buf, *p;
+	int ret;
+	size_t send_size = 1 + len * sizeof(uint32_t);
+
+	buf = kzalloc(send_size, GFP_KERNEL | GFP_DMA);
+	if (!buf)
+		return -ENOMEM;
+	buf[0] = reg;
+
+	for (i = 0, p = buf + 1; i < len; i++, p += sizeof(uint32_t))
+		put_unaligned_be32(values[i], p);
+
+	ret = i2c_master_send(client, buf, send_size);
+
+	kfree(buf);
+
+	if (ret == send_size)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+/*
+ * register read for 8- and 20-byte registers
+ */
+static int tas571x_reg_read_multiword(struct i2c_client *client,
+		unsigned int reg, long values[], size_t len)
+{
+	unsigned int i;
+	uint8_t send_buf;
+	uint8_t *recv_buf, *p;
+	struct i2c_msg msgs[2];
+	unsigned int recv_size = len * sizeof(uint32_t);
+	int ret;
+
+	recv_buf = kzalloc(recv_size, GFP_KERNEL | GFP_DMA);
+	if (!recv_buf)
+		return -ENOMEM;
+
+	send_buf = reg;
+
+	msgs[0].addr = client->addr;
+	msgs[0].len = sizeof(send_buf);
+	msgs[0].buf = &send_buf;
+	msgs[0].flags = 0;
+
+	msgs[1].addr = client->addr;
+	msgs[1].len = recv_size;
+	msgs[1].buf = recv_buf;
+	msgs[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		goto err_ret;
+	else if (ret != ARRAY_SIZE(msgs)) {
+		ret = -EIO;
+		goto err_ret;
+	}
+
+	for (i = 0, p = recv_buf; i < len; i++, p += sizeof(uint32_t))
+		values[i] = get_unaligned_be32(p);
+
+err_ret:
+	kfree(recv_buf);
+	return ret;
+}
+
+/*
+ * Integer array controls for setting biquad, mixer, DRC coefficients.
+ * According to the datasheet each coefficient is effectively 26bits,
+ * i.e. stored as 32bits, where bits [31:26] are ignored.
+ * TI's TAS57xx Graphical Development Environment tool however produces
+ * coefficients with more than 26 bits. For this reason we allow values
+ * in the full 32-bits reange.
+ * The coefficients are ordered as given in the TAS571x data sheet:
+ * b0, b1, b2, a1, a2
+ */
+
+static int tas571x_coefficient_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	int numcoef = kcontrol->private_value >> 16;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = numcoef;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xffffffff;
+	return 0;
+}
+
+static int tas571x_coefficient_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+
+	return tas571x_reg_read_multiword(i2c, index,
+		ucontrol->value.integer.value, numcoef);
+}
+
+static int tas571x_coefficient_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+
+	return tas571x_reg_write_multiword(i2c, index,
+		ucontrol->value.integer.value, numcoef);
+}
+
 static int tas571x_set_dai_fmt(struct snd_soc_dai *dai, unsigned int format)
 {
 	struct tas571x_private *priv = snd_soc_codec_get_drvdata(dai->codec);
@@ -241,6 +365,15 @@ static const struct snd_soc_dai_ops tas571x_dai_ops = {
 	.digital_mute	= tas571x_mute,
 };
 
+
+#define BIQUAD_COEFS(xname, reg) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = tas571x_coefficient_info, \
+	.get = tas571x_coefficient_get,\
+	.put = tas571x_coefficient_put, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.private_value = reg | (5 << 16) }
+
 static const char *const tas5711_supply_names[] = {
 	"AVDD",
 	"DVDD",
@@ -340,6 +473,43 @@ static const struct snd_kcontrol_new tas5717_controls[] = {
 		   TAS571X_SOFT_MUTE_REG,
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
+
+	/*
+	 * The biquads are named according to the register names.
+	 * Please note that TI's TAS57xx Graphical Development Environment
+	 * tool names them different.
+	 */
+	BIQUAD_COEFS("CH1 - Biquad 0", TAS5717_CH1_BQ0_REG),
+	BIQUAD_COEFS("CH1 - Biquad 1", TAS5717_CH1_BQ1_REG),
+	BIQUAD_COEFS("CH1 - Biquad 2", TAS5717_CH1_BQ2_REG),
+	BIQUAD_COEFS("CH1 - Biquad 3", TAS5717_CH1_BQ3_REG),
+	BIQUAD_COEFS("CH1 - Biquad 4", TAS5717_CH1_BQ4_REG),
+	BIQUAD_COEFS("CH1 - Biquad 5", TAS5717_CH1_BQ5_REG),
+	BIQUAD_COEFS("CH1 - Biquad 6", TAS5717_CH1_BQ6_REG),
+	BIQUAD_COEFS("CH1 - Biquad 7", TAS5717_CH1_BQ7_REG),
+	BIQUAD_COEFS("CH1 - Biquad 8", TAS5717_CH1_BQ8_REG),
+	BIQUAD_COEFS("CH1 - Biquad 9", TAS5717_CH1_BQ9_REG),
+	BIQUAD_COEFS("CH1 - Biquad 10", TAS5717_CH1_BQ10_REG),
+	BIQUAD_COEFS("CH1 - Biquad 11", TAS5717_CH1_BQ11_REG),
+
+	BIQUAD_COEFS("CH2 - Biquad 0", TAS5717_CH2_BQ0_REG),
+	BIQUAD_COEFS("CH2 - Biquad 1", TAS5717_CH2_BQ1_REG),
+	BIQUAD_COEFS("CH2 - Biquad 2", TAS5717_CH2_BQ2_REG),
+	BIQUAD_COEFS("CH2 - Biquad 3", TAS5717_CH2_BQ3_REG),
+	BIQUAD_COEFS("CH2 - Biquad 4", TAS5717_CH2_BQ4_REG),
+	BIQUAD_COEFS("CH2 - Biquad 5", TAS5717_CH2_BQ5_REG),
+	BIQUAD_COEFS("CH2 - Biquad 6", TAS5717_CH2_BQ6_REG),
+	BIQUAD_COEFS("CH2 - Biquad 7", TAS5717_CH2_BQ7_REG),
+	BIQUAD_COEFS("CH2 - Biquad 8", TAS5717_CH2_BQ8_REG),
+	BIQUAD_COEFS("CH2 - Biquad 9", TAS5717_CH2_BQ9_REG),
+	BIQUAD_COEFS("CH2 - Biquad 10", TAS5717_CH2_BQ10_REG),
+	BIQUAD_COEFS("CH2 - Biquad 11", TAS5717_CH2_BQ11_REG),
+
+	BIQUAD_COEFS("CH3 - Biquad 0", TAS5717_CH3_BQ0_REG),
+	BIQUAD_COEFS("CH3 - Biquad 1", TAS5717_CH3_BQ1_REG),
+
+	BIQUAD_COEFS("CH4 - Biquad 0", TAS5717_CH4_BQ0_REG),
+	BIQUAD_COEFS("CH4 - Biquad 1", TAS5717_CH4_BQ1_REG),
 };
 
 static const struct reg_default tas5717_reg_defaults[] = {
-- 
2.5.0
