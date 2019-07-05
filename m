From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.3-rc1
Date: Fri, 5 Jul 2019 10:38:13 +0530
Message-ID: <20190705050813.GT2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4615413336554496662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8C60F800E6
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2019 07:11:25 +0200 (CEST)
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


--===============4615413336554496662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive the updates for soundwire for v5.3.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.3-rc1

for you to fetch changes up to 2aeac95d1a4cc85aae57ab842d5c3340df0f817f:

  soundwire: add module_sdw_driver helper macro (2019-07-01 11:52:43 +0530)

----------------------------------------------------------------
soundwire updates for v5.3-rc1

Updates for 5.3 include:
 - module_sdw_driver macro for drivers
 - Documentation updates for code-blocks
 - Improvement from Pierre on intel and cadence driver
 - Clarification of DisCo properties and updates

----------------------------------------------------------------
Jan Kotas (1):
      soundwire: cdns: Fix compilation error on arm64

Mauro Carvalho Chehab (1):
      docs: soundwire: locking: fix tags for a code-block

Pierre-Louis Bossart (15):
      soundwire: intel: filter SoundWire controller device search
      soundwire: mipi_disco: fix master/link error
      soundwire: add port-related definitions
      soundwire: remove master data port properties
      soundwire: mipi-disco: remove master_count property for masters
      soundwire: rename 'freq' fields
      soundwire: mipi-disco: fix clock stop modes
      soundwire: clarify comment
      soundwire: rename/clarify MIPI DisCo properties
      soundwire: cadence_master: use rate_limited dynamic debug
      soundwire: cadence_master: log Slave status mask on errors
      soundwire: cadence_master: check the number of bidir PDIs
      soundwire: Intel: add log for number of PCM and PDM PDIs
      soundwire: fix typo in comments
      soundwire: intel_init: add checks on link numbers

Srinivas Kandagatla (1):
      soundwire: add module_sdw_driver helper macro

 Documentation/driver-api/soundwire/locking.rst |  4 +-
 drivers/soundwire/bus.c                        |  6 +-
 drivers/soundwire/cadence_master.c             | 30 +++++----
 drivers/soundwire/intel.c                      | 17 +++--
 drivers/soundwire/intel.h                      |  2 +-
 drivers/soundwire/intel_init.c                 | 25 +++++++-
 drivers/soundwire/mipi_disco.c                 | 35 +++++-----
 drivers/soundwire/stream.c                     |  8 +--
 include/linux/soundwire/sdw.h                  | 88 ++++++++++++++++++++--=
----
 include/linux/soundwire/sdw_type.h             | 11 ++++
 10 files changed, 162 insertions(+), 64 deletions(-)

--=20
~Vinod

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdHts9AAoJEHwUBw8lI4NHcdsQAJRMhyfZPdEo3XB+L3REtCC1
RuJz8AsFt5evH4yD+cMUPeSV8kAV3h2WjjcPH3N2d7oZS/8zkTj4POce7+2L2iLi
kP9Z8x+LiSHrpgGZd+9Wp+Y/0MWHZp7sUH9p9RxO5r39wVCVKiy9eCw8ZOx46IBM
1JBueQAot0N0MeCrnfwpv+OaCOrnrfO0ITaPypBXvbNtDAtFSpmHDmAgoVKcF1Cd
yfic4xCOdBVRByLJe/3C1kP3iU7T35sXYk5ONjFGo3Smgl94Th973nHli84cWxwW
WCKU9lSm1A0n4GKMYBEmlZmhIe9+n/e3EXKxAkpV689s/uSqresl+utjM8f4JOEu
dEhNDCK6+RvIxgwCFGGbM5nBdIMieE6vzycyyuPBHLEKLe97pY5GcV0nISGghZxZ
m7hDxNFqrmmCEyJ2sXXdljuDvfLkP5K+Q7msTHWllM48n82wIC+5UHStQOgFmheR
MzItfk84Owikx7vRvOBzPmdkceiks/5eEKuDOltI9y+xg6onfXub5cxiSz+yjPdw
s/KUOudlZrRhby8SUoldSBVfIf/CKqpVxmYFyqnpu/YSeIlRKmPFm3xpMjygRU/E
LKMrFvWJKMIj+NWAizwjdaF6DQ0L0GykxMgOPyARQUbaYvIBbYcSjqV94skn9Dg4
4QenkRxulsytX6KI3kfk
=5Z75
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============4615413336554496662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4615413336554496662==--
