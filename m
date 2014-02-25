From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Tue, 25 Feb 2014 12:52:32 +0900
Message-ID: <20140225035232.GQ25940@sirena.org.uk>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
 <20140224160648.GC6132@MrMyself>
 <20140225000027.GI25940@sirena.org.uk>
 <20140225023840.GB7229@MrMyself>
 <20140225030947.GO25940@sirena.org.uk>
 <20140225031313.GA7343@MrMyself>
 <20140225033929.GP25940@sirena.org.uk>
 <20140225034635.GB7343@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHaz2YzBa9+c1qrr"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140225034635.GB7343@MrMyself>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--eHaz2YzBa9+c1qrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 11:46:36AM +0800, Nicolin Chen wrote:
> On Tue, Feb 25, 2014 at 12:39:29PM +0900, Mark Brown wrote:

> > So register it from the ESAI driver then.

> Then I think I need to find a way to pass the clock to CODEC driver...

Won't the normal DT mechanisms work here?  I'd expect them to, you can
already have multiple clock providers in a system.

--eHaz2YzBa9+c1qrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDBN9AAoJELSic+t+oim9m3oP/ian+E4E5/TnFFWXIno4wPjB
MYT4qXoRvOAbHbGslnckXf9gPGuYPGRa6pjLwWPdby6qq/SdSxXk196NPcy9+Xi2
dbNN3/bjWhEzmNW+qQ02dPFln0TIakr00wB5NOSiQUv4iDp94YXFnZ6lheWfUj8L
b06gkitHdWCsJkbOwzB3hyaXKCPL0Q1Nww+bi7/SR3IMJnGTXks6IVdfu3Ex71hx
Kp75/0AYV3HgUHkDJa6LRLhc2r8sGpcqylZLRoHAxYL+JXKP2CCx1A5L9F5WBlUJ
eFCgdxm8z22wp/7DuRZQQyTH47qc87kQ9vP8qXDeplP94Jk/LvyTJWmTOX98oMZ7
et1fl34n3CrqaAieHwhkBk9emL7eCy1LGQA4c6YKZi9tLPCKm3cH3vxs3VDeNLTI
RyEhGRBLQ2I9561D/0UM8Q6CFVCI/Ny71moFr8JCqR0yKFwXZjb0UoGxPnMUh5hF
2MN/yMOy+edP0hPF9QDfqH4fZIn6t8nCBqNEI3gvM8vfS9RXCEDGxDenmlhJI/UD
8yq4OKPQrfxMBgOR2MRrKZm6qfxmOwQjp6SEA4BzavVz53pisp/bJJuDVJbp4NSv
TZMtud3Na3XjuVXCrDd1QrRGz6AQ/wUzHbpqy3KdYQHO5zGY5rlWAZeGet0VUyKN
e/wPB/sLt1rhupy6boXE
=l608
-----END PGP SIGNATURE-----

--eHaz2YzBa9+c1qrr--
