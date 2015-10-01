From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Prevent writing reserved registers on tlv320aic3104
 CODECs
Date: Thu, 1 Oct 2015 11:15:36 +0100
Message-ID: <20151001101536.GB12635@sirena.org.uk>
References: <1443655493-5554-1-git-send-email-rmann@latencyzero.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443655493-5554-1-git-send-email-rmann@latencyzero.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rick Mann <rmann@latencyzero.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2015 at 04:24:53PM -0700, Rick Mann wrote:
> The current code writes a set of registers that are reserved on the tlc320aic3104. The change skips those registers for that IC.

I'll apply this but please keep your commit logs wrapped at
considerably less than 80 columns and use subject lines reflecting the
style for the subsystem - see SubmittingPatches for details.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDQfHAAoJECTWi3JdVIfQsHwH/Rh/lO4TZabs/YfBLFbEcxGN
tYECWtlbyNmRlTlEaQ0HH9h5OKhNo5DV4pNcz3QrKVzGasJvjkKg+PzraDg+KyrN
CjI1/e2UWi0IQguTFJLJvbR8JPvVRuml5ke27FSNPwlNHFpw6zRRLm7oDcrHjxRK
kCxlrHB1LLnudJDB2Li7ZPt/62lWHUbgC7HCTK2unbgb7nzDe/LubRVmCS542tYL
daa2826/TnLQv/C+Q6h1WYM4PZsU4He6ZHDlg/UaSvJMZAgGwntDf0py5C7pcUtz
SDev3xrUKMzxwgTZ3eutuQsABbIhQ85TSIymaYlKlJlkKUQwbK8NpO7YPqNV7O4=
=qRw0
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
