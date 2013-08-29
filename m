From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Add ADAU1X61 and ADAU1X81 CODECs
	common code
Date: Thu, 29 Aug 2013 11:13:59 +0100
Message-ID: <20130829101359.GR10783@sirena.org.uk>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
 <20130828165957.GL10783@sirena.org.uk>
 <521EFF1B.9070202@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1929041062017207063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2880E261706
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 12:14:02 +0200 (CEST)
In-Reply-To: <521EFF1B.9070202@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1929041062017207063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwSwrS9OkH+FvIfA"
Content-Disposition: inline


--rwSwrS9OkH+FvIfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 09:58:19AM +0200, Lars-Peter Clausen wrote:

> It would be nice if this could be handled by the core. But how? One option
> might be tracking the the DAI format in the core and power up the DAI widget
> in DAPM if the stream is active regardless of if there is an active path if
> the DAI is in master mode. That may power up more than what is needed
> though. E.g. for this CODEC the clock generator and the rest of the DAI can
> be powered up independently and we only need to power up the clock generator.

Yes, that was what I was thinking of.  We can provide a mechanism to
allow the driver to specify a specific widget for the clocks if one
exists and fall back on the DAI widgets otherwise.

> >> +static int adau17x1_set_dai_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> >> +{

> > What's this doing?  It'd be better to have a specific ID and check that
> > too.

> Setting the relationship between the external clock rate and the internal
> base sample rate. There might be a better way to do this though.

If it's specifying two clock rates then specifying them both as actual
rates might make sense.  I take it it's not possible for the driver to
automatically figure out what the most sensible rate is?

> >> +int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
> >> +	enum adau17x1_micbias_voltage micbias)

> > When would a machine driver use this (as opposed to just letting it be
> > set by platform data)?

> It is not meant to be used by machine drivers, but by the adau1761 and
> adau1781 CODEC drivers, which set the micbias based on platform data.

Ah, in that case how about having generic platform data for the core and
just passing that through to a platform data parsing function?

--rwSwrS9OkH+FvIfA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHx7kAAoJELSic+t+oim92ZMP/ApX4KX0y4YJ2RQrKSjYIAWC
tHmLRBfjNK1cGv0IbtksPC52R5uwIeAQeLSWC41fGenDK7nwc3T4SadwVLkaF/Zd
vrH2dhIL/JVz0R8lNFrx4KP+tVHFS34RF2YX1YbK7VBU+xT1B72jpIUZ7BTMIejQ
jsrdAZknRaBA5tVjwSx+qWck48sQGe5D/BuvQNTXghEruZRp5OwIP/ycvWeBK6om
TSALWYh+qWtkuVktE1meg0H5Qxhlr42f+rDFer4iFqRZKmBJ9vQE5eTQxqINSTok
UT9bLglGFUguCehvBU4KozRCe9pxijZWNVYO7FMR+rVR84hI+wnCtYxi3lA6IUJA
ZZT3MGfAIzXGqVilQDAIBbv4TI8aHH27HkcbzqLllze3Bx6c3DJWthtMr8bJ1WOy
aML1jWqzR9kg7Ohu3WlP0eAOVnifRP+G4vWiE/LzLZFkXNTUJK9hk4S/yRlw4lms
Jtd67xQYZLZw/dMIak4zpJTzzEX9Qz9WeEATIZzAEuNj1lb40p7wKrM586Iq5LU0
l7lO//NLzqrC+u8ArnHHJDjNoV1Uz028dcY+V6iIy5DYVokfCMdXRTce2hEJt0Q5
RZjayjUOjd0hm4GTRuThIsSaqlOdTz9Svqc5+QeSb9HPER939GlQRpMazRybDyD+
iu0jOjedp0DtmAB4HbZQ
=+Mf9
-----END PGP SIGNATURE-----

--rwSwrS9OkH+FvIfA--

--===============1929041062017207063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1929041062017207063==--
