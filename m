From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Mon, 16 Dec 2013 20:13:03 +0000
Message-ID: <20131216201303.GQ3185@sirena.org.uk>
References: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8974982972027971162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C96622617AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 21:13:08 +0100 (CET)
In-Reply-To: <1386936829-9627-1-git-send-email-nhcao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nenghua Cao <nhcao@marvell.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============8974982972027971162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JaBjgNvtdKe5H086"
Content-Disposition: inline


--JaBjgNvtdKe5H086
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 08:13:48PM +0800, Nenghua Cao wrote:
> From: Nenghua Cao <nhcao@marvell.com>
>=20
> V2 -> V1:
>=20
>    Removes the flag and update DPCM always when mixer/mux changes, accord=
ing
> to Takashi's and Mark's suggestion.

Don't send cover letters for single patches, if there's anything that
needs to be said put it after the --- in the patch mail.

--JaBjgNvtdKe5H086
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr17LAAoJELSic+t+oim9lzAP/iMzrAvXj2WDEbLjNSUEn2JQ
lStMqgMytVUHtEWtt7hxCt5/0SveNXpBUWh29SqaMJ8fH4N1uHI/z+D3xoa1T6Yz
MFIRlDDfjcKlwVyq+JCd1+3BgvgR7dFnO8tXVzw/NQp5J1MxyH0Pz9pbrBNLUZEC
TUsoH/PkNGwOUdO+RU7g/dsDH/9vHPPiY51jJ9TWgYXs8w3BHJ4g2+X5+b8GF+Km
MtKEf5liO9H5/43djB2yUgUpHvna6KCHi9TBnboIadEeeZYDBv7BSL04b76QGPTD
DEfVKKnQJIThWLGXIJQXeT5S8sFKBUPqowwY6M/e4bn037PeEwpY6gckZYfP2MSs
8vpCIlLt/qhwbRqwgF1XD+lmvH8kz3y2q9BqNOSS4Oog4E4EyqRqPKtEH5Z+Cajo
TJZ5d3QWmrKJq7cO5/Wnhx3o1r0Ge+p8LR5i6ANd/E3Fr5G95/H+TfbNRx00t/cZ
v+5sFtOdaB/L9tHsZCaapLoGTddrg7bzk+vCr7xmPH7s1967DKa6+JfYRzdjfJjN
Lg6d/zr/hHY3JeFEu+5TiwlznFjSrd1SkWnS1Nm11wBCNez9sW0WoX7hDxTj4cuh
aOUCEp+COb6RH957hbGXkQbpz+shlOvL6aCfevNvVKzDHxAbwr/dByux4VKpgJjY
XfwB82j6N8xipX+kgy3H
=GWAz
-----END PGP SIGNATURE-----

--JaBjgNvtdKe5H086--

--===============8974982972027971162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8974982972027971162==--
