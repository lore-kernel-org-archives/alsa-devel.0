From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix incorrect condition check in trigger()
Date: Mon, 14 Apr 2014 21:31:26 +0100
Message-ID: <20140414203126.GB25182@sirena.org.uk>
References: <1397225400-2769-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KVy3XSgRgEDVTe6j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397225400-2769-1-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org


--KVy3XSgRgEDVTe6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 10:10:00PM +0800, Nicolin Chen wrote:

> +		/* Check if the opposite FRDE is also disabled */
> +		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {

I've applied this since it's a fix but this is *not* a triumph of
legibility, the ternery operator is often not helpful.

--KVy3XSgRgEDVTe6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTEWbAAoJELSic+t+oim9SbYP/iMzf8vQUEoMh6qZgtpcCJTp
/kvf4ZihGLA906RM+siUvfuhP7RAbnEyMRzMdlQQTXj1ck/x15SPhW+7vNoXw8iS
UE3YHazA8pBncQb60EV8VfVr3Hp38wxTp67TZLi80jAa3TEaYh7E3UqGIErqrapD
zf2sYeSxESQaa5vxCylVqzOYMAexAUA2OJraGxez1j92zfE0FkCEs7UpXSsNeqh/
Zr4IeF1lKxoXfITRPhkeApyg548O2TxewxVIGkrsJTSoCLhihCs9kkZtl0+v/IbZ
htnnVEK7fehYVSzbNTl8UNaorthZye/sc9pGmYyZrvsd8yzZxf1lGAx3uHCNCYPh
/BnuktjV1dd4pRMfWv+z9EBNHcZ2+QbsA3oBnmmRDq4CGJ5J7rHllL+FrcF1U+VH
RS5XhafZhoEQurZsFskzc1xNGGBnRsevAKrQUBGWmwexGPKEqdXt1F06iF83jeSB
qOtT3DQTRQK0xVmCz4jrhZYzlXaPQVvjY9TTYyS4htBXVkJFzUjqcNX/OfIDU+rU
LAyrY4ATyI/AWSWVq5EdVGBuAWkK07hPIS2zC7D4nbs5Z0QwFU9k0umjjC2oSdOq
zFcMN38o5m3Lzyl6lhAR+qBzCq5QR6BhUMIAeXTQ1Xb65cc6qDcb7VZURvQdD7mj
45QN6hxuLEgx0UxDQWAs
=Q04x
-----END PGP SIGNATURE-----

--KVy3XSgRgEDVTe6j--
