From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
Date: Sat, 13 Sep 2014 09:37:49 -0700
Message-ID: <20140913163749.GK7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ys8nbMVQRzTucb0g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--ys8nbMVQRzTucb0g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:

> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -423,6 +423,11 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
>  		return PTR_ERR(i2s->hclk);
>  	}
> +	ret = clk_prepare_enable(i2s->hclk);
> +	if (ret) {
> +		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
> +		return ret;
> +	}

BTW: you're also missing a clk_disable_unprepare() in the remove path
here, please send a followup fixing that.

--ys8nbMVQRzTucb0g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHLdAAoJECTWi3JdVIfQJy4H/1EOxw6wz1vYvDYcOSC7HOKf
XzM3ytKOg6lMqnBS4Ng98FYTtEN0xjDlePDT7CfiFxam3Ca9QakZzntU0r7Zs2WC
Jbx/Bajc3elSOTX7pC9KtnzgokSpuoWiOoHKwK3HRYV6dESdtBFFn6o+AaiTr775
S5KkTLqDHLUcsPuepqjrzXg0wxPk6+AJNJK0BicUgEPz0Ov8KZEeqa/Y1k1XWYpc
TOYBwrk879Q26VzxssWmrHQSDB41Ha7VoO5MMBXmQHCLPpoNB4BCFiMg4wQwp/go
iQJeEzT7INA4odF7PCyb0HajdfQujUo6k9BmfTyKX84Ocy71cG/GklBoQ+xQi/g=
=iPbT
-----END PGP SIGNATURE-----

--ys8nbMVQRzTucb0g--
