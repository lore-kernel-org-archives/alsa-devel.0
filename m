From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SoC: wm8991: Remove unused pointer in
 wm8991_probe()
Date: Fri, 7 Feb 2014 13:39:48 +0000
Message-ID: <20140207133948.GO32298@sirena.org.uk>
References: <20140204212059.51b9a904@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3001739896500780919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B45A9265457
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 14:39:55 +0100 (CET)
In-Reply-To: <20140204212059.51b9a904@spike>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3001739896500780919==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nfvf/JXVyOeI7XiA"
Content-Disposition: inline


--nfvf/JXVyOeI7XiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 09:20:59PM +0100, Christian Engelmayer wrote:
> Remove unused pointer 'wm8991' in function wm8991_probe(). The last user
> vanished with a86652e5 (ASoC: wm8991: Convert to direct regmap API usage)
>=20
> Detected by Coverity: CID 1162831

This doesn't apply against current code, please check and resend and
please also remember to CC maintainers on patches.

--nfvf/JXVyOeI7XiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9OIhAAoJELSic+t+oim9kJwP/0fFE4aq5as+eRkRB0kJ6PYt
lDvfekvd/r8EzaoEJxw8iY8yzSdx+DqGjZd98Mwo1k+SF9if4ltdrtb9PAtHCZWb
IgzulbbDIndU5/lR0ifrkmHJH8RgBOExY9y2+D2VJ+58bHKBF0XonqlNFGGo07n+
zvT9DV3TMYrDMs5S+f6yDT4De2WaJM6UGGrbYkNU3cPiI21iPSrwYOBILG6i2ywJ
lavLQFFiFDVjHA6BMLGC054fsP5xuMkj4lzXQL298FYhbeoowffo7dACf7cjSB+N
z48MQ8ORe7uk4XCdbJpg8nhTq3EE564laVYOzSVTGXhKOUO97fqcgaHp2pXPGXX8
qWy0eQjFuvi2P9eIrYN/9bCeqsdZnnhO64gAFg2IPEoZzT7x9MPUAXV7IGyLiLs0
l6rPd8jUTJz0fJJ6dQKsdGHpd9MnrFrt2UBojVRKc8EZi6ScqHoPH7Z0xjLmJZIT
xsqIkGHWwPCBJlKmZ4kpRKd1D5ROv40xkMnc+V92auplghDrKEaj46U4lo5timzf
5dvQ317lkgbU4SCweufeBuBQKecvjo/T0pRdl3LpwM1mj3pOgWqIU3Sj5B274idZ
i/JPY3aRUYbUnCpBGOK72wpEt31jcDrZeRwPgLBqR4undaOH/4dSkmnCEgkX/OM/
qSwIy9qH0bOUWHpmN4jc
=ucRg
-----END PGP SIGNATURE-----

--nfvf/JXVyOeI7XiA--

--===============3001739896500780919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3001739896500780919==--
