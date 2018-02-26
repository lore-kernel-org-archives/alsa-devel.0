From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Mon, 26 Feb 2018 19:47:55 +0000
Message-ID: <20180226194755.GC6681@sirena.org.uk>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226183407.22335-1-k.marinushkin@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2018 at 07:34:07PM +0100, Kirill Marinushkin wrote:

> 2. The suggested commit breaks the existing ASoC.

> The existing functionality already works with several existing ASoC by
> Intel. The suggested commit will break it for the following reason:

> The ALSA topology mechanism loads the binary topology file into ASoC. The
> suggested commit modifies the parser, but the binaries are already created for
> the existing functionality. As a result, all existing binaries will be parsed
> incorrectly.

Are there actual binaries using the existing code or is that just
theoretical?  My impression was that this was fixing things for existing
binaries which were shipped for non-mainline kernels, is that not the
case?

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqUZGoACgkQJNaLcl1U
h9BV0wf+MnEgey/kA7HAcjeqsTX4vi86P3zsbAnGfZYhXuwF9pkef8IpXuhkegtu
A84aSCBlVh5FHlbtEJ7lBIb6I2wL2LWhQa2OhZGOAM3zov5UzOzx0aUaeryKG1vZ
0Q82EHSiggGXxIbWkx6e0y8ffeG0LudgFdPmc72YRt/TkwV+HQEjE+fliw30QGl8
yjvQZaSCjPUMliQ5LEcMU6cjkp06qXyTFLGB5bCDXoP+GTvfCQhB8y12Ie0pQ+g6
by37Wf3Kr1K61QIIme5mVr++gC0XCi40xqaOTC5PUnLfEpN220iwv82AZ6JyadxI
iQouk4ykjSiPAOyNQJF02oPQ8k9JTg==
=DETx
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
