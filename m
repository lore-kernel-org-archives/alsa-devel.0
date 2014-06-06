From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] dt: wm8904: add device tree binding document
Date: Fri, 6 Jun 2014 10:58:39 +0100
Message-ID: <20140606095839.GC2520@sirena.org.uk>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
 <1401963572-10953-4-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6nSyB+bcl/pT7+kx"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401963572-10953-4-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, boris.brezillon@free-electrons.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6nSyB+bcl/pT7+kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2014 at 06:19:30PM +0800, Bo Shen wrote:

> +  - reg: the I2C address of the device.
> +  - clocks and clock-names: reference to
> +    <Documentation/devicetree/bindings/clock/clock-bindings.txt>

This all looks good except for in the above you should list the name of
the clock (mclk) - that name is part of the binding.

--6nSyB+bcl/pT7+kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkZDMAAoJELSic+t+oim9/0UP/RrCMjaVTOwKgBUAFsZJfc0S
YPjsSo/vI1vR5fPwCeGbwsZgaaluV14tmfY8BXkwL157fwqPytQVVSt0yW9THctE
aLoJzG5wYfYs0TPD5rPN9int5Dg/wyJ8oQdBeoOUwa2i6mNpBc/Q56dX2hNWb0cR
iz6MS1Gw7MhCCGI8f/M2iTHTXnE6G/SFRybYakT4m8xUenDsG3XSKJExwir8TGgH
7Wt+4wC0dekoOxXEN2Mm7aQFUADzmI0HBWZAzJvhNpR6cYN4vkCnf156L0bSPnYZ
jLYP9Nsx2hRo74ns6waQc0m4z+VYZPTtMqxZBkLiRY28UsFd4v1idMI4cU7QsD2t
rZyYG7EK3jcPZBJgfrQ1jJ5AwLCfOk5jZmXAaHl7ddMpL55LowIxQ9QqRphxkyWY
GmAN6cWUVHKS951E3jWb8PAM/fwOoOuBORhhn2iJ/SAvfkCrPcsESurDWrSTzpRs
QjU64s48+MhVeIK5WR9/nTbFuWtOz6n6Ihlv2lyOnDVVDKR49jM9fhZ4HKKEArgG
xU06TSCHAtSGsq5TAfchlfKTE2YkCxo5Xk1dg1iVnR1wVRue2qrmlfmcVP65AMRo
I/mXJM32wRJlm6bkIUl/23x886PrLXe0SYtPUyGd47xSHgpcPg7DyQTB76Adw5vw
XbcibAl9SPBvaF4rruRF
=hzUb
-----END PGP SIGNATURE-----

--6nSyB+bcl/pT7+kx--
