From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Tue, 12 Dec 2017 16:32:54 +0000
Message-ID: <20171212163254.GL16323@sirena.org.uk>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8409770595384610688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B6D266DF0
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 17:32:56 +0100 (CET)
In-Reply-To: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8409770595384610688==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 01:54:25PM -0600, Steven Eckhoff wrote:
> Currently there is no support for the TSCS42xx audio CODEC.
>=20
> Add support for it.
>=20
> v5 attempts to address all issues raised in the previous reviews.
>=20
> Thank you to everyone who has invested their time reviewing these
> patches.

Please add inter-version changelogs and commentary like this after ---=20
as covered in SubmittingPatches - this lets tools know they don't need
to end up in git.

> +  - compatible : "tscs:tscs42xx"

Compatible strings should be for specific devices, they may all be
treated identically by software now but may not be in future.

> +		do {
> +			ret =3D snd_soc_read(codec, R_DACCRSTAT);
> +			if (ret < 0) {
> +				dev_err(codec->dev,
> +					"Failed to read stat (%d)\n", ret);
> +				return ret;
> +			}
> +		} while (ret);

There should be some sort of upper bound on how many times we'll try to
wait for this in case the hardware fails somehow.

> +static int tscs42xx_mute_stream(struct snd_soc_dai *dai, int mute, int s=
tream)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	int ret;
> +
> +	if (mute)
> +		if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			ret =3D dac_mute(codec);
> +		else
> +			ret =3D adc_mute(codec);
> +	else
> +		if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			ret =3D dac_unmute(codec);
> +		else
> +			ret =3D adc_unmute(codec);
> +
> +	return ret;
> +}

All these mute functions also shut down the PLLs which since...

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		ret =3D snd_soc_update_bits(codec, R_AIC1, RM_AIC1_MS,
> +				RV_AIC1_MS_MASTER);
> +		if (ret < 0)
> +			dev_err(codec->dev,
> +				"Failed to set codec DAI master (%d)\n", ret);
> +		else
> +			ret =3D 0;
> +		break;
> +	default:

=2E..we only support the CODEC being the clock master seems like it might
mean we stop clocking the DAI?  If that's the case it's better to just
not have the mute control and allow the user to just control these as
normal mutes.

> +static int tscs42xx_probe(struct snd_soc_codec *codec)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(r_inits); ++i) {
> +		ret =3D snd_soc_write(codec, r_inits[i].reg, r_inits[i].def);
> +		if (ret < 0) {
> +			dev_err(codec->dev,
> +				"Failed to write codec defaults (%d)\n", ret);
> +			return ret;
> +		}
> +	}

I'd expect the driver to just reset the CODEC (it appears to have that
feature) and the regmap.

> +static int tscs42xx_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Just remove empty functions.

> +static const struct i2c_device_id tscs42xx_i2c_id[] =3D {
> +	{ "tscs42xx", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tscs42xx_i2c_id);

I2C IDs are better as explicit part numbers too like compatible
strings.

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlowBLUACgkQJNaLcl1U
h9DJnQf8DmxQjDHBoPR0DQ3D0ImTYo6g08TpjxtQFvtHlObARs6oOSQwOgj7wipl
uBSbNgbKhMbCc1/CQXFHHRsHtlVDsXD1XxBI3H8igV7Gvmv1WAKoXwpSsSLvMLqV
kplLIyUn5CFBWEAlKxQdYtZ5e3tF0pQPSDdMVifMdx/ZYscy8gn8/vDcSC65m6W0
kyd50A1lGQIzOw63D2Q8UXTD0szep/OD1mdTUKhj2E2xSrdjpF+S76bmFGTzcEZ6
UfBl2oVijX/O4uCSx9FQvoO5Cscl6ltVAI03enPujnRTXslTFr+89NoqZVWQAw+b
HaXVwi6/ODdYSGRx3LftgikaMyLVCA==
=cQm6
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--

--===============8409770595384610688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8409770595384610688==--
