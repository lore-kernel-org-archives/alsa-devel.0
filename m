From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Tue, 13 Mar 2012 22:45:29 +0000
Message-ID: <20120313224529.GL3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8765154506024522409=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58C1F103A6E
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 23:45:33 +0100 (CET)
In-Reply-To: <1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
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


--===============8765154506024522409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 04:11:40PM +0100, Ola Lilja wrote:

> +++ b/sound/soc/codecs/Kconfig
> @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
>  	tristate "Build all ASoC CODEC drivers"
>  	select SND_SOC_88PM860X if MFD_88PM860X
>  	select SND_SOC_L3
> +	select SND_SOC_AB8500
>  	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
>  	select SND_SOC_AD1836 if SPI_MASTER
>  	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI

This driver really has no dependencies?  That seems *extremely*
surprising - have you tried building on x86?

> +
> +ifdef CONFIG_SND_SOC_UX500_DEBUG
> +CFLAGS_ab8500_audio.o :=3D -DDEBUG
> +endif

Once again if you're adding random custom stuff like this for your
driver you shouldn't be.

> diff --git a/sound/soc/codecs/ab8500_audio.c b/sound/soc/codecs/ab8500_au=
dio.c

Everything else uses -codec.

> +/* AB8500 register cache */
> +static const u8 ab8500_reg_cache[AB8500_CACHEREGNUM];

> +static enum sid_state sid_status =3D SID_UNCONFIGURED;

No static data or custom cache implementations.

> +/* Read a register from the audio-bank of AB8500 */
> +static unsigned int ab8500_codec_read_reg(struct snd_soc_codec *codec, u=
nsigned int reg)
> +{
> +	int status;
> +	unsigned int value =3D 0;
> +
> +	if (reg < VIRT_REG_BASE) {

Why are you doing this virtual register stuff?  It's making the code a
lot more complex and doesn't look at all driver specific.

> +		} else {
> +			dev_dbg(codec->dev, "%s: Read 0x%02x from register 0x%02x:0x%02x\n",
> +				__func__, value8, (u8)AB8500_AUDIO, (u8)reg);

There's already *plenty* of trace for register I/O in the framework.

> +static const char * const enum_ena_dis[] =3D {"Enabled", "Disabled"};
> +static const char * const enum_dis_ena[] =3D {"Disabled", "Enabled"};

Why are the controls using these enums and not Switch controls?  UIs
know how to display switches.

> +/* Earpiece - Mute */
> +static const struct snd_kcontrol_new dapm_ear_mute[] =3D {
> +	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF, REG_MUTECONF_MUTEAR, 1=
, 1),
> +};

This looks like it's just a mute rather than a mixer input enable
(there's only one control...) so should be a regular sound control;
unless there's a very good reason mutes other than mixer inputs normally
don't affect the audio path as you might get pops and you probably don't
want to do things like stop clocking just because the output is
silenced.  Similar thing applies in several other places.

> +/* Earpiece source selector */
> +static const char * const enum_ear_lineout_source[] =3D {"Headset Left",=
 "IHF Left"};
> +static SOC_ENUM_SINGLE_DECL(dapm_enum_ear_lineout_source, REG_DMICFILTCO=
NF,
> +			REG_DMICFILTCONF_DA3TOEAR, enum_ear_lineout_source);
> +static const struct snd_kcontrol_new dapm_ear_lineout_source =3D
> +	SOC_DAPM_ENUM("Earpiece or LineOut Mono Source", dapm_enum_ear_lineout_=
source);

This control can probably have a much better name...=20

> +/* IHF - Enable/Disable */
> +static const struct soc_enum enum_ihf_left =3D SOC_ENUM_SINGLE(0, 0, 2, =
enum_dis_ena);

80 columns please.

> +/* from -31 to 31 dB in 1 dB steps (mute instead of -32 dB) */
> +static DECLARE_TLV_DB_SCALE(adx_dig_gain_tlv, -3200, 100, 1);

I'm really not a big fan of this sort of comment, adds greatly to the
verbosity but just duplicates the code.

> +static const char * const enum_earselcm[] =3D {"0.95V", "1.10V", "1.27V"=
, "1.58V"};
> +static SOC_ENUM_SINGLE_DECL(soc_enum_earselcm,
> +	REG_ANACONF1, REG_ANACONF1_EARSELCM, enum_earselcm);

Should this really be configured by the application layer and not
platform data?

> +/* Digital interface - DA from slot mapping */
> +static const char * const enum_da_from_slot_map[] =3D {"SLOT0",
> +					"SLOT1",

Indentation.  Also are you sure that this isn't DAPM stuff?

> +	SOC_ENUM("Earpiece DAC Low Power Playback Switch",
> +		soc_enum_eardaclowpow),

These aren't switches, they're enums.  Switches are strictly boolean
things with values 0 and 1.

> +	snd_soc_update_bits(codec,
> +			REG_DIGIFCONF3,
> +			BMASK(REG_DIGIFCONF3_IF1MASTER),
> +			BMASK(REG_DIGIFCONF3_IF1MASTER));

You're unconditionally setting these bits?

> +	snd_soc_update_bits(codec, REG_DIGIFCONF4, clr_mask, set_mask);

Either clr_mask and set_mask are misnamed or this doesn't do what you
think it does.  The bits specified by the third argument are set to the
values given in the fourth argument.  It looks like the code thinks that
the bits in the third argument will be cleared and the bits in the
fourth argument will be set.

> +static int ab8500_codec_set_word_length_if1(struct snd_soc_codec *codec,=
 unsigned int wl)
> +{

Just inline stuff like this.

> +static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec *codec, u=
nsigned int delay)

This too.

> +/* Configures audio macrocell into the AB8500 Chip */
> +static int ab8500_codec_configure_audio_macrocell(struct snd_soc_codec *=
codec)
> +{
> +	u8 value8;
> +	unsigned int value;
> +	int status;
> +
> +	status =3D ab8500_sysctrl_write(AB8500_STW4500CTRL3,
> +		AB8500_STW4500CTRL3_CLK32KOUT2DIS | AB8500_STW4500CTRL3_RESETAUDN,
> +		AB8500_STW4500CTRL3_RESETAUDN);
> +	if (status < 0)
> +		return status;

You're just unconditionally setting these values - shouldn't they be
platform data?

> +static int ab8500_codec_add_widgets(struct snd_soc_codec *codec)
> +{
> +	int status;
> +
> +	status =3D snd_soc_dapm_new_controls(&codec->dapm, ab8500_dapm_widgets,
> +			ARRAY_SIZE(ab8500_dapm_widgets));

Just point at the tables from the snd_soc_codec and remove all this
code.

> +static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substrea=
m,
> +		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
> +{
> +	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
> +
> +	return 0;
> +}

Remove all empty functions.
> +
> +struct snd_soc_dai_driver ab8500_codec_dai[] =3D {
> +	{
> +		.name =3D "ab8500-codec-dai.0",
> +		.id =3D 0,
> +		.playback =3D {
> +			.stream_name =3D "ab8500_0p",

You should hook up the links to the widgets using DAPM routes, currently
you're using the implicitly created routes from the stream name which is
still supported but isn't best practice.

> +static int ab8500_codec_remove(struct snd_soc_codec *codec)
> +{
> +	dev_dbg(codec->dev, "%s Enter.\n", __func__);
> +
> +	snd_soc_dapm_free(&codec->dapm);

Why are you doing this?

> +	/* Create register cache */
> +	ab8500_codec_driver.reg_cache_size =3D AB8500_LAST_REG - AB8500_FIRST_R=
EG;
> +	ab8500_codec_driver.reg_cache_default =3D
> +		kzalloc(ab8500_codec_driver.reg_cache_size * sizeof(u8), GFP_KERNEL);

The driver struct should be constant, the stuff you're initialising it
with here is compile time constant - why are you doing this dynamically
at runtime/

> +
> +	/* Create driver private-data struct */
> +	drvdata =3D kzalloc(sizeof(struct ab8500_codec_drvdata), GFP_KERNEL);

Anything you do alloc should be devm_kzalloc().

> +	struct ab8500_codec_drvdata *drvdata =3D dev_get_drvdata(&pdev->dev);
> +
> +	dev_info(&pdev->dev, "%s Enter.\n", __func__);
> +
> +	kfree(ab8500_codec_driver.reg_cache_default);
> +
> +	kfree(drvdata->virt_reg_cache);
> +	kfree(drvdata);
> +
> +	snd_soc_unregister_codec(&pdev->dev);

This would avoid issues like this where you free the data the device
uses before you free the device.

> +static int __devinit ab8500_codec_platform_driver_init(void)

module_platform_driver.

> +/* Extended interface for codec-driver */
> +
> +int ab8500_audio_power_control(struct snd_soc_codec *codec, bool power_o=
n);
> +int ab8500_audio_set_word_length(struct snd_soc_dai *dai, unsigned int w=
l);
> +int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai, unsigned int del=
ay);
> +int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
> +			unsigned int fmt,
> +			unsigned int wl,
> +			unsigned int delay);
> +void ab8500_audio_anc_configure(struct snd_soc_codec *codec,
> +			bool apply_fir, bool apply_iir);

No, you shouldn't be exporting this stuff - it all looks like basic
framework stuff.

> +/* Virtual register base
> + * This address should be located above any physical register used by AS=
oC.
> + * It is used to map virtual registers needed by the codec-driver.
> + */
> +#define VIRT_REG_BASE				0x3000

Why are you doing this virtual register stuff?

> +#define REG_DAPATHCONF_ENDACHSL			5

All these constants need to be driver local or namespaced (preferrably
namespaced whatever).

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX84CAAoJEBus8iNuMP3dSLYP/033B+H/w8FN5O/L/UAdvTca
dWnafxX2PoG3Qq1nq/51rankCMlZKmZ9xUxvr3kkRV54q7LtlDVILNZ4kZinncwU
erhx4HB1T5+dNcmsO1I+u8jLofUNuOH/e1wThYnUt1t/bqoxCpkPhvZEXIcgHeUp
eUqma6YM90jPUuRh4IZQwVcQUFCoc2mB4GnvptKOND76z5wp7yO/x2yRaIst5QZ9
cZdlkB/QirnoTGC+/57StbW6P4uJtdiolZqet+0b82B8jJgGFGSX/ELGofeLyosx
+FvtVFZ4m6ia/svsg1elZR57bOFJDSSPD5P52f/FkOm+CwiYMuLj06pl3pnqefjQ
/eZU1kTQHdcuK53mv2fHKPge0rK2IUyktKeiLnQe7g7LhOB59pJ0vyvNbB7tBY+d
wL8y1dgdixlxn1Y1tcYHEhLJsvHIUP9iUWVTapKaVbdj5g5j6qu4Ad5r508+Qv5I
ywJnt/ucLj9PZXQJumznygthxdPeoYbzlafNfrd2Bj95ZrKmnTAQX+hqac7wcaKY
nTh/SV+zWC2S8v7QI1TE/KKyZeI4n3liJivfBmdqMjtnE7CK5fYbbPiGU3cEZeJr
8GG2QpcypZRpUh1J7xblvRn1hD5l8FUxI7cHZchiC7ySJNm0EVXtjvMOCN3Dxgxj
KaxygXsjK7oRTEYK121+
=T/YW
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--

--===============8765154506024522409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8765154506024522409==--
