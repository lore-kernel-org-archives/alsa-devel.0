From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: fsl_esai: Add driver suspend
 and resume to support MEGA Fast
Date: Mon, 20 Jul 2015 18:48:35 +0100
Message-ID: <20150720174835.GJ11162@sirena.org.uk>
References: <ee6572bca11f44288db1d38e1934c0a7e7fb9ed2.1436339869.git.zidan.wang@freescale.com>
 <60254232400b21246e63e31f88645397d4f6834b.1436339869.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7231040774698024542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 525822614A1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:48:49 +0200 (CEST)
In-Reply-To: <60254232400b21246e63e31f88645397d4f6834b.1436339869.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7231040774698024542==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSsOQ17jdCCyz0AY"
Content-Disposition: inline


--DSsOQ17jdCCyz0AY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 03:22:28PM +0800, Zidan Wang wrote:

> @@ -722,7 +748,9 @@ static const struct regmap_config fsl_esai_regmap_con=
fig =3D {
> =20
>  	.max_register =3D REG_ESAI_PCRC,
>  	.readable_reg =3D fsl_esai_readable_reg,
> +	.volatile_reg =3D fsl_esai_volatile_reg,
>  	.writeable_reg =3D fsl_esai_writeable_reg,
> +	.cache_type =3D REGCACHE_RBTREE,

Do you really want to use a rbtree here without cache defaults or
marking all registers as volatile?  As soon as we try to allocate a
cache node we'll be doing allocations inside a spinlock which isn't
terribly clever.  I'd expect a flat cache, ideally with defaults
provided (though that isn't essential, everything will default to 0) or
an rbtree with defaults provided.

--DSsOQ17jdCCyz0AY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrTRyAAoJECTWi3JdVIfQT7kH/3k6fWzIDmxGwILh1RzYJ9/p
mILrHGK7sjXOQ8L/km9exh+q98fbbfnWQI0jcb1JqsfXKGj53QWaK58I8UnUF/xM
HU5lLpfKJYdV40w4jSxkOZS1QzC8vhocz+bCf9jHYAAurO3QFe9j3YTHsuVGd4v8
zn4ddg/ncu7BUCvODNjuj5BcF1Ys//NlYb9NcIn4ahBGIIJH1n1aiDWb4Xszhnly
TjH+W934gOLE1Ur638YxEMy46Y57rm57ItHtzkGJhm+sItFD1YNmwup6ZgP5OImS
8Pdi+o2x/ZGbD8iZ0l5V6zpXIcpHG7g/tARzUPWvzCxn5+KnrNNf+EvjAWLxsHM=
=gK/+
-----END PGP SIGNATURE-----

--DSsOQ17jdCCyz0AY--

--===============7231040774698024542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7231040774698024542==--
