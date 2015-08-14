From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: Handle multiple codecs with split
 playback / capture
Date: Fri, 14 Aug 2015 16:52:23 +0100
Message-ID: <20150814155223.GO10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9004212233684860447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D4DF26649A
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:33 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9004212233684860447==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HJakWL7yBo69DI1O"
Content-Disposition: inline


--HJakWL7yBo69DI1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 04:12:56PM +0200, Ricard Wanderlof wrote:

> (Referring to this thread:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093214.htm=
l)

I shouldn't need to read another mailing list thread as the first part
of a commit log, and if referring to external information you should
always include a human readable description of what you're referring to
so that people can understand your message without having to start
another program.  As it is I'm in a plane over the Atlantic so I can't
tell what you're talking about here, sorry.

> As noted in the thread, there might be more places where the new

Please write the commit log to describe the change without needing to
refer to other threads.

>  /**
> + * snd_soc_dai_stream_valid() - check if a DAI supports the given stream
> + *
> + * @dai: The DAI to check for stream support
> + * @stream: The stream type (playback / capture) to check for

You're adding externally readable kerneldoc on a static function so
nothing outside this file can use it.

> + *
> + * Checks if the DAI in question supports the indicated stream type.
> + * Needed to skip over codecs when iterating over
> + * snd_soc_pcm_runtime->codec_dais in order to skip codecs that are play=
back-
> + * or capture-only, which would otherwise inhibit capture or playback,
> + * respectively, to the other codec in a multiple codec / common I2S bus
> + * environment.
> + */

This mostly seems to describe a potential use of this function, not what
it is supposed to do.

> +static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
> +{
> +	struct snd_soc_pcm_stream *codec_stream;
> +
> +	if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		codec_stream =3D &dai->driver->playback;
> +	else
> +		codec_stream =3D &dai->driver->capture;
> +
> +	/* If the codec specifies any rate at all, it supports the stream. */
> +	return !!codec_stream->rates;

The !! is redundant here.

>  	/* first calculate min/max only for CODECs in the DAI link */
>  	for (i =3D 0; i < rtd->num_codecs; i++) {
> +
> +		/* Skip codecs which don't support the current stream type. */
> +		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
> +					      substream->stream))
> +			continue;
> +
>  		codec_dai_drv =3D rtd->codec_dais[i]->driver;
>  		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>  			codec_stream =3D &codec_dai_drv->playback;

So what happens if we end up in these loops and nothing matches?  It'd
be good to document the considerations there.

> @@ -827,6 +859,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substrea=
m *substream,
>  		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>  		struct snd_pcm_hw_params codec_params;
> =20
> +		/* Skip codecs which don't support the current stream type. */
> +		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
> +			continue;
> +
>  		/* copy params for each codec */
>  		codec_params =3D *params;

We're still calling hw_params() for all CODECs, even ones that happen to
not be suitable...  is that sensible?  It might be in a case where the
CODEC for one direction clocks everything but I can see problems
occurring if the transmit and receive paths are separately clocked which
is going to be quite common for things like i.MX systems.  If the two
are tied together there's going to be constraints between the two
directions.

I'd expect that we could take a pretty good guess as to what the best
thing to do is based on the symmetry constraints we have for the link
but I think we do want to think about this early.

--HJakWL7yBo69DI1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzg6zAAoJECTWi3JdVIfQTlcH/0+ncrtOsi6toz8aAPXlcwd1
v7L2ebZAgPmjY3mD1vnru7fGcL9AuizKt9ASxyy7Lh26rLG0goZEIJ9ROn1sU0xv
SfeF79+aFEK+e6bZjPT0piZfB+ZGVFYgcdZpR+0zz3p8/Gjq+8sJ0Bcvivq0T9sm
B8xq278Mg5vDgDFQAwoypLdp9mniYewZHi170IWRbs/Lbtq99So7VrXAxHChZOIY
lU7Q4MFwF201m9zaiMy7LdpKIkgkPgK5WJfL1toRx5BDwcmSvs7LMEMPft8/2PZ7
NZSqTzt6DwtnCfz8egMNernOlQI3jsmqE/QdyGqR5kIVZ0CFr9u34wggst+cvqY=
=YWmQ
-----END PGP SIGNATURE-----

--HJakWL7yBo69DI1O--

--===============9004212233684860447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9004212233684860447==--
