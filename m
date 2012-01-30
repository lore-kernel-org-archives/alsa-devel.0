From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Ux500: Add driver for
 Ux500/AB8500 platform/codec
Date: Mon, 30 Jan 2012 17:22:14 +0000
Message-ID: <20120130172214.GM4882@opensource.wolfsonmicro.com>
References: <1327933110-22229-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3259410906549053910=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C8CB103977
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 18:22:18 +0100 (CET)
In-Reply-To: <1327933110-22229-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3259410906549053910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2012 at 03:18:30PM +0100, Ola Lilja wrote:
> Add the ST-Ericsson Ux500 ASoC platform-driver, AB8500 codec-driver and
> machine-driver for U8500 hardware.

This *needs* to be split up for review, there's a *lot* of only
tangentally related things in here and...

>  26 files changed, 8519 insertions(+), 9 deletions(-)

=2E..an over 8000 line patch is not easy to review at the best of times.

I'm going to comment on a few things but this is really not a detailed
review.  From the brief look I've had (most of my comments are on the
CODEC driver but I did at least glance at most of the code) my overall
comment is that the code doesn't look like ASoC code at a structural
level.  The fact that it's all submitted in one patch seems indicative
of this, and for example what looks like it's supposed to be a machine
driver is peering into the CODEC power management directly rather than
letting the CODEC driver get on with things.

Please make much more of an effort to work with the framework, you
should have a series of isolated drivers for the various components of
the system and they should all be using framework features where
possible.

In terms of ths split:

>  arch/arm/mach-ux500/board-mop500-msp.c        |  195 ++
>  arch/arm/mach-ux500/board-mop500-regulators.c |   28 +
>  arch/arm/mach-ux500/board-mop500.c            |    7 +-
>  arch/arm/mach-ux500/board-mop500.h            |    1 +

This adds machine support for a particular board on the ARM side.

>  arch/arm/mach-ux500/clock.c                   |    8 +-
>  arch/arm/mach-ux500/devices-common.h          |    2 +-
>  arch/arm/mach-ux500/include/mach/msp.h        | 1030 +++++++++

This looks like some random CPU core stuff.

>  include/sound/ux500_ab8500.h                  |   36 +
>  sound/soc/Kconfig                             |    1 +
>  sound/soc/Makefile                            |    1 +

This should be a separate patch on the end of the series which enables
the build.

>  sound/soc/codecs/Kconfig                      |    4 +
>  sound/soc/codecs/Makefile                     |    6 +
>  sound/soc/codecs/Makefile.rej                 |   10 +
>  sound/soc/codecs/ab8500_audio.c               | 2928 +++++++++++++++++++=
++++++
>  sound/soc/codecs/ab8500_audio.h               |  673 ++++++

This adds the CODEC driver and should be done separately and you
shouldn't be sending .rej files as part of your patch.

>  sound/soc/ux500/Kconfig                       |   33 +
>  sound/soc/ux500/Makefile                      |   25 +
>  sound/soc/ux500/u8500.c                       |  150 ++
>  sound/soc/ux500/ux500_ab8500.c                |  790 +++++++

One of these is a machine driver, again should be separate.

>  sound/soc/ux500/ux500_msp_dai.c               |  998 +++++++++
>  sound/soc/ux500/ux500_msp_dai.h               |   83 +
>  sound/soc/ux500/ux500_msp_i2s.c               | 1004 +++++++++
>  sound/soc/ux500/ux500_msp_i2s.h               |   40 +

Not sure what the split is here but this looks like the I2S controller
and can go as a separate patch.

>  sound/soc/ux500/ux500_pcm.c                   |  428 ++++
>  sound/soc/ux500/ux500_pcm.h                   |   44 +

The DMA controller should also be split.

> +/*** Sample Frequencies ***/
> +/* These are no longer required, frequencies in Hz can be used directly =
*/

If they are not required then remove them.

> +#ifndef UX500_AB8500_H
> +#define UX500_AB8500_H
> +
> +extern struct snd_soc_ops ux500_ab8500_ops[];
> +
> +struct snd_soc_pcm_runtime;
> +
> +int ux500_ab8500_startup(struct snd_pcm_substream *substream);
> +
> +void ux500_ab8500_shutdown(struct snd_pcm_substream *substream);
> +
> +int ux500_ab8500_hw_params(struct snd_pcm_substream *substream,
> +			struct snd_pcm_hw_params *params);
> +
> +int ux500_ab8500_soc_machine_drv_init(void);
> +
> +void ux500_ab8500_soc_machine_drv_cleanup(void);
> +
> +int ux500_ab8500_machine_codec_init(struct snd_soc_pcm_runtime *runtime);
> +
> +extern void ux500_ab8500_jack_report(int);
> +

Nothing in this header looks like it should be exported, I've not
actually looked at any of the code to see what this stuff is doing but
it all looks like it should be private to the relevant drivers.

> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -45,6 +45,7 @@ source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
>  source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> +source "sound/soc/ux500/Kconfig"
> =20
>  # Supported codecs
>  source "sound/soc/codecs/Kconfig"

Keep Kconfig and Makefiles sorted.

> index 7c205e7..a02b2c3 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
>  	tristate "Build all ASoC CODEC drivers"
>  	select SND_SOC_88PM860X if MFD_88PM860X
>  	select SND_SOC_L3
> +	select SND_SOC_AB8500
>  	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
>  	select SND_SOC_AD1836 if SPI_MASTER
>  	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI

Only if the MFD is there or it won't build.

> @@ -201,3 +203,7 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+=3D snd-soc-wm-hubs.o
>  # Amp
>  obj-$(CONFIG_SND_SOC_MAX9877)	+=3D snd-soc-max9877.o
>  obj-$(CONFIG_SND_SOC_TPA6130A2)	+=3D snd-soc-tpa6130a2.o
> +
> +ifdef CONFIG_SND_SOC_UX500_DEBUG
> +CFLAGS_ab8500_audio.o :=3D -DDEBUG
> +endif

No other driver has this.  Why does your driver have it?

> +/* Macros to simplify implementation of register write sequences and err=
or handling */
> +#define AB8500_SET_BIT_LOCKED(xreg, xbit, xerr, xerr_hdl) { \
> +	xerr =3D snd_soc_update_bits_locked(ab8500_codec, xreg, REG_MASK_NONE, =
BMASK(xbit)); \
> +	if (xerr < 0) \
> +		goto xerr_hdl; }
> +#define AB8500_CLEAR_BIT_LOCKED(xreg, xbit, xerr, xerr_hdl) { \
> +	xerr =3D snd_soc_update_bits_locked(ab8500_codec, xreg, BMASK(xbit), RE=
G_MASK_NONE); \
> +	if (xerr < 0) \
> +		goto xerr_hdl; }
> +#define AB8500_WRITE(xreg, xvalue, xerr, xerr_hdl) { \
> +	xerr =3D snd_soc_write(ab8500_codec, xreg, xvalue); \
> +	if (xerr < 0) \
> +		goto xerr_hdl; }

This just obscures the code.

> +/*
> + * AB8500 register cache & default register settings
> + */
> +static const u8 ab8500_reg_cache[AB8500_CACHEREGNUM] =3D {

Hrm, I would say the core ought to be converted over to regmap but it
looks like the "I2C" I/O actually goes via some magic "prcmu" interface
and not I2C.  I'd really like to try to avoid adding new cache users but
this does look like a valid use.

> +static struct snd_soc_codec *ab8500_codec;

If you need this something is seriously wrong.

> +/* ANC FIR- & IIR-coeff caches */
> +static int ab8500_anc_fir_coeff_cache[REG_ANC_FIR_COEFFS];
> +static int ab8500_anc_iir_coeff_cache[REG_ANC_IIR_COEFFS];

No global static data, store it per device.

> +static int ab8500_codec_read_reg(struct snd_soc_codec *codec, unsigned i=
nt bank,
> +		unsigned int reg)
> +{
> +	u8 value;
> +	int status =3D abx500_get_register_interruptible(
> +		codec->dev, bank, reg, &value);

Non-interruptible I/O please.  The user killing their application
shouldn't cause us to fail to shut down the audio path.

> +	if (status < 0) {
> +		pr_err("%s: Register (%02x:%02x) read failed (%d).\n",
> +			__func__, (u8)bank, (u8)reg, status);
> +	} else {
> +		pr_debug("Read 0x%02x from register %02x:%02x\n",
> +			(u8)value, (u8)bank, (u8)reg);
> +		status =3D value;

We have plenty of diagnsotic support in the core for basic stuff like
register I/O.  When you are logging use dev_ variants.

> +static unsigned int ab8500_codec_read_reg_audio(struct snd_soc_codec *co=
dec,
> +		unsigned int reg)
> +{
> +	u8 *cache =3D codec->reg_cache;
> +	return cache[reg];
> +}

Absolutely no open coded cache implementations, use the soc-cache
facilities.

> +static inline void ab8500_codec_dump_all_reg(struct snd_soc_codec *codec)
> +{
> +	int i;
> +
> +	pr_debug("%s Enter.\n", __func__);
> +
> +	for (i =3D AB8500_FIRST_REG; i <=3D AB8500_LAST_REG; i++)
> +		ab8500_codec_read_reg_audio_nocache(codec, i);
> +}

We have support for this in the core.

> +/* Updates an audio register.
> + */
> +static inline int ab8500_codec_update_reg_audio(struct snd_soc_codec *co=
dec,
> +		unsigned int reg, unsigned int clr, unsigned int ins)
> +{
> +	unsigned int new, old;
> +
> +	old =3D ab8500_codec_read_reg_audio(codec, reg);
> +	new =3D (old & ~clr) | ins;
> +	if (old =3D=3D new)
> +		return 0;
> +
> +	return ab8500_codec_write_reg_audio(codec, reg, new);
> +}

Ditto for this.

> +/* Generic soc info for signed register controls. */
> +int snd_soc_info_s(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_info *uinfo)

If this is generic (and it looks like it is) then what is it doing in a
particular driver?

> +static int st_fir_value_control_get(struct snd_kcontrol *kcontrol,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	return 0;
> +}

This looks obviously buggy.

> +/* Controls - DAPM */

> +/* Inverted order - Ascending/Descending */
> +enum control_inversion {
> +	NORMAL =3D 0,
> +	INVERT =3D 1
> +};

Seriously?

> +	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
> +	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
> +		pr_err("%s: ERROR: The device is either a master or a slave.\n",
> +			__func__);
> +	default:
> +		pr_err("%s: ERROR: Unsupporter master mask 0x%x\n",
> +			__func__,
> +			fmt & SND_SOC_DAIFMT_MASTER_MASK);
> +		return -EINVAL;
> +	}

All those three cases do the same thinng.

> +static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec *codec, u=
nsigned int delay)
> +{
> +	unsigned int clear_mask, set_mask;
> +
> +	clear_mask =3D BMASK(REG_DIGIFCONF4_IF1DEL);
> +	set_mask =3D 0;
> +
> +	switch (delay) {
> +	case 0:
> +		break;
> +	case 1:
> +		set_mask |=3D BMASK(REG_DIGIFCONF4_IF1DEL);
> +		break;
> +	default:
> +		pr_err("%s: ERROR: Unsupported bit-delay (0x%x)!\n", __func__, delay);
> +		return -EINVAL;
> +	}

Eh?  Why is this done separately to the configuration of the AIF mode?

> +	data =3D ab8500_codec_read_reg(codec, AB8500_MISC, AB8500_GPIO_DIR4_REG=
);
> +	data |=3D GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT | GPIO31_DIR_OUTPUT;
> +	ab8500_codec_write_reg(codec, AB8500_MISC, AB8500_GPIO_DIR4_REG, data);

This loooks like platform data...

> +void ab8500_audio_power_control(bool power_on)
> +{
> +	if (ab8500_codec =3D=3D NULL) {
> +		pr_err("%s: ERROR: AB8500 ASoC-driver not yet probed!\n", __func__);
> +		return;
> +	}

Use the framework features for power management, we've got enough ways
for your driver to get told when to power up and down none of which
require a global pointer to a device.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJtDGAAoJEBus8iNuMP3dGnAP/197BX3u2iTlWrIhsAfPiy1F
3G4fe3Cy/TUOLSRYYwxgWpIsKpEQ/PZ+VEEQ1V92UR2pWI/OpKu01zh/4oCoTQFK
azwgoMyep08oVp1AvyK5F2qsn1u4PzNwfbnhhHQfTC2SWb7lVJ0JmNiNcQJ9pMSd
w8nXK1a4vuW9RY4pRnrn3d6TnWJt5Gq/4IGmDYP8XNqEB+CC1avUC58yCTSwY2fS
WM80s9WTl36wKIe3Pc+AAAav7CJZgQDIG9Kgz8j4KcD4WGr/dctniXJE9bVLJqFb
MHc2He3Po9+jyk1LhQ0g5L2uJf6aG96L+8EdCHowSqea20e2qBCxOMsYr3OPfVuq
ULNxDg2QIkAznZ3ntbsvoeDb2nh/a8j6fKneSOIT29gyyR1J/zUEWqfMJzbrsLRq
HwHTyE2EfnvEz1vL297Sy/WJKXBYP5A+fYbcO0LxE7IkaEN+OMddp5iEfa1SleB2
HKOTHiniyVYDC3yv0AltaADdg2sAvaSGGbc6bAkBvLQV4xWbhu9JsWGjw4X36F0X
tCxLwpLsoHv9rEhQQTDmB1uojueipBhJnxX/XjgJVDu/jVE6IMzrSTvArL8Yx1ZM
k3SJX/Sr7XTefrDPT/htWYA60prhw5MFyQwVeT5fjx5Rok8My7SwufTimS8r5qS8
upi2y8+7jnqS+glLuJbB
=KEEG
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--

--===============3259410906549053910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3259410906549053910==--
