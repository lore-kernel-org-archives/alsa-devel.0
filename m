From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: add hikey960-i2s DT bindings
Date: Wed, 10 Apr 2019 12:10:32 +0100
Message-ID: <20190410111032.GJ6106@sirena.org.uk>
References: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pengcheng Li <lipengcheng8@huawei.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, john.stultz@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, liyuequan@hisilicon.com, cash.qianli@hisilicon.com, huangli295@hisilicon.com, hantanglei@huawei.com, wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com, xuwei5@huawei.com
List-Id: alsa-devel@alsa-project.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2019 at 09:57:41PM +0800, Pengcheng Li wrote:

> +Required properties:
> +
> +- compatible: should be one of the following:
> +   - "hisilicon,hi3660-i2s-1.0"
> +- reg: physical base address of the i2s controller unit and length of
> +   memory mapped region.

This binding is inaccurate for the code as it requires two memory
regions, one for the IP and one for the system controller.  However as I
said in the review of the driver you should probably be using the
standard syscon binding for the system controller.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytzycACgkQJNaLcl1U
h9CbMQf+MU0o4vQiRVLvnUzyJy9F0DiTkSTOzWFxxAmW0jm5y0v5vMCD9ExC2uBF
uvYHdj9luy4Es/ah0eovKtLFVgV7xnQtqAUPpz+uH9azreBiCH8nMHTz2l8NVXys
8zdjd+5fsO2tggHKiiOJka17c7XC1XWrOkCfz9GZC3RuKPOe/Vg10ZNgH4fbzfdP
OdeQRhnrviDWTLhcdE6VPH5XayiG+DPZxqOk5hfkAI6Lcqk3ZiNBXeRSclOt6G8u
vRZPLEztEjY9aSDi32wEs1BFvt8hpXE+CuRxUPIgHTBiwC7sojdl3P66y3H52ILQ
1R96bj2dZ4baL1Z5fls7UKaNUSKmLQ==
=Zgie
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
