From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Thu, 16 Jul 2015 12:00:32 +0100
Message-ID: <20150716110032.GU11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A15KrHDpJ6QU5wxe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437033944.27428.11.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Xing Zheng <zhengxing@rock-chips.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--A15KrHDpJ6QU5wxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2015 at 10:05:44AM +0200, Paul Bolle wrote:

> > +static struct platform_driver snd_rk_mc_driver = {
> > +	.probe = snd_rk_mc_probe,
> > +	.remove = snd_rk_mc_remove,
> > +	.driver = {
> > +		.name = DRV_NAME,

> > +MODULE_ALIAS("platform:" DRV_NAME);

> This seems only useful if there's a corresponding struct
> platform_device. Ie, a platform_device with a "rockchip-snd-max98090"
> .name, which will trigger a "MODALIAS=platform:rockchip-snd-max98090"
> uevent when it's created. But I couldn't find where such a
> platform_device is created.

> Did I miss something? Or is there another way this alias is useful here?

You've got platform_device and platform_driver confused I think.

--A15KrHDpJ6QU5wxe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp47PAAoJECTWi3JdVIfQjNMH/0TtEm3GWw8m76Y/gTV0Yulo
qyG8dPxRk/RQiKjvJE3OMOMGuYvNRwq04AXZXq6ql18FQYrqf1io7/NcRnlkaV3S
JZASgAzgqGZKakhiLDLnMtCYaB0FDBjT28bfBQY/rKXAvMKVUri/5z+fyHaSyUnD
y7P6nRMtBKQXNH6Kg5odsO0JPuXteTvLktFCH74eqYJZCJB1NdCA/it5dAVgU+fd
ty9YeByyo/6iGc/U5+3VdY3sKU0MchlfxhArcGcMnpMlGGE10u72WCcOhqTUzHvm
7BxhkuwBULKPHjXIAY+Zi0KiSXX4QUmLIHPD7fj8dtlLh/RGC0N62Z2vqGG3+gE=
=ZqXt
-----END PGP SIGNATURE-----

--A15KrHDpJ6QU5wxe--
