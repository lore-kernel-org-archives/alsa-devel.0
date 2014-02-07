From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8991: Remove unused pointer in
	wm8991_probe()
Date: Fri, 7 Feb 2014 20:51:56 +0000
Message-ID: <20140207205156.GN1757@sirena.org.uk>
References: <20140204212059.51b9a904@spike>
 <20140207133948.GO32298@sirena.org.uk>
 <20140207194319.74f6099f@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643670122495268639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3C962654BE
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 21:52:35 +0100 (CET)
In-Reply-To: <20140207194319.74f6099f@spike>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0643670122495268639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Content-Disposition: inline


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 07:43:19PM +0100, Christian Engelmayer wrote:
> Remove unused pointer 'wm8991' in function wm8991_probe(). The last user
> vanished with a86652e5 (ASoC: wm8991: Convert to direct regmap API usage)
>=20
> Detected by Coverity: CID 1162831

Applied, thanks.

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9UdpAAoJELSic+t+oim9JuYP/03BVeK00MoRq+zFH84KleA1
c/KoBHko7ckRdSiPFnyIfshrdbpXJOkc7brtsKKTCFOLSg4NkE7NH6JeqLVT1s9a
V6Rz/nkIFaUmwi5AxN+jFeVwTueflexKDHeKAW9AwUPzUFOfnc2KAQqCtauFWUqd
FoOk9Imz+nvRwAQIEr+wkoANOMqE5p2RZRYwPu22W/8s27eygA32Wt2ScIDKSVXH
awoCSnbb4RJsfNjA7EP7CPjJCCN2PhBH8s762DoX2u8e9j+QW7r9iUy3GokHOKSq
/kGYaFVU2yZUo82+Bda34USBi/uFoPK2h6VV5pvbgadSMqhdOGHvWM6Kg7x1XTiB
OedeXgCjklYBH+D5boQhpL9gm9to8mekkgk6gZequip9g33FVZbQfFEamolmSEvM
tc1SYqWTa+qhab23KLansmmn86jN7ZjoysVpXJQKkq+ZnhtLUCKZmmAZG7pYdSi3
WUqWvkQbhqz6W9y1UWaNckAI1qV+w5PBb6PBJ2rWE76NbsMJEkWR+7ZNJf7Ad5x2
35sG4Xifk+yfRnWy8TZPptAW09ZxzhVI92FkMYrf753pDHSegVB/0rEgPYBzVICS
4VOODleTE8zSYA1dIkfDsLxg9ujbQJQiTXpbzkxPAwFnHfR1hdOvEKoptFSUXB4w
+n9Q8N7cplqvV3G3SNV/
=nlhJ
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--

--===============0643670122495268639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643670122495268639==--
