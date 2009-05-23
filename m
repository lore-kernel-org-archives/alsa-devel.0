From: "Demian Martin" <demianm@attglobal.net>
Subject: Re: Alsa-devel Digest, Vol 27, Issue 124
Date: Sat, 23 May 2009 23:27:22 GMT
Message-ID: <403382336-1243121183-cardhu_decombobulator_blackberry.rim.net-1660422915-@bxe1265.bisx.prod.on.blackberry>
References: <mailman.1667.1243120399.2052.alsa-devel@alsa-project.org>
Reply-To: demianm@attglobal.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp07.bis.na.blackberry.com (smtp07.bis.na.blackberry.com
	[216.9.248.54]) by alsa0.perex.cz (Postfix) with ESMTP id 734FA10380B
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 01:26:25 +0200 (CEST)
In-Reply-To: <mailman.1667.1243120399.2052.alsa-devel@alsa-project.org>
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
List-Id: alsa-devel@alsa-project.org


Demian Martin
PDS
209 613 6990

-----Original Message-----
From: alsa-devel-request@alsa-project.org

Date: Sun, 24 May 2009 01:13:19 
To: <alsa-devel@alsa-project.org>
Subject: Alsa-devel Digest, Vol 27, Issue 124


Send Alsa-devel mailing list submissions to
	alsa-devel@alsa-project.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
or, via email, send a message with subject or body 'help' to
	alsa-devel-request@alsa-project.org

You can reach the person managing the list at
	alsa-devel-owner@alsa-project.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Alsa-devel digest..."


Today's Topics:

   1. [PATCH V2 4/9] Add a few more mpc5200 PSC defines (Jon Smirl)
   2. [PATCH V2 6/9] Codec for STAC9766 used on the Efika (Jon Smirl)
   3. [PATCH V2 7/9] AC97 driver for mpc5200 (Jon Smirl)


----------------------------------------------------------------------

Message: 1
Date: Sat, 23 May 2009 19:13:03 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [alsa-devel] [PATCH V2 4/9] Add a few more mpc5200 PSC
	defines
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
Message-ID: <20090523231303.17919.35877.stgit@terra>
Content-Type: text/plain; charset="utf-8"

Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers. This patch is going in via Grant's tree.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index a218da6..fb84120 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -28,6 +28,10 @@
 #define MPC52xx_PSC_MAXNUM	6
 
 /* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR_UNEX_RX	0x0001
+#define MPC52xx_PSC_SR_DATA_VAL	0x0002
+#define MPC52xx_PSC_SR_DATA_OVR	0x0004
+#define MPC52xx_PSC_SR_CMDSEND	0x0008
 #define MPC52xx_PSC_SR_CDE	0x0080
 #define MPC52xx_PSC_SR_RXRDY	0x0100
 #define MPC52xx_PSC_SR_RXFULL	0x0200
@@ -61,6 +65,12 @@
 #define MPC52xx_PSC_RXTX_FIFO_EMPTY	0x0001
 
 /* PSC interrupt status/mask bits */
+#define MPC52xx_PSC_IMR_UNEX_RX_SLOT 0x0001
+#define MPC52xx_PSC_IMR_DATA_VALID	0x0002
+#define MPC52xx_PSC_IMR_DATA_OVR	0x0004
+#define MPC52xx_PSC_IMR_CMD_SEND	0x0008
+#define MPC52xx_PSC_IMR_ERROR		0x0040
+#define MPC52xx_PSC_IMR_DEOF		0x0080
 #define MPC52xx_PSC_IMR_TXRDY		0x0100
 #define MPC52xx_PSC_IMR_RXRDY		0x0200
 #define MPC52xx_PSC_IMR_DB		0x0400
@@ -117,6 +127,7 @@
 #define MPC52xx_PSC_SICR_SIM_FIR		(0x6 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_24		(0x7 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_32		(0xf << 24)
+#define MPC52xx_PSC_SICR_AWR			(1 << 30)
 #define MPC52xx_PSC_SICR_GENCLK			(1 << 23)
 #define MPC52xx_PSC_SICR_I2S			(1 << 22)
 #define MPC52xx_PSC_SICR_CLKPOL			(1 << 21)



------------------------------

Message: 2
Date: Sat, 23 May 2009 19:13:07 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [alsa-devel] [PATCH V2 6/9] Codec for STAC9766 used on the
	Efika
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
Message-ID: <20090523231307.17919.5277.stgit@terra>
Content-Type: text/plain; charset="utf-8"

AC97 codec for STAC9766 used on the Efika.
Datasheet: http://www.idt.com/products/getDoc.cfm?docID=13134007

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7f78b65..cb07d9b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -19,6 +19,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_PCM3008
 	select SND_SOC_SSM2602 if I2C
+	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
@@ -93,6 +94,9 @@ config SND_SOC_PCM3008
 config SND_SOC_SSM2602
 	tristate
 
+config SND_SOC_STAC9766
+	tristate
+
 config SND_SOC_TLV320AIC23
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 70c55fa..46c007c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -7,6 +7,7 @@ snd-soc-cs4270-objs := cs4270.o
 snd-soc-l3-objs := l3.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-ssm2602-objs := ssm2602.o
+snd-soc-stac9766-objs := stac9766.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
@@ -42,6 +43,7 @@ obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
+obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
new file mode 100644
index 0000000..7740cd5
--- /dev/null
+++ b/sound/soc/codecs/stac9766.c
@@ -0,0 +1,470 @@
+/*
+ * stac9766.c  --  ALSA SoC STAC9766 codec support
+ *
+ * Copyright 2009 Jon Smirl, Digispeaker
+ * Author: Jon Smirl <jonsmirl@gmail.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Features:-
+ *
+ *   o Support for AC97 Codec, S/PDIF
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/soc-of-simple.h>
+
+#include "stac9766.h"
+
+#define STAC9766_VERSION "0.10"
+
+/*
+ * STAC9766 register cache
+ */
+static const u16 stac9766_reg[] = {
+	0x6A90, 0x8000, 0x8000, 0x8000, /* 6 */
+	0x0000, 0x0000, 0x8008, 0x8008, /* e */
+	0x8808, 0x8808, 0x8808, 0x8808, /* 16 */
+	0x8808, 0x0000, 0x8000, 0x0000, /* 1e */
+	0x0000, 0x0000, 0x0000, 0x000f, /* 26 */
+	0x0a05, 0x0400, 0xbb80, 0x0000, /* 2e */
+	0x0000, 0xbb80, 0x0000, 0x0000, /* 36 */
+	0x0000, 0x2000, 0x0000, 0x0100, /* 3e */
+	0x0000, 0x0000, 0x0080, 0x0000, /* 46 */
+	0x0000, 0x0000, 0x0003, 0xffff, /* 4e */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 56 */
+	0x4000, 0x0000, 0x0000, 0x0000, /* 5e */
+	0x1201, 0xFFFF, 0xFFFF, 0x0000, /* 66 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
+	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
+	0x0000, 0x0000, 0x0000, 0x0000, /* 7e */
+};
+
+static const char *stac9766_record_mux[] = {"Mic", "CD", "Video", "AUX", "Line", "Stereo Mix", "Mono Mix", "Phone"};
+static const char *stac9766_mono_mux[] = {"Mix", "Mic"};
+static const char *stac9766_mic_mux[] = {"Mic1", "Mic2"};
+static const char *stac9766_SPDIF_mux[] = {"PCM", "ADC Record"};
+static const char *stac9766_popbypass_mux[] = {"Normal", "Bypass Mixer"};
+static const char *stac9766_record_all_mux[] = {"All analog", "Analog plus DAC"};
+static const char *stac9766_boost1[] = {"0dB", "10dB"};
+static const char *stac9766_boost2[] = {"0dB", "20dB"};
+static const char *stac9766_stereo_mic[] = {"Off", "On"};
+
+static const struct soc_enum stac9766_record_enum =
+	SOC_ENUM_DOUBLE(AC97_REC_SEL, 8, 0, 8, stac9766_record_mux);
+static const struct soc_enum stac9766_mono_enum =
+	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 9, 2, stac9766_mono_mux);
+static const struct soc_enum stac9766_mic_enum =
+	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 8, 2, stac9766_mic_mux);
+static const struct soc_enum stac9766_SPDIF_enum =
+	SOC_ENUM_SINGLE(AC97_STAC_DA_CONTROL, 1, 2, stac9766_SPDIF_mux);
+static const struct soc_enum stac9766_popbypass_enum =
+	SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 15, 2, stac9766_popbypass_mux);
+static const struct soc_enum stac9766_record_all_enum =
+	SOC_ENUM_SINGLE(AC97_STAC_ANALOG_SPECIAL, 12, 2, stac9766_record_all_mux);
+static const struct soc_enum stac9766_boost1_enum =
+	SOC_ENUM_SINGLE(AC97_MIC, 6, 2, stac9766_boost1); /* 0/10dB */
+static const struct soc_enum stac9766_boost2_enum =
+	SOC_ENUM_SINGLE(AC97_STAC_ANALOG_SPECIAL, 2, 2, stac9766_boost2); /* 0/20dB */
+static const struct soc_enum stac9766_stereo_mic_enum =
+	SOC_ENUM_SINGLE(AC97_STAC_STEREO_MIC, 2, 1, stac9766_stereo_mic);
+
+static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600, 0);
+static const DECLARE_TLV_DB_LINEAR(record_tlv, 0, 2250);
+static const DECLARE_TLV_DB_LINEAR(beep_tlv, -4500, 0);
+static const DECLARE_TLV_DB_LINEAR(mix_tlv, -3450, 1200);
+
+static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
+	SOC_DOUBLE_TLV("Speaker Volume", AC97_MASTER, 8, 0, 31, 1, master_tlv),
+	SOC_SINGLE("Speaker Switch", AC97_MASTER, 15, 1, 1),
+	SOC_DOUBLE_TLV("Headphone Volume", AC97_HEADPHONE, 8, 0, 31, 1, master_tlv),
+	SOC_SINGLE("Headphone Switch", AC97_HEADPHONE, 15, 1, 1),
+	SOC_SINGLE_TLV("Mono Out Volume", AC97_MASTER_MONO, 0, 31, 1, master_tlv),
+	SOC_SINGLE("Mono Out Switch", AC97_MASTER_MONO, 15, 1, 1),
+
+	SOC_DOUBLE_TLV("Record Volume", AC97_REC_GAIN, 8, 0, 15, 0, record_tlv),
+	SOC_SINGLE("Record Switch", AC97_REC_GAIN, 15, 1, 1),
+
+
+	SOC_SINGLE_TLV("Beep Volume", AC97_PC_BEEP, 1, 15, 1, beep_tlv),
+	SOC_SINGLE("Beep Switch", AC97_PC_BEEP, 15, 1, 1),
+	SOC_SINGLE("Beep Frequency", AC97_PC_BEEP, 5, 127, 1),
+	SOC_SINGLE_TLV("Phone Volume", AC97_PHONE, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("Phone Switch", AC97_PHONE, 15, 1, 1),
+
+	SOC_ENUM("Mic Boost1", stac9766_boost1_enum),
+	SOC_ENUM("Mic Boost2", stac9766_boost2_enum),
+	SOC_SINGLE_TLV("Mic Volume", AC97_MIC, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("Mic Switch", AC97_MIC, 15, 1, 1),
+	SOC_ENUM("Stereo Mic", stac9766_stereo_mic_enum),
+
+	SOC_DOUBLE_TLV("Line Volume", AC97_LINE, 8, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("Line Switch", AC97_LINE, 15, 1, 1),
+	SOC_DOUBLE_TLV("CD Volume", AC97_CD, 8, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("CD Switch", AC97_CD, 15, 1, 1),
+	SOC_DOUBLE_TLV("AUX Volume", AC97_AUX, 8, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("AUX Switch", AC97_AUX, 15, 1, 1),
+	SOC_DOUBLE_TLV("Video Volume", AC97_VIDEO, 8, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("Video Switch", AC97_VIDEO, 15, 1, 1),
+
+	SOC_DOUBLE_TLV("DAC Volume", AC97_PCM, 8, 0, 31, 1, mix_tlv),
+	SOC_SINGLE("DAC Switch", AC97_PCM, 15, 1, 1),
+	SOC_SINGLE("Loopback Test Switch", AC97_GENERAL_PURPOSE, 7, 1, 0),
+	SOC_SINGLE("3D Volume", AC97_3D_CONTROL, 3, 2, 1),
+	SOC_SINGLE("3D Switch", AC97_GENERAL_PURPOSE, 13, 1, 0),
+
+	SOC_ENUM("SPDIF Mux", stac9766_SPDIF_enum),
+	SOC_ENUM("Mic1/2 Mux", stac9766_mic_enum),
+	SOC_ENUM("Record All Mux", stac9766_record_all_enum),
+	SOC_ENUM("Record Mux", stac9766_record_enum),
+	SOC_ENUM("Mono Mux", stac9766_mono_enum),
+	SOC_ENUM("Pop Bypass Mux", stac9766_popbypass_enum),
+};
+
+int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
+                                unsigned int val)
+{
+	u16 *cache = codec->reg_cache;
+
+	if (reg > AC97_STAC_PAGE0) {
+		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
+		soc_ac97_ops.write(codec->ac97, reg, val);
+		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
+		return 0;
+	}
+	if (reg / 2 > ARRAY_SIZE(stac9766_reg))
+		return -EIO;
+
+	soc_ac97_ops.write(codec->ac97, reg, val);
+	cache[reg / 2] = val;
+	return 0;
+}
+
+unsigned int stac9766_ac97_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	u16 val = 0, *cache = codec->reg_cache;
+
+	if (reg > AC97_STAC_PAGE0) {
+		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
+		val = soc_ac97_ops.read(codec->ac97, reg - AC97_STAC_PAGE0);
+		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
+		return val;
+	}
+	if (reg / 2 > ARRAY_SIZE(stac9766_reg))
+		return -EIO;
+
+	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
+		reg == AC97_INT_PAGING || reg == AC97_VENDOR_ID1 ||
+		reg == AC97_VENDOR_ID2) {
+
+		val = soc_ac97_ops.read(codec->ac97, reg);
+		return val;
+	}
+	return cache[reg / 2];
+}
+
+static int ac97_analog_prepare(struct snd_pcm_substream *substream,
+                                struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned short reg, vra;
+
+	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
+
+	vra |= 0x1; /* enable variable rate audio */
+
+	stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		reg = AC97_PCM_FRONT_DAC_RATE;
+	else
+		reg = AC97_PCM_LR_ADC_RATE;
+
+	return stac9766_ac97_write(codec, reg, runtime->rate);
+}
+
+static int ac97_digital_prepare(struct snd_pcm_substream *substream,
+                                struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned short reg, vra;
+
+	stac9766_ac97_write(codec, AC97_SPDIF, 0x2002);
+
+	vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
+	vra |= 0x5; /* Enable VRA and SPDIF out */
+
+	stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
+
+	reg = AC97_PCM_FRONT_DAC_RATE;
+
+	return stac9766_ac97_write(codec, reg, runtime->rate);
+}
+
+static int ac97_digital_trigger(struct snd_pcm_substream *substream,
+								int cmd, struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned short vra;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
+		vra = stac9766_ac97_read(codec, AC97_EXTENDED_STATUS);
+		vra &= !0x04;
+		stac9766_ac97_write(codec, AC97_EXTENDED_STATUS, vra);
+		break;
+	}
+	return 0;
+}
+
+static int stac9766_set_bias_level(struct snd_soc_codec *codec,
+                                enum snd_soc_bias_level level)
+{
+	switch (level) {
+	case SND_SOC_BIAS_ON: /* full On */
+	case SND_SOC_BIAS_PREPARE: /* partial On */
+	case SND_SOC_BIAS_STANDBY: /* Off, with power */
+		stac9766_ac97_write(codec, AC97_POWERDOWN, 0x0000);
+		break;
+	case SND_SOC_BIAS_OFF: /* Off, without power */
+		/* disable everything including AC link */
+		stac9766_ac97_write(codec, AC97_POWERDOWN, 0xffff);
+		break;
+	}
+	codec->bias_level = level;
+	return 0;
+}
+
+int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
+{
+	if (try_warm && soc_ac97_ops.warm_reset) {
+		soc_ac97_ops.warm_reset(codec->ac97);
+		if (stac9766_ac97_read(codec, 0) == stac9766_reg[0])
+			return 1;
+	}
+
+	soc_ac97_ops.reset(codec->ac97);
+	if (soc_ac97_ops.warm_reset)
+		soc_ac97_ops.warm_reset(codec->ac97);
+	if (stac9766_ac97_read(codec, 0) != stac9766_reg[0])
+		return -EIO;
+	return 0;
+}
+
+static int stac9766_codec_suspend(struct platform_device *pdev,
+                                pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	stac9766_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int stac9766_codec_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	u16 id, reset;
+
+	reset = 0;
+	/* give the codec an AC97 warm reset to start the link */
+reset:
+	if (reset > 5) {
+		printk(KERN_ERR "stac9766 failed to resume");
+		return -EIO;
+	}
+	codec->ac97->bus->ops->warm_reset(codec->ac97);
+	id = soc_ac97_ops.read(codec->ac97, AC97_VENDOR_ID2);
+	if (id != 0x4c13) {
+		stac9766_reset(codec, 0);
+		reset++;
+		goto reset;
+	}
+	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
+		stac9766_set_bias_level(codec, SND_SOC_BIAS_ON);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops stac9766_dai_ops_analog =
+{
+	.prepare = ac97_analog_prepare,
+};
+
+static struct snd_soc_dai_ops stac9766_dai_ops_digital =
+{
+	.prepare = ac97_digital_prepare,
+	.trigger = ac97_digital_trigger,
+};
+
+struct snd_soc_dai stac9766_dai[] = {
+{
+	.name = "stac9766 analog",
+	.id = 0,
+	.ac97_control = 1,
+
+	/* stream cababilities */
+	.playback = {
+		.stream_name = "stac9766 analog",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SND_SOC_STD_AC97_FMTS,
+	},
+	.capture = {
+		.stream_name = "stac9766 analog",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SND_SOC_STD_AC97_FMTS,
+	},
+	/* alsa ops */
+	.ops = &stac9766_dai_ops_analog,
+},
+{
+	.name = "stac9766 IEC958",
+	.id = 1,
+	.ac97_control = 1,
+
+	/* stream cababilities */
+	.playback = {
+		.stream_name = "stac9766 IEC958",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_32000 | \
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE,
+	},
+	/* alsa ops */
+	.ops = &stac9766_dai_ops_digital,
+}};
+EXPORT_SYMBOL_GPL(stac9766_dai);
+
+static int stac9766_codec_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
+
+	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (socdev->card->codec == NULL)
+		return -ENOMEM;
+	codec = socdev->card->codec;
+	mutex_init(&codec->mutex);
+
+	codec->reg_cache = kmemdup(stac9766_reg, sizeof(stac9766_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL) {
+		ret = -ENOMEM;
+		goto cache_err;
+	}
+	codec->reg_cache_size = sizeof(stac9766_reg);
+	codec->reg_cache_step = 2;
+
+	codec->name = "STAC9766";
+	codec->owner = THIS_MODULE;
+	codec->dai = stac9766_dai;
+	codec->num_dai = ARRAY_SIZE(stac9766_dai);
+	codec->write = stac9766_ac97_write;
+	codec->read = stac9766_ac97_read;
+	codec->set_bias_level = stac9766_set_bias_level;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	if (ret < 0)
+		goto codec_err;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0)
+		goto pcm_err;
+
+	/* do a cold reset for the controller and then try
+	 * a warm reset followed by an optional cold reset for codec */
+	stac9766_reset(codec, 0);
+	ret = stac9766_reset(codec, 1);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to reset STAC9766: AC97 link error\n");
+		goto reset_err;
+	}
+
+	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	snd_soc_add_controls(codec, stac9766_snd_ac97_controls, ARRAY_SIZE(
+	                                stac9766_snd_ac97_controls));
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0)
+		goto reset_err;
+	return 0;
+
+reset_err:
+	snd_soc_free_pcms(socdev);
+pcm_err:
+	snd_soc_free_ac97_codec(codec);
+codec_err:
+	kfree(codec->private_data);
+cache_err:
+	kfree(socdev->card->codec);
+	socdev->card->codec = NULL;
+	return ret;
+}
+
+static int stac9766_codec_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	if (codec == NULL)
+		return 0;
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_free_ac97_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_stac9766 =
+{
+	.probe = stac9766_codec_probe,
+	.remove = stac9766_codec_remove,
+	.suspend = stac9766_codec_suspend,
+	.resume = stac9766_codec_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_stac9766);
+
+static int __init stac9766_modinit(void)
+{
+	return snd_soc_register_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));
+}
+module_init(stac9766_modinit);
+
+static void __exit stac9766_exit(void)
+{
+	snd_soc_unregister_dais(stac9766_dai, ARRAY_SIZE(stac9766_dai));
+}
+module_exit(stac9766_exit);
+
+MODULE_DESCRIPTION("ASoC stac9766 driver");
+MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
new file mode 100644
index 0000000..65642eb
--- /dev/null
+++ b/sound/soc/codecs/stac9766.h
@@ -0,0 +1,21 @@
+/*
+ * stac9766.h  --  STAC9766 Soc Audio driver
+ */
+
+#ifndef _STAC9766_H
+#define _STAC9766_H
+
+#define AC97_STAC_PAGE0 0x1000
+#define AC97_STAC_DA_CONTROL (AC97_STAC_PAGE0 | 0x6A)
+#define AC97_STAC_ANALOG_SPECIAL (AC97_STAC_PAGE0 | 0x6E)
+#define AC97_STAC_STEREO_MIC 0x78
+
+/* STAC9766 DAI ID's */
+#define STAC9766_DAI_AC97_ANALOG		0
+#define STAC9766_DAI_AC97_DIGITAL		1
+
+extern struct snd_soc_dai stac9766_dai[];
+extern struct snd_soc_codec_device soc_codec_dev_stac9766;
+
+
+#endif



------------------------------

Message: 3
Date: Sat, 23 May 2009 19:13:09 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [alsa-devel] [PATCH V2 7/9] AC97 driver for mpc5200
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
Message-ID: <20090523231309.17919.83073.stgit@terra>
Content-Type: text/plain; charset="utf-8"

AC97 driver for mpc5200

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/Kconfig            |   11 +
 sound/soc/fsl/Makefile           |    1 
 sound/soc/fsl/mpc5200_psc_ac97.c |  394 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h |   15 +
 4 files changed, 421 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 1918c78..3bce952 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -29,3 +29,14 @@ config SND_SOC_MPC5200_I2S
 	select PPC_BESTCOMM_GEN_BD
 	help
 	  Say Y here to support the MPC5200 PSCs in I2S mode.
+
+config SND_SOC_MPC5200_AC97
+	tristate "Freescale MPC5200 PSC in AC97 mode driver"
+	depends on PPC_MPC52xx && PPC_BESTCOMM
+	select AC97_BUS
+	select SND_MPC52xx_DMA
+	select PPC_BESTCOMM_GEN_BD
+	help
+	  Say Y here to support the MPC5200 PSCs in AC97 mode.
+
+
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 7731ef2..14631a1 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_SND_SOC_MPC8610) += snd-soc-fsl-ssi.o snd-soc-fsl-dma.o
 # MPC5200 Platform Support
 obj-$(CONFIG_SND_MPC52xx_DMA) += mpc5200_dma.o
 obj-$(CONFIG_SND_SOC_MPC5200_I2S) += mpc5200_psc_i2s.o
+obj-$(CONFIG_SND_SOC_MPC5200_AC97) += mpc5200_psc_ac97.o
 
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
new file mode 100644
index 0000000..fa1bb9a
--- /dev/null
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -0,0 +1,394 @@
+/*
+ * linux/sound/mpc5200-ac97.c -- AC97 support for the Freescale MPC52xx chip.
+ *
+ * Copyright (C) 2009 Jon Smirl, Digispeaker
+ * Author: Jon Smirl <jonsmirl@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/mpc52xx_psc.h>
+
+#include "mpc5200_dma.h"
+#include "mpc5200_psc_ac97.h"
+
+#define DRV_NAME "mpc5200-psc-ac97"
+
+/* ALSA only supports a single AC97 device so static is recommend here */
+static struct psc_dma *psc_dma;
+
+static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
+{
+	int timeout;
+	unsigned int val;
+
+	spin_lock(&psc_dma->lock);
+
+	/* Wait for it to be ready */
+	timeout = 1000;
+	while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr.status) &
+						MPC52xx_PSC_SR_CMDSEND) )
+		udelay(10);
+
+	if (!timeout) {
+		pr_err("timeout on ac97 bus (rdy)\n");
+		return 0xffff;
+	}
+
+	/* Do the read */
+	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
+
+	/* Wait for the answer */
+	timeout = 1000;
+	while ((--timeout) && !(in_be16(&psc_dma->psc_regs->sr_csr.status) &
+						MPC52xx_PSC_SR_DATA_VAL) )
+		udelay(10);
+
+	if (!timeout) {
+		pr_err("timeout on ac97 read (val) %x\n", in_be16(&psc_dma->psc_regs->sr_csr.status));
+		return 0xffff;
+	}
+
+	/* Get the data */
+	val = in_be32(&psc_dma->psc_regs->ac97_data);
+	if ( ((val>>24) & 0x7f) != reg ) {
+		pr_err("reg echo error on ac97 read\n");
+		return 0xffff;
+	}
+	val = (val >> 8) & 0xffff;
+
+	spin_unlock(&psc_dma->lock);
+	return (unsigned short) val;
+}
+
+static void psc_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
+{
+	int timeout;
+
+	spin_lock(&psc_dma->lock);
+
+	/* Wait for it to be ready */
+	timeout = 1000;
+	while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr.status) &
+						MPC52xx_PSC_SR_CMDSEND) )
+		udelay(10);
+
+	if (!timeout) {
+		pr_err("timeout on ac97 write\n");
+		return;
+	}
+
+	/* Write data */
+	out_be32(&psc_dma->psc_regs->ac97_cmd, ((reg & 0x7f) << 24) | (val << 8));
+
+	spin_unlock(&psc_dma->lock);
+}
+
+static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
+
+	/* Do a cold reset */
+	out_8(&regs->op1, MPC52xx_PSC_OP_RES);
+	udelay(10);
+	out_8(&regs->op0, MPC52xx_PSC_OP_RES);
+	udelay(50);
+
+	/* PSC recover from cold reset (cfr user manual, not sure if useful) */
+	out_be32(&regs->sicr, in_be32(&regs->sicr));
+}
+
+static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
+
+	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
+	udelay(3);
+	out_be32(&regs->sicr, psc_dma->sicr);
+}
+
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= psc_ac97_read,
+	.write		= psc_ac97_write,
+	.reset		= psc_ac97_cold_reset,
+	.warm_reset	= psc_ac97_warm_reset,
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+#ifdef CONFIG_PM
+static int psc_ac97_suspend(struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+static int psc_ac97_resume(struct snd_soc_dai *dai)
+{
+	return 0;
+}
+
+#else
+#define psc_ac97_suspend	NULL
+#define psc_ac97_resume	NULL
+#endif
+
+static int psc_ac97_hw_analog_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+
+	dev_dbg(psc_dma->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
+		" periods=%i buffer_size=%i  buffer_bytes=%i channels=%i"
+		" rate=%i format=%i\n",
+		__func__, substream, params_period_size(params),
+		params_period_bytes(params), params_periods(params),
+		params_buffer_size(params), params_buffer_bytes(params),
+		params_channels(params), params_rate(params), params_format(params));
+
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		if (params_channels(params) == 1)
+			psc_dma->slots |= 0x00000100;
+		else
+			psc_dma->slots |= 0x00000300;
+	} else {
+		if (params_channels(params) == 1)
+			psc_dma->slots |= 0x01000000;
+		else
+			psc_dma->slots |= 0x03000000;
+	}
+
+	spin_lock(&psc_dma->lock);
+	out_be32(&psc_dma->psc_regs->ac97_slots, psc_dma->slots);
+	spin_unlock(&psc_dma->lock);
+
+	return 0;
+}
+
+static int psc_ac97_hw_digital_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+
+	spin_lock(&psc_dma->lock);
+	if (params_channels(params) == 1)
+		out_be32(&psc_dma->psc_regs->ac97_slots, 0x01000000);
+	else
+		out_be32(&psc_dma->psc_regs->ac97_slots, 0x03000000);
+	spin_unlock(&psc_dma->lock);
+
+	return 0;
+}
+
+static int psc_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
+								 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+			psc_dma->slots &= 0xFFFF0000;
+		else
+			psc_dma->slots &= 0x0000FFFF;
+
+		spin_lock(&psc_dma->lock);
+		out_be32(&psc_dma->psc_regs->ac97_slots, psc_dma->slots);
+		spin_unlock(&psc_dma->lock);
+		break;
+	}
+	return 0;
+}
+
+/* ---------------------------------------------------------------------
+ * ALSA SoC Bindings
+ *
+ * - Digital Audio Interface (DAI) template
+ * - create/destroy dai hooks
+ */
+
+/**
+ * psc_ac97_dai_template: template CPU Digital Audio Interface
+ */
+static struct snd_soc_dai_ops psc_ac97_analog_ops = {
+	.hw_params	= psc_ac97_hw_analog_params,
+	.trigger	= psc_ac97_trigger,
+};
+
+static struct snd_soc_dai_ops psc_ac97_digital_ops = {
+	.hw_params	= psc_ac97_hw_digital_params,
+};
+
+struct snd_soc_dai psc_ac97_dai[] = {
+{
+	.name   = "AC97",
+	.suspend = psc_ac97_suspend,
+	.resume = psc_ac97_resume,
+	.playback = {
+		.channels_min   = 1,
+		.channels_max   = 6,
+		.rates          = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_BE,
+	},
+	.capture = {
+		.channels_min   = 1,
+		.channels_max   = 2,
+		.rates          = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_BE,
+	},
+	.ops = &psc_ac97_analog_ops,
+},
+{
+	.name   = "SPDIF",
+	.playback = {
+		.channels_min   = 1,
+		.channels_max   = 2,
+		.rates          = SNDRV_PCM_RATE_32000 | \
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE,
+	},
+	.ops = &psc_ac97_digital_ops,
+}};
+EXPORT_SYMBOL_GPL(psc_ac97_dai);
+
+
+
+/* ---------------------------------------------------------------------
+ * OF platform bus binding code:
+ * - Probe/remove operations
+ * - OF device match table
+ */
+static int __devinit psc_ac97_of_probe(struct of_device *op,
+				      const struct of_device_id *match)
+{
+	int rc, i, id1, id2, timeout, max_reset;
+	struct snd_ac97 ac97;
+	struct mpc52xx_psc __iomem *regs;
+
+	rc = mpc5200_audio_dma_create(op);
+	if (rc != 0)
+		return rc;
+
+	for (i = 0; i < ARRAY_SIZE(psc_ac97_dai); i++)
+		psc_ac97_dai[i].dev = &op->dev;
+
+	rc = snd_soc_register_dais(psc_ac97_dai, ARRAY_SIZE(psc_ac97_dai));
+	if (rc != 0) {
+		pr_err("Failed to register DAI\n");
+		return 0;
+	}
+
+	psc_dma = dev_get_drvdata(&op->dev);
+	regs = psc_dma->psc_regs;
+	ac97.private_data = psc_dma;
+
+	for (i = 0; i < ARRAY_SIZE(psc_ac97_dai); i++)
+		psc_ac97_dai[i].private_data = psc_dma;
+
+	psc_dma->imr = 0;
+	out_be16(&psc_dma->psc_regs->isr_imr.imr, psc_dma->imr);
+
+	/* Configure the serial interface mode to AC97 */
+	psc_dma->sicr = MPC52xx_PSC_SICR_SIM_AC97 | MPC52xx_PSC_SICR_ENAC97;
+	out_be32(&regs->sicr, psc_dma->sicr);
+
+	/* No slots active */
+	out_be32(&regs->ac97_slots, 0x00000000);
+
+	/* AC97 clock is generated by the codec.
+	 * Ensure that it starts ticking after codec reset.
+	 */
+	max_reset = 0;
+reset:
+	if (max_reset++ > 5) {
+		dev_err(&op->dev, "AC97 codec failed to reset\n");
+		mpc5200_audio_dma_destroy(op);
+		return -ENODEV;
+	}
+
+	psc_ac97_cold_reset(&ac97);
+	psc_ac97_warm_reset(&ac97);
+
+	/* first make sure it is low */
+	timeout = 0;
+	while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0) {
+		udelay(1);
+		if (timeout++ > 1000)
+			goto reset;
+	}
+	/* then wait for the transition to high */
+	timeout = 0;
+	while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) == 0) {
+		udelay(1);
+		if (timeout++ > 1000)
+			psc_ac97_warm_reset(&ac97);
+	}
+
+	/* Go */
+	out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+
+	id1 = psc_ac97_read(&ac97, AC97_VENDOR_ID1);
+	id2 = psc_ac97_read(&ac97, AC97_VENDOR_ID2);
+
+	dev_info(&op->dev, "Codec ID is %04x %04x\n", id1, id2);
+
+	return 0;
+}
+
+static int __devexit psc_ac97_of_remove(struct of_device *op)
+{
+	return mpc5200_audio_dma_destroy(op);
+}
+
+/* Match table for of_platform binding */
+static struct of_device_id psc_ac97_match[] __devinitdata = {
+	{ .compatible = "fsl,mpc5200-psc-ac97", },
+	{ .compatible = "fsl,mpc5200b-psc-ac97", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, psc_ac97_match);
+
+static struct of_platform_driver psc_ac97_driver = {
+	.match_table = psc_ac97_match,
+	.probe = psc_ac97_of_probe,
+	.remove = __devexit_p(psc_ac97_of_remove),
+	.driver = {
+		.name = "mpc5200-psc-ac97",
+		.owner = THIS_MODULE,
+	},
+};
+
+/* ---------------------------------------------------------------------
+ * Module setup and teardown; simply register the of_platform driver
+ * for the PSC in AC97 mode.
+ */
+static int __init psc_ac97_init(void)
+{
+	return of_register_platform_driver(&psc_ac97_driver);
+}
+module_init(psc_ac97_init);
+
+static void __exit psc_ac97_exit(void)
+{
+	of_unregister_platform_driver(&psc_ac97_driver);
+}
+module_exit(psc_ac97_exit);
+
+MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
+MODULE_DESCRIPTION("mpc5200 AC97 module");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.h b/sound/soc/fsl/mpc5200_psc_ac97.h
new file mode 100644
index 0000000..4bc18c3
--- /dev/null
+++ b/sound/soc/fsl/mpc5200_psc_ac97.h
@@ -0,0 +1,15 @@
+/*
+ * Freescale MPC5200 PSC in AC97 mode
+ * ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ */
+
+#ifndef __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
+#define __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
+
+extern struct snd_soc_dai psc_ac97_dai[];
+
+#define MPC5200_AC97_NORMAL 0
+#define MPC5200_AC97_SPDIF 1
+
+#endif /* __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__ */



------------------------------

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


End of Alsa-devel Digest, Vol 27, Issue 124
*******************************************
