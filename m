From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/4] ASoC: Add codec machine driver for RK3036
Date: Mon, 19 Oct 2015 20:13:12 +0100
Message-ID: <20151019191312.GQ32054@sirena.org.uk>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5KxTQ9fdN6Op3ksq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, benzh@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--5KxTQ9fdN6Op3ksq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 09:01:08AM +0800, Shunqian Zheng wrote:
> From: ZhengShunQian <zhengsq@rock-chips.com>
>=20
> This patch add the machine driver for rk3036.

Like Sjoerd said this looks like it migh be better just using
simple-card, if not...

> +	ret =3D snd_soc_dai_set_fmt(codec_dai, dai_fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set cpu DAI configuration */
> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, dai_fmt);

Set this in the dai_link struct.

--5KxTQ9fdN6Op3ksq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJUDHAAoJECTWi3JdVIfQqIkH/RqYRy3SMtxLZCDf/FVYM8ub
q4wGBuEmG4Ju07kgmaGSd0rGXE6XKwFrtuKcCuwZk07f4NroTjOOYXOncm+mo5uU
RAjE2dheI3CFRLpf9YpwnbQE/Ydy2eWf1pQ/YG7xSTiQayV/H4+AN3xR+TAKPBl/
lB7SOpcAkrpFqPlEB/N0JosLCSnJ2JIgaw0NR/UKetcg5Sty9uQ3JPMRm708f0BT
XtS8SfUtCmoDp0B3Fa3WVPS0ongJpBr6YOQGvIOWAHxqYJeudxd98yWYV9YowuwP
G5+I8sq4VtbK+lpXeVbcqenLxl/IN7dlr8e7CIu0XuMlolVcLBuFR5ihJPLRgrQ=
=FHza
-----END PGP SIGNATURE-----

--5KxTQ9fdN6Op3ksq--
