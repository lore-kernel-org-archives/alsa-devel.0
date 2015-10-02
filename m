From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
Date: Fri, 2 Oct 2015 18:03:11 +0100
Message-ID: <20151002170311.GW12635@sirena.org.uk>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
 <20150930182219.GU15635@sirena.org.uk>
 <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yitian <yitian.bu@tangramtek.com>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Andrew.Jackson@arm.com, tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2015 at 10:24:42AM +0800, yitian wrote:

> I think maybe two reasons:
> 1. designware I2S IP in my chipset(new design) is using tx empty and rx
> available signal as the DMA handshaking signal, but it may be not true
> for all chipsets. If I2S has separate signal as DMA handshaking signal, mask
> irq should not impact DMA transfer. But Synopsys's engineer recommend us to
> use
> tx and rx irq signal as the DMA handshaking signal, meanwhile we cannot find
> separate DMA handshaking signal from designware's IP spec, that's why tx/rx
> irq
> will impact DMA transfer.

If that's what the Synopsis engineers recommend I'd guess that other
integrations are doing the same thing.

> 2. I am using a FPGA for test, the cpu frequency of it is only 26MHz, that
> means
> XRUN is very easy to happen on my board. But I guess most of the developers
> are using real chipset which can have at least 600MHz frequency so XRUN is
> not easy to be reproduced. As my test, No XUN, no this bug...

Ah, that might be it - it might just be that other systems are working
due to race conditions.

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDrjPAAoJECTWi3JdVIfQahEH/1njlXeqdFN6Jfv/Ba4Fq6G/
aUg0QZGJiu4E44Mt5ls4sq4Ydnc4Rr5LxkllSBgfn9b3ZtM6B6gHfpY4RKMMmH3A
bpcP+6DySQQE5uxCZcmn9dV8YXyQDScHDnfx5dNz/bvanywcZbVgOvGxNHEJSFnU
HD/DPQzKhylHeoJHBEaO+yloT7VqKGzyHGRFH9zuXBR2csU5yE4jrWMuPErMWUFQ
KgZkI5JucrJ8svMlhg0saleKandDUCgCLyulc9YZ6Wb6nKsUhfkRvQA3u2YstEWF
8YpDLDxUpdil7abWQ1U4L/8x5vdKJ+dnuKVgGPz0IwuEvI+WMfa7vFtmCJUxv44=
=+ZTM
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--
