From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] soundwire updates for v5.2-rc1
Date: Mon, 29 Apr 2019 16:58:29 +0530
Message-ID: <20190429112829.GH3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4953711455552681611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46AC8F806E7
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 13:28:43 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4953711455552681611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Please PULL to receive updates to soundwire subsystem

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.2-rc1

for you to fetch changes up to 4abbd783d126cabfc20d1b8d50b1d5026b5cba09:

  soundwire: intel: fix implicit header use of module.h/export.h (2019-04-1=
4 15:52:50 +0530)

----------------------------------------------------------------
soundwire updates for v5.2-rc1

This round saw interest from Intel, Linaro and Cadence in
Soundwire. More patches are in pipeline (maybe next cycle)

 - removal of useless initialzation in core
 - couple of header and kcalloc inversion fixes on Intel driver

----------------------------------------------------------------
Paul Gortmaker (1):
      soundwire: intel: fix implicit header use of module.h/export.h

Pierre-Louis Bossart (3):
      soundwire: intel: fix inversion in devm_kcalloc parameters
      soundwire: remove useless initializations
      soundwire: stream: remove useless initialization of local variable

 drivers/soundwire/bus.c        | 2 --
 drivers/soundwire/intel.c      | 5 +++--
 drivers/soundwire/intel_init.c | 2 ++
 drivers/soundwire/stream.c     | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

Thanks
--=20
~Vinod

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcxt/dAAoJEHwUBw8lI4NHz4AQAJAOb2nb95UYUxrr0RLV+jCv
PRb7otRSeBJMfWcfAFVWdf2i4bdOeD/k4iGxYpYx/nWDtzHtLciZ2u+7S/+z+5bd
KKCYpmuCEkhWgm0USTwuZzNV8DOHTnR8eOTrS79nueJHqZolcPyhnWOBXIpqC8Gd
GiXFxedbsk/pXvs0Rj3HZLxQkFgSPlNg4rW69KWCNUMRpn70BsMv9xAaBrJRs5mx
2XdtUqx8HPxgXXOA5eeo1d/UIZ6/9SSHvSYTb45CE4AVhqvFNnw5R4a/HH3A3Coa
8nk0PAU79FFmHUIS8hpqk2qppL18+byuruiog99myI6J96GeS0UkuWwFX+C2mhdj
4+DzaOBXapO0wB2tv2tqM5IxQAav5yOLywu4FccCzrXSKqv6tBnKjFQMk+0PIz3q
cnmb3+FztSRpDFzYKbTGIabRT2rXjEBiHuh5b9RbjPpQTECdRCr9VyVgFILYinez
EMoidk5kB2ErVa7vx9QQdTapAJPNOeruRXaNGiOZHz+weeECUpNM9R74h35TFTU8
sU1DD8Na48dFW58DGS0s5SDcUgvtQWcGrwhJW4+MtV8ASs9EPIcfdLWKZeB+RMql
BRYg/xaykYvriTaupv3HffnuzrXfwI6nZTNk9uM9mmyfmqKRd7AgS/7YSINQsxxC
UQUF0H8CpChsCpn1a/Is
=I1sV
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============4953711455552681611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4953711455552681611==--
