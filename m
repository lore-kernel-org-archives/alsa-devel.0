From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Fix TDM slot length
 handling in arizona_hw_params
Date: Tue, 12 Aug 2014 22:44:51 +0100
Message-ID: <20140812214451.GZ17528@sirena.org.uk>
References: <1407853832-7176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2438003113759127519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C563D265329
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 23:45:04 +0200 (CEST)
In-Reply-To: <1407853832-7176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2438003113759127519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OrwgwoTw2SklcH1j"
Content-Disposition: inline


--OrwgwoTw2SklcH1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2014 at 03:30:32PM +0100, Charles Keepax wrote:
> From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
>=20
> TDM slot length was set same as word length, regardless of the value
> received in set_tdm_slot. This patch sets the TDM slot length correctly
> as received in set_tdm_slot DAI callback

Applied, thanks.

--OrwgwoTw2SklcH1j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6orQAAoJELSic+t+oim9PwsQAIH3XG7xibrwIhsPZXOo8Crj
Q5UX98fh6MIPibAQTbyEKR74sHpkwtmy2MvhgQOzw//eyWpF+ArHAWySBXN/ZCb7
BshREBOGxADgcXEitLwKyL0P1BZ78v9eCSlG/81j7wB8lIYywWxPM5hYURhqxqKN
pY2U/45SLzP0ECmln33jaAPaNqPmAl1V3SPv3TH4D6fwgzY6GSys2fcpIO3RbS/x
LGJv0B7plLeC58pK4p9nlEj+eTngZfxcqzgAS8FiebXSjgpVXGIzWNm0eHbahqO1
x52HJy2py2d981UMRzCKnyfJY3FRvP6NDiwdct0XKN8NdNFfz/uIAIP/o8dDJX4d
xr0qwQ2RIe9AKo+iXP/AEoRprYJL3E8w8NldsTz0zy8p+0cl3sL+JZQHWnuJ/mQy
rIVTUncZBBYd8T6D+deBWncS4hL0lC82g6J8fjLx8xxiHWmGJX2VGT3eSJzr2IaQ
/238skdP1FQBYR+tQ7GxRaSYMWtYwZpQLs1YjcgIQU8gAHqWZrPLgdR69HKG9lcW
oTbWPNbSS0SB0HgL802O3L3N00xEw87bj9Q39zKcqHN+tw4K+XYC3g+i008oWTMc
mTKq70YdhRwoHsBRr3RqE5/krSXx6UJBJeWJDpYwfiYbL7ShDwsJ1r71q48CBnGt
DUyLifrun3Bq4FVYSRS6
=pjBo
-----END PGP SIGNATURE-----

--OrwgwoTw2SklcH1j--

--===============2438003113759127519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2438003113759127519==--
