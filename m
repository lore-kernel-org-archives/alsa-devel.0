From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: add rt5514 codec driver
Date: Fri, 29 Jan 2016 01:14:45 +0100
Message-ID: <20160129001445.GL4130@sirena.org.uk>
References: <1453204948-21945-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7258370908039584926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3835A2614CB
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:14:58 +0100 (CET)
In-Reply-To: <1453204948-21945-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7258370908039584926==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 08:02:28PM +0800, Oder Chiou wrote:

> +	pr_warn("Base clock rate %d is too high\n", rate);
> +	return -EINVAL;

dev_warn()

> +static int rt5514_adc_power_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D snd_soc_dapm_to_codec(w->dapm);
> +	struct rt5514_priv *rt5514 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA1,
> +			RT5514_POW_LDO18_IN | RT5514_POW_LDO18_ADC |
> +			RT5514_POW_LDO21 | RT5514_POW_BG_LDO18_IN |
> +			RT5514_POW_BG_LDO21,
> +			RT5514_POW_LDO18_IN | RT5514_POW_LDO18_ADC |
> +			RT5514_POW_LDO21 | RT5514_POW_BG_LDO18_IN |
> +			RT5514_POW_BG_LDO21);
> +		regmap_update_bits(rt5514->regmap, RT5514_PWR_ANA2,
> +			RT5514_POW_BG_MBIAS | RT5514_POW_MBIAS |
> +			RT5514_POW_VREF2 | RT5514_POW_VREF1,
> +			RT5514_POW_BG_MBIAS | RT5514_POW_MBIAS |
> +			RT5514_POW_VREF2 | RT5514_POW_VREF1);

This looks suspicously like there are a lot of supplies here that could
be handled by supply widgets?

> +	bclk_ms =3D frame_size > 32 ? 1 : 0;

Please write normal if statements, it makes things easier to read.

> +static int rt5514_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int rt5514_suspend(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +
> +static int rt5514_resume(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Just remove empty functions.

> +static int rt5514_i2c_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct i2c_client *client =3D context;
> +	struct rt5514_priv *rt5514 =3D i2c_get_clientdata(client);
> +
> +	regmap_read(rt5514->regmap_physical, reg | RT5514_DSP_MAPPING, val);

Some comments or something in the changelog explaining what's going on
with this multi-level register map would be good.  The naming of these
functions is a bit odd, I'd expect _i2c_ for the physical regmap but
actually these are for accessing the DSP register map AIUI?

I *think* this is OK but the explanation would help me be sure (and
hopefully anyone working with the driver in the future).

> +static void rt5514_reset(struct rt5514_priv *rt5514)
> +{
> +	regmap_write(rt5514->regmap_physical, 0x1800101c, 0x00000000);
> +	regmap_write(rt5514->regmap_physical, 0x18001100, 0x0000031f);

This is a fun set of magic numbers!  I'm wondering if it might be better
as a regmap patch?  Normally patches are corrections to the register
settings that get applied after something is reset but perhaps this=20
also applies here (or to some of the sequence)...  It's the fact that
it's a large set of magic numbers getting written in around reset, it
looks like some of the purpose is the same.

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqq7zAAoJECTWi3JdVIfQTzIH/jI/2wywjCFOsI1GXItgioOP
rwTTLpi9fe5//rR+xzqEhMFrHwMZXi48+yw6v7ABH+Gc1671IcMODgxloKqmhetK
ebteEOWdycq1D0AW7crWW5nj4A2CkGUBWMfe8TDKQjAuG0pM9QWx1fWHt2FdCuL0
OzlCVMJmO18ytLUwDODseF48BUB7Ktk4PDfgdjOA5QFfHpm9XAdNnQyrAfhTJNwG
UC9SahDP+yiO8qdxl1Lf1Qzs7dMRAG7lpgflDD40TqNFi/PVZO1eBvcio8h52VNH
A8972pyQLsZc3WrE5elywF8XIcZRXfQroHCmJCRExSsv4doeLF9FQv9e4dg8P0A=
=lWLQ
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--

--===============7258370908039584926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7258370908039584926==--
