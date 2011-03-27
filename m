From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH v5] ASoC: SSM2602: convert to soc-cache
Date: Sun, 27 Mar 2011 17:14:10 -0400
Message-ID: <1301260450-6333-1-git-send-email-vapier@gentoo.org>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id CD1C01037FC
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 00:13:04 +0200 (CEST)
In-Reply-To: <1301124539-527-2-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
v5
	- use snd_soc_cache_sync

 sound/soc/codecs/ssm2602.c |  133 ++++++++++++++-----------------------------
 1 files changed, 43 insertions(+), 90 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 5a5a6b1..ba02771 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -48,7 +48,6 @@
 struct ssm2602_priv {
 	unsigned int sysclk;
 	enum snd_soc_control_type control_type;
-	void *control_data;
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
 };
@@ -65,55 +64,7 @@ static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	0x0000, 0x0000
 };
 
-/*
- * read ssm2602 register cache
- */
-static inline unsigned int ssm2602_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg == SSM2602_RESET)
-		return 0;
-	if (reg >= SSM2602_CACHEREGNUM)
-		return -1;
-	return cache[reg];
-}
-
-/*
- * write ssm2602 register cache
- */
-static inline void ssm2602_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	if (reg >= SSM2602_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-/*
- * write to the ssm2602 register space
- */
-static int ssm2602_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	/* data is
-	 *   D15..D9 ssm2602 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	ssm2602_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define ssm2602_reset(c)	ssm2602_write(c, SSM2602_RESET, 0)
+#define ssm2602_reset(c)	snd_soc_write(c, SSM2602_RESET, 0)
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -278,8 +229,7 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
-	u16 iface = ssm2602_read_reg_cache(codec, SSM2602_IFACE) & 0xfff3;
+	u16 iface = snd_soc_read(codec, SSM2602_IFACE) & 0xfff3;
 	int i = get_coeff(ssm2602->sysclk, params_rate(params));
 
 	if (substream == ssm2602->slave_substream) {
@@ -294,8 +244,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	srate = (coeff_div[i].sr << 2) |
 		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
 
-	ssm2602_write(codec, SSM2602_ACTIVE, 0);
-	ssm2602_write(codec, SSM2602_SRATE, srate);
+	snd_soc_write(codec, SSM2602_ACTIVE, 0);
+	snd_soc_write(codec, SSM2602_SRATE, srate);
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -311,8 +261,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 		iface |= 0x000c;
 		break;
 	}
-	ssm2602_write(codec, SSM2602_IFACE, iface);
-	ssm2602_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
+	snd_soc_write(codec, SSM2602_IFACE, iface);
+	snd_soc_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
 	return 0;
 }
 
@@ -360,7 +310,7 @@ static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	/* set active */
-	ssm2602_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
+	snd_soc_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
 
 	return 0;
 }
@@ -374,7 +324,7 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 
 	/* deactivate */
 	if (!codec->active)
-		ssm2602_write(codec, SSM2602_ACTIVE, 0);
+		snd_soc_write(codec, SSM2602_ACTIVE, 0);
 
 	if (ssm2602->master_substream == substream)
 		ssm2602->master_substream = ssm2602->slave_substream;
@@ -385,12 +335,12 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = ssm2602_read_reg_cache(codec, SSM2602_APDIGI) & ~APDIGI_ENABLE_DAC_MUTE;
+	u16 mute_reg = snd_soc_read(codec, SSM2602_APDIGI) & ~APDIGI_ENABLE_DAC_MUTE;
 	if (mute)
-		ssm2602_write(codec, SSM2602_APDIGI,
+		snd_soc_write(codec, SSM2602_APDIGI,
 				mute_reg | APDIGI_ENABLE_DAC_MUTE);
 	else
-		ssm2602_write(codec, SSM2602_APDIGI, mute_reg);
+		snd_soc_write(codec, SSM2602_APDIGI, mute_reg);
 	return 0;
 }
 
@@ -466,30 +416,30 @@ static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	ssm2602_write(codec, SSM2602_IFACE, iface);
+	snd_soc_write(codec, SSM2602_IFACE, iface);
 	return 0;
 }
 
 static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg = ssm2602_read_reg_cache(codec, SSM2602_PWR) & 0xff7f;
+	u16 reg = snd_soc_read(codec, SSM2602_PWR) & 0xff7f;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* vref/mid, osc on, dac unmute */
-		ssm2602_write(codec, SSM2602_PWR, reg);
+		snd_soc_write(codec, SSM2602_PWR, reg);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* everything off except vref/vmid, */
-		ssm2602_write(codec, SSM2602_PWR, reg | PWR_CLK_OUT_PDN);
+		snd_soc_write(codec, SSM2602_PWR, reg | PWR_CLK_OUT_PDN);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* everything off, dac mute, inactive */
-		ssm2602_write(codec, SSM2602_ACTIVE, 0);
-		ssm2602_write(codec, SSM2602_PWR, 0xffff);
+		snd_soc_write(codec, SSM2602_ACTIVE, 0);
+		snd_soc_write(codec, SSM2602_PWR, 0xffff);
 		break;
 
 	}
@@ -540,16 +490,14 @@ static int ssm2602_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int ssm2602_resume(struct snd_soc_codec *codec)
 {
 	int i;
-	u8 data[2];
 	u16 *cache = codec->reg_cache;
 
 	/* Sync reg_cache with the hardware */
-	for (i = 0; i < ARRAY_SIZE(ssm2602_reg); i++) {
-		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
-		data[1] = cache[i] & 0x00ff;
-		codec->hw_write(codec->control_data, data, 2);
-	}
+	for (i = 0; i < ARRAY_SIZE(ssm2602_reg); i++)
+		snd_soc_write(codec, i, cache[i]);
+
 	ssm2602_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	return 0;
 }
 
@@ -560,31 +508,39 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 
 	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
 
-	codec->control_data = ssm2602->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, ssm2602->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
 
-	ssm2602_reset(codec);
+	ret = ssm2602_reset(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		return ret;
+	}
 
 	/*power on device*/
-	ssm2602_write(codec, SSM2602_ACTIVE, 0);
+	snd_soc_write(codec, SSM2602_ACTIVE, 0);
 	/* set the update bits */
-	reg = ssm2602_read_reg_cache(codec, SSM2602_LINVOL);
-	ssm2602_write(codec, SSM2602_LINVOL, reg | LINVOL_LRIN_BOTH);
-	reg = ssm2602_read_reg_cache(codec, SSM2602_RINVOL);
-	ssm2602_write(codec, SSM2602_RINVOL, reg | RINVOL_RLIN_BOTH);
-	reg = ssm2602_read_reg_cache(codec, SSM2602_LOUT1V);
-	ssm2602_write(codec, SSM2602_LOUT1V, reg | LOUT1V_LRHP_BOTH);
-	reg = ssm2602_read_reg_cache(codec, SSM2602_ROUT1V);
-	ssm2602_write(codec, SSM2602_ROUT1V, reg | ROUT1V_RLHP_BOTH);
+	reg = snd_soc_read(codec, SSM2602_LINVOL);
+	snd_soc_write(codec, SSM2602_LINVOL, reg | LINVOL_LRIN_BOTH);
+	reg = snd_soc_read(codec, SSM2602_RINVOL);
+	snd_soc_write(codec, SSM2602_RINVOL, reg | RINVOL_RLIN_BOTH);
+	reg = snd_soc_read(codec, SSM2602_LOUT1V);
+	snd_soc_write(codec, SSM2602_LOUT1V, reg | LOUT1V_LRHP_BOTH);
+	reg = snd_soc_read(codec, SSM2602_ROUT1V);
+	snd_soc_write(codec, SSM2602_ROUT1V, reg | ROUT1V_RLHP_BOTH);
 	/*select Line in as default input*/
-	ssm2602_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
+	snd_soc_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
 			APANA_ENABLE_MIC_BOOST);
-	ssm2602_write(codec, SSM2602_PWR, 0);
+	snd_soc_write(codec, SSM2602_PWR, 0);
 
 	snd_soc_add_controls(codec, ssm2602_snd_controls,
 				ARRAY_SIZE(ssm2602_snd_controls));
 	ssm2602_add_widgets(codec);
 
-	return ret;
+	return 0;
 }
 
 /* remove everything here */
@@ -599,8 +555,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.remove =	ssm2602_remove,
 	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
-	.read = ssm2602_read_reg_cache,
-	.write = ssm2602_write,
 	.set_bias_level = ssm2602_set_bias_level,
 	.reg_cache_size = sizeof(ssm2602_reg),
 	.reg_word_size = sizeof(u16),
@@ -625,7 +579,6 @@ static int ssm2602_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, ssm2602);
-	ssm2602->control_data = i2c;
 	ssm2602->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.4.1
