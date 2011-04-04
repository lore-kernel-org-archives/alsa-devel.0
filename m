From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 2/2] ALSA: ASoc: putting together AT91SAM9260 and TLV320AIC3X
Date: Mon, 04 Apr 2011 10:57:01 +0200
Message-ID: <4D9987DD.8040703@aksignal.cz>
References: <1300949648-15078-1-git-send-email-horms@verge.net.au> <1300949648-15078-2-git-send-email-horms@verge.net.au> <4D8B2068.60402@aksignal.cz> <4D8BA47B.8050904@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D8BA47B.8050904@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: alsa-devel@vger.kernel.org, alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,
this is separeted PATCH for glue AT91SAM9260 and TLV320AIC3X on CDU boa=
rd.

Depend on: [PATCH 1/2] ALSA: ASoc: TLV320AIC3X: ad SPI and clock on GPI=
O2 or BCLK
	[PATCH] ALSA: ASoc: new functions snd_soc_7_8_*
	[PATCH] ARCH arm: adding new board: CDU
Kernel version: 2.6.38
Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

Dne 24.3.2011 21:07, Ryan Mallon napsal(a):
> On 03/24/2011 11:43 PM, Prchal Ji=C5=99=C3=AD wrote:
>> Hi,
>> this patch is for example how to put together AT91SAM9260 and TLV320=
AIC3106 controlled via SPI.
>> It tooks me a lot of time to make it working, so I think it could be=
 helpfull for other people.
>>
>> In original source "snd-soc-afeb9260.c" which I use as example is BI=
G ERROR:
>> In function "afeb9260_soc_init" is missing call of "atmel_ssc_set_au=
dio(0);". It cause bug "PROBLEM: Asoc driver in
>> 2.6.37.3 for AT91SAM9260 / TLV320AIC3X is broken" which I post some =
time ago.
>=20
> Hi Jiri,
>=20
> This patch is actually doing two things: adding board support for a n=
ew
> at91sam9260 device and adding the audio glue for the new board. It
> should be split into two patches. Quick review below.
>=20
> ~Ryan
>=20
I separate it.

>>
>> Depend on: [PATCH 1/2] ALSA: ASoc: TLV320AIC3X: ad SPI and clock on =
GPIO2 or BCLK
>> Kernel version: 2.6.38
>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> ---
>>
>> diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.=
38-vanilla/sound/soc/atmel/Kconfig
>> /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/Kconfig
>> --- linux-2.6.38-vanilla/sound/soc/atmel/Kconfig	2011-03-15 02:20:32=
=2E000000000 +0100
>> +++ /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/Kconf=
ig	2011-03-22 09:46:46.751566158 +0100
>> @@ -50,3 +50,11 @@ config SND_AT91_SOC_AFEB9260
>>  	select SND_SOC_TLV320AIC23
>>  	help
>>  	  Say Y here to support sound on AFEB9260 board.
>> +
>> +config SND_AT91_SOC_CDU
>> +	tristate "SoC Audio support for CDU board"
>> +	depends on ARCH_AT91 && MACH_CDU && SND_ATMEL_SOC
>> +	select SND_ATMEL_SOC_SSC
>> +	select SND_SOC_TLV320AIC3X
>> +	help
>> +	  Say Y here to support sound on CDU board.
>> diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.=
38-vanilla/sound/soc/atmel/Makefile
>> /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/Makefile
>> --- linux-2.6.38-vanilla/sound/soc/atmel/Makefile	2011-03-15 02:20:3=
2.000000000 +0100
>> +++ /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/Makef=
ile	2011-03-16 09:26:17.000000000 +0100
>> @@ -14,3 +14,4 @@ snd-soc-playpaq-objs :=3D playpaq_wm8510.o
>>  obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) +=3D snd-soc-sam9g20-wm87=
31.o
>>  obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) +=3D snd-soc-playpaq.o
>>  obj-$(CONFIG_SND_AT91_SOC_AFEB9260) +=3D snd-soc-afeb9260.o
>> +obj-$(CONFIG_SND_AT91_SOC_CDU) +=3D snd-soc-cdu.o
>> diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.=
38-vanilla/sound/soc/atmel/snd-soc-cdu.c
>> /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/snd-soc-c=
du.c
>> --- linux-2.6.38-vanilla/sound/soc/atmel/snd-soc-cdu.c	1970-01-01 01=
:00:00.000000000 +0100
>> +++ /home/prchal/arm/fw-cdu/linux/linux-2.6.38/sound/soc/atmel/snd-s=
oc-cdu.c	2011-03-24 09:27:55.404367652 +0100
>> @@ -0,0 +1,264 @@
>> +/*
>> + * snd-soc-cdu  --  SoC audio for AT91SAM9260-based
>> + * 			AKsignal CDU board.
>> + *
>> + *  Copyright (C) 2005 SAN People
>> + *  Copyright (C) 2008 Atmel
>> + *  Copyright (C) 2011 AK signal Brno
>> + *
>> + * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
>> + *          Jiri Prchal <jiri.prchal@aksignal.cz>
>> + *
>> + * Based on ati_b1_wm8731.c by:
>> + * Frank Mandarino <fmandarino@endrelia.com>
>> + * Copyright 2006 Endrelia Technologies Inc.
>> + * Based on corgi.c by:
>> + * Copyright 2005 Wolfson Microelectronics PLC.
>> + * Copyright 2005 Openedhand Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=
1307  USA
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/kernel.h>
>> +#include <linux/clk.h>
>> +#include <linux/timer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +
>> +#include <linux/atmel-ssc.h>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <mach/hardware.h>
>> +#include <mach/gpio.h>
>=20
> Note sure you need all of these includes. linux/interrupt.h,
> linux/moduleparam.h, linux/timer.h and mach/gpio.h at least appear to=
 be
> uneccessary.
Cleaned up.

>=20
>> +
>> +#include "../codecs/tlv320aic3x.h"
>> +#include "atmel-pcm.h"
>> +#include "atmel_ssc_dai.h"
>> +
>> +struct {
>> +	unsigned int channels;
>> +	snd_pcm_format_t format;
>> +	unsigned int rate;
>> +	unsigned int codecclk;
>> +	unsigned int cmrdiv;
>> +	unsigned int period;
>> +} cdu_audio[] =3D {
>> +	/* 16 bit stereo modes */
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 8000, 2096000, 25, 130,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 16000, 2496000, 21, 77,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 32000, 2496000, 21, 38,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 48000, 2016000, 26, 20,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 96000, 4032000, 13, 20,},
>> +
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 11025, 2381400, 22, 107,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 22050, 2381400, 22, 53,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 44100, 2381400, 22, 26,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 88200, 4762800, 11, 26,},
>> +
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 11520, 2626560, 20, 113,},
>> +	{2, SNDRV_PCM_FORMAT_S16_LE, 23040, 2626560, 20, 56,},
>=20
> Can these be calculated rather than using a table? The first two valu=
es
> probably don't need to be in the table since they are always the same=
=2E
Explained in new comment why it is table. I made the table smaller.

>=20
>> +
>> +};
>> +
>> +static int cdu_hw_params(struct snd_pcm_substream *substream, struc=
t snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
>> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>> +	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>> +	int ret;
>> +	int i, found =3D 0;
>> +	snd_pcm_format_t format =3D params_format(params);
>> +	unsigned int rate =3D params_rate(params);
>> +	unsigned int channels =3D params_channels(params);
>> +
>> +	/* set codec DAI configuration */
>> +	ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SO=
C_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>=20
> Long lines should be broken to fit inside 80 characters.
OK.

>=20
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* set cpu DAI configuration */
>> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | SND_SOC_=
DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* find the correct audio parameters */
>> +	for (i =3D 0; i < ARRAY_SIZE(cdu_audio); i++) {
>> +		if (rate =3D=3D cdu_audio[i].rate &&
>> +		    format =3D=3D cdu_audio[i].format &&
>> +		    channels =3D=3D cdu_audio[i].channels) {
>> +			found =3D 1;
>> +			break;
>> +		}
>> +	}
>> +	if (!found)
>> +		return -EINVAL;
>=20
> Should maybe do this before doing the dai_set_fmt's since we only
> support some modes. Also:
>=20
> 	/* Only support 2 channel S16_LE */
> 	if (channels !=3D 2 || format !=3D SNDRV_PCM_FORMAT_S16_LE)
> 		return -EINVAL;
>=20
> 	/* Check rate support */
> 	for (i =3D 0; i < ARRAY_SIZE(cdc_audio); i++)
> 		if (rate =3D=3D cdc_audio[i].rate) {
> 			found =3D 1;
> 			break;
> 		}
> 	if (!found)
> 		return -EINVAL;
>=20
OK.

>> +
>> +	/* Set the codec system clock for DAC and ADC */
>> +	ret =3D snd_soc_dai_set_sysclk(codec_dai, CLKIN_BCLK, cdu_audio[i]=
=2Ecodecclk, SND_SOC_CLOCK_IN);
>> +	if (ret < 0) {
>> +		printk(KERN_ERR "can't set codec system clock\n");
>=20
> You should, I think, be able to do:
>=20
> 	struct device *dev =3D rtd->card->dev;
>=20
> 	dev_err(dev, "can't set codec system clock\n");
>=20
> Same goes for other printks.
>=20
OK.

>> +		return ret;
>> +	}
>> +
>> +	/* Set the cpu clock dividers to BCLK */
>> +	ret =3D snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cdu_aud=
io[i].cmrdiv);
>> +	ret |=3D snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_TCMR_PERIOD, cd=
u_audio[i].period);
>> +	ret |=3D snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_RCMR_PERIOD, cd=
u_audio[i].period);
>> +	if (ret < 0) {
>> +		printk(KERN_ERR "can't set cpu system clock\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct snd_soc_ops cdu_ops =3D {
>> +	.hw_params =3D cdu_hw_params,
>> +};
>> +
>> +static const struct snd_soc_dapm_widget cdu_dapm_widgets[] =3D {
>> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>> +	SND_SOC_DAPM_LINE("Line Out", NULL),
>> +	SND_SOC_DAPM_MIC("Mic Jack", NULL),
>> +	SND_SOC_DAPM_LINE("Line In", NULL),
>> +};
>> +
>> +static const struct snd_soc_dapm_route intercon[] =3D {
>> +	/* Headphone connected to HPLOUT, HPROUT */
>> +	{"Headphone Jack", NULL, "HPLOUT"},
>> +	{"Headphone Jack", NULL, "HPROUT"},
>> +
>> +	/* Line Out connected to LLOUT, RLOUT */
>> +	{"Line Out", NULL, "LLOUT"},
>> +	{"Line Out", NULL, "RLOUT"},
>> +
>> +	/* Mic connected to (MIC3L | MIC3R) */
>> +	{"MIC3L", NULL, "Mic Bias 2V"},
>> +	{"MIC3R", NULL, "Mic Bias 2V"},
>> +	{"Mic Bias 2V", NULL, "Mic Jack"},
>> +
>> +	/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
>> +	{"LINE1L", NULL, "Line In"},
>> +	{"LINE2L", NULL, "Line In"},
>> +	{"LINE1R", NULL, "Line In"},
>> +	{"LINE2R", NULL, "Line In"},
>> +};
>> +
>> +/*
>> + * Logic for a aic3x as connected on a cdu board.
>> + */
>> +static int cdu_aic3x_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +	struct snd_soc_codec *codec =3D rtd->codec;
>> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>> +	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>> +	int ret;
>> +
>> +	printk(KERN_DEBUG "cdu_aic3x: cdu_aic3x_init called\n");
>=20
> Is this line really needed?
>=20
NO, removed.

>> +
>> +	/* Add specific widgets */
>> +	snd_soc_dapm_new_controls(dapm, cdu_dapm_widgets,
>> +				  ARRAY_SIZE(cdu_dapm_widgets));
>> +	/* Set up specific audio path interconnects */
>> +	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
>> +
>> +	/* always connected */
>> +	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
>> +	snd_soc_dapm_enable_pin(dapm, "Line Out");
>> +	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
>> +	snd_soc_dapm_enable_pin(dapm, "Line In");
>> +
>> +	snd_soc_dapm_sync(dapm);
>=20
> IIRC, you no longer need to explicitly call snd_soc_dapm_enable_pin a=
nd
> snd_soc_dapm_sync. Somebody else can probably shed more light on this=
=2E
>=20
Removed.

>> +
>> +	return 0;
>> +}
>> +
>> +static struct snd_soc_dai_link cdu_dai =3D {
>> +	.name		=3D "TLV320AIC3106",
>> +	.stream_name	=3D "PCM",
>> +	.cpu_dai_name	=3D "atmel-ssc-dai.0",
>> +	.codec_dai_name	=3D "tlv320aic3x-hifi",
>> +	.init =3D cdu_aic3x_init,
>=20
> Tab-delimiting got messed here.
>=20
OK.

>> +	.platform_name	=3D "atmel-pcm-audio",
>> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>> +	.codec_name	=3D "tlv320aic3x-codec.0-001b",
>> +#endif
>> +#if defined(CONFIG_SPI_MASTER)
>> +	.codec_name	=3D "spi1.3",
>> +#endif
>=20
> If both CONFIG_I2C and CONFIG_SPI_MASTER are set then you will have a
> broken build. Which one does the CDU board use?
>=20
Since CDU use only SPI the I2C option removed.

>> +	.ops		=3D &cdu_ops,
>> +};
>> +
>> +static struct snd_soc_card snd_soc_cdu =3D {
>> +	.name		=3D "TLV320AIC3106",
>> +	.dai_link	=3D &cdu_dai,
>> +	.num_links	=3D 1,
>> +};
>> +
>> +static struct platform_device *cdu_snd_device;
>> +
>> +static int __init cdu_init(void)
>> +{
>> +	struct clk *pllb;
>=20
> Remove this line, pllb is never used in this function.
>=20
OK.

>> +	int ret;
>> +
>> +	ret =3D atmel_ssc_set_audio(0);
>> +	if (ret !=3D 0) {
>=20
> Nitpick. Just if (ret) is fine.
>=20
OK.

>> +		pr_err("Failed to set SSC 0 for audio: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	cdu_snd_device =3D platform_device_alloc("soc-audio", -1);
>> +	if (!cdu_snd_device) {
>> +		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
>> +		ret =3D -ENOMEM;
>> +	}
>> +
>> +	platform_set_drvdata(cdu_snd_device, &snd_soc_cdu);
>> +
>> +	ret =3D platform_device_add(cdu_snd_device);
>> +	if (ret) {
>> +		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
>=20
> Use pr_err to be consistent.
>=20
OK.

>> +		goto err_device_add;
>> +	}
>> +
>> +	return ret;
>> +
>> +err_device_add:
>> +	platform_device_put(cdu_snd_device);
>> +err:
>> +	return ret;
>> +}
>> +
>> +static void __exit cdu_exit(void)
>> +{
>> +	platform_device_unregister(cdu_snd_device);
>> +	cdu_snd_device =3D NULL;
>=20
> I don't think you need to set cdu_snd_device to NULL here.
>=20
OK.

>> +}
>> +
>> +module_init(cdu_init);
>> +module_exit(cdu_exit);
>> +
>> +/* Module information */
>> +MODULE_AUTHOR("Jiri Prchal <jiri.prchal@aksignal.cz>");
>> +MODULE_DESCRIPTION("ALSA SoC CDU_AIC3X");
>> +MODULE_LICENSE("GPL");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.38-=
vanilla/sound/soc/atmel/Kconfig
linux-2.6.38-patch/sound/soc/atmel/Kconfig
--- linux-2.6.38-vanilla/sound/soc/atmel/Kconfig	2011-03-15 02:20:32.00=
0000000 +0100
+++ linux-2.6.38-patch/sound/soc/atmel/Kconfig	2011-03-22 09:46:46.7515=
66158 +0100
@@ -50,3 +50,11 @@ config SND_AT91_SOC_AFEB9260
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y here to support sound on AFEB9260 board.
+
+config SND_AT91_SOC_CDU
+	tristate "SoC Audio support for CDU board"
+	depends on ARCH_AT91 && MACH_CDU && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_TLV320AIC3X
+	help
+	  Say Y here to support sound on CDU board.
diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.38-=
vanilla/sound/soc/atmel/Makefile
linux-2.6.38-patch/sound/soc/atmel/Makefile
--- linux-2.6.38-vanilla/sound/soc/atmel/Makefile	2011-03-15 02:20:32.0=
00000000 +0100
+++ linux-2.6.38-patch/sound/soc/atmel/Makefile	2011-03-16 09:26:17.000=
000000 +0100
@@ -14,3 +14,4 @@ snd-soc-playpaq-objs :=3D playpaq_wm8510.o
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) +=3D snd-soc-sam9g20-wm8731.=
o
 obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) +=3D snd-soc-playpaq.o
 obj-$(CONFIG_SND_AT91_SOC_AFEB9260) +=3D snd-soc-afeb9260.o
+obj-$(CONFIG_SND_AT91_SOC_CDU) +=3D snd-soc-cdu.o
diff -uprN -X linux-2.6.38-vanilla/Documentation/dontdiff linux-2.6.38-=
vanilla/sound/soc/atmel/snd-soc-cdu.c
linux-2.6.38-patch/sound/soc/atmel/snd-soc-cdu.c
--- linux-2.6.38-vanilla/sound/soc/atmel/snd-soc-cdu.c	1970-01-01 01:00=
:00.000000000 +0100
+++ linux-2.6.38-patch/sound/soc/atmel/snd-soc-cdu.c	2011-03-25 13:42:0=
7.545051043 +0100
@@ -0,0 +1,259 @@
+/*
+ * snd-soc-cdu  --  SoC audio for AT91SAM9260-based
+ * 			AKsignal CDU board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *  Copyright (C) 2011 AK signal Brno
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *          Jiri Prchal <jiri.prchal@aksignal.cz>
+ *
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7  USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#include "../codecs/tlv320aic3x.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+/*
+ * Table of supported rates
+ * with their clock divider (cmrdiv) and number clock in frame (period=
 + 1 * 2),
+ * codecclk sould be integer multiple of sample rate even if it is not=
 exact true
+ * to avoid data on SSC underrun / overrun -
+ * CPU can not generate clock as fine as CODEC.
+ */
+struct {
+	unsigned int rate;
+	unsigned int codecclk;
+	unsigned int cmrdiv;
+	unsigned int period;
+} cdu_audio[] =3D {
+	{8000, 2096000, 25, 130,},
+	{16000, 2496000, 21, 77,},
+	{32000, 2496000, 21, 38,},
+	{48000, 2016000, 26, 20,},
+	{96000, 4032000, 13, 20,},
+
+	{11025, 2381400, 22, 107,},
+	{22050, 2381400, 22, 53,},
+	{44100, 2381400, 22, 26,},
+	{88200, 4762800, 11, 26,},
+
+	/* special rates for serial line transfer */
+	{11520, 2626560, 20, 113,},
+	{23040, 2626560, 20, 56,},
+	{46080, 2764800, 19, 29,},
+};
+
+static int cdu_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
+	struct device *dev =3D rtd->card->dev;
+	int ret;
+	int i, found =3D 0;
+
+	/* set codec DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* Only support 1 or 2 channel S16_LE */
+	if ((params_channels(params) !=3D 1 && params_channels(params) !=3D 2=
) ||
+	   params_format(params) !=3D SNDRV_PCM_FORMAT_S16_LE)
+		return -EINVAL;
+
+	/* Check rate support */
+	for (i =3D 0; i < ARRAY_SIZE(cdu_audio); i++)
+		if (params_rate(params) =3D=3D cdu_audio[i].rate) {
+			found =3D 1;
+			break;
+		}
+	if (!found)
+		return -EINVAL;
+
+	/* Set the codec system clock for DAC and ADC */
+	ret =3D snd_soc_dai_set_sysclk(codec_dai,
+				     CLKIN_BCLK, cdu_audio[i].codecclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(dev, "can't set codec system clock\n");
+		return ret;
+	}
+
+	/* Set the cpu clock dividers to BCLK */
+	ret =3D snd_soc_dai_set_clkdiv(cpu_dai,
+				     ATMEL_SSC_CMR_DIV, cdu_audio[i].cmrdiv);
+	ret |=3D snd_soc_dai_set_clkdiv(cpu_dai,
+				      ATMEL_SSC_TCMR_PERIOD,
+				      cdu_audio[i].period);
+	ret |=3D snd_soc_dai_set_clkdiv(cpu_dai,
+				      ATMEL_SSC_RCMR_PERIOD,
+				      cdu_audio[i].period);
+	if (ret < 0) {
+		dev_err(dev, "can't set cpu system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops cdu_ops =3D {
+	.hw_params =3D cdu_hw_params,
+};
+
+static const struct snd_soc_dapm_widget cdu_dapm_widgets[] =3D {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] =3D {
+	/* Headphone connected to HPLOUT, HPROUT */
+	{"Headphone Jack", NULL, "HPLOUT"},
+	{"Headphone Jack", NULL, "HPROUT"},
+
+	/* Line Out connected to LLOUT, RLOUT */
+	{"Line Out", NULL, "LLOUT"},
+	{"Line Out", NULL, "RLOUT"},
+
+	/* Mic connected to (MIC3L | MIC3R) */
+	{"MIC3L", NULL, "Mic Bias 2V"},
+	{"MIC3R", NULL, "Mic Bias 2V"},
+	{"Mic Bias 2V", NULL, "Mic Jack"},
+
+	/* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
+	{"LINE1L", NULL, "Line In"},
+	{"LINE2L", NULL, "Line In"},
+	{"LINE1R", NULL, "Line In"},
+	{"LINE2R", NULL, "Line In"},
+};
+
+/*
+ * Logic for a aic3x as connected on a cdu board.
+ */
+static int cdu_aic3x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec =3D rtd->codec;
+	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
+	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
+	int ret;
+
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(dapm, cdu_dapm_widgets,
+				  ARRAY_SIZE(cdu_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
+
+	return 0;
+}
+
+static struct snd_soc_dai_link cdu_dai =3D {
+	.name		=3D "TLV320AIC3106",
+	.stream_name	=3D "PCM",
+	.cpu_dai_name	=3D "atmel-ssc-dai.0",
+	.codec_dai_name	=3D "tlv320aic3x-hifi",
+	.init		=3D cdu_aic3x_init,
+	.platform_name	=3D "atmel-pcm-audio",
+	.codec_name	=3D "spi1.3",
+	.ops		=3D &cdu_ops,
+};
+
+static struct snd_soc_card snd_soc_cdu =3D {
+	.name		=3D "TLV320AIC3106",
+	.dai_link	=3D &cdu_dai,
+	.num_links	=3D 1,
+};
+
+static struct platform_device *cdu_snd_device;
+
+static int __init cdu_init(void)
+{
+	int ret;
+
+	ret =3D atmel_ssc_set_audio(0);
+	if (ret) {
+		pr_err("Failed to set SSC 0 for audio: %d\n", ret);
+		return ret;
+	}
+
+	cdu_snd_device =3D platform_device_alloc("soc-audio", -1);
+	if (!cdu_snd_device) {
+		pr_err("ASoC: Platform device allocation failed: %d\n", ret);
+		ret =3D -ENOMEM;
+	}
+
+	platform_set_drvdata(cdu_snd_device, &snd_soc_cdu);
+
+	ret =3D platform_device_add(cdu_snd_device);
+	if (ret) {
+		pr_err("ASoC: Platform device adding failed: %d\n", ret);
+		goto err_device_add;
+	}
+
+	return ret;
+
+err_device_add:
+	platform_device_put(cdu_snd_device);
+err:
+	return ret;
+}
+
+static void __exit cdu_exit(void)
+{
+	platform_device_unregister(cdu_snd_device);
+}
+
+module_init(cdu_init);
+module_exit(cdu_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jiri Prchal <jiri.prchal@aksignal.cz>");
+MODULE_DESCRIPTION("ALSA SoC CDU_AIC3X");
+MODULE_LICENSE("GPL");
