From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Update sst audio firmware for Skylake
Date: Wed, 16 Mar 2016 12:14:41 +0530
Message-ID: <20160316064441.GQ13211@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2388402287731872784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EFA5C26071E
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 07:40:23 +0100 (CET)
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


--===============2388402287731872784==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the updated version of Skylake audio firmware
version 896. This contains some bug fixes and wov module fixes.

The following changes since commit 9be9ff282635c25694819c39aae0f6cc6c251c12:

  iwlwifi: add -21.ucode to WHENCE (2016-03-10 11:28:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 780f4eed8ff971bd4d6c41ecded4c99135cd36f9:

  linux-firmware: intel: Update Skylake audio firmware (2016-03-14 11:38:19=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Update Skylake audio firmware

 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v896.bin | Bin 0 -> 233472 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 intel/dsp_fw_release_v896.bin

Thanks
--=20
~Vinod

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6QDZAAoJEHwUBw8lI4NHuxIP/RD6ZSY8cntfioCogkp/qXvs
kEUrh7y+4eLLq74qTv0XLJZev7AO/RtkWrbMb9uQZZDvTDTvQMV3QhGmqcMmlIij
wyb4mTFsUx6IgYxB3GZh/7hxlt6nWU3+O6UlEP6v/fHaj6AdIMiZHA7Y8lb4Uufj
/GcQ5CAMiVlu+RQMmTHu8uCvCGFWVF5Ry8er6YBrdzDNg+qSAxJJhYU/wr+Yb41W
UBDnlKQOosbHrLk8yLkBYDZ+uJSGQkotZCorDkJtZ8ciRlC9coLt3RfmoIajJNwJ
ZJG6USSd9aC1V6sPI/8vGk+vKMlUWFTh1y4n3r2O4jOndHkKUIgQk8je6Xd09+75
1TU1dc8GIRHGdAhU7oiefOx9WQkBYhCWwbNhfsCYBx2w+6N9dFouKZIkmp0lX2uD
FufAJVQznt5QuPcgNr1IMKhiGRi5GtW0ZHKBBx8Qn7eId5lJVEwvT/XcbMDeWHb/
l7Y6OSkd3pjC0DTmQLZP6+bzXs6WyC6CiK2uPh7VzL4xxuiTgXJNdlwWlp1bxocB
OvWnF4PmOACKdPt3oru2d8zXgzARcQE/0J2rAhL7gjoTEhUrQn8qW/6tbCWg25S7
xZIsJTbqJdHEsq1lC+RZblAKOdmHUxMrNkQwJFvVLCPD8IgeNYJ+B3gDNi97JJtO
Gh9S3Bh2Icc5U0xRG0Yz
=GPob
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

--===============2388402287731872784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2388402287731872784==--
