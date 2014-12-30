From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Tue, 30 Dec 2014 17:10:32 +0000
Message-ID: <20141230171032.GQ17800@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4267432545023660948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA4026067A
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 18:10:42 +0100 (CET)
In-Reply-To: <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4267432545023660948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qgDdgraOM7qMRx0j"
Content-Disposition: inline


--qgDdgraOM7qMRx0j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 02:01:34AM +0000, Kuninori Morimoto wrote:

> I think I have not got comment/response about these patches.

>        17. ASoC: rsnd: add Synchronous SRC mode
>        19. ASoC: rsnd: add salvage support for under/over flow error on SRC

> Can you give me feedback ?

The problem with those is that they add the first patch adds explicit
controls for the rates which look awfully like the sort of thing people
are supposed to be doing using DPCM (I've said before these drivers
should be using that...).  I need to figure out if we have existing
controls which do this sort of thing in the driver at which point this
isn't so bad but still not good or if this is a new thing for the
driver.

--qgDdgraOM7qMRx0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotyHAAoJECTWi3JdVIfQ0i4H+gO2vd7W52DrPwgfhCcGzTFO
SZpAPEkhHmvOBx61Q1//xsrp4VRWN7XU3SvpugR1qWxll+RFnHmGo6xj0Ce+dZeu
acn5+8QWVZSQkNnB+qs6Q3wPFHIWlOxlykEgW3Z5KttMaC/JRD4LwEXYMpToDeIr
FHbc0u+4WklfYqazSbROdH3pumS4bEWkHNE/4ivX5gZiGrNT6ULFhLWMO3x4gOtO
0vKucnuKcxOg7QxLrMHq7vXQQ+pXJuBQAvYSvO3JS8Oq9uVxeSlTgmuCbSLCxywl
c9f9qxj0IYse3XLW+uapTK+XHVGlnr3kblFgE0V19oMC82tbBdP2HLIPZysFCiU=
=zDUH
-----END PGP SIGNATURE-----

--qgDdgraOM7qMRx0j--

--===============4267432545023660948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4267432545023660948==--
