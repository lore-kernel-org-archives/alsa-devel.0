From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Sat, 12 Mar 2016 12:53:17 +0700
Message-ID: <20160312055317.GT3898@sirena.org.uk>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
 <20160222031944.GT18327@sirena.org.uk>
 <20160311225937.GA27257@panicking>
 <20160311230930.GB27257@panicking>
 <20160311232856.GC27257@panicking>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160311232856.GC27257@panicking>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 12, 2016 at 12:29:00AM +0100, Michael Trimarchi wrote:

> diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2=
c.c
> index 4118106..609f07f 100644
> --- a/sound/soc/codecs/pcm179x-i2c.c
> +++ b/sound/soc/codecs/pcm179x-i2c.c
> @@ -44,12 +44,6 @@ static int pcm179x_i2c_remove(struct i2c_client *clien=
t)
>  	return pcm179x_common_exit(&client->dev);
>  }
> =20
> -static const struct of_device_id pcm179x_of_match[] =3D {
> -	{ .compatible =3D "ti,pcm1792a", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> -

One effect of moving this out of the I2C driver is to break module
autoloading: currently modutils does not pay attention to the reference
=66rom the driver structure to the ID table but instead just looks at the
MODULE_DEVICE_TABLE.  This is a problem with some existing devices but
we shouldn't introduce new instances.

I don't actually know if MODULE_DEVICE_TABLE can reference an object in
a different file off the top of my head, though a brief test suggests it
has issues.

> +static int pcm179x_startup(struct snd_pcm_substream *substream,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	struct pcm179x_private *priv =3D snd_soc_codec_get_drvdata(codec);
> +	u64 formats =3D PCM1792A_FORMATS;
> +
> +	switch (priv->codec_model) {
> +	case PCM1795:
> +		formats =3D PCM1795_FORMATS;
> +		break;

It would be more data driven to just register a different DAI structure
for the 1795.  Both approaches work, it's just a little nicer to avoid
code where possible.

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW467JAAoJECTWi3JdVIfQDYUH/R+mYlu9kVevy7EmXdMj3qCy
bVzrDCOV+M0qmXMqUGMcGdssHbWoW0SI34IfXmmFf3wue/grLc5jdsTe1xbZ1bG3
RDLo3JFhgutBT5mqx1VjpIu7cWVCQAQhhOD7kwpAYSWzFsiVWnf/WcIa6rC2DmGL
UgwjK+Dv8ddfdk5Tb+BMeHsm3JPn7+eWB8/CSrCz7ysCqudBhxHx8mNoOUoZswFz
6nRCqHV7K5JhdpUO4brPqAoEjGZRov2JcRk5V02jZDyZlBEohbl2xl03GV7pLFZK
4ZrScYpPWJEXw2wa3YjYxexMKcHm9lKHRs1aKj/ArkqrEW6J8DqN0KoMnFY/Dac=
=ODrI
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
