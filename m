From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: wm8994: missing break in
	wm8994_get_fll_config()
Date: Sat, 18 May 2013 12:26:04 +0100
Message-ID: <20130518112604.GT1627@sirena.org.uk>
References: <20130515070943.GB20381@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4785432755526932230=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 12ABF260319
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 13:26:12 +0200 (CEST)
In-Reply-To: <20130515070943.GB20381@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4785432755526932230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/U0GMd1Pus0mbMSS"
Content-Disposition: inline


--/U0GMd1Pus0mbMSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2013 at 10:09:43AM +0300, Dan Carpenter wrote:
> Smatch complains that:
>=20
> 	sound/soc/codecs/wm8994.c:2087 wm8994_get_fll_config()
> 		warn: missing break? reassigning 'fll->k'
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

--/U0GMd1Pus0mbMSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRl2VJAAoJELSic+t+oim9Lr8P/jj/MH8+WENu478PwXYxC9Gd
6ecjGaV7m9sRluO0jXkfiMcB+kzdjQ5GVSsaPg31OhaEwof0eHdYmZX9k2uikF4N
tokODkrCyIqKKAj3vpRHF4/E6vgyR1KMh66+GQEoLbtoYuGZsLyyDhoQgd4bfA3z
66tXfyQFL5VRCWWOLWvvJXIjGhWQl6mAOVFvYmbwEdWPob/mWxbSf51W8J5z6DZn
zYBSbHT3t6ZbfdRrQ6BlzXHtngBne7J79Y27DUutn6p0Msc/YCq4r+4ISOy8A7CQ
VFOEopjGqpxc03UqKKKL6eXl+lyWob6mU6NnJvCK612IobW7/pApHwwr6zBiT3Cu
STBhcylcWF7UyxL8a6Stw2tjWIY0CEqUyDZ5/HEsaAgkb4JCtFfxMp+xT6PU8MGR
lTqrQOveXMAQRdoDHEn982ZgZHIGtD3Pq2If/d2D48ljKTPrK1GSqG+dm9Y5CBxv
Bu/dbyjwKZTAvh7l9SFzalfakWpgOGcL9CyXsJ/PM+3/yn9T+o5xwCfsJXjaL9Jt
wqIi7M77v1WUL8qIO1VpNnQXaQyuaJcQ0hmcHzWKOwrIfCk5N2fFDGTXMy6nEw6R
V71ozRGbKmminq7cAHafYrCUVL2VFLPe1j2IOYHhllc7mS4wuOueEYKvpcooFnNR
5O04rFiAiZeyYrFZHfFD
=mipt
-----END PGP SIGNATURE-----

--/U0GMd1Pus0mbMSS--

--===============4785432755526932230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4785432755526932230==--
