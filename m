From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Mon, 22 Feb 2016 12:19:44 +0900
Message-ID: <20160222031944.GT18327@sirena.org.uk>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LJuv+M/03Kgs6kNS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160205172451.GA30542@panicking>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--LJuv+M/03Kgs6kNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 06:24:57PM +0100, Michael Trimarchi wrote:

> +#define PCM1795	1
> +	unsigned int codec_model;

It looks like you're trying to define an enum here.

> +static const unsigned int codec_model = PCM1795;

That's a weird name to use here.  Call it pcm1795 or something, though
normally we just cast the integer to and from a pointer.

> +	{ .compatible = "ti,pcm1795",
> +	  .data = &codec_model,
> +	},

This is strange indentation, just keep it on one line and it's easier to
follow.

--LJuv+M/03Kgs6kNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyn5PAAoJECTWi3JdVIfQQqoH/j+slj+kg4UIkopgg2mdG74j
o2xQXOI/SPJgRRYknSlqfwhzb5UzSEwb8oHMFvthmcotjVkupTwEhzEg2gl+wHp9
2zLit0hNSjzwAhAz8JkzQZK2I0eZKbj+jCamVZH0nRldsvHMgP71dHc4TpFbXRX2
aHthUCXw0MusP6MvUFDp9ApJM685Wof7jscH2zKQVONZ2E3sNJGZotjcw6DZqWS8
1pt0tJEzWOLAxWsHMTEQ9q/eT1ULm7sSAtK1m/NM+pMUzVHasefyGfhzvLkqXXDC
Se52A+8HwwAk+m1Qf/1SQUq80OWSGwCY1+3oT872XRvlWdDP+3oPeQyKINwwQ5Q=
=OdqR
-----END PGP SIGNATURE-----

--LJuv+M/03Kgs6kNS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
