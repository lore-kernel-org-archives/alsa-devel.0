From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Update sst audio firmware for Skylake
Date: Thu, 5 May 2016 12:23:52 +0530
Message-ID: <20160505065352.GV2274@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2622313728615592475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CFE8261AFF
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 08:48:08 +0200 (CEST)
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


--===============2622313728615592475==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gQyIpR7q4QSXYu+"
Content-Disposition: inline


--7gQyIpR7q4QSXYu+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the updated version of Skylake audio
firmware version 927. This contains off fixes for system wake and
wov module handler.

The following changes since commit 8afadbe553017bec1e442b5a9fba859b54fd33fb:

  ath10k: QCA9377 hw1.0: add firmware and board files (2016-05-03 13:15:57 =
-0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 40d7ffa911fe52d63a12a4cc51231580f81a5fcf:

  linux-firmware: intel: Update Skylake audio firmware (2016-05-05 12:06:56=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v927.bin | Bin 0 -> 233472 bytes
 3 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 intel/dsp_fw_release_v927.bin

--=20
~Vinod

--7gQyIpR7q4QSXYu+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXKu4AAAoJEHwUBw8lI4NHssUQAJp/FbwR66WIkcAC6dGHy5jq
3hGsjbOkJPkSRlt0m8aIiJ5TZmRs60PMTQQHh8FttWtpRCSxlVklx7oIIo6SGnzb
52EI1EUi4j6kw4Duh2NSpqjANu8oR4Peb6KoQO1yIMl2jbkMrzxd7DCoUOhU4x5H
hnqR8uRYHvH+ulP0y9l8FiCa6kDDLwxTUMhxlKs7iTBqpPUaVZZ0c6jmuXyIXlyZ
UoRAA5SR5+1Wv4w3kZUnMGIlqVGKff6y4jyaGTvMnjHWb/MVYfG9FEEeLtPwCtgl
N+m/Liw1Sv/uGveM7A9Km1rTMhWRhgnCxLVn2DbwfYelPshx9t+OuL4t4AAxwSiY
PQ3Zo0EN7u7ystjQXbTT2PtTz4Gl9TlqWK1MdtMefFWcTIvT6spPLpdjBqGTc742
/sB67Fuw9NcQRwMklhCOkc7zF6aVSVdOHZRCQKbM02/Y+cbS5f0R1vdTtSBnfMjZ
xmcCAi1OcuPrhp1XBmHLF8s8JpEyrS+/kpXw22Msifh1qcqW+kwCd+gL16ADpxwn
NlyyaVMbYMsAksyqGo/wNS+nxjTI4pgEiwHEVNTm4T0VQyBHP27eqoZW8DwCQwre
G576Z88d0su8tAF5RiVAdD0qXbTubWIf17r9T6rC0QtfVsgYIleKlwmQegKkFF4N
utpi9HNlIp1ebCTkHt2v
=w+3a
-----END PGP SIGNATURE-----

--7gQyIpR7q4QSXYu+--

--===============2622313728615592475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2622313728615592475==--
