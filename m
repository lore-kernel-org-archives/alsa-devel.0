From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Don't bypass settings if cpu-dai is
 Master
Date: Tue, 28 Oct 2014 16:05:16 +0000
Message-ID: <20141028160516.GZ18557@sirena.org.uk>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
 <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sC1KxrFoiW8MuHBc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: b02247@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--sC1KxrFoiW8MuHBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 04:48:11PM -0700, Nicolin Chen wrote:
> When cpu-dai is the DAI Master (CBM_CFx), it may need some configurations,
> set_sysclk() call for eample, for cpu-dai side in the hw_params(), even if
> the set_bias_level() has already taken care of the codec-dai side.

Applied, thanks.

--sC1KxrFoiW8MuHBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT768AAoJECTWi3JdVIfQwmUH/3kHoarWO77yk17oVY3U4Aby
R/vlzUFosMqGZBNmEFamsfbBEd5jNq9P5I5eWvOCoP7bw+OL5RU9F3XU2blZVA+d
7Nt28CXcF7ankJs0Qa2h/3tpbbAbFnx3HW/NIS/xVktH8eYrNZMZ0uVILOePBc5B
P9HWZC+k9CqCIxpi3PWzoPt9e5ipjCknDDQhhdcINrIosnK8sG7vUfUASlSk7YrU
ayMFCqFjL6etw0bX5uoVixA0qmLsOG5UZ1wMZaM7IKy4FmaRsfELhAArX2IAASD9
H7TgQtvIiTufcFUqGVnp5XL5VJME9VoL5/P1haidTca/8HfKi8lTalcVkC9hMcg=
=xXnR
-----END PGP SIGNATURE-----

--sC1KxrFoiW8MuHBc--
