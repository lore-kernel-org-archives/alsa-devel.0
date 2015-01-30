From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add rt288 codec support
Date: Fri, 30 Jan 2015 13:56:01 +0100
Message-ID: <20150130125601.GK26617@finisterre.sirena.org.uk>
References: <1422598893-28393-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8308455158592158128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC0526549B
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 09:29:53 +0100 (CET)
In-Reply-To: <1422598893-28393-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com, lgirdwood@gmail.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8308455158592158128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 02:21:33PM +0800, Bard Liao wrote:
> This patch adds support for rt288 codec.
>=20
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
>  sound/soc/codecs/rt286.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This is fine in so far as it goes but I'd also expect to see the rt288
ID being added to the I2C device IDs table - a board should be able to
register the device as an rt288 if that's what it is. =20

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUy39gAAoJECTWi3JdVIfQCz0H/RKBNFEnr5Y6ZhmMQxl5DJMK
2WYqhiasnBf9vKy4RoQtv9N/2f7LV6DbeSuBq1+NG4SRzSMbS2Q1C9OH5X/AR4/x
zRUMxXdAuTm8Oi+3hqTxQYuY00hmoW1EjJ7DRuKTo6ieoAncq2X0sG+mKhd/I68o
OY3Nu+Zb6fZElIcFlUBWN6aUm6a1UiIeg4f0GsKAdKmIXwHUiN40fJydbH/O0Gqo
iplv2cgpERS0dbkPNtYfwR0CBa+HKVbOmKhReZlOWJLTXq9flOcGDezp99onH3uR
wCyYfaz2ZRjHnovctQLJgH8OhghdTxffWjQC/0dgtvnVAX8Ci6avtMwEOUbrVLs=
=y+N2
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--

--===============8308455158592158128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8308455158592158128==--
