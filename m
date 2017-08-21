From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: intel audio firmware updates
Date: Mon, 21 Aug 2017 10:50:48 +0530
Message-ID: <20170821052042.GH3053@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3605948838511307421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE84266EAF
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 07:17:34 +0200 (CEST)
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


--===============3605948838511307421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull to receive updated KBL audio firmware. Along with this time for
some cleaning of the exiting files and remove no longer used SKL and BXT
fw files.

The following changes since commit 7d2c913dcd1be083350d97a8cb1eba24cfacbc8a:

  ath10k: update year in license (2017-06-22 12:06:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git intel

for you to fetch changes up to 7b7513e03eb6949f39fba2eb4b661c31f8ea6f5b:

  linux-firmware: intel: remove old broxton firmware (2017-08-21 10:35:32 +=
0530)

----------------------------------------------------------------
Subhransu S. Prusty (1):
      linux-firmware: intel: Update Kabylake audio firmware

Vinod Koul (2):
      linux-firmware: intel: remove old skylake firmware
      linux-firmware: intel: remove old broxton firmware

 WHENCE                        |  26 +++-----------------------
 intel/dsp_fw_bxtn_v1118.bin   | Bin 505608 -> 0 bytes
 intel/dsp_fw_bxtn_v2010.bin   | Bin 505608 -> 0 bytes
 intel/dsp_fw_bxtn_v430.bin    | Bin 505608 -> 0 bytes
 intel/dsp_fw_bxtn_v702.bin    | Bin 505608 -> 0 bytes
 intel/dsp_fw_kbl.bin          |   2 +-
 intel/dsp_fw_kbl_v2630.bin    | Bin 0 -> 243016 bytes
 intel/dsp_fw_release_v827.bin | Bin 233472 -> 0 bytes
 intel/dsp_fw_release_v869.bin | Bin 233472 -> 0 bytes
 intel/dsp_fw_release_v896.bin | Bin 233472 -> 0 bytes
 intel/dsp_fw_release_v927.bin | Bin 233472 -> 0 bytes
 intel/dsp_fw_release_v948.bin | Bin 221184 -> 0 bytes
 intel/dsp_fw_release_v951.bin | Bin 221184 -> 0 bytes
 intel/dsp_fw_release_v958.bin | Bin 221184 -> 0 bytes
 14 files changed, 4 insertions(+), 24 deletions(-)
 delete mode 100644 intel/dsp_fw_bxtn_v1118.bin
 delete mode 100644 intel/dsp_fw_bxtn_v2010.bin
 delete mode 100644 intel/dsp_fw_bxtn_v430.bin
 delete mode 100644 intel/dsp_fw_bxtn_v702.bin
 create mode 100644 intel/dsp_fw_kbl_v2630.bin
 delete mode 100644 intel/dsp_fw_release_v827.bin
 delete mode 100644 intel/dsp_fw_release_v869.bin
 delete mode 100644 intel/dsp_fw_release_v896.bin
 delete mode 100644 intel/dsp_fw_release_v927.bin
 delete mode 100644 intel/dsp_fw_release_v948.bin
 delete mode 100644 intel/dsp_fw_release_v951.bin
 delete mode 100644 intel/dsp_fw_release_v958.bin

Thanks
--=20
~Vinod

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZmm2qAAoJEHwUBw8lI4NHGqsQALIymQrwL3mC6X+4jJuaRb7x
UIOZlCu+6kDKKW1rTlEAGHRjUiJq+P+F4q2GkT8uLb+rCHG0QiMt7N5ZZNkRUsqS
jK4Z9R1d1fWxYkVftnuihfsJiF1NBT/ZaZYRhAnf+B6iQzTpCgykyZrp+JahHi4B
FAWtnvpCGZxualklS2XHq9nnLkOctuPKE6LUwO3WGQvBZH9SeCc1hTRBP9gQW09w
wadKLJo1p9930fwYp9BM5bSzOd/VX3fxF66KfZSsCfrrBnv2/MDw3vKO5NODeMLk
pAW7eUF9y7sQ5HLCzmcrQNvW/IBF9qoJckDJJne8JMwKr0KHOs3qI8OJqTEbHcp7
fHw7fGVNdosqBdEQQiQWOZLCp25NQMVtyG/RUB27X1HY1pAEPKIrfVr69b1n32OF
kZhojQug+BvEnLSDU7gOeTrnvHasmflAb3STihvXoPH64k5QDTIUw+RbJci5QErv
656m0chTexe70bBad+LD4uEDagDqgXEtT7Z/CrNoG/KBlG0PS8DrVZWHiKG0bGxB
Om9sgGsTJmCWbTcaPJPjvWY3WvktARbjG1c/5PBreElgYgV0qnDzejLEeYXvrfyf
j7tOuSSMg7pn7lLP+jQIcSCY33qgFjF+cOXVkA4saTs82FdxKApKTRjRyGDIyPVt
gOdFmGwhK3orB8F/ppGZ
=UDD4
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

--===============3605948838511307421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3605948838511307421==--
