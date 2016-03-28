From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
Date: Mon, 28 Mar 2016 12:11:15 -0700
Message-ID: <20160328191115.GE2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com
List-Id: alsa-devel@alsa-project.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 11:42:05AM +0800, PC Liao wrote:

> +Optional properties:
> +- mediatek,rt5650_i2s: I2S mode of rt5650
> +  0: using I2S1 on rt5650 for record
> +  1: using I2S2 on rt5650 for record
> +

I would expect the machine driver to have a reference to the DAI that is
in use rather than a property like this.  This is the way pretty much
all DT based machine drivers work...

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+YHFAAoJECTWi3JdVIfQozgH/j3rUQlVWmCwqFd/8FuekTbV
cmiyPnpYI/NebElwyx2hfMCXHo1Q8SmpY+dO4tNlia0/ySpp5Pu/hbY+ELuiByA0
1ddzci4OO8iyZvtQ/6+CzIvFcix2GOW6wHPTD9us4ZCc5SujY1pJzMdiqrY7aMfJ
k7mbZZxyvw635mjUE5W3ZkMtFUgllbWoWaGhO2VAYQ1ouy5DhPMn+nfJZMDLkVaA
/ULeJ1NzDOQfT+GEjRmVsBU6cHpMH/VN5wYKnn2NLhXoJAvA3+w7y3xGgwbG/8Oq
/NcIXw+Z1UvYhLAOfgYS4V+mG2dVXumZI2mcexHexBXQr0N4ZfYZHgKfTMLAqkM=
=veuE
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
