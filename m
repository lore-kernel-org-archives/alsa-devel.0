From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v5 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
Date: Wed, 29 Jun 2016 20:13:22 +0100
Message-ID: <20160629191322.GT6247@sirena.org.uk>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cUjMc5fB5G+GsIM6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466149440-23889-7-git-send-email-garlic.tseng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org


--cUjMc5fB5G+GsIM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 03:43:57PM +0800, Garlic Tseng wrote:

> +static int mt2701_afe_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
> +				     int div)
> +{

Why are we adding a set_clkdiv() operation?  I would expect the driver
to be able to figure things out automatically.

> +	case DIV_ID_MCLK_TO_BCK:
> +		afe_priv->i2s_path[i2s_num].div_mclk_to_bck = div;
> +		break;
> +	case DIV_ID_BCK_TO_LRCK:
> +		afe_priv->i2s_path[i2s_num].div_bck_to_lrck = div;
> +		break;

Especially in the case where we're configuring LRCLK, that's trivial
when we know the sample rate which we have to know anyway.

--cUjMc5fB5G+GsIM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdB3RAAoJECTWi3JdVIfQ3i4H/jYWX/TMsFxkFrK4hQuSqQR9
U9z+zyvxFGVIZCKn28o0zVdrukgCeTXTnWXdqut8tnCDZU+sVmOp3bVsFk/sHUBQ
eQwhiw90zbJ0pUKb8ARREX0k3MedjEdNJgxMgX9a+JK31Xo+Oafqt7FsKU9N0pP4
H10qlDNIZvBzh6oDqzgKvUI+LImcYefVTsS+TUVVIMg6Hc/IRHyVDdEG5LqBQjfv
YrMRezTFDYuXQKzmTW7biNqPUn7Tm6FtjqifHx4nwvrnFwCzW9sMK1iTj0OgEKON
xdh45c+oQJoXYKwrzsGMa1h7Cn2PnrJ1RzM6/apd13l+nwbvtoZV4xAKLZ09qKE=
=jCnM
-----END PGP SIGNATURE-----

--cUjMc5fB5G+GsIM6--
