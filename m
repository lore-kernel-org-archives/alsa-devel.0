From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 19:27:07 +0000
Message-ID: <20171206192707.vurfm6whlzku3ifk@sirena.org.uk>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com>
 <20171206123908.GB1827@finisterre>
 <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
 <20171206172924.mrd233uipzorrymc@sirena.org.uk>
 <caea9bc4-94f3-41bc-5940-5769917962cf@ti.com>
 <20171206184219.fhhohxdihsm33kf6@sirena.org.uk>
 <d531a2c5-94d9-aa6f-dc6e-aeb22f70d746@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7354747956257761404=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 95CF1267048
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 20:27:09 +0100 (CET)
In-Reply-To: <d531a2c5-94d9-aa6f-dc6e-aeb22f70d746@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7354747956257761404==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b4n7johiy3urxrxp"
Content-Disposition: inline


--b4n7johiy3urxrxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 12:49:39PM -0600, Andrew F. Davis wrote:
> On 12/06/2017 12:42 PM, Mark Brown wrote:

> > We need to preserve old bindings to ensure DT compatiblity, the easiest
> > way to do that is to keep old machine drivers around.  There are plenty
> > of older drivers that wouldn't be accepted now but would at least need
> > replacing with a compatibility layer that adapts the bindings onto one
> > of the generic drivers.  That adaption layer would definitely be useful
> > (basically a big table of platform data) but it'd take time to implement
> > it.

> We then should at least start depreciating them now so that someday we
> can drop that stuff. Isolating them would be the first step.

Moving the drivers around is not going to help with that.  For users the
drivers are not deprecated until someone actually steps up and makes
something that allows the generic drivers to handle the old bindings and
moves them over, at which point we'd just remove things that have been
converted.  We can't just tell them not to use something without
providing an alternative.  For developers they're just going to end up
with the simpler machine drivers sitting next to a bunch of machine
drivers that reasonably exist which I'm not sure clarifies anything.
It's an orthogonal problem.

> > Wouldn't a few regexps in the MAINTAINERS file cover it?  We've already
> > got a bunch of vendors doing this.

> pcm*
> tas*
> tlv*
> twl*

> It's messy how many prefixes we have :/

Eh, not that bad.  And easy enough to do anyway.

--b4n7johiy3urxrxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooRIsACgkQJNaLcl1U
h9CZewf+IQXx4dMVO9FenqGUMRSkcjZmaOxpFnbp4eOe6gTl7TgaKT1CuRB/RJoV
2ZhsXiELa3h7Uop3OXg1MMnIcR8tQFHTRmf7wt39li4oXX+Pmg1RRycgoYAc6FPh
0UpcTLAEO9UuwXJ13kmdl60tKR3rXL7OsEcukEcaLgOqFB69MFXgQsaKXmP2UA1H
ApsHUfYlkPGNKTP8WK8emobT5h3/wfUHv5haemyKyLtCz1CU5OD0Nd9KYl0Z6w0W
rkaEpj4ah/8Q3SSU2VZhHQIgFzHrvFk/LTOd6N18QPx1JJrSXDqos7GoeSMWS7bi
R2xsLJ96hlWfxJtnX/mH3zc7ar3Bfw==
=J+c3
-----END PGP SIGNATURE-----

--b4n7johiy3urxrxp--

--===============7354747956257761404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7354747956257761404==--
