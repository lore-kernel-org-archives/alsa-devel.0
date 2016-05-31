From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Add audio firmware for Broxton
Date: Tue, 31 May 2016 09:28:11 +0530
Message-ID: <20160531035811.GL16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3136883572749917608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 94179265D29
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 05:51:51 +0200 (CEST)
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


--===============3136883572749917608==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the Intel audio firmware for audio DSP in Broxton
platforms. This firmware comes with same license as audio firmware for
Skylake and is fully redistributable.


The following changes since commit 7db6ab934fc0196c41f40ea07218de2cab27abb5:

  qed: Add FW 8.10.5.0 (2016-05-29 10:16:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git apl

for you to fetch changes up to f5598347032b1e4dd49e15401a1a9b867062625c:

  linux-firmware: intel: Add Broxton audio firmware (2016-05-31 09:20:44 +0=
530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Add Broxton audio firmware

 WHENCE                     |   6 ++++++
 intel/dsp_fw_bxtn.bin      |   1 +
 intel/dsp_fw_bxtn_v430.bin | Bin 0 -> 505608 bytes
 3 files changed, 7 insertions(+)
 create mode 120000 intel/dsp_fw_bxtn.bin
 create mode 100644 intel/dsp_fw_bxtn_v430.bin

Thanks
--=20
~Vinod

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXTQvTAAoJEHwUBw8lI4NHACoP/1foOXWzSE7WDJaUXNvtgCoy
4CDLlRPvZ+0OqK7/6A2kOiWmf6Ljb7TZgHW39nL/JiGNInlMVoGiNy4C0upofAm4
vUJAndP83fLQvYXOSlz5qgK6+HuwI44WQPLmJuxlYGV5NHEDbGq8q6c0iecdwMZ0
b/IoE0xnP75GYQo82Be4gQlVGKh1on7d1IixjMblTw17TrDUGtrFiwmUoD0GerzF
ozbHeq2wHdFcT/Ry7kORd/pkc+obRSHCTe6zXiOnoQub2T5fAar8WLhieDKqFK24
L15NSl7c0H6fi6yLLWu1uRCB4FjvyxF/Zbg3mFGFtypCtPW/l1GRe8nGWGX74Rqy
JH19xAW18vX30uqmB5yiJjG3HIBMZAJXCiIWU0m+TzauOtzwGLP4OfjxBgXlddkd
r8gkogw9XR/0bHvIJ8B0tG5kVOyJOVOnoYFTikeXmhxbxEhm3t5tCDpI3jY14FVE
l4d9OKhrJUcku6lQsJYnaiibZphtXVOo1TRqcxE6y/pw2cuUVyuTE5GiaPvVdh7B
BAdZXHrLZBMIGNG8WU/Ja6OHHUTrYMXokikDPwah1cHZb1wNEmIGDprN6NwIIra5
xuMpI8iVIABzlA7tQTuXlQAk2oL7ZVG+s6Db2KOAAUCFdsJ3w4hN91H3EkQsqQdB
+N+sBSRBuHgSJCbbEwl+
=YAd9
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

--===============3136883572749917608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3136883572749917608==--
