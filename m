From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: davinci-mcasp: Improved
	suspend/resume support
Date: Thu, 2 Oct 2014 11:56:52 +0100
Message-ID: <20141002105652.GR4273@sirena.org.uk>
References: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
 <20141001160240.GC4273@sirena.org.uk> <542CFCFB.4060709@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4025705393419802501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1C45261563
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 12:57:07 +0200 (CEST)
In-Reply-To: <542CFCFB.4060709@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4025705393419802501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3NPeJodHuZECfqv"
Content-Disposition: inline


--u3NPeJodHuZECfqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2014 at 10:21:31AM +0300, Peter Ujfalusi wrote:
> On 10/01/2014 07:02 PM, Mark Brown wrote:

> > Applied both, thanks.  Might be worth converting to regmap and using the
> > cache code?

> Yes, it is in my to-do list. One thing I'm a bit puzzled currently is on how
> to handle the serializer registers. Depending on the SoC the McASP is
> integrated in we can have different number of serializers, also in some SoC
> different McASP ports have different number of serializers. I do not want to
> have separate regmap struct for all of these (which would most probably means
> different compatible flag in DT). I also want to avoid wiring in some max
> limit of the serializer registers. But probably I need to do this at the end.

This sort of thing is why the access stuff is done with functions and
get the device passed in, though max_register is still just a number.
I don't know if that'll particularly help or not.

--u3NPeJodHuZECfqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULS90AAoJECTWi3JdVIfQ+Z0H/1onnLPGO5Si9IiO5HKV/bbV
V6CZZTnVWtdnxontOQYQ9xvxdsyqRju1LhcUIXzeUZV6mks2uLuWsY1XKMt/nwX9
FfJjG7l4Ijxgo9asEgyBClD7shYAr6MprPjHgiviCVjwXuaGXOQbsZnTIUyziA6r
KXxjP2/Y9UI/vtnQzLt9yjtQsKI54f91n/AhXFOJlBwx1OXDXzk6+1GEq3RxVwMU
emi8honpaCX3E9sTyP1+/sqz7bNWSpONhsbgmWmf3jaRL3ssgOiiKCZkUwGIZvEU
AunC6asqOluKZd+gBOYJi6FrtNpyKgmb3LPEBM0n/iHWotFvvlzdlGv7NBAm0Fw=
=Zl+h
-----END PGP SIGNATURE-----

--u3NPeJodHuZECfqv--

--===============4025705393419802501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4025705393419802501==--
