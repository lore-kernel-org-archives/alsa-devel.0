From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: remove unnecessary mach/clock.h
Date: Tue, 24 Sep 2013 11:07:49 +0100
Message-ID: <20130924100749.GR21013@sirena.org.uk>
References: <87mwn2r5i7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7106177749787723639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BCE72619E5
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 12:49:00 +0200 (CEST)
In-Reply-To: <87mwn2r5i7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7106177749787723639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CyK+4APo+PILEYPp"
Content-Disposition: inline


--CyK+4APo+PILEYPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2013 at 01:25:08AM -0700, Kuninori Morimoto wrote:
> ${LINUX}/sound/soc/sh driver can be compiled from
> SuperH and ARM.
> but, ${LINUX}/sound/soc/sh/rcar driver included
> SH-ARM specific header.
> This patch removes it

Applied, thanks.

--CyK+4APo+PILEYPp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQWRyAAoJELSic+t+oim9bv0P/ijvEZmxAyD7JCRHefxwBQja
IeEaffm0MkMsrHod6DXwGjtatkPpAE9Ih6dyx5Y+eOKj9rr+gIhu1lRnHjWfnNqK
jI/TWV88FEDHoX83d3ufOc+n8/0a/j3f9qb1vW1WvBcR71qLmCt/dNxBQIq8lAFm
cAXaxuGJNuo1KFqAV75ddPWmjkt3VZ35CtuBhLN14/vVZ2y3PFe1Mh1ZhugmeQcu
3f+yxmWr+kdwxCR1ZdS64xqzcqpj8mYYDb/im3ZEeqeuDSgiXz6gezNNYEG66cpE
lftktG5t/fmxCQIuRdgx48mLKcaXpn2iJuL7lD89cMmghFtXyveACWZzCBsufb/8
VT0sySaLivqe7zvl1T8FSineeLx8t7mp2LZcx1vVhGfiyGjEvMfrUEAvxtisiFWG
kbbMRjb0xRhl1S+fklp854ehm/7vISQKCVKKdZfwprJh89YhJmGeI3SmIB6JaCKP
GOxjIJyC0EhY06kL+DmhXpSPwGpIdECudhiW/T74MiSnzZNS0cgN/t1oX7GHiXWT
EFxBvJuxuVqguyUrl+akAlqyoEBSIElAIPumsIXWUuLBj7TYsqqsfGK4KForcgkj
m6crqyFe7SjHc/mXyZxSHY2VZ9zwjX1e+Gch8QoIVafda8D7NJO0kiQ5aYJttUiP
B4PdvRb92Rf29gq5JGUr
=XE2q
-----END PGP SIGNATURE-----

--CyK+4APo+PILEYPp--

--===============7106177749787723639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7106177749787723639==--
