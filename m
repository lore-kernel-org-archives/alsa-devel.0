From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL] soundwire fixes for v5.4-rc5
Date: Fri, 16 Aug 2019 15:27:09 +0530
Message-ID: <20190816095709.GC12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

We have couple of fixes queued up, please pull. Some more are in review,
will send them later.
These fixes are in linux-next as well.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.3-rc5

for you to fetch changes up to 8676b3ca4673517650fd509d7fa586aff87b3c28:

  soundwire: fix regmap dependencies and align with other serial links (201=
9-08-09 10:20:40 +0530)

----------------------------------------------------------------
soundwire fixes for v5.3-rc5

Pierre sent fixes which are queued now for v5.3-rc5 are:
 - regmap dependecy
 - cadence register definitions

----------------------------------------------------------------
Pierre-Louis Bossart (3):
      soundwire: cadence_master: fix register definition for SLAVE_STATE
      soundwire: cadence_master: fix definitions for INTSTAT0/1
      soundwire: fix regmap dependencies and align with other serial links

 drivers/base/regmap/Kconfig        | 2 +-
 drivers/soundwire/Kconfig          | 7 +------
 drivers/soundwire/Makefile         | 2 +-
 drivers/soundwire/cadence_master.c | 8 ++++----
 4 files changed, 7 insertions(+), 12 deletions(-)

Thanks
--=20
~Vinod

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdVn31AAoJEHwUBw8lI4NHbucQAM+0LcMCYEANet0ypYgl51j2
k8EUiwGmk+QFnyOuBmjQy57Q6SxLLBRDx5+rbXUro9AuZaWae+sobMeK/OYw++3c
PMs7s4X5bU3I9qibnv6yco4G3jh7LOraFKXbWPTL/LuJcnThTo6ml9pt1Od7dccY
FzcE0bZ/AJgN37+Oa/Wsb85gvX5Cdg5lKRqcVhFQZX3I/hvqN4Cs7dRa8UsO2xON
ZtpOdKHCchR1URSzVqWhpGIxgU1L8eBLlh0BKFeoSrVBv5Gb8XcJmCa5ypM6nZpQ
Ra3Rdv5PXJ3clrj93C2+3pwY17wISjQKjcWeo/esCmxm+Psq3sRo61hO8PFkuGm6
xNHC2djcYPyMlmPwQp75Xfr2SOAWr1Ca9W4jk2V4A3hxQ/cpocYFy9BGs9O4wzGV
kaJFeS9mBQxgMYEqinu2KeS2Ek313Q2Y8c89m924FBzCSpIlUehZImgACukMigI/
TYnk0lpMk3InbS3uHJOKQQRpMclgbhFg4x3HzFmaeYKKZGlraNUWiXYf7+ZNbBTR
o2Cqqe3CwYRsZW5EUlazQW8ZTctoGCnu26noLLKkhOecmSWNW8f3HS4/koGWTQPf
KemgIL7ZpIDOzQ5DhmcOJmCkIS8IPw8S2S7SsV1VWl4Ns2wqLv/pVOOizHaR0OLu
mJOnsFTTkm54zmzvcmAp
=JH/o
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
