From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add NULL checks for the
	stream pointer
Date: Wed, 7 Jan 2015 11:18:11 +0000
Message-ID: <20150107111811.GV2634@sirena.org.uk>
References: <1420556647-17270-1-git-send-email-yang.jie@intel.com>
 <20150106172223.GE2634@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901B7FB6E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3373670964648143437=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3DCE260487
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 12:18:27 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901B7FB6E@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3373670964648143437==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lV0sGir0hZRRmFZQ"
Content-Disposition: inline


--lV0sGir0hZRRmFZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2015 at 12:53:24AM +0000, Jie, Yang wrote:

> > I'd be much happier if this warned in cases where it wasn't totally obvious that
> > attempting to use a NULL pointer is sensible.

> [Keyon] thanks for review, Mark. So you meant we should add some warning log here, right?

Yes, I'd be a lot happier with that - if there's some cases which happen
a lot and it makes sense that they happen a lot then the changelog
and/or the code should make it clear that those cases are OK but as a
default it seems better to at least say we ignored things.

--lV0sGir0hZRRmFZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrRXyAAoJECTWi3JdVIfQGfoH/0/tfAyf/aKzs35x4r3GVZUg
fL0MC3uRI5vpN0/GC2rmRJHv5fb6uCEW7rj5iGm0zX36KgdSYIIhqKbiY4FgSkpN
+D5CukRmDVg/qnjtpyIrhfJwlDeDhEm2b884xeDWUB2tAierihsSFu7O8zJmINKj
nxFWPs6IMpbAIAj2lwSWCtHAz0qrwkC1o1Syd7NXLlaRdIlz3F2hdliZxPV8v1V/
UU2SEC7Nkl/2dNDVOrEuARFTl5zi8c2qmjwvpEoANt/x3NTIxBuKUTDrtywawEdW
uysTskBqmzaf16MGSbF1mqhwGMvycaE/n1iny4CGodepdXO7+u34qClZggaGa8k=
=//H2
-----END PGP SIGNATURE-----

--lV0sGir0hZRRmFZQ--

--===============3373670964648143437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3373670964648143437==--
