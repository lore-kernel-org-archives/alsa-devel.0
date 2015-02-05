From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 18:14:58 +0000
Message-ID: <20150205181458.GG21293@sirena.org.uk>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LrHETvO+Jkdo+Zl+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org


--LrHETvO+Jkdo+Zl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 11:35:07AM -0800, Kevin Strasser wrote:
> All sst firmware is provided under the intel directory of the linux-firmware
> tree. By default this directory structure is kept when installing on a target
> system. Change the path to expect a default linux-firmware installation.

Applied, thanks.  It doesn't apply as a fix but that seems to be OK as
the only request_firmware() I spotted there appears to use intel/
prefixed directories already.

--LrHETvO+Jkdo+Zl+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07MhAAoJECTWi3JdVIfQqRsH/3R4wIAoBzIYRHi+Fs5R8yQb
6yKERF8E2xmp7zniQVp5UklDNE9Qhi7ANnIlztHQTiGz60CduxhfqT9bItMs0fsA
PI7198fDHXMFIBjIda78FPzIWFkN/4YOvF/iBrdpUdatXaiH25jLB83ungQdmAHr
1ZhjLvE3007LcB5DA2OIgG4YqI7H+z2A3ODQJdywzgaPFl94NMl74f489saTJRMb
b6aMvIM6oVGQfZb5gS2akI1Mrjn7it3wmWv5HklddHV0M06Z0BhkvuKQ+UCk5nb6
6xsgHVgBAn3ciSXY3rtkFcGhNhCvbUYuLn49ASFgaXTrWu2dpEu8kXFK0BmQleA=
=fNbX
-----END PGP SIGNATURE-----

--LrHETvO+Jkdo+Zl+--
