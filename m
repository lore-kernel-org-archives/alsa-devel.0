From: Vinod <vkoul@kernel.org>
Subject: [GIT PULL] soundwire updates
Date: Fri, 11 May 2018 22:17:06 +0530
Message-ID: <20180511164706.GE32709@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6568362352174382165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 410D8267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 18:47:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6568362352174382165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

As discussed here is the pull request containing SoundWire streaming patches
and email update patch for me.
I have added Mark's Ack on ASoC patch as well.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git next

for you to fetch changes up to c46302ec554c575e79d791c7c84fd4c795e97680:

  soundwire: intel: Add audio DAI ops (2018-05-11 21:48:07 +0530)

----------------------------------------------------------------
Sanyog Kale (7):
      Documentation: soundwire: Add more documentation
      soundwire: Add support for SoundWire stream management
      soundwire: Add support for port management
      soundwire: Add Master and Slave port programming
      soundwire: Add helpers for ports operations
      soundwire: Add bank switch routine
      soundwire: Add stream configuration APIs

Shreyas NC (2):
      ASoC: Add SoundWire stream programming interface
      soundwire: Remove cdns_master_ops

Vinod Koul (5):
      soundwire: Update email address for Vinod
      soundwire: cdns: Add port routines
      soundwire: cdns: Add stream routines
      soundwire: intel: Add stream initialization
      soundwire: intel: Add audio DAI ops

 .../driver-api/soundwire/error_handling.rst        |   65 +
 Documentation/driver-api/soundwire/index.rst       |    3 +
 Documentation/driver-api/soundwire/locking.rst     |  106 ++
 Documentation/driver-api/soundwire/stream.rst      |  372 +++++
 MAINTAINERS                                        |    2 +-
 drivers/soundwire/Kconfig                          |    2 +-
 drivers/soundwire/Makefile                         |    2 +-
 drivers/soundwire/bus.c                            |   43 +
 drivers/soundwire/bus.h                            |   72 +
 drivers/soundwire/cadence_master.c                 |  451 +++++-
 drivers/soundwire/cadence_master.h                 |  151 ++
 drivers/soundwire/intel.c                          |  525 ++++++-
 drivers/soundwire/intel.h                          |    4 +
 drivers/soundwire/intel_init.c                     |    3 +
 drivers/soundwire/stream.c                         | 1479 ++++++++++++++++=
++++
 include/linux/soundwire/sdw.h                      |  332 ++++-
 include/linux/soundwire/sdw_intel.h                |   14 +
 include/sound/soc-dai.h                            |   23 +
 18 files changed, 3634 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
 create mode 100644 Documentation/driver-api/soundwire/locking.rst
 create mode 100644 Documentation/driver-api/soundwire/stream.rst
 create mode 100644 drivers/soundwire/stream.c

Thanks
--=20
~Vinod

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa9ckKAAoJEHwUBw8lI4NH6ccP/R/TiVFeMpIi0qIW394GcD/X
uCYASl1fcqpye5QnDhUDZYighhSGfsMCliWPELASy58efJ2TxF1hu2Dbk44T3rgN
IRIOEcLCDMc7kt/ALtO3pTUih5KEg6EPK728FP8Fs3fQdw/Fz7iIeqB8eTVAmA5D
GEoOplvP3E6MlopKbkLjpA4TwW90ELbLpAGNdpCM5ABLB8lRCwN5FlO7gVyHJXd9
C5ZjljGLB/Pq0BeLPIqEnZP8v/NEARkOo6UOIgGAknNZswEAeGahUDOEBYFVVoZw
ka0q+5Ycd1SjbPdQntw147NtRURNg0ftf6YfrxA2elP+eZo1YF/3EdZ4LTi4tAAs
IOQ5xIT/8Ns3w3OtrwgBzg9tStUavLItAGxs/V9X6jyv4r2ajnZOGetoXYpzhEc/
0/jHS3czEABIMi6w/Bpb/Y482pn6Ksi6YHAUwge4H8NjC83uyqbtTE8EVjAXaQDy
6IVaJJYbpkh4Os20yf+2sZQlNRj97pcxgp8bR7lOLdarNAaQSNXSQgfbouBt5mf+
ReDjM6mKMETNRRmI/y98F+4d1pfzrbW1LW/yPL1L0/V70j5882JxckOHx+WQ7U8H
QCx+u/g94M+ONJ5EAVtT/OIE613FZuRUDBzubU3sX13munWjzCZsq/ut8NiKPHXJ
n5Xl+JdAg1xx+Q9ZefgL
=1aZm
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--===============6568362352174382165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6568362352174382165==--
