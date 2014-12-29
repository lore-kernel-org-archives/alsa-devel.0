From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Mon, 29 Dec 2014 16:52:46 +0000
Message-ID: <20141229165246.GZ17800@sirena.org.uk>
References: <cover.1414053169.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cqgibCT2eNae4+Dl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1414053169.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--cqgibCT2eNae4+Dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 23, 2014 at 10:32:49AM +0200, Jean-Francois Moine wrote:
> The NXP TDA998x HDMI transmitter may transmit audio to the HDMI link
> from 2 different sources, I2S and S/PDIF.

So, I'm not seeing *any* interest here from any other HDMI users.  This
is a continuing theme with HDMI patches and is really very concerning,
everyone appears to be working in their own bubbles coming up with their
own things and ignoring everyone else's work - what little review I'm
seeing seems to be happening only after I explicitly prompt it.  I'm
following up to Jean-Francois' patches here but this isn't specific to
them, it seems like a general thing with HDMI code.

This in turn makes me think there's some abstraction problems with
what's going on and we're going to have to go through yet more
refactorings to fix things up as we do manage to come up with better
abstractions.  What I'd really like to see as a bare minimum is some
visible conversation about what we're doing and sign that people are
at least keeping in mind generic solutions when working on HDMI code.
Some commentary on the similarities and differences between hardware
and which abstractions work with which devices would also be really
helpful in working out if we're going in the right direction.

Basically at the minute I'm worried that we may be making the problems
we've got here worse not better, I've not personally had the time to sit
down and study the hardware sufficiently to form a firm impression
myself which isn't helping.

--cqgibCT2eNae4+Dl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoYbZAAoJECTWi3JdVIfQkIEH/2fiNrgDHQawYRxNQhcbJwSy
ITPRwYBq4D3kay1+XiR7FfxVtHaOJO7sRRQmjeB41tBzMjuir5b238ZaIfYKJK3k
YEPB46yaSXAbW4DbjDaLO5ul+4ZlW6rZRAiungYq3QAROrvfS2kjM5tM1fDSyd/a
NHRYB0NxvWCd9tfZFChGWIIsupHeHtNF7lFfwgrR0ve02ACbgLpN0Su7DScu0NJ2
csTwwcdNWT5lP5Op67GO5igshLBuZF/3Z4olTwTsguhWji1KuIeP5Sac49pbpdm4
qayMSgWnb2FRJx5EZHhdnvnpfa2+Bwka0n5dFmsvXwHfmMx8t3id3KqMGMlX0vE=
=3ShM
-----END PGP SIGNATURE-----

--cqgibCT2eNae4+Dl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
