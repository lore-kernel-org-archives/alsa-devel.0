From: Vinod Koul <vinod.koul@intel.com>
Subject: Resend [GIT PULL]: Update sst audio firmware for
	Skylake
Date: Fri, 5 Feb 2016 13:08:20 +0530
Message-ID: <20160205073820.GD2531@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4749600633892648529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E502605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 08:34:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-firmware@kernel.org
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4749600633892648529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resending again as previous email bounced for linux-firmware@kernel.org...

Hello Linux firmware maintainers,

Please PULL to receive the updated version of Skylake audio firmware.

This PULL request has two patches, first one creates a sym link for binary
name which helps us to keep different versions of firmware in git

Second one updates to latest FW v869

The following changes since commit 52442afee9907bc32a058f22bb3295d040677c26:

  brcm: add firmware for bcm4366 device (2016-01-25 15:15:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to f7996657e8f25386541593242cb8e906d9808ec7:

  linux-firmware: intel: Update Skylake audio firmware (2016-02-04 10:36:52=
 +0530)

----------------------------------------------------------------
Vinod Koul (2):
      linux-firmware: intel: add symbolic link and file versions
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      | Bin 233472 -> 23 bytes
 intel/dsp_fw_release_v827.bin | Bin 0 -> 233472 bytes
 intel/dsp_fw_release_v869.bin | Bin 0 -> 233472 bytes
 4 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 =3D> 120000 intel/dsp_fw_release.bin
 create mode 100644 intel/dsp_fw_release_v827.bin
 create mode 100644 intel/dsp_fw_release_v869.bin

Thanks
--=20
~Vinod

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWtFFsAAoJEHwUBw8lI4NHGsMQAJAHbHKX6SU6jneTGjcx6JuA
zlbkpPF1kfa6gKJDViqZb5T4vNA7Ko6rn1t2EGL8coSdayFU4ROBIR59/DmKCh8W
5vLJGvASAwopMQIjAzMdaPDVJ2WhspGhzJHtr5CwmiFT+J0oi5aOIRT7sBvb5aYb
yFIcydBbwx9ho+xM4TrCsOQKAr/6VekHtWZ2BKLnKHPYFHB2DljTnFYbAnovc4+e
5Mxs9QXz3mWox+pDJsFEqBdt40y48Wmg4GngkACFHTH5j2OhlWWxvGf0FV5u+ENV
aU6hvmWoMv0jCpABY4Vz65vl49y0e0hNfGSyfWVxTYa6r9dWe6TrLvLCkACf+wPu
usICXnVxGd475SRbotgEhyA8bkhrNqgoF/xMVhaVKrWECF4MptI9MkoUM3AUvNA2
ODfGchSKNl5LonM1scX4VlD3tuMd/vR/DKcPuZl6XNXa33CKhMYLyS8DK8QjKK6Y
Cs3amqMeEpFp3vUDG6PxMbMdCkrhcWd1NOvAuGCxoSewZD9yYdRAe2Whls/mTKGq
PWaHWZS2HtNSdd5KH0P3fosdyhVGGjEzl3KyQaVs1pdGHF5mUr9J4355ny+b4knc
y2k6o74qXj3gg2qSyuhQozGsYHSiglnf891AocrhnNNp/1ar1qwKv3Uw57d5LrYe
XYZPV8pQN5e91fUV8cc9
=nwVb
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

--===============4749600633892648529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4749600633892648529==--
