From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sta32x: Add support for XTI clock
Date: Wed, 17 Oct 2018 19:59:32 +0100
Message-ID: <20181017185932.GI24097@sirena.org.uk>
References: <20181017113703.23737-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3774228458677249254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BD0F2675A4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 20:59:34 +0200 (CEST)
In-Reply-To: <20181017113703.23737-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3774228458677249254==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 01:37:03PM +0200, Daniel Mack wrote:

>  	sta32x->component =3D component;
> =20
> +	if (sta32x->xti_clk) {

This didn't apply as the component assignment above isn't upstream but
that was sufficiently trivial so I've fixed it up - you might want to
check though.

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHhpMACgkQJNaLcl1U
h9Crngf/dJuZOJB5G2TyUvueLHG1KNUcKLZmpawkPE5uLzQoVuD3JdDRn3Kn+QgA
+m4sQm4uREbC+VzFsiA0PCcHcCK1OwNzVxx3EAQ9kBaKn9MkVKTbuIkbWmVss2L2
ilw1pJYFMZZzo1H285i89xaaBoQ0r17IRDDS5tpvk0QeN5vlxX45Jq8O0cck72La
IcVTjjNwOKNQ46W85+KfrG2CaojHFw1M5enr0YaAkdXB8y3tE/MmATCkYB+LjI7O
/+gFkDeb6UxJZR1OYswMrvGg9obDu/QAul/Jv3ZbpOsIg529UTHiIzD2T/kCIzMv
B+25vecKpcov9EssePcokXtI8Y9Rlw==
=Smb1
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--

--===============3774228458677249254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3774228458677249254==--
