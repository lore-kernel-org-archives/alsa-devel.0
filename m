From: Vinod <vkoul@kernel.org>
Subject: Re: [GIT PULL] soundwire updates
Date: Sun, 13 May 2018 10:53:54 +0530
Message-ID: <20180513052354.GA2967@vkoul-mobl>
References: <20180511164706.GE32709@vkoul-mobl.Dlink>
 <20180512141359.GC6591@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6635022657422241162=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 2905E267359
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 07:30:03 +0200 (CEST)
In-Reply-To: <20180512141359.GC6591@kroah.com>
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


--===============6635022657422241162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12-05-18, 16:13, Greg KH wrote:
> On Fri, May 11, 2018 at 10:17:06PM +0530, Vinod wrote:
> > Hi Greg,
> >=20
> > As discussed here is the pull request containing SoundWire streaming pa=
tches
> > and email update patch for me.
> > I have added Mark's Ack on ASoC patch as well.
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git next
>=20
> Can I get a signed-tag to pull from?  That looks like a random branch, I
> don't really "trust" that :)

No worried I wasn't aware of your preference, so here you go with a signed =
tag.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-streaming

for you to fetch changes up to c46302ec554c575e79d791c7c84fd4c795e97680:

  soundwire: intel: Add audio DAI ops (2018-05-11 21:48:07 +0530)

----------------------------------------------------------------
soundwire streaming

This contains:
 - Support for SoundWire Streaming
 - Documentation updates for streaming
 - Cadence and Intel driver updates for streaming
 - ASoC API for programming soundwire stream

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

--=20
~Vinod

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa98vqAAoJEHwUBw8lI4NH2z8P/Asp61E2WVzDceQU1taDCvTa
i+SaiV47Az57O5gcw/UVVqT/9RQBzv6hh3TNCZ4yDqidrsGX8QElzJAdNSMN4u9+
4YjmrFoAzk/9kU750iQ8J3HmT6rKDjtZgsIRYsriKO3Pi8WXq7ZuJtR36bSDfK/d
sEva8qqJbsSQ5qe01I/4WQvaAV8ctTcTRQ23WAEV1U9GVUoiQJktzRDok9wS9/G/
Uf/wLzv0DWImxePwsYP6CTS4QLTiqy1pWRNzUOc/F+ZAUcNw4BOcKnCm78JPrvXu
TeWJc4svOh1HG+QXGbs0SSOc3R4xWtnRxDdPJLcwFiwEeFd7BP1GT8uhwDSaEfdT
xXc4WIXkyfXQjtxI7WZ99iTogZHqxKyfR/KeLSw7AYs7PmQW+YnMvUnHwcLTa0jG
5JLPjNustCWfbVgYLYdMf6sM8aod3/0eSCrsHRQQ/ucUnlbKUrlsPn4mxmKZyPkk
5y6SlviPidMQqWdpJKJhkk1yeW9LZC0PGH733O0ebg/tJW86dJc09Br8tPn/kBgd
57ZeHiNx6Kx9b1O8rZgv+yGKk4NMOIIln6PrfPRsZBdVhvE6imsnFQ3NeB3Vy+EK
AdUHSPHSFG0BXd2xHqRyKqUaiIPVk0NtLVGVARAyhMJWclh1igq4gnBFypGctbMo
UiCr9WiDf8MYxl/pkNrK
=7W2k
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============6635022657422241162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6635022657422241162==--
