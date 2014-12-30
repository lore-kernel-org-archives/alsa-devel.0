From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] mfd: wm8994: use PLATFORM_DEVID_AUTO for
 regulator devs creation to avoid conflicts
Date: Tue, 30 Dec 2014 11:28:21 +0000
Message-ID: <20141230112821.GL11764@sirena.org.uk>
References: <1419918320-12693-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Epw7rTp1fwvhE3T0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419918320-12693-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: lgirdwood@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Epw7rTp1fwvhE3T0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2014 at 02:45:20PM +0900, Inha Song wrote:
> After commit: 6e3f62f0793e ("mfd: core: Fix platform-device id generation")
> We must set the id base when register a duplicate name of mfd_cell.
> but, if we use PLATFORM_DEVID_AUTO flag, cell ids are automatically
> allocated and managed without cell id setting.

The driver relies on getting those specific IDs in order to work out
which LDO it's working with, automatically generated numbers may be the
same now but can you guarantee that in future?

--Epw7rTp1fwvhE3T0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUooxUAAoJECTWi3JdVIfQrPcH/3yUFFqmcLkLc0lFAJlcKW1a
JNoMaQaO/akL7u10EqvEbYJ049DXJG1JCS/H8Tofc5UAeUaBfqmeBYH6PhrYXvyB
Exr9+fbw1i34gCQQxCdgS5iqtQSiReegcOTBbGBk3PWbjkehhtOg+7HO9JfrJBDn
ZlQIva2eG7vP7Khb/zPKtkeIT5kHkfibBmRfmUic4e9dDpt0XD+C+4CdyxQq0Y5g
+OyUBp5v4PIn04dWsQ/+HWfiqCcSypKyjQSEWV9x3ouCbZGGOu227oF757UbQ9LF
OptD862Yjf0x86UhsZrH3BUn6kiqsDPS0f1ZQ8Le4fmj1fAzlRCukG/eGjuMncI=
=+I5x
-----END PGP SIGNATURE-----

--Epw7rTp1fwvhE3T0--
