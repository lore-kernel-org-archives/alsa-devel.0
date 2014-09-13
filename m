From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
Date: Sat, 13 Sep 2014 09:36:48 -0700
Message-ID: <20140913163648.GJ7960@sirena.org.uk>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CZb08McUREi1kVi+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--CZb08McUREi1kVi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
> As "hclk" is used for rockchip I2S controller, driver must to enable
> it in probe.

Applied, again this is a bug fix.  How did the original submission get
tested?

--CZb08McUREi1kVi+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUFHKfAAoJECTWi3JdVIfQRdUH/iqPYwP7J/RLSFv1aupWqYVx
HvAyuf6N5Bsea2eofmXwrRGpe64a7BXh/Be+8rQXCu1vFxf6Dd8D6B85E3uE5wyq
uU88hMSUciK1wijNZw9GoP9YvfRrLnaKyUIsxsEmkTWThd/btXZDKLmwsBB50DQ+
xAYh41usHWdkD6HW3hzK8FZWJglplPsc/0z36iY2OVwRsLYrFb2NnFKRiEsu+0SO
Fn0tqfNAId/cfO3ji/bmMW+e8cLkck4dzsd1wX/dBB/ErGl30CVbFBB62IQ2ilmM
mUSP3vtSYdV3NyK8nYSnsFFFL1JS/WwEjSoKAvhNxW+WgLyPGFv/y2qPfPEz3fE=
=0lEn
-----END PGP SIGNATURE-----

--CZb08McUREi1kVi+--
