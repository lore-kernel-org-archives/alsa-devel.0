From: Mark Brown <broonie@kernel.org>
Subject: Re: Splitting out controls
Date: Fri, 30 Oct 2015 11:36:18 +0900
Message-ID: <20151030023618.GR28319@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
 <561CADA8.3040903@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324633006520330855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D219265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:36:25 +0100 (CET)
In-Reply-To: <561CADA8.3040903@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org


--===============0324633006520330855==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="htVlOAOs/VIaEhiC"
Content-Disposition: inline


--htVlOAOs/VIaEhiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2015 at 09:07:20AM +0200, David Henningsson wrote:
> On 2015-10-12 22:59, James Cameron wrote:

James, please don't drop CCs (this is the convention for kernel lists).

> I personally believe that if the physical hardware can be set to state where
> it's bricked, the hardware itself is buggy.

> If the hardware is buggy, this should be worked around in BIOS or whatever
> firmware is present on the machine. Otherwise there is a bug in BIOS.

This is just not possible for most systems, there is no BIOS only a
bootoloader which hands off control to the kernel and stops running at
that point.

--htVlOAOs/VIaEhiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMtedAAoJECTWi3JdVIfQzNgH/2X5QSqd83R4EcHioJrv3wbS
5T+DweLqc7svJbdgvzjiu+QMglnbEzgWL0MHWyHKkVDrWSPDeM3dv/sNmXEcOJMb
e8Ths5lYYw5+W0VbSd8q6wjSTFsiCH4z/JxixqNeWW7Pd38exB9AE6cCTKgUr+yo
4S6vLOPgnezZFb84Wz842fMNCR8sKHS8pPxhBlVCEtt/x9idCtNu8vjw8mLjoxZh
XKvfbMu2xmLGVmJMG2SFdA4Q7gLEcf8c49U5jOO/T4jZxYFAT3uHJH6gok2iB8tV
3901w9uEGiLOtjs5F3Zdmal8wpVR2ufEPNVN63bfbwWV3CsSB4xFpgaK7ba82lE=
=8MpL
-----END PGP SIGNATURE-----

--htVlOAOs/VIaEhiC--

--===============0324633006520330855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0324633006520330855==--
