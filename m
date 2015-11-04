From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Add sst audio firmware for Skylake
Date: Wed, 4 Nov 2015 17:56:31 +0530
Message-ID: <20151104122631.GL12910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2029326172848643250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BE8F5260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 13:23:02 +0100 (CET)
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2029326172848643250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the Intel audio firmware for audio DSP in Skylake
platforms.

This firmware uses the Intel binary firmware release licence along with
newlibc license and is fully redistributable

The following changes since commit 66d3d8d7607c9a3a7d083f81990f6523f5842065:

  Add FW binary used by mwlwifi driver. (2015-10-18 19:28:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 33a1bc51b670ee198045b68b968d5575bd49c907:

  linux-firmware: add Skylake audio firmware (2015-11-04 17:26:40 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: add Skylake audio firmware

 LICENCE.adsp_sst         | 999 +++++++++++++++++++++++++++++++++++++++++++=
++++
 WHENCE                   |  10 +
 intel/dsp_fw_release.bin | Bin 0 -> 233472 bytes
 3 files changed, 1009 insertions(+)
 create mode 100644 LICENCE.adsp_sst
 create mode 100644 intel/dsp_fw_release.bin

Thanks
--=20
~Vinod

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWOfl3AAoJEHwUBw8lI4NHmUYQAKz4CQTS2Gq6N+HypdVAd2oD
oSLEPYQJYiTHoxhj/xaXWoOIeksybudF1Q1eVUovfjJMCR/YfxIdwQ7lK37xQTnD
8f0F5r7wRnnfIQXLXfFJ2JCdJofVzVppZVkeeEM2mwfKCwRBTXiy24tbrZEruN2x
2yrng6tw3ezPWUh6jyT5LzmqrDmgN8Xmzcbl2DbnxFHOf376wAXGa+ASEmsoT/ZM
h8qYA+SfW1x+o4xyh1Nz43OPDFuafb0MPo7tcLMLjkWU6AqmUInsqppMSSdq1hXg
IFHtksgkvfKraQMQ3YrTRM5Li7GOZn1z2PMy+IZXdBxbRmLxbZCTcsfmOIjK2Kzk
8A69/EOdN6G7hkrTGQTxgs/DPoi9u4ebG9qajI9E6Tr3kSLWj8CRbKLUEW+/I5Op
6j98tMq8QDCdPtf2bHBwL/FULi0MyHjUqQZ0Jz+Q4ZezkMb9ayRC5t2YLq8Rw7/n
h5JVJsMRVEkn/z3hus4xCWW0yUQ5HFKzYFvBPdwdcge9cuBC94g3F40BI76Dr9p7
3ydnYZHZS0sLIRMV4covPtdpyOFLt/ffe2N6GtUjGr3RhQcH1q9XJdfLJBNjN9Oj
HrPdiJ9KzDf60YQ+lqYpa/rubRJ6KVzVvC+y/nlApnfABCIfgUoi+dldB+tGjsWE
wdBsWRjzAhDyXQW/pH4R
=seMd
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

--===============2029326172848643250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2029326172848643250==--
