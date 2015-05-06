From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas571x: Eliminate redundant dev->of_node NULL
 check
Date: Wed, 6 May 2015 11:37:40 +0100
Message-ID: <20150506103740.GK22845@sirena.org.uk>
References: <1430866350-21391-1-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jiS9VSgpxNAFFmzS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430866350-21391-1-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jiS9VSgpxNAFFmzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:52:29PM -0700, Kevin Cernekee wrote:
> of_match_device() checks if dev->of_node is NULL, so we don't need to do
> it again in the probe function.

Applied, thanks.

--jiS9VSgpxNAFFmzS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSe70AAoJECTWi3JdVIfQtj0H/jZBFrbSc8PfwAmfK0tVmRmC
JKEnBquUPPc9Kgx9Qwj+auKwGM5v0geLmGn4Eg6scccEJY+08VzBznWcyPF0vnEQ
3kNlSKA0l7WldYmqcSTgZ/ZnQZL/aR+/NTSd+CPB2B/Rtw6twzzgmvJ65Gm0rgnW
Q4g5hiF4N5j/ptobJGnwwK0/AVvQuxGlHxgSSaxfkYV7ApXkmGZAj08kmhYId5N7
2kPs1BkJVv8poVj5EL+XU2PDOEkuR4hgDE39Hr8B4hyq1PpajWM6ZO0xvgVHWv7O
CKZ8RWm+a0lR/2GPjP++UI+t//JM87OwdI2FKkYFtr8uQGAlwDtEOyUd1enRCtM=
=dFU0
-----END PGP SIGNATURE-----

--jiS9VSgpxNAFFmzS--
