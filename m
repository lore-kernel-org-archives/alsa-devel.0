From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: Handle multiple codecs with split
 playback / capture
Date: Mon, 17 Aug 2015 13:44:48 -0700
Message-ID: <20150817204448.GC10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
 <20150814155223.GO10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170922420.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2307813874365563319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 59ADF26042F
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 22:44:52 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508170922420.27635@lnxricardw1.se.axis.com>
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


--===============2307813874365563319==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BCQW4u8rtOzpP30D"
Content-Disposition: inline


--BCQW4u8rtOzpP30D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:02:29AM +0200, Ricard Wanderlof wrote:
> On Fri, 14 Aug 2015, Mark Brown wrote:
> > On Thu, Aug 13, 2015 at 04:12:56PM +0200, Ricard Wanderlof wrote:

> Should the commit message have any information as to which specific use=
=20
> case led to the creation of the patch?

That's often good to mention, yes.

> > > +	return !!codec_stream->rates;

> > The !! is redundant here.

> I still felt it made sense as rates is an int and the function actually=
=20
> returns a bool, i.e. the !! indicates to a human reader that the author o=
f=20
> the function is aware that rates is not a bool yet the function is=20
> declared as one.

It's sufficiently obvious that you're just checking if rates has
anything set at all here I think.

> > > @@ -827,6 +859,10 @@ static int soc_pcm_hw_params(struct snd_pcm_subs=
tream *substream,
> > >  		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
> > >  		struct snd_pcm_hw_params codec_params;

> > > +		/* Skip codecs which don't support the current stream type. */
> > > +		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
> > > +			continue;

> > >  		/* copy params for each codec */
> > >  		codec_params =3D *params;

> > We're still calling hw_params() for all CODECs, even ones that happen to
> > not be suitable...  is that sensible?=20

> Hm, how so, the soc_dai_hw_params(..., codec_dai) is further on inside th=
e=20
> loop so the continue skips over it?

> However, if nothing matches, soc_dai_hw_params(..., cpu_dai) would still=
=20
> be called, just after the loop, which might not make sense.=20

I think that's the bit I was thinking of, sorry.

> > It might be in a case where the CODEC for one direction clocks=20
> > everything but I can see problems occurring if the transmit and receive=
=20
> > paths are separately clocked which is going to be quite common for=20
> > things like i.MX systems.  If the two are tied together there's going t=
o=20
> > be constraints between the two directions.

> > I'd expect that we could take a pretty good guess as to what the best
> > thing to do is based on the symmetry constraints we have for the link
> > but I think we do want to think about this early.

> I guess it would be better just to 'goto out' after the loop if a suitabl=
e=20
> codec could not be found.

Well, there's two things here: one is if we've got a completely invalid
configuration with no CODECs being configured and the other is if we
should only be configuring matching CODECs in the first place.  For
systems where the LRCLK and BCLK are shared between playback and capture
we may want to always configure them even if the CODEC driving the
clocks isn't the one handling the audio.

--BCQW4u8rtOzpP30D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0ke/AAoJECTWi3JdVIfQIOkH/16SvJiEDJogq8lhi6RyBcYo
W5ftNjTXsB9cqOlsJVqEJIyQsvm+veny3SxI+Z93Zv/d686bpJOmpeKZQogZPvpq
MV8PBzQtH6k2ReH2sHmybTPw7afsWSvTxkQs6YSC1ZUfZijlDaNCh5t9uwevsA2u
+UssdXSgv4YHnU9ZZXq5Y3IcYvWICJNGyjhoGiW02EqQe13nb3I+oi+2P0XOEnsT
ibLyBHJeOeiYsOMZ+m0bA46vcBPMTf1gGNl2OIK7iBVM73kR2Q4a6mwwRzJIg/Ra
N5yHoRss/59V+USIHJ9oAGliIYhdThhNiZLI+F4+6Jy1isMNhEYlNwoF3v8autg=
=OG/M
-----END PGP SIGNATURE-----

--BCQW4u8rtOzpP30D--

--===============2307813874365563319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2307813874365563319==--
