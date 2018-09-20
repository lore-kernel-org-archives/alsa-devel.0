From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/11] ASoC: add for_each_component_all()
	macro
Date: Thu, 20 Sep 2018 10:32:55 -0700
Message-ID: <20180920173255.GA20825@sirena.org.uk>
References: <874lenr4a3.wl-kuninori.morimoto.gx@renesas.com>
 <87r2hrppjo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4109423196126647094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EAA912677BB
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:32:59 +0200 (CEST)
In-Reply-To: <87r2hrppjo.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4109423196126647094==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 01:30:10AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> To be more readable code, this patch adds
> new for_each_component_all() macro, and replace existing code to it.

I think this one might be better named as just for_each_component() - I
don't think there's much risk of confusion with the more specific
iterators for specific types of components and it sounds less awkward.
I'll skip this and one subsequent patch that depended on it then apply
the rest, they all look good.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluj2cYACgkQJNaLcl1U
h9DcIQf/WD2WGW9O+Xkzx87l3TTB+/baP5ii/H21BHT42CpqSBxm8X6p7JiYKJh6
r5TRH2KseF1OE3j16MPOyHPSivYU2lKc98bMnUetXFCT6rWSNhi/AVL2YIf4MslI
27utgBvL3LRe6VMLnGuE8xOBl5WMWCTV7dOkYQZztxRABc65vECK686PJI6zJoma
ogeW5JUCsBXNzTKt08HFm5Qao/KWL7fmiELDmSBupBVthS7E3TwEsS/JcaFLncjL
X2Q8A6z47FloBqs15FjKGlJmRR23L21SJy9u69WAl+uwAPDjRih70heajmaVrw4i
aUBME52pUmgjSs8UuLAGmfR2AWFWRQ==
=KBIY
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

--===============4109423196126647094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4109423196126647094==--
