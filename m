From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: make Kconfig selects depend on ACPI
Date: Tue, 29 Mar 2016 09:51:46 -0700
Message-ID: <20160329165146.GR2350@sirena.org.uk>
References: <56FAB111.2070503@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvRocJ6whMXXNc9q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FAB111.2070503@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--vvRocJ6whMXXNc9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 09:45:05AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Prevent SND_SST_IPC_ACPI from being selected when CONFIG_ACPI is
> not enabled.  This fixes the kconfig warning:

These are drivers which can't be instantiated without ACPI...

--vvRocJ6whMXXNc9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rKhAAoJECTWi3JdVIfQ/fcH/iYucVq92RMheV5l4HO+dmlJ
q6X33PuXJEs6J5VQ8okNOvX/U5LRLuxZfamE1AemBPljKeqPIqzJ3EXiguraht5G
XvNGUxrLSYERFL5polMxU0GdeXxFOFX0GK8qkgpiUB65Z10puTnlwWXwx4xkG46N
HrjcA51Ry2AZs5DFtiK7UWdt81KQ6C/VKzgYEyBP/6pKiXImY9FFg1KvTqeICR9x
GvJTNqQu6/GwxjqvyH5eSBFYT2vFzGk/yuZFbqdA2FumRBjay1g5KEr3srU3q7vV
kn2V8nIB0R1o0OovMefVp8+JXAeACDx8j1iY5htI3LAYbT0r8r62A6KvNr8FD6o=
=SZAz
-----END PGP SIGNATURE-----

--vvRocJ6whMXXNc9q--
