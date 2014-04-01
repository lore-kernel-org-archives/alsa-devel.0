From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH bisect 1/2] ASoC: fsl_sai: Fix buggy configurations in
 trigger()
Date: Tue, 1 Apr 2014 12:56:59 +0100
Message-ID: <20140401115659.GQ2269@sirena.org.uk>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-2-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcsbBFLnFtTJqgUw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396322227-482-2-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org


--HcsbBFLnFtTJqgUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2014 at 11:17:06AM +0800, Nicolin Chen wrote:
> The current trigger() has two crucial problems:
> 1) The DMA request enabling operations (FSL_SAI_CSR_FRDE) for Tx and Rx are
>    now totally exclusive: It would fail to run simultaneous Tx-Rx cases.
> 2) The TERE disabling operation depends on an incorrect condition -- active
>    reference count that only gets increased in snd_pcm_open() and decreased
>    in snd_pcm_close(): The TERE would never get cleared.

Applied, thanks.

--HcsbBFLnFtTJqgUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqmIAAoJELSic+t+oim946MP/iXSUpw+dx2A7yXMkq/swc7Z
D7A0Nr0YZjM7MvTjo+rbtHCPXCSbST9P0SUEKMJUc8dRzqklAJNJ5um/gUpY+4le
DtalVp3+h8R+kgY92sOoK2Qh0kN29UEo+MUf1E0fS1f5/xQi/uGDmmCWEdjbjeNB
ENCM6ByrtI4vuiV051Wj9UQcSU2ppdJiDE/ijCuNQjeb8aE0U0Brznx7f1mX4m0Z
b4zhhsCIwQiDxA7BWtBjTy8YDiEGtMNYZkeMYMtNgElwYmISsPnXoQ9I806Whm2f
hqONkJSBrQY6cfsXbJqkcLTpP/FaWq56Dr3oPFCsudI3U7FOyUACGnJjGMF8k2Xq
WfzHhW4aMQRSLoCzUmS4Lch7Y0AqXenMz0ikW5mqh1ZuHHCwh1w+4Xnr/mr55D6/
OHGTa+uveC/KiRFPun9tahi3d572GMJg0uBd5LBUgOBOLKp7EBFWKywOyoljQyKQ
DxMNLM+1TQDFJCYvEwnqCUcBRCyHtdNU0W0Ursqb/IT7z4V1rWxF4zFMC42BdFk9
s2w4hRqJk1wOQEOtydSwA97zlsTdSZPfoOeE4mQoWwmgNB198CfdUsR0UpEDx1+v
75nimuF/NgCSzy2Q8l3Co7XzU5z1YhSH32O3Vya8RQ2Fs4zT7x5I2HANR26nTLCW
eR2Rq4hHW7NRGPNwUwOZ
=KNUf
-----END PGP SIGNATURE-----

--HcsbBFLnFtTJqgUw--
