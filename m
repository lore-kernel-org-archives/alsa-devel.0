From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: es8328: fix error return code
 in es8328_codec_probe()
Date: Mon, 1 Sep 2014 11:34:14 +0100
Message-ID: <20140901103414.GP29327@sirena.org.uk>
References: <1409532470-32364-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4319943151627071019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 08281261B23
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 12:34:34 +0200 (CEST)
In-Reply-To: <1409532470-32364-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org


--===============4319943151627071019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDT6ON1uLKeoILhE"
Content-Disposition: inline


--oDT6ON1uLKeoILhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2014 at 08:47:50AM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied, thanks.

--oDT6ON1uLKeoILhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBEujAAoJELSic+t+oim9kYcP/0mQVqeXw/T5VRTsXkXPFuQ7
6PIl1WOrx+90JdRi0CJIzsdNCTyNIsV3z8HGzFceOJGXuUe0Mj3zp3HPmDQERrlW
oldk1QFtMgStigp1TUtjWCLUt0igu1KDtp1609IQ0ObRJF+ri4AnGikteQP742rc
QH+uS/0nNUeiRy/H2xNy+sO3dBXOldSsVg7vrnLS9UJfv53FdbNoHZHkmYRk8or1
IaJAKHYc9t6nFFuf92QQQfM8nTlglDGoGzI8HlSU9NDuz+AI8Yru6eGnSkEHzUwg
DfiJwlzoALd9ulEfr8D5nAGH7uocSGm2AoSlSY7j6GTQvC89kv/5v0OYaM48lICU
csXbhG2uYl5jL8+XYDPUPGhWJn0LIJR41u/XHLveKvR1gjf3G0q3hubIHXSThfVr
RUvvFsnqQL1VRVBKFYOh+Bkc4tdfQt6NbSbKEmrBfW8v3dRqg12/aUwcFYtMXz9f
7JA9L+LzCqCYIlUzan5FlWdUCDBm+J5vYf5gK/B7NPrIXEMNHywc5Ss1YbtlIdfp
vWXlfIAIzvg9sHpWcGBGY+Lak3XEqMsUbRww9VI5aAxZAAO6+7ZsJjZwu6AyATxC
qPW9/se8CyRF+luu+A9NRMMh6nWLKH//LITq6mm1kyC4acGRwrD/aCPfLiQZKTvx
H/i3+ZqqnQh1lkJygLpz
=iQwH
-----END PGP SIGNATURE-----

--oDT6ON1uLKeoILhE--

--===============4319943151627071019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4319943151627071019==--
