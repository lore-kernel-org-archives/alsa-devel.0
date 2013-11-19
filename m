From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/10] ASoC: ux500_pcm: Extend Device Tree support to
 deal with DMA data
Date: Tue, 19 Nov 2013 18:50:04 +0000
Message-ID: <20131119185004.GH2674@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-7-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9gXqgVhKaPB5h51M"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384859269-19801-7-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--9gXqgVhKaPB5h51M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 11:07:45AM +0000, Lee Jones wrote:
> Soon we will strip out pdata support from the Ux500 set of ASoC drivers.
> When this happens it will have to supply a DMA slave_config to the
> dmaengine. At the moment a great deal of this comes from pdata via
> AUXDATA. We need to become independent of this soon. This patch starts
> the process by allocating memory for the associated data structures and
> fetches the MSP id used for const struct indexing.

Applied, thanks.

--9gXqgVhKaPB5h51M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7LZAAoJELSic+t+oim9w6wP/iU45AxHAtr/MgDlYQh2QxUq
rKIEGVcV3sKfIDk2P1Yo4R1w+aXqqDxVeA/pK3VsiYaZyCdZEWlsxeaVvnlJOEU7
61cULcR6/CtLtbc71Dr8nydixS7vt8pgMcOIssXam+cBOJef0Z3tfFtB9Eoh0D/3
dR3F6QWT9sXzyfYhheIhLV+qE99fTUw/KigufKSxDwu7gqjl8Xdbed9C1KhCof2b
lfhGbBSdMbt84+wFn/b4Ys270UIXV9VwdQLi6UpYzEHuPUiMu1ZZwb51NR1W9Quf
cjQ+gv2dat+EW9mV5z8vBJ96VNcwSKLtq9bjA3bQkflFi393LmdwgIzRLBamSrVK
3PXtxQFpv+aR8YUnNlU7mMe1hdDL4TuV02KQiWjwF5CxMRIq9Wb9b7oMSzFcNpdP
ukmo8b9DTtL3NLhNAqwmDClJ6duDHTNuOlghzYZxOvMSh3KVRZ9kFbbmEJ6mFLWU
TnhzPawYGpuWM1L2JhzAyZ+HgnpLMAqh8Ilb342EYJ8+X/cqnObd4jlz8hTnjhI1
gYHZjiSxnJH2yz3Zagf4LSBIMPuXzMjA95yM3OGqgKSJCoB5/GHAKJOriVPfLt0V
rlr4rOb8fVUmdhKO+M18hmAaSpq0JocJzDuxJeJeANZaZOdpyFCsQDawwMKXT5TB
0+U8RIMV/1xvmviEAVES
=FuQg
-----END PGP SIGNATURE-----

--9gXqgVhKaPB5h51M--
