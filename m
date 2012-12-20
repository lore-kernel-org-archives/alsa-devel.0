From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: sta529: Fix update register bits
 in sta529_set_dai_fmt
Date: Thu, 20 Dec 2012 16:01:40 +0000
Message-ID: <20121220160140.GF4985@opensource.wolfsonmicro.com>
References: <1355991445.11688.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5357853852655408568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8896E261666
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 17:01:41 +0100 (CET)
In-Reply-To: <1355991445.11688.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5357853852655408568==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IdQYvU5iz1n5pUC3"
Content-Disposition: inline


--IdQYvU5iz1n5pUC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2012 at 04:17:25PM +0800, Axel Lin wrote:
> Both the mask and mode settings are wrong in current code.
>=20
> According to the datasheet:

Applied, thanks.

--IdQYvU5iz1n5pUC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0zZRAAoJELSic+t+oim9tfIP/R6/huky/D60pDpx+vo8zFSH
8Q3kSMLrC6qJYNMqzU495zGdd436bir8XcRCj9H1hUur7AjpumZhfI038WprxjJ+
Mjwlh60FbkOZsdM8pUql6o8gKo01YtBAJ9nO1E1JRDQQw2n9MeeeNC7R7kFtA27j
xVAQIGyXo5Bka2gEzfOjx8zunmSg4qskWRoun6hDeEi+ETVcD4xFd1PACfTIX10N
sgVDBsKL81pCx79RKx63q/kbCendvbuJy/atr0DIJ0DyTv2nTVHujhGlkTHx6Jvm
7ifgWQlqqCFx1Y3uB33VKB/Z7faOTjEyO0Yz315kZEaecazvhvoj/PJImyDXZgTg
aVR+n/GMeivwsCG9ZIUizddDJXJLfX2qPQDE1zRfEfJ+c2Ada1oy6kQk7Zkny3HJ
Vfz0QVet10W7r1oQyNgmfOtw5aX2k4PfJ4II5UaZJOvQnkBdZeuAIXdxYZb6El/C
WTlj9e/GkzRpgoYm4NIxjA7J/lDC+8FxtyIoHIfzFtDc3UG6oMIyblrnrJR00bWR
tvcE5dRP5WvJBtOzKl6Lerrb34k02a5pBBUyFKDtfC7guw8X1/k2ZlYHpTVNvPak
mmLWoI204tmYynXdzqYr1SGiE+1kXALxlEgVyng5JA2y/Huap7H3K2oA7ahgNfqn
TFolHNBMKEO9G5uJ8mz/
=T4by
-----END PGP SIGNATURE-----

--IdQYvU5iz1n5pUC3--

--===============5357853852655408568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5357853852655408568==--
