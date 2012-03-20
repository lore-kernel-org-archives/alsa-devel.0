From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH 1/8] sound:asoc: Add support for STA529 Audio
	Codec
Date: Tue, 20 Mar 2012 17:03:45 +0530
Message-ID: <a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D2E4A103BA8
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:34:49 +0100 (CET)
In-Reply-To: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, spear-devel@list.st.com, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds the support for STA529 audio codec.
Details of the audio codec can be seen here:
http://www.st.com/internet/imag_video/product/159187.jsp

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/codecs/Kconfig  |    5 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/sta529.c |  414 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 421 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/sta529.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 59d8efa..2c003d1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -49,6 +49,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2602 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_STA32X if I2C
+	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
@@ -252,6 +253,10 @@ config SND_SOC_SSM2602
 config SND_SOC_STA32X
 	tristate
 
+config SND_SOC_STA529
+	tristate
+	depends on I2C
+
 config SND_SOC_STAC9766
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0c0e6ce..a0e43cd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -39,6 +39,7 @@ snd-soc-sn95031-objs := sn95031.o
 snd-soc-spdif-objs := spdif_transciever.o spdif_receiver.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-sta32x-objs := sta32x.o
+snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
@@ -143,6 +144,7 @@ obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
+obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
new file mode 100644
index 0000000..1294947
--- /dev/null
+++ b/sound/soc/codecs/sta529.c
@@ -0,0 +1,414 @@
+/*
+ * ASoC codec driver for spear platform
+ *
+ * sound/soc/codecs/sta529.c -- spear ALSA Soc codec driver
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+/* STA529 Register offsets */
+#define	 STA529_FFXCFG0		0x00
+#define	 STA529_FFXCFG1		0x01
+#define	 STA529_MVOL		0x02
+#define	 STA529_LVOL		0x03
+#define	 STA529_RVOL		0x04
+#define	 STA529_TTF0		0x05
+#define	 STA529_TTF1		0x06
+#define	 STA529_TTP0		0x07
+#define	 STA529_TTP1		0x08
+#define	 STA529_S2PCFG0		0x0A
+#define	 STA529_S2PCFG1		0x0B
+#define	 STA529_P2SCFG0		0x0C
+#define	 STA529_P2SCFG1		0x0D
+#define	 STA529_PLLCFG0		0x14
+#define	 STA529_PLLCFG1		0x15
+#define	 STA529_PLLCFG2		0x16
+#define	 STA529_PLLCFG3		0x17
+#define	 STA529_PLLPFE		0x18
+#define	 STA529_PLLST		0x19
+#define	 STA529_ADCCFG		0x1E /*mic_select*/
+#define	 STA529_CKOCFG		0x1F
+#define	 STA529_MISC		0x20
+#define	 STA529_PADST0		0x21
+#define	 STA529_PADST1		0x22
+#define	 STA529_FFXST		0x23
+#define	 STA529_PWMIN1		0x2D
+#define	 STA529_PWMIN2		0x2E
+#define	 STA529_POWST		0x32
+
+#define STA529_CACHEREGNUM	0x33 /*total num of reg. in sta529*/
+
+#define STA529_RATES		(SNDRV_PCM_RATE_8000 | \
+				SNDRV_PCM_RATE_11025 | \
+				SNDRV_PCM_RATE_16000 | \
+				SNDRV_PCM_RATE_22050 | \
+				SNDRV_PCM_RATE_32000 | \
+				SNDRV_PCM_RATE_44100 | \
+				SNDRV_PCM_RATE_48000)
+
+#define STA529_FORMAT		SNDRV_PCM_FMTBIT_S16_LE
+#define	S2PC_VALUE		0x98
+#define CLOCK_OUT		0x60
+#define LEFT_J_DATA_FORMAT	0x10
+#define I2S_DATA_FORMAT		0x12
+#define RIGHT_J_DATA_FORMAT	0x14
+#define CODEC_MUTE_VAL		0x80
+
+#define POWER_CNTLMSAK		0x40
+#define POWER_STDBY		0x40
+#define FFX_MASK		0x80
+#define FFX_OFF			0x80
+#define POWER_UP		0x00
+
+static const u8 sta529_reg[STA529_CACHEREGNUM] = {
+	0x35, 0xc8, 0x50, 0x00,
+	0x00, 0x00, 0x02, 0x00,
+	0x02, 0x05, 0xb2, 0x41,
+	0x92, 0x41, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x80, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0xD2, 0x40,
+	0x21, 0xef, 0x04, 0x06,
+	0x41, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+struct sta529 {
+	unsigned int sysclk;
+	enum snd_soc_control_type control_type;
+	void *control_data;
+};
+
+static const char *pwm_mode_text[] = { "binary", "headphone", "ternary",
+	"phase-shift"};
+static const char *interface_mode_text[] = { "slave", "master"};
+
+static const struct soc_enum pwm_src_enum =
+SOC_ENUM_SINGLE(STA529_FFXCFG1, 4, 4, pwm_mode_text);
+
+static const struct soc_enum mode_src_enum =
+SOC_ENUM_SINGLE(STA529_P2SCFG0, 0, 2, interface_mode_text);
+
+static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
+	SOC_ENUM("PWM Select", pwm_src_enum),
+	SOC_ENUM("MODE Select", mode_src_enum),
+};
+
+static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -9150, 50, 0);
+static const DECLARE_TLV_DB_SCALE(master_vol_tlv, -12750, 50, 0);
+
+static const struct snd_kcontrol_new sta529_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Digital Playback Volume", STA529_LVOL, STA529_RVOL, 0,
+			127, 0, out_gain_tlv),
+	SOC_SINGLE_TLV("Master Playback Volume", STA529_MVOL, 0, 127, 1,
+			master_vol_tlv),
+};
+
+static int
+sta529_set_bias_level(struct snd_soc_codec *codec,
+		enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
+				POWER_UP);
+		snd_soc_update_bits(codec, STA529_MISC, 1, 0x01);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
+		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
+				POWER_STDBY);
+		/* Making FFX output to zero */
+		snd_soc_update_bits(codec, STA529_FFXCFG0, FFX_MASK,
+				FFX_OFF);
+		snd_soc_update_bits(codec, STA529_MISC, 1, 0x00);
+
+		break;
+	}
+
+	/*
+	 * store the label for powers down audio subsystem for suspend.This is
+	 * used by soc core layer
+	 */
+	codec->dapm.bias_level = level;
+	return 0;
+
+}
+
+static int sta529_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	int pdata, play_freq_val, record_freq_val;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		pdata = 1;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		pdata = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		pdata = 3;
+		break;
+	}
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 11025:
+		play_freq_val = 0;
+		record_freq_val = 2;
+		break;
+	case 16000:
+	case 22050:
+		play_freq_val = 1;
+		record_freq_val = 0;
+		break;
+
+	case 32000:
+	case 44100:
+	case 48000:
+		play_freq_val = 2;
+		record_freq_val = 0;
+		break;
+	default:
+		printk(KERN_WARNING, "bad rate\n");
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		snd_soc_update_bits(codec, STA529_S2PCFG1, 0xC0, (pdata << 6));
+		snd_soc_update_bits(codec, STA529_MISC, 0x0C,
+				(play_freq_val << 4));
+	} else {
+		snd_soc_update_bits(codec, STA529_P2SCFG1, 0xC0, (pdata << 6));
+		snd_soc_update_bits(codec, STA529_MISC, 0x0C,
+				(record_freq_val << 2));
+
+	}
+
+	sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
+	mdelay(10);
+
+	return 0;
+}
+
+static int sta529_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0) & ~CODEC_MUTE_VAL;
+
+	if (mute)
+		mute_reg |= CODEC_MUTE_VAL;
+
+	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);
+
+	return 0;
+}
+
+static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u8 mode = 0;
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode = LEFT_J_DATA_FORMAT;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		mode = I2S_DATA_FORMAT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mode = RIGHT_J_DATA_FORMAT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mode |= 0x20;
+	snd_soc_update_bits(codec, STA529_S2PCFG0, 0xE0, mode);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops sta529_dai_ops = {
+	.hw_params	=	sta529_hw_params,
+	.set_fmt	=	sta529_set_dai_fmt,
+	.digital_mute	=	sta529_mute,
+};
+
+static struct snd_soc_dai_driver sta529_dai = {
+	.name = "sta529-audio",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = STA529_RATES,
+		.formats = STA529_FORMAT,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = STA529_RATES,
+		.formats = STA529_FORMAT,
+	},
+	.ops	= &sta529_dai_ops,
+};
+
+static int sta529_probe(struct snd_soc_codec *codec)
+{
+	struct sta529 *sta529 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, sta529->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	snd_soc_add_controls(codec, sta529_snd_controls,
+			ARRAY_SIZE(sta529_snd_controls));
+
+	snd_soc_add_controls(codec, sta529_new_snd_controls,
+			ARRAY_SIZE(sta529_new_snd_controls));
+	return 0;
+}
+
+/* power down chip */
+static int sta529_remove(struct snd_soc_codec *codec)
+{
+	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int sta529_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int sta529_resume(struct snd_soc_codec *codec)
+{
+	snd_soc_cache_sync(codec);
+	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);
+
+	return 0;
+}
+
+struct snd_soc_codec_driver soc_codec_dev_sta529 = {
+	.probe = sta529_probe,
+	.remove = sta529_remove,
+	.set_bias_level = sta529_set_bias_level,
+	.suspend = sta529_suspend,
+	.resume = sta529_resume,
+	.reg_cache_size = STA529_CACHEREGNUM,
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = sta529_reg,
+
+};
+
+static __devinit int sta529_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	struct sta529 *sta529;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EINVAL;
+
+	sta529 = kzalloc(sizeof(struct sta529), GFP_KERNEL);
+	if (sta529 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, sta529);
+	sta529->control_data = i2c;
+	sta529->control_type = SND_SOC_I2C;
+
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_sta529, &sta529_dai, 1);
+	if (ret < 0)
+		kfree(sta529);
+	return ret;
+}
+
+static int sta529_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id sta529_i2c_id[] = {
+	{ "sta529", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sta529_i2c_id);
+
+static struct i2c_driver sta529_i2c_driver = {
+	.driver = {
+		.name = "sta529",
+		.owner = THIS_MODULE,
+	},
+	.probe		= sta529_i2c_probe,
+	.remove		= __devexit_p(sta529_i2c_remove),
+	.id_table	= sta529_i2c_id,
+};
+
+static int __init sta529_modinit(void)
+{
+	int ret = 0;
+
+	ret = i2c_add_driver(&sta529_i2c_driver);
+	if (ret != 0)
+		printk(KERN_ERR "Failed to reg sta529 I2C driver: %d\n", ret);
+
+	return ret;
+
+}
+module_init(sta529_modinit);
+
+static void __exit sta529_exit(void)
+{
+	i2c_del_driver(&sta529_i2c_driver);
+}
+module_exit(sta529_exit);
+
+MODULE_DESCRIPTION("ASoC STA529 codec driver");
+MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.2.2
