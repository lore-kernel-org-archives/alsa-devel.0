From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 07/21] ASoC: Convert WM8741 to
	devm_kzalloc()
Date: Mon, 5 Dec 2011 07:59:31 +0100
Message-ID: <20111205065931.GA7341@avionic-0098.mockup.avionic-design.de>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322948009-27658-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4851135480514223288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BF4D24372
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 07:59:49 +0100 (CET)
In-Reply-To: <1322948009-27658-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4851135480514223288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8741.c |   16 ++++------------
>  1 files changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index bf471dc..24d8ec5 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
[...]
> @@ -512,20 +513,13 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
> =20
>  	ret =3D snd_soc_register_codec(&i2c->dev,
>  				     &soc_codec_dev_wm8741, &wm8741_dai, 1);
> -	if (ret !=3D 0)
> -		goto err;
> =20
>  	return ret;
> -
> -err:
> -	kfree(wm8741);
> -	return ret;
>  }

Any particular reason why this is not collapsed into:

	return snd_soc_register_codec(...)

The same goes for patches 8 and 9.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7ca9MACgkQZ+BJyKLjJp8/yQCeIhgWwvsuENDE0jmrsjinnnyo
usYAn2+rcDhxGyS5S/opS4GOGT/7NhYx
=93oq
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============4851135480514223288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4851135480514223288==--
