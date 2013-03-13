From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: imx-audmux: Use
	devm_clk_get()
Date: Wed, 13 Mar 2013 10:39:45 +0000
Message-ID: <20130313103945.GG25610@opensource.wolfsonmicro.com>
References: <1363132289-15211-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4170210632758622360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C772265E0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:39:47 +0100 (CET)
In-Reply-To: <1363132289-15211-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4170210632758622360==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 08:51:28PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> By using devm_clk_get() we can save a call to clk_put().

Applied, thanks.

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFdrAAoJELSic+t+oim9kBsP/jMnckY1oBBfTBevFWVEnqa2
mJnjiNcPylUodNbe8yZaGI/KfoLrvfsF6czfd48ibbeKhlIuaJMhmcIoTl4Wjr/X
br0gRXLf4meYBdLnnbllmqJ4OPfPpjM0y+aswwabUAjH+pW+t6C3VUOb3D9nuLUZ
4N7CxGMslQmYCPSfVd7VdFLj24rukCkfbmVZVSkL5bAYhiFh7hEhK+D09exVkRzt
A/P91wrwrJS08e5gsNU2Xb7sCab68gfXjaCRpXexreaiYRpaPft3ovaRYuqI+MWO
+ZgZQeFbIVTjZzw7E87Ega4jy38QKKzY4c2rIw97p8aMXARRXZHH+JsF50wjNhmm
cHY3IOeWUPzvrRxT5NKRu8qTEXAd2kC8/Qpz6zc+EkQ5BZJQktjlB5lhQwAiDpih
nPO0t2h6OfASEJe1kDMkmmvKYWYVNYok0xa2ohcg1pGMQhdXw2f4PJfbhmH26yLe
CAisSwX3b7PNlcbLb18YShpzTl8xLhnKaKbMxqGq2sCaJebklt1iuzeKnIoAHsPb
uSb8rObld24oHYhcWFb/zadMiBpvK2PemAoBfeEuJnHOpNYed6LngppPPoHsUqrB
8+R6Swybcc733NQuRVmwDY/T0TYNDEGyJe5T5Kita5y9Ga1arQqPTSXUnxgYh4wP
FIMOYR24qIc/vUVDe6NZ
=sXRt
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--

--===============4170210632758622360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4170210632758622360==--
