From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm: Mostly constify constraints
Date: Thu, 5 Jul 2012 12:14:41 +0100
Message-ID: <20120705111441.GR4111@opensource.wolfsonmicro.com>
References: <1341423313-9561-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhatm4rgp.wl%tiwai@suse.de>
	<20120705092841.GI4111@opensource.wolfsonmicro.com>
	<s5hehoqleg7.wl%tiwai@suse.de>
	<20120705103527.GM4111@opensource.wolfsonmicro.com>
	<s5h8veylcce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4621884832505896346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 139D0244E1
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 13:14:43 +0200 (CEST)
In-Reply-To: <s5h8veylcce.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4621884832505896346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P6nFlVIU+yrLqGt6"
Content-Disposition: inline


--P6nFlVIU+yrLqGt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 12:41:05PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Well, it's mostly const - it's const unless the rule itself starts
> > fiddling with stuff which I'd have expected to be the exception rather
> > than the rule.

> Well, the only rule is that rule (function) rules the meaning of the
> private pointer :)

Ugh, that's pretty vile really.  But anyway...

--P6nFlVIU+yrLqGt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9XcHAAoJEBus8iNuMP3dClwP/AyilCJBJdzgPq6BUmdDOOrQ
y7/dNTrSZ1KtIUyusjU2r4t9odQ2eWKVG5KAjXdgVPvZVSuWWqg62jNbsNPOTm6+
ORLfWSkVyMzHgif468VflvuAxdGgoWfAWSyyHriz53Lqt03YLmdoJBj8Kw/EJDbi
7EO1ZUxlaIFx1iPienAO5ZgC+7DlHQMr/VY80ewdHBfAv+RxNSy+fjqO+6PoaEfQ
X7VvkGMbj1uxSjYgyLKGtfiKSr1PujDjpFylD0yEY0oVgz3CsS0ccG54dlCZKpF8
yn8chRfNZvbDXG57Ng+irLc/fIXT6XrQQdDYLmFj45NXV13V6bZCJ5XRg73tv6qv
pqgEcHboKdwdo5VEoAs7XYBvd3JvDZtkR5VR3pdp5olMsC0g2foXIbnUYaJ26Nfn
/txpIl4dKVpGBR3YYGWeidPvOnlt+kliRQYCULIZPXjsDd957MkfOrsVrKioGRxq
u+MWy3uBeNgZ6G/3PBINNA0fiZ+rVYd0rnz4yvMHQbCVQl+nosd4oEPethKirEz/
ivTFAmkg+cyvzjfs+Cd68Rb+HREXiGQOlUjma6GyXh/pR/MJR6aKwJm8NHPEl4K5
eP6Fu2OPo5frxo8SrV3Ocf33+TrKPOMa4sS1rRzz6qBkEzzLr/Stw0NLhbvsubeM
cNliX6fSPz/4ruly+PGH
=IWPD
-----END PGP SIGNATURE-----

--P6nFlVIU+yrLqGt6--

--===============4621884832505896346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4621884832505896346==--
