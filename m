From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/2] ASoC: sgtl5000: Read
 SGTL5000_CHIP_ID in i2c_probe()
Date: Fri, 10 May 2013 10:15:09 +0100
Message-ID: <20130510091509.GJ3200@sirena.org.uk>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0299218502835302849=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D922610D6
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 11:15:39 +0200 (CEST)
In-Reply-To: <1368144947-23775-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============0299218502835302849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2013 at 09:15:46PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The usual place for reading chip ID is inside i2c_probe, so move it there=
 and=20
> also convert it to regmap.

Applied, thanks.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjLqaAAoJELSic+t+oim9baUP/3QRZ8n+SSZyBbaPE/XviwLu
6/mhoZoP1ejy6mdj5M2kNgcbaiFbMjnTEFsF2OZtQmRUHh78JSapvWLMijIMQT+K
gd+DEu66A3EWnHhMWfzYn7EhOjRZmQQTt9wbto/QziYys0w4mVWYKFJ9QEDfXglS
llLzudBeE52iPO0+NtHMACvBQmuxUhYNmMHtaenSmpBOZNdl3ohvjB946ilUffPg
KRPCVP2eSriCYQgAtpDae2CjOoaeGfoXmlpjmdWY5qBMFboJYc+ikoY13J0KZIoi
S7AuzC3UAbnbOzTEKlchjGuCJ7VRmkqw4c+CU62ouoe5o8W8dJlIE86e8ItvcZD6
6Pq9X1mcq9nffywyqOT5LFpxt+vkuxCgcrRUTGkpUqaWSObicwpe22MeKcwsm/CF
VUwttxV4anEvPf2pPj6OXndtcl980nGdEIDFTgJJ+CWm0glykt90LSp8uNmpFIKo
oB+fhlN75tBXZpOQY5BxNp07cXy39vhnnWUGb5Kbd4uFo9uv9dZcqa0d9/TBsQb0
YGtwwWjQof+3tueEjFD0FW7RQ2UCnr+7+qya0VmZ4jhNNWrHL5xCwayNjPr4YFdY
FDDRelsSkFrS8gYVtabnOzj6GYJDPBJe/lIGtWeZ/oLNTywV6BRootKse1Hk7EPe
ytQhDPAth6shWulEANd4
=DyCR
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--

--===============0299218502835302849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0299218502835302849==--
