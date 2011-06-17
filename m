From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: add STA32X codec driver
Date: Fri, 17 Jun 2011 10:30:14 +0200
Message-ID: <BANLkTin5icz9a2+eQs1GWrFiyR5KVm+9Gw@mail.gmail.com>
References: <BANLkTinVAPv4gyAg3OOP=6oZ+bNEeAojDA@mail.gmail.com>
	<1308226043-18584-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id D73B92446D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 10:30:15 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1736724pzk.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 01:30:14 -0700 (PDT)
In-Reply-To: <1308226043-18584-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Is that version good to go in or is there anything left you want me correct?


Thanks,
Daniel


On Thu, Jun 16, 2011 at 2:07 PM, Daniel Mack <zonque@gmail.com> wrote:
> From: Johannes Stezenbach <js@sig21.net>
>
> Signed-off-by: Johannes Stezenbach <js@sig21.net>
> [zonque@gmail.com: transform to new ASoC structure]
> ---
> =A0sound/soc/codecs/Kconfig =A0| =A0 =A04 +
> =A0sound/soc/codecs/Makefile | =A0 =A02 +
> =A0sound/soc/codecs/sta32x.c | =A0778 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A0sound/soc/codecs/sta32x.h | =A0210 ++++++++++++
> =A04 files changed, 994 insertions(+), 0 deletions(-)
> =A0create mode 100644 sound/soc/codecs/sta32x.c
> =A0create mode 100644 sound/soc/codecs/sta32x.h
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 98175a0..dd075f2 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -42,6 +42,7 @@ config SND_SOC_ALL_CODECS
> =A0 =A0 =A0 =A0select SND_SOC_SN95031 if INTEL_SCU_IPC
> =A0 =A0 =A0 =A0select SND_SOC_SPDIF
> =A0 =A0 =A0 =A0select SND_SOC_SSM2602 if SND_SOC_I2C_AND_SPI
> + =A0 =A0 =A0 select SND_SOC_STA32X if I2C
> =A0 =A0 =A0 =A0select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
> =A0 =A0 =A0 =A0select SND_SOC_TLV320AIC23 if I2C
> =A0 =A0 =A0 =A0select SND_SOC_TLV320AIC26 if SPI_MASTER
> @@ -216,6 +217,9 @@ config SND_SOC_SPDIF
> =A0config SND_SOC_SSM2602
> =A0 =A0 =A0 =A0tristate
>
> +config SND_SOC_STA32X
> + =A0 =A0 =A0 tristate
> +
> =A0config SND_SOC_STAC9766
> =A0 =A0 =A0 =A0tristate
>
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index fd85584..2ad1310 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -28,6 +28,7 @@ snd-soc-alc5623-objs :=3D alc5623.o
> =A0snd-soc-sn95031-objs :=3D sn95031.o
> =A0snd-soc-spdif-objs :=3D spdif_transciever.o
> =A0snd-soc-ssm2602-objs :=3D ssm2602.o
> +snd-soc-sta32x-objs :=3D sta32x.o
> =A0snd-soc-stac9766-objs :=3D stac9766.o
> =A0snd-soc-tlv320aic23-objs :=3D tlv320aic23.o
> =A0snd-soc-tlv320aic26-objs :=3D tlv320aic26.o
> @@ -120,6 +121,7 @@ obj-$(CONFIG_SND_SOC_SGTL5000) =A0+=3D snd-soc-sgtl50=
00.o
> =A0obj-$(CONFIG_SND_SOC_SN95031) =A0+=3Dsnd-soc-sn95031.o
> =A0obj-$(CONFIG_SND_SOC_SPDIF) =A0 =A0+=3D snd-soc-spdif.o
> =A0obj-$(CONFIG_SND_SOC_SSM2602) =A0+=3D snd-soc-ssm2602.o
> +obj-$(CONFIG_SND_SOC_STA32X) =A0 +=3D snd-soc-sta32x.o
> =A0obj-$(CONFIG_SND_SOC_STAC9766) +=3D snd-soc-stac9766.o
> =A0obj-$(CONFIG_SND_SOC_TLV320AIC23) =A0 =A0 =A0+=3D snd-soc-tlv320aic23.o
> =A0obj-$(CONFIG_SND_SOC_TLV320AIC26) =A0 =A0 =A0+=3D snd-soc-tlv320aic26.o
> diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
> new file mode 100644
> index 0000000..0fe38975
> --- /dev/null
> +++ b/sound/soc/codecs/sta32x.c
> @@ -0,0 +1,778 @@
> +/*
> + * Codec driver for ST STA32x 2.1-channel high-efficiency digital audio =
system
> + *
> + * Copyright: 2011 Raumfeld GmbH
> + * Author: Johannes Stezenbach <js@sig21.net>
> + *
> + * based on code from:
> + * =A0 =A0 Wolfson Microelectronics PLC.
> + * =A0 =A0 =A0 Mark Brown <broonie@opensource.wolfsonmicro.com>
> + * =A0 =A0 Freescale Semiconductor, Inc.
> + * =A0 =A0 =A0 Timur Tabi <timur@freescale.com>
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + */
> +
> +#define DEBUG
> +#define pr_fmt(fmt) KBUILD_MODNAME ":%s:%d: " fmt, __func__, __LINE__
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +
> +#include "sta32x.h"
> +
> +#define STA32X_RATES (SNDRV_PCM_RATE_32000 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_44100 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_48000 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_88200 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_96000 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_176400 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_192000)
> +
> +#define STA32X_FORMATS \
> + =A0 =A0 =A0 (SNDRV_PCM_FMTBIT_S16_LE =A0| SNDRV_PCM_FMTBIT_S16_BE =A0| \
> + =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
> + =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
> + =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
> + =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S24_LE =A0| SNDRV_PCM_FMTBIT_S24_BE =A0=
| \
> + =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S32_LE =A0| SNDRV_PCM_FMTBIT_S32_BE)
> +
> +/* Power-up register defaults */
> +static const u8 sta32x_regs[STA32X_REGISTER_COUNT] =3D {
> + =A0 =A0 =A0 0x63, 0x80, 0xc2, 0x40, 0xc2, 0x5c, 0x10, 0xff, 0x60, 0x60,
> + =A0 =A0 =A0 0x60, 0x80, 0x00, 0x00, 0x00, 0x40, 0x80, 0x77, 0x6a, 0x69,
> + =A0 =A0 =A0 0x6a, 0x69, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> + =A0 =A0 =A0 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2d,
> + =A0 =A0 =A0 0xc0, 0xf3, 0x33, 0x00, 0x0c,
> +};
> +
> +/* regulator power supply names */
> +static const char *sta32x_supply_names[] =3D {
> + =A0 =A0 =A0 "Vdda", /* analog supply, 3.3VV */
> + =A0 =A0 =A0 "Vdd3", /* digital supply, 3.3V */
> + =A0 =A0 =A0 "Vcc" =A0 /* power amp spply, 10V - 36V */
> +};
> +
> +/* codec private data */
> +struct sta32x_priv {
> + =A0 =A0 =A0 struct regulator_bulk_data supplies[ARRAY_SIZE(sta32x_suppl=
y_names)];
> + =A0 =A0 =A0 struct snd_soc_codec *codec;
> +
> + =A0 =A0 =A0 unsigned int mclk;
> + =A0 =A0 =A0 unsigned int format;
> +};
> +
> +static const DECLARE_TLV_DB_SCALE(mvol_tlv, -12700, 50, 1);
> +static const DECLARE_TLV_DB_SCALE(chvol_tlv, -7950, 50, 1);
> +static const DECLARE_TLV_DB_SCALE(tone_tlv, -120, 200, 0);
> +
> +static const char *sta32x_drc_ac[] =3D {
> + =A0 =A0 =A0 "Anti-Clipping", "Dynamic Range Compression" };
> +static const char *sta32x_auto_eq_mode[] =3D {
> + =A0 =A0 =A0 "User", "Preset", "Loudness" };
> +static const char *sta32x_auto_gc_mode[] =3D {
> + =A0 =A0 =A0 "User", "AC no clipping", "AC limited clipping (10%)",
> + =A0 =A0 =A0 "DRC nighttime listening mode" };
> +static const char *sta32x_auto_xo_mode[] =3D {
> + =A0 =A0 =A0 "User", "80Hz", "100Hz", "120Hz", "140Hz", "160Hz", "180Hz"=
, "200Hz",
> + =A0 =A0 =A0 "220Hz", "240Hz", "260Hz", "280Hz", "300Hz", "320Hz", "340H=
z", "360Hz" };
> +static const char *sta32x_preset_eq_mode[] =3D {
> + =A0 =A0 =A0 "Flat", "Rock", "Soft Rock", "Jazz", "Classical", "Dance", =
"Pop", "Soft",
> + =A0 =A0 =A0 "Hard", "Party", "Vocal", "Hip-Hop", "Dialog", "Bass-boost =
#1",
> + =A0 =A0 =A0 "Bass-boost #2", "Bass-boost #3", "Loudness 1", "Loudness 2=
",
> + =A0 =A0 =A0 "Loudness 3", "Loudness 4", "Loudness 5", "Loudness 6", "Lo=
udness 7",
> + =A0 =A0 =A0 "Loudness 8", "Loudness 9", "Loudness 10", "Loudness 11", "=
Loudness 12",
> + =A0 =A0 =A0 "Loudness 13", "Loudness 14", "Loudness 15", "Loudness 16" =
};
> +static const char *sta32x_limiter_select[] =3D {
> + =A0 =A0 =A0 "Limiter Disabled", "Limiter #1", "Limiter #2" };
> +static const char *sta32x_limiter_attack_rate[] =3D {
> + =A0 =A0 =A0 "3.1584", "2.7072", "2.2560", "1.8048", "1.3536", "0.9024",
> + =A0 =A0 =A0 "0.4512", "0.2256", "0.1504", "0.1123", "0.0902", "0.0752",
> + =A0 =A0 =A0 "0.0645", "0.0564", "0.0501", "0.0451" };
> +static const char *sta32x_limiter_release_rate[] =3D {
> + =A0 =A0 =A0 "0.5116", "0.1370", "0.0744", "0.0499", "0.0360", "0.0299",
> + =A0 =A0 =A0 "0.0264", "0.0208", "0.0198", "0.0172", "0.0147", "0.0137",
> + =A0 =A0 =A0 "0.0134", "0.0117", "0.0110", "0.0104" };
> +
> +static const unsigned int sta32x_limiter_ac_attack_tlv[] =3D {
> + =A0 =A0 =A0 TLV_DB_RANGE_HEAD(2),
> + =A0 =A0 =A0 0, 7, TLV_DB_SCALE_ITEM(-1200, 200, 0),
> + =A0 =A0 =A0 8, 16, TLV_DB_SCALE_ITEM(300, 100, 0),
> +};
> +
> +static const unsigned int sta32x_limiter_ac_release_tlv[] =3D {
> + =A0 =A0 =A0 TLV_DB_RANGE_HEAD(5),
> + =A0 =A0 =A0 0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
> + =A0 =A0 =A0 1, 1, TLV_DB_SCALE_ITEM(-2900, 0, 0),
> + =A0 =A0 =A0 2, 2, TLV_DB_SCALE_ITEM(-2000, 0, 0),
> + =A0 =A0 =A0 3, 8, TLV_DB_SCALE_ITEM(-1400, 200, 0),
> + =A0 =A0 =A0 8, 16, TLV_DB_SCALE_ITEM(-700, 100, 0),
> +};
> +
> +static const unsigned int sta32x_limiter_drc_attack_tlv[] =3D {
> + =A0 =A0 =A0 TLV_DB_RANGE_HEAD(3),
> + =A0 =A0 =A0 0, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
> + =A0 =A0 =A0 8, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
> + =A0 =A0 =A0 14, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
> +};
> +
> +static const unsigned int sta32x_limiter_drc_release_tlv[] =3D {
> + =A0 =A0 =A0 TLV_DB_RANGE_HEAD(5),
> + =A0 =A0 =A0 0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
> + =A0 =A0 =A0 1, 2, TLV_DB_SCALE_ITEM(-3800, 200, 0),
> + =A0 =A0 =A0 3, 4, TLV_DB_SCALE_ITEM(-3300, 200, 0),
> + =A0 =A0 =A0 5, 12, TLV_DB_SCALE_ITEM(-3000, 200, 0),
> + =A0 =A0 =A0 13, 16, TLV_DB_SCALE_ITEM(-1500, 300, 0),
> +};
> +
> +static const struct soc_enum sta32x_drc_ac_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_CONFD, STA32X_CONFD_DRC_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2, sta32x_drc_ac);
> +static const struct soc_enum sta32x_auto_eq_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_AUTO1, STA32X_AUTO1_AMEQ_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, sta32x_auto_eq_mode);
> +static const struct soc_enum sta32x_auto_gc_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_AUTO1, STA32X_AUTO1_AMGC_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4, sta32x_auto_gc_mode);
> +static const struct soc_enum sta32x_auto_xo_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_AUTO2, STA32X_AUTO2_XO_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16, sta32x_auto_xo_mode);
> +static const struct soc_enum sta32x_preset_eq_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_AUTO3, STA32X_AUTO3_PEQ_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32, sta32x_preset_eq_mode);
> +static const struct soc_enum sta32x_limiter_ch1_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_C1CFG, STA32X_CxCFG_LS_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, sta32x_limiter_select);
> +static const struct soc_enum sta32x_limiter_ch2_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_C2CFG, STA32X_CxCFG_LS_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, sta32x_limiter_select);
> +static const struct soc_enum sta32x_limiter_ch3_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_C3CFG, STA32X_CxCFG_LS_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, sta32x_limiter_select);
> +static const struct soc_enum sta32x_limiter1_attack_rate_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_L1AR, STA32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16, sta32x_limiter_attack_r=
ate);
> +static const struct soc_enum sta32x_limiter2_attack_rate_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_L2AR, STA32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16, sta32x_limiter_attack_r=
ate);
> +static const struct soc_enum sta32x_limiter1_release_rate_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_L1AR, STA32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16, sta32x_limiter_release_=
rate);
> +static const struct soc_enum sta32x_limiter2_release_rate_enum =3D
> + =A0 =A0 =A0 SOC_ENUM_SINGLE(STA32X_L2AR, STA32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16, sta32x_limiter_release_=
rate);
> +static const struct snd_kcontrol_new sta32x_snd_controls[] =3D {
> +SOC_SINGLE_TLV("Master Volume", STA32X_MVOL, 0, 0xff, 1, mvol_tlv),
> +SOC_SINGLE("Master Playback Switch", STA32X_MMUTE, 0, 1, 1),
> +SOC_SINGLE("Ch1 Playback Switch", STA32X_MMUTE, 1, 1, 1),
> +SOC_SINGLE("Ch2 Playback Switch", STA32X_MMUTE, 2, 1, 1),
> +SOC_SINGLE("Ch3 Playback Switch", STA32X_MMUTE, 3, 1, 1),
> +SOC_SINGLE_TLV("Ch1 Volume", STA32X_C1VOL, 0, 0xff, 1, chvol_tlv),
> +SOC_SINGLE_TLV("Ch2 Volume", STA32X_C2VOL, 0, 0xff, 1, chvol_tlv),
> +SOC_SINGLE_TLV("Ch3 Volume", STA32X_C3VOL, 0, 0xff, 1, chvol_tlv),
> +SOC_SINGLE("De-emphasis Filter Switch", STA32X_CONFD, STA32X_CONFD_DEMP_=
SHIFT, 1, 0),
> +SOC_ENUM("Compressor/Limiter Switch", sta32x_drc_ac_enum),
> +SOC_SINGLE("Miami Mode Switch", STA32X_CONFD, STA32X_CONFD_MME_SHIFT, 1,=
 0),
> +SOC_SINGLE("Zero Cross Switch", STA32X_CONFE, STA32X_CONFE_ZCE_SHIFT, 1,=
 0),
> +SOC_SINGLE("Soft Ramp Switch", STA32X_CONFE, STA32X_CONFE_SVE_SHIFT, 1, =
0),
> +SOC_SINGLE("Auto-Mute Switch", STA32X_CONFF, STA32X_CONFF_IDE_SHIFT, 1, =
0),
> +SOC_ENUM("Automode EQ", sta32x_auto_eq_enum),
> +SOC_ENUM("Automode GC", sta32x_auto_gc_enum),
> +SOC_ENUM("Automode XO", sta32x_auto_xo_enum),
> +SOC_ENUM("Preset EQ", sta32x_preset_eq_enum),
> +SOC_SINGLE("Ch1 Tone Control Bypass Switch", STA32X_C1CFG, STA32X_CxCFG_=
TCB_SHIFT, 1, 0),
> +SOC_SINGLE("Ch2 Tone Control Bypass Switch", STA32X_C2CFG, STA32X_CxCFG_=
TCB_SHIFT, 1, 0),
> +SOC_SINGLE("Ch1 EQ Bypass Switch", STA32X_C1CFG, STA32X_CxCFG_EQBP_SHIFT=
, 1, 0),
> +SOC_SINGLE("Ch2 EQ Bypass Switch", STA32X_C2CFG, STA32X_CxCFG_EQBP_SHIFT=
, 1, 0),
> +SOC_SINGLE("Ch1 Master Volume Bypass Switch", STA32X_C1CFG, STA32X_CxCFG=
_VBP_SHIFT, 1, 0),
> +SOC_SINGLE("Ch2 Master Volume Bypass Switch", STA32X_C1CFG, STA32X_CxCFG=
_VBP_SHIFT, 1, 0),
> +SOC_SINGLE("Ch3 Master Volume Bypass Switch", STA32X_C1CFG, STA32X_CxCFG=
_VBP_SHIFT, 1, 0),
> +SOC_ENUM("Ch1 Limiter Select", sta32x_limiter_ch1_enum),
> +SOC_ENUM("Ch2 Limiter Select", sta32x_limiter_ch2_enum),
> +SOC_ENUM("Ch3 Limiter Select", sta32x_limiter_ch3_enum),
> +SOC_SINGLE_TLV("Bass Tone Control", STA32X_TONE, STA32X_TONE_BTC_SHIFT, =
15, 0, tone_tlv),
> +SOC_SINGLE_TLV("Treble Tone Control", STA32X_TONE, STA32X_TONE_TTC_SHIFT=
, 15, 0, tone_tlv),
> +SOC_ENUM("Limiter1 Attack Rate (dB/ms)", sta32x_limiter1_attack_rate_enu=
m),
> +SOC_ENUM("Limiter2 Attack Rate (dB/ms)", sta32x_limiter2_attack_rate_enu=
m),
> +SOC_ENUM("Limiter1 Release Rate (dB/ms)", sta32x_limiter1_release_rate_e=
num),
> +SOC_ENUM("Limiter2 Release Rate (dB/ms)", sta32x_limiter1_release_rate_e=
num),
> +
> +/* depending on mode, the attack/release thresholds have
> + * two different enum definitions; provide both
> + */
> +SOC_SINGLE_TLV("Limiter1 Attack Threshold (AC Mode)", STA32X_L1ATRT, STA=
32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_ac_attack_tlv),
> +SOC_SINGLE_TLV("Limiter2 Attack Threshold (AC Mode)", STA32X_L2ATRT, STA=
32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_ac_attack_tlv),
> +SOC_SINGLE_TLV("Limiter1 Release Threshold (AC Mode)", STA32X_L1ATRT, ST=
A32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_ac_release_tlv),
> +SOC_SINGLE_TLV("Limiter2 Release Threshold (AC Mode)", STA32X_L2ATRT, ST=
A32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_ac_release_tlv),
> +SOC_SINGLE_TLV("Limiter1 Attack Threshold (DRC Mode)", STA32X_L1ATRT, ST=
A32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_drc_attack_tlv),
> +SOC_SINGLE_TLV("Limiter2 Attack Threshold (DRC Mode)", STA32X_L2ATRT, ST=
A32X_LxA_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_drc_attack_tlv),
> +SOC_SINGLE_TLV("Limiter1 Release Threshold (DRC Mode)", STA32X_L1ATRT, S=
TA32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_drc_release_tlv),
> +SOC_SINGLE_TLV("Limiter2 Release Threshold (DRC Mode)", STA32X_L2ATRT, S=
TA32X_LxR_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A016, 0, sta32x_limiter_drc_release_tlv),
> +};
> +
> +static const struct snd_soc_dapm_widget sta32x_dapm_widgets[] =3D {
> +SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
> +SND_SOC_DAPM_OUTPUT("LEFT"),
> +SND_SOC_DAPM_OUTPUT("RIGHT"),
> +SND_SOC_DAPM_OUTPUT("SUB"),
> +};
> +
> +static const struct snd_soc_dapm_route sta32x_dapm_routes[] =3D {
> + =A0 =A0 =A0 { "LEFT", NULL, "DAC" },
> + =A0 =A0 =A0 { "RIGHT", NULL, "DAC" },
> + =A0 =A0 =A0 { "SUB", NULL, "DAC" },
> +};
> +
> +/* MCLK interpolation ratio per fs */
> +static struct {
> + =A0 =A0 =A0 int fs;
> + =A0 =A0 =A0 int ir;
> +} interpolation_ratios[] =3D {
> + =A0 =A0 =A0 { 32000, 0 },
> + =A0 =A0 =A0 { 44100, 0 },
> + =A0 =A0 =A0 { 48000, 0 },
> + =A0 =A0 =A0 { 88200, 1 },
> + =A0 =A0 =A0 { 96000, 1 },
> + =A0 =A0 =A0 { 176400, 2 },
> + =A0 =A0 =A0 { 192000, 2 },
> +};
> +
> +/* MCLK to fs clock ratios */
> +static struct {
> + =A0 =A0 =A0 int ratio;
> + =A0 =A0 =A0 int mcs;
> +} mclk_ratios[3][7] =3D {
> + =A0 =A0 =A0 { { 768, 0 }, { 512, 1 }, { 384, 2 }, { 256, 3 },
> + =A0 =A0 =A0 =A0 { 128, 4 }, { 576, 5 }, { 0, 0 } },
> + =A0 =A0 =A0 { { 384, 2 }, { 256, 3 }, { 192, 4 }, { 128, 5 }, {64, 0 },=
 { 0, 0 } },
> + =A0 =A0 =A0 { { 384, 2 }, { 256, 3 }, { 192, 4 }, { 128, 5 }, {64, 0 },=
 { 0, 0 } },
> +};
> +
> +
> +/**
> + * sta32x_set_dai_sysclk - configure MCLK
> + * @codec_dai: the codec DAI
> + * @clk_id: the clock ID (ignored)
> + * @freq: the MCLK input frequency
> + * @dir: the clock direction (ignored)
> + *
> + * The value of MCLK is used to determine which sample rates are support=
ed
> + * by the STA32X, based on the mclk_ratios table.
> + *
> + * This function must be called by the machine driver's 'startup' functi=
on,
> + * otherwise the list of supported sample rates will not be available in
> + * time for ALSA.
> + *
> + * For setups with variable MCLKs, pass 0 as 'freq' argument. This will =
cause
> + * theoretically possible sample rates to be enabled. Call it again with=
 a
> + * proper value set one the external clock is set (most probably you wou=
ld do
> + * that from a machine's driver 'hw_param' hook.
> + */
> +static int sta32x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int clk_id, unsigned int freq, int dir)
> +{
> + =A0 =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> + =A0 =A0 =A0 int i, j, ir, fs;
> + =A0 =A0 =A0 unsigned int rates =3D 0;
> + =A0 =A0 =A0 unsigned int rate_min =3D -1;
> + =A0 =A0 =A0 unsigned int rate_max =3D 0;
> +
> + =A0 =A0 =A0 pr_debug("mclk=3D%u\n", freq);
> + =A0 =A0 =A0 sta32x->mclk =3D freq;
> +
> + =A0 =A0 =A0 if (sta32x->mclk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(interpolation_=
ratios); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir =3D interpolation_ratios=
[i].ir;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fs =3D interpolation_ratios=
[i].fs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; mclk_ratios[i=
r][j].ratio; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mclk_ra=
tios[ir][j].ratio * fs =3D=3D freq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rates |=3D snd_pcm_rate_to_rate_bit(fs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (fs < rate_min)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 rate_min =3D fs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (fs > rate_max)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 rate_max =3D fs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: soc should support a rate list */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rates &=3D ~SNDRV_PCM_RATE_KNOT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rates) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "could =
not find a valid sample rate\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable all possible rates */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rates =3D STA32X_RATES;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate_min =3D 32000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate_max =3D 192000;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 codec_dai->driver->playback.rates =3D rates;
> + =A0 =A0 =A0 codec_dai->driver->playback.rate_min =3D rate_min;
> + =A0 =A0 =A0 codec_dai->driver->playback.rate_max =3D rate_max;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * sta32x_set_dai_fmt - configure the codec for the selected audio format
> + * @codec_dai: the codec DAI
> + * @fmt: a SND_SOC_DAIFMT_x value indicating the data format
> + *
> + * This function takes a bitmask of SND_SOC_DAIFMT_x bits and programs t=
he
> + * codec accordingly.
> + */
> +static int sta32x_set_dai_fmt(struct snd_soc_dai *codec_dai,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int fm=
t)
> +{
> + =A0 =A0 =A0 struct snd_soc_codec *codec =3D codec_dai->codec;
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> + =A0 =A0 =A0 u8 confb =3D snd_soc_read(codec, STA32X_CONFB);
> +
> + =A0 =A0 =A0 pr_debug("\n");
> + =A0 =A0 =A0 confb &=3D ~(STA32X_CONFB_C1IM | STA32X_CONFB_C2IM);
> +
> + =A0 =A0 =A0 switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_CBS_CFS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_RIGHT_J:
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x->format =3D fmt & SND_SOC_DAIFMT_FOR=
MAT_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_NB_NF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D STA32X_CONFB_C2IM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SND_SOC_DAIFMT_NB_IF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D STA32X_CONFB_C1IM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 snd_soc_write(codec, STA32X_CONFB, confb);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * sta32x_hw_params - program the STA32X with the given hardware paramet=
ers.
> + * @substream: the audio stream
> + * @params: the hardware parameters to set
> + * @dai: the SOC DAI (ignored)
> + *
> + * This function programs the hardware with the values provided.
> + * Specifically, the sample rate and the data format.
> + */
> +static int sta32x_hw_params(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_pcm_hw_p=
arams *params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dai =
*dai)
> +{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> + =A0 =A0 =A0 struct snd_soc_codec *codec =3D rtd->codec;
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> + =A0 =A0 =A0 unsigned int rate;
> + =A0 =A0 =A0 int i, mcs =3D -1, ir =3D -1;
> + =A0 =A0 =A0 u8 confa, confb;
> +
> + =A0 =A0 =A0 rate =3D params_rate(params);
> + =A0 =A0 =A0 pr_debug("rate: %u\n", rate);
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(interpolation_ratios); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (interpolation_ratios[i].fs =3D=3D rate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ir =3D interpolation_ratios=
[i].ir;
> + =A0 =A0 =A0 if (ir < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 for (i =3D 0; mclk_ratios[ir][i].ratio; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mclk_ratios[ir][i].ratio * rate =3D=3D =
sta32x->mclk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcs =3D mclk_ratios[ir][i].=
mcs;
> + =A0 =A0 =A0 if (mcs < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 confa =3D snd_soc_read(codec, STA32X_CONFA);
> + =A0 =A0 =A0 confa &=3D ~(STA32X_CONFA_MCS_MASK | STA32X_CONFA_IR_MASK);
> + =A0 =A0 =A0 confa |=3D (ir << STA32X_CONFA_IR_SHIFT) | (mcs << STA32X_C=
ONFA_MCS_SHIFT);
> +
> + =A0 =A0 =A0 confb =3D snd_soc_read(codec, STA32X_CONFB);
> + =A0 =A0 =A0 confb &=3D ~(STA32X_CONFB_SAI_MASK | STA32X_CONFB_SAIFB);
> + =A0 =A0 =A0 switch (params_format(params)) {
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S24_LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S24_BE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S24_3LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S24_3BE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("24bit\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S32_LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S32_BE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("24bit or 32bit\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sta32x->format) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_RIGHT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S20_3LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S20_3BE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("20bit\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sta32x->format) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_RIGHT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S18_3LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S18_3BE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("18bit\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sta32x->format) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x9;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_RIGHT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0xa;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S16_LE:
> + =A0 =A0 =A0 case SNDRV_PCM_FORMAT_S16_BE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("16bit\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sta32x->format) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_I2S:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0x0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0xd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case SND_SOC_DAIFMT_RIGHT_J:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 confb |=3D 0xe;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 snd_soc_write(codec, STA32X_CONFA, confa);
> + =A0 =A0 =A0 snd_soc_write(codec, STA32X_CONFB, confb);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * sta32x_set_bias_level - DAPM callback
> + * @codec: the codec device
> + * @level: DAPM power level
> + *
> + * This is called by ALSA to put the codec into low power mode
> + * or to wake it up. =A0If the codec is powered off completely
> + * all registers must be restored after power on.
> + */
> +static int sta32x_set_bias_level(struct snd_soc_codec *codec,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum snd=
_soc_bias_level level)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> +
> + =A0 =A0 =A0 pr_debug("level =3D %d\n", level);
> + =A0 =A0 =A0 switch (level) {
> + =A0 =A0 =A0 case SND_SOC_BIAS_ON:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SND_SOC_BIAS_PREPARE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Full power on */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_CONFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN | STA32X_CONFF_EAPD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN | STA32X_CONFF_EAPD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SND_SOC_BIAS_STANDBY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (codec->dapm.bias_level =3D=3D SND_SOC_B=
IAS_OFF) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_bulk_enab=
le(ARRAY_SIZE(sta32x->supplies),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x->supplies);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(cod=
ec->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Failed to enable supplies: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_cache_sync(codec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Power up to mute */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_CONFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN | STA32X_CONFF_EAPD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN | STA32X_CONFF_EAPD);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case SND_SOC_BIAS_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The chip runs through the power down seq=
uence for us. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_CONFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN | STA32X_CONFF_EAPD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA=
32X_CONFF_PWDN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(300);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_bulk_disable(ARRAY_SIZE(sta32x->s=
upplies),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0sta32x->supplies);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 codec->dapm.bias_level =3D level;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct snd_soc_dai_ops sta32x_dai_ops =3D {
> + =A0 =A0 =A0 .hw_params =A0 =A0 =A0=3D sta32x_hw_params,
> + =A0 =A0 =A0 .set_sysclk =A0 =A0 =3D sta32x_set_dai_sysclk,
> + =A0 =A0 =A0 .set_fmt =A0 =A0 =A0 =A0=3D sta32x_set_dai_fmt,
> +};
> +
> +static struct snd_soc_dai_driver sta32x_dai =3D {
> + =A0 =A0 =A0 .name =3D "STA32X",
> + =A0 =A0 =A0 .playback =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .stream_name =3D "Playback",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_min =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_max =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rates =3D STA32X_RATES,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .formats =3D STA32X_FORMATS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .ops =3D &sta32x_dai_ops,
> +};
> +
> +#ifdef CONFIG_PM
> +static int sta32x_suspend(struct snd_soc_codec *codec, pm_message_t stat=
e)
> +{
> + =A0 =A0 =A0 sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int sta32x_resume(struct snd_soc_codec *codec)
> +{
> + =A0 =A0 =A0 sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define sta32x_suspend NULL
> +#define sta32x_resume NULL
> +#endif
> +
> +static int sta32x_probe(struct snd_soc_codec *codec)
> +{
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> + =A0 =A0 =A0 int i, ret =3D 0;
> +
> + =A0 =A0 =A0 sta32x->codec =3D codec;
> +
> + =A0 =A0 =A0 /* regulators */
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(sta32x->supplies); i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x->supplies[i].supply =3D sta32x_suppl=
y_names[i];
> +
> + =A0 =A0 =A0 ret =3D regulator_bulk_get(codec->dev, ARRAY_SIZE(sta32x->s=
upplies),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sta32x->=
supplies);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to request supp=
lies: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D regulator_bulk_enable(ARRAY_SIZE(sta32x->supplies),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta=
32x->supplies);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "Failed to enable suppl=
ies: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_get;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Tell ASoC what kind of I/O to use to read the registers.=
 =A0ASoC will
> + =A0 =A0 =A0 =A0* then do the I2C transactions itself.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C=
);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(codec->dev, "failed to set cache I/=
O (ret=3D%i)\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* read reg reset values into cache */
> + =A0 =A0 =A0 for (i =3D 0; i < STA32X_REGISTER_COUNT; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_cache_write(codec, i, sta32x_regs[i=
]);
> +
> + =A0 =A0 =A0 /* FIXME enable thermal warning adjustment and recovery =A0=
*/
> + =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_CONFA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA32X_CONFA_TWAB |=
 STA32X_CONFA_TWRB, 0);
> +
> + =A0 =A0 =A0 /* FIXME select 2.1 mode =A0*/
> + =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_CONFF,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA32X_CONFF_OCFG_M=
ASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 << STA32X_CONFF_O=
CFG_SHIFT);
> +
> + =A0 =A0 =A0 /* FIXME channel to output mapping */
> + =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_C1CFG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA32X_CxCFG_OM_MAS=
K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 << STA32X_CxCFG_O=
M_SHIFT);
> + =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_C2CFG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA32X_CxCFG_OM_MAS=
K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 << STA32X_CxCFG_O=
M_SHIFT);
> + =A0 =A0 =A0 snd_soc_update_bits(codec, STA32X_C3CFG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 STA32X_CxCFG_OM_MAS=
K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 << STA32X_CxCFG_O=
M_SHIFT);
> +
> + =A0 =A0 =A0 sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> + =A0 =A0 =A0 /* Bias level configuration will have done an extra enable =
*/
> + =A0 =A0 =A0 regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x=
->supplies);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_get:
> + =A0 =A0 =A0 regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->s=
upplies);
> +err:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int sta32x_remove(struct snd_soc_codec *codec)
> +{
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D snd_soc_codec_get_drvdata(co=
dec);
> +
> + =A0 =A0 =A0 regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x=
->supplies);
> + =A0 =A0 =A0 regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->s=
upplies);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct snd_soc_codec_driver sta32x_codec =3D {
> + =A0 =A0 =A0 .probe =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sta32x_probe,
> + =A0 =A0 =A0 .remove =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x_remove,
> + =A0 =A0 =A0 .suspend =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0sta32x_suspend,
> + =A0 =A0 =A0 .resume =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x_resume,
> + =A0 =A0 =A0 .reg_cache_size =3D =A0 =A0 =A0 STA32X_REGISTER_COUNT,
> + =A0 =A0 =A0 .reg_word_size =3D =A0 =A0 =A0 =A0sizeof(u8),
> + =A0 =A0 =A0 .set_bias_level =3D =A0 =A0 =A0 sta32x_set_bias_level,
> + =A0 =A0 =A0 .controls =3D =A0 =A0 =A0 =A0 =A0 =A0 sta32x_snd_controls,
> + =A0 =A0 =A0 .num_controls =3D =A0 =A0 =A0 =A0 ARRAY_SIZE(sta32x_snd_con=
trols),
> + =A0 =A0 =A0 .dapm_widgets =3D =A0 =A0 =A0 =A0 sta32x_dapm_widgets,
> + =A0 =A0 =A0 .num_dapm_widgets =3D =A0 =A0 ARRAY_SIZE(sta32x_dapm_widget=
s),
> + =A0 =A0 =A0 .dapm_routes =3D =A0 =A0 =A0 =A0 =A0sta32x_dapm_routes,
> + =A0 =A0 =A0 .num_dapm_routes =3D =A0 =A0 =A0ARRAY_SIZE(sta32x_dapm_rout=
es),
> +};
> +
> +static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 const struct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 struct sta32x_priv *sta32x;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 sta32x =3D kzalloc(sizeof(struct sta32x_priv), GFP_KERNEL);
> + =A0 =A0 =A0 if (!sta32x)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 i2c_set_clientdata(i2c, sta32x);
> +
> + =A0 =A0 =A0 ret =3D snd_soc_register_codec(&i2c->dev, &sta32x_codec, &s=
ta32x_dai, 1);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&i2c->dev, "Failed to register code=
c (%d)\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static __devexit int sta32x_i2c_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct sta32x_priv *sta32x =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 struct snd_soc_codec *codec =3D sta32x->codec;
> +
> + =A0 =A0 =A0 if (codec)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sta32x_set_bias_level(codec, SND_SOC_BIAS_O=
FF);
> +
> + =A0 =A0 =A0 regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->s=
upplies);
> +
> + =A0 =A0 =A0 if (codec) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_unregister_codec(&client->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_codec_set_drvdata(codec, NULL);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kfree(sta32x);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct i2c_device_id sta32x_i2c_id[] =3D {
> + =A0 =A0 =A0 { "sta326", 0 },
> + =A0 =A0 =A0 { "sta328", 0 },
> + =A0 =A0 =A0 { "sta329", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, sta32x_i2c_id);
> +
> +static struct i2c_driver sta32x_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "sta32x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D =A0 =A0sta32x_i2c_probe,
> + =A0 =A0 =A0 .remove =3D =A0 __devexit_p(sta32x_i2c_remove),
> + =A0 =A0 =A0 .id_table =3D sta32x_i2c_id,
> +};
> +
> +static int __init sta32x_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&sta32x_i2c_driver);
> +}
> +module_init(sta32x_init);
> +
> +static void __exit sta32x_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&sta32x_i2c_driver);
> +}
> +module_exit(sta32x_exit);
> +
> +MODULE_DESCRIPTION("ASoC STA32X driver");
> +MODULE_AUTHOR("Johannes Stezenbach <js@sig21.net>");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/sta32x.h b/sound/soc/codecs/sta32x.h
> new file mode 100644
> index 0000000..b97ee5a
> --- /dev/null
> +++ b/sound/soc/codecs/sta32x.h
> @@ -0,0 +1,210 @@
> +/*
> + * Codec driver for ST STA32x 2.1-channel high-efficiency digital audio =
system
> + *
> + * Copyright: 2011 Raumfeld GmbH
> + * Author: Johannes Stezenbach <js@sig21.net>
> + *
> + * based on code from:
> + * =A0 =A0 Wolfson Microelectronics PLC.
> + * =A0 =A0 Mark Brown <broonie@opensource.wolfsonmicro.com>
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + */
> +#ifndef _ASOC_STA_32X_H
> +#define _ASOC_STA_32X_H
> +
> +/* STA326 register addresses */
> +
> +#define STA32X_REGISTER_COUNT =A00x2d
> +
> +#define STA32X_CONFA =A0 0x00
> +#define STA32X_CONFB =A0 =A00x01
> +#define STA32X_CONFC =A0 =A00x02
> +#define STA32X_CONFD =A0 =A00x03
> +#define STA32X_CONFE =A0 =A00x04
> +#define STA32X_CONFF =A0 =A00x05
> +#define STA32X_MMUTE =A0 =A00x06
> +#define STA32X_MVOL =A0 =A0 0x07
> +#define STA32X_C1VOL =A0 =A00x08
> +#define STA32X_C2VOL =A0 =A00x09
> +#define STA32X_C3VOL =A0 =A00x0a
> +#define STA32X_AUTO1 =A0 =A00x0b
> +#define STA32X_AUTO2 =A0 =A00x0c
> +#define STA32X_AUTO3 =A0 =A00x0d
> +#define STA32X_C1CFG =A0 =A00x0e
> +#define STA32X_C2CFG =A0 =A00x0f
> +#define STA32X_C3CFG =A0 =A00x10
> +#define STA32X_TONE =A0 =A0 0x11
> +#define STA32X_L1AR =A0 =A0 0x12
> +#define STA32X_L1ATRT =A0 0x13
> +#define STA32X_L2AR =A0 =A0 0x14
> +#define STA32X_L2ATRT =A0 0x15
> +#define STA32X_CFADDR2 =A00x16
> +#define STA32X_B1CF1 =A0 =A00x17
> +#define STA32X_B1CF2 =A0 =A00x18
> +#define STA32X_B1CF3 =A0 =A00x19
> +#define STA32X_B2CF1 =A0 =A00x1a
> +#define STA32X_B2CF2 =A0 =A00x1b
> +#define STA32X_B2CF3 =A0 =A00x1c
> +#define STA32X_A1CF1 =A0 =A00x1d
> +#define STA32X_A1CF2 =A0 =A00x1e
> +#define STA32X_A1CF3 =A0 =A00x1f
> +#define STA32X_A2CF1 =A0 =A00x20
> +#define STA32X_A2CF2 =A0 =A00x21
> +#define STA32X_A2CF3 =A0 =A00x22
> +#define STA32X_B0CF1 =A0 =A00x23
> +#define STA32X_B0CF2 =A0 =A00x24
> +#define STA32X_B0CF3 =A0 =A00x25
> +#define STA32X_CFUD =A0 =A0 0x26
> +#define STA32X_MPCC1 =A0 =A00x27
> +#define STA32X_MPCC2 =A0 =A00x28
> +/* Reserved 0x29 */
> +/* Reserved 0x2a */
> +#define STA32X_Reserved 0x2a
> +#define STA32X_FDRC1 =A0 =A00x2b
> +#define STA32X_FDRC2 =A0 =A00x2c
> +/* Reserved 0x2d */
> +
> +
> +/* STA326 register field definitions */
> +
> +/* 0x00 CONFA */
> +#define STA32X_CONFA_MCS_MASK =A00x03
> +#define STA32X_CONFA_MCS_SHIFT 0
> +#define STA32X_CONFA_IR_MASK =A0 0x18
> +#define STA32X_CONFA_IR_SHIFT =A03
> +#define STA32X_CONFA_TWRB =A0 =A0 =A00x20
> +#define STA32X_CONFA_TWAB =A0 =A0 =A00x40
> +#define STA32X_CONFA_FDRB =A0 =A0 =A00x80
> +
> +/* 0x01 CONFB */
> +#define STA32X_CONFB_SAI_MASK =A00x0f
> +#define STA32X_CONFB_SAI_SHIFT 0
> +#define STA32X_CONFB_SAIFB =A0 =A0 0x10
> +#define STA32X_CONFB_DSCKE =A0 =A0 0x20
> +#define STA32X_CONFB_C1IM =A0 =A0 =A00x40
> +#define STA32X_CONFB_C2IM =A0 =A0 =A00x80
> +
> +/* 0x02 CONFC */
> +#define STA32X_CONFC_OM_MASK =A0 0x03
> +#define STA32X_CONFC_OM_SHIFT =A00
> +#define STA32X_CONFC_CSZ_MASK =A00x7c
> +#define STA32X_CONFC_CSZ_SHIFT 2
> +
> +/* 0x03 CONFD */
> +#define STA32X_CONFD_HPB =A0 =A0 =A0 0x01
> +#define STA32X_CONFD_HPB_SHIFT 0
> +#define STA32X_CONFD_DEMP =A0 =A0 =A00x02
> +#define STA32X_CONFD_DEMP_SHIFT =A0 =A0 =A0 =A01
> +#define STA32X_CONFD_DSPB =A0 =A0 =A00x04
> +#define STA32X_CONFD_DSPB_SHIFT =A0 =A0 =A0 =A02
> +#define STA32X_CONFD_PSL =A0 =A0 =A0 0x08
> +#define STA32X_CONFD_PSL_SHIFT 3
> +#define STA32X_CONFD_BQL =A0 =A0 =A0 0x10
> +#define STA32X_CONFD_BQL_SHIFT 4
> +#define STA32X_CONFD_DRC =A0 =A0 =A0 0x20
> +#define STA32X_CONFD_DRC_SHIFT 5
> +#define STA32X_CONFD_ZDE =A0 =A0 =A0 0x40
> +#define STA32X_CONFD_ZDE_SHIFT 6
> +#define STA32X_CONFD_MME =A0 =A0 =A0 0x80
> +#define STA32X_CONFD_MME_SHIFT 7
> +
> +/* 0x04 CONFE */
> +#define STA32X_CONFE_MPCV =A0 =A0 =A00x01
> +#define STA32X_CONFE_MPCV_SHIFT =A0 =A0 =A0 =A00
> +#define STA32X_CONFE_MPC =A0 =A0 =A0 0x02
> +#define STA32X_CONFE_MPC_SHIFT 1
> +#define STA32X_CONFE_AME =A0 =A0 =A0 0x08
> +#define STA32X_CONFE_AME_SHIFT 3
> +#define STA32X_CONFE_PWMS =A0 =A0 =A00x10
> +#define STA32X_CONFE_PWMS_SHIFT =A0 =A0 =A0 =A04
> +#define STA32X_CONFE_ZCE =A0 =A0 =A0 0x40
> +#define STA32X_CONFE_ZCE_SHIFT 6
> +#define STA32X_CONFE_SVE =A0 =A0 =A0 0x80
> +#define STA32X_CONFE_SVE_SHIFT 7
> +
> +/* 0x05 CONFF */
> +#define STA32X_CONFF_OCFG_MASK 0x03
> +#define STA32X_CONFF_OCFG_SHIFT =A0 =A0 =A0 =A00
> +#define STA32X_CONFF_IDE =A0 =A0 =A0 0x04
> +#define STA32X_CONFF_IDE_SHIFT 3
> +#define STA32X_CONFF_BCLE =A0 =A0 =A00x08
> +#define STA32X_CONFF_ECLE =A0 =A0 =A00x20
> +#define STA32X_CONFF_PWDN =A0 =A0 =A00x40
> +#define STA32X_CONFF_EAPD =A0 =A0 =A00x80
> +
> +/* 0x06 MMUTE */
> +#define STA32X_MMUTE_MMUTE =A0 =A0 0x01
> +
> +/* 0x0b AUTO1 */
> +#define STA32X_AUTO1_AMEQ_MASK 0x03
> +#define STA32X_AUTO1_AMEQ_SHIFT =A0 =A0 =A0 =A00
> +#define STA32X_AUTO1_AMV_MASK =A00xc0
> +#define STA32X_AUTO1_AMV_SHIFT 2
> +#define STA32X_AUTO1_AMGC_MASK 0x30
> +#define STA32X_AUTO1_AMGC_SHIFT =A0 =A0 =A0 =A04
> +#define STA32X_AUTO1_AMPS =A0 =A0 =A00x80
> +
> +/* 0x0c AUTO2 */
> +#define STA32X_AUTO2_AMAME =A0 =A0 0x01
> +#define STA32X_AUTO2_AMAM_MASK 0x0e
> +#define STA32X_AUTO2_AMAM_SHIFT =A0 =A0 =A0 =A01
> +#define STA32X_AUTO2_XO_MASK =A0 0xf0
> +#define STA32X_AUTO2_XO_SHIFT =A04
> +
> +/* 0x0d AUTO3 */
> +#define STA32X_AUTO3_PEQ_MASK =A00x1f
> +#define STA32X_AUTO3_PEQ_SHIFT 0
> +
> +/* 0x0e 0x0f 0x10 CxCFG */
> +#define STA32X_CxCFG_TCB =A0 =A0 =A0 0x01 =A0 =A0/* only C1 and C2 */
> +#define STA32X_CxCFG_TCB_SHIFT 0
> +#define STA32X_CxCFG_EQBP =A0 =A0 =A00x02 =A0 =A0/* only C1 and C2 */
> +#define STA32X_CxCFG_EQBP_SHIFT =A0 =A0 =A0 =A01
> +#define STA32X_CxCFG_VBP =A0 =A0 =A0 0x03
> +#define STA32X_CxCFG_VBP_SHIFT 2
> +#define STA32X_CxCFG_BO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
> +#define STA32X_CxCFG_LS_MASK =A0 0x30
> +#define STA32X_CxCFG_LS_SHIFT =A04
> +#define STA32X_CxCFG_OM_MASK =A0 0xc0
> +#define STA32X_CxCFG_OM_SHIFT =A06
> +
> +/* 0x11 TONE */
> +#define STA32X_TONE_BTC_SHIFT =A00
> +#define STA32X_TONE_TTC_SHIFT =A04
> +
> +/* 0x12 0x13 0x14 0x15 limiter attack/release */
> +#define STA32X_LxA_SHIFT =A0 =A0 =A0 0
> +#define STA32X_LxR_SHIFT =A0 =A0 =A0 4
> +
> +/* 0x26 CFUD */
> +#define STA32X_CFUD_W1 =A0 =A0 =A0 =A0 0x01
> +#define STA32X_CFUD_WA =A0 =A0 =A0 =A0 0x02
> +#define STA32X_CFUD_R1 =A0 =A0 =A0 =A0 0x04
> +#define STA32X_CFUD_RA =A0 =A0 =A0 =A0 0x08
> +
> +
> +/* biquad filter coefficient table offsets */
> +#define STA32X_C1_BQ_BASE =A0 =A0 =A00
> +#define STA32X_C2_BQ_BASE =A0 =A0 =A020
> +#define STA32X_CH_BQ_NUM =A0 =A0 =A0 4
> +#define STA32X_BQ_NUM_COEF =A0 =A0 5
> +#define STA32X_XO_HP_BQ_BASE =A0 40
> +#define STA32X_XO_LP_BQ_BASE =A0 45
> +#define STA32X_C1_PRESCALE =A0 =A0 50
> +#define STA32X_C2_PRESCALE =A0 =A0 51
> +#define STA32X_C1_POSTSCALE =A0 =A052
> +#define STA32X_C2_POSTSCALE =A0 =A053
> +#define STA32X_C3_POSTSCALE =A0 =A054
> +#define STA32X_TW_POSTSCALE =A0 =A055
> +#define STA32X_C1_MIX1 =A0 =A0 =A0 =A0 56
> +#define STA32X_C1_MIX2 =A0 =A0 =A0 =A0 57
> +#define STA32X_C2_MIX1 =A0 =A0 =A0 =A0 58
> +#define STA32X_C2_MIX2 =A0 =A0 =A0 =A0 59
> +#define STA32X_C3_MIX1 =A0 =A0 =A0 =A0 60
> +#define STA32X_C3_MIX2 =A0 =A0 =A0 =A0 61
> +
> +#endif /* _ASOC_STA_32X_H */
> --
> 1.7.5.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
