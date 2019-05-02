From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL]: Second soundwire updates
Date: Thu, 2 May 2019 22:26:36 +0530
Message-ID: <20190502165636.GU3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7240925083794621687=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC109F8075A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 19:02:23 +0200 (CEST)
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


--===============7240925083794621687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

As discussed here is the second soundwire PULL request for v5.2-rc1.

The following changes since commit 4abbd783d126cabfc20d1b8d50b1d5026b5cba09:

  soundwire: intel: fix implicit header use of module.h/export.h (2019-04-1=
4 15:52:50 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.2-rc1_2

for you to fetch changes up to f3ed52bc798d7a5bc229d62374bf24173498092b:

  soundwire: remove multiple blank lines (2019-05-02 22:12:26 +0530)

----------------------------------------------------------------
2nd soundwire updates for v5.2-rc1

This includes
 - the code cleanup series from Pierre
 - subsequent cleanups from me

----------------------------------------------------------------
Pierre-Louis Bossart (27):
      soundwire: Kconfig: fix help format
      soundwire: bus: fix alignment issues
      soundwire: bus: fix typos in comments
      soundwire: bus: fix boolean comparisons
      soundwire: bus: remove spurious newline
      soundwire: bus_type: fix alignment issues
      soundwire: mipi_disco: fix alignment issues
      soundwire: mipi_disco: fix boolean comparisons
      soundwire: stream: fix alignment issues
      soundwire: slave: fix alignment issues
      soundwire: intel_init: fix alignment issues
      soundwire: intel: fix alignment issues
      soundwire: intel: protect macro parameters
      soundwire: intel: fix boolean comparison
      soundwire: cadence_master: fix alignment issues
      soundwire: cadence_master: balance parentheses
      soundwire: cadence_master: fix boolean comparisons
      soundwire: cadence_master: remove spurious newline
      soundwire: fix SPDX license for header files
      soundwire: cadence: fix SPDX license for header files
      soundwire: intel: fix SPDX license for header files
      soundwire: fix alignment issues in header files
      soundwire: cadence: fix alignment issues in header files
      soundwire: bus: remove useless parentheses
      soundwire: add missing newlines in dynamic debug logs
      soundwire: cadence: add missing newlines in dynamic debug logs
      soundwire: intel: add missing newlines in dynamic debug logs

Vinod Koul (14):
      soundwire: fix kconfig help format
      soundwire: fix SPDX license for header files
      soundwire: intel: fix SPDX license for header file
      soundwire: remove empty line before/after braces
      soundwire: cadence: remove empty line after braces
      soundwire: intel: remove empty line after braces
      soundwire: add argument to function definition
      soundwire: more alignment fixes
      soundwire: intel: more alignment fixes
      soundwire: avoid multiple assignments
      soundwire: fix more typos
      soundwire: wrap macro argument in parenthesis
      soundwire: add a blank line between functions
      soundwire: remove multiple blank lines

 drivers/soundwire/Kconfig               |   4 +-
 drivers/soundwire/bus.c                 | 150 ++++++++---------
 drivers/soundwire/bus.h                 |  16 +-
 drivers/soundwire/bus_type.c            |   4 +-
 drivers/soundwire/cadence_master.c      | 100 +++++------
 drivers/soundwire/cadence_master.h      |  22 +--
 drivers/soundwire/intel.c               | 135 ++++++++-------
 drivers/soundwire/intel.h               |   4 +-
 drivers/soundwire/intel_init.c          |  13 +-
 drivers/soundwire/mipi_disco.c          | 122 +++++++-------
 drivers/soundwire/slave.c               |  10 +-
 drivers/soundwire/stream.c              | 283 ++++++++++++++++------------=
----
 include/linux/soundwire/sdw.h           |  16 +-
 include/linux/soundwire/sdw_intel.h     |   6 +-
 include/linux/soundwire/sdw_registers.h |   5 +-
 include/linux/soundwire/sdw_type.h      |   6 +-
 16 files changed, 449 insertions(+), 447 deletions(-)

Thanks
--=20
~Vinod

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcyyFEAAoJEHwUBw8lI4NH+KQP/1lA6Xc0KTxcY7HPEL4kcQsp
sadSIX74pcJZR27/F+8L2WqJSMXkZdUoTEINpkBv8k0csonaQjCF2blVBzcvXjaJ
+egRm6T0rSNmtGX2ZudAw2Iyei5c0jcBgbphxn8OTUcXAqbQlK58cOZCG9mxgTCi
ERR9acaAD5rhYbyCIlCivGBy84FNaQVF5dMOENhMVqbDHES7ha6446pVNVFgV3jX
szIyFmoKSC7/ZU5gieaL/mNLhf8PgQjTQ6Ewrem8sPqowvSKYz1R+kraGlKNdTW1
Bd9j4OO/B/OkOFwF9Q25WNjjIhmP4U3EM9NeDsBdoly70I24WRiQ3f7c+EsFrPeX
M1Op9R8uXLVfyPzYezmA1WOQRlihqES5EqLzi/i7ueUoo69fRraQSmwpqQrdrked
uURfLqOIZpDW8JWG6L1+pd2WfHefWKIfJJm9VMv2mPy6L9cZN9WramPazbfiGMVN
+kobYDqvb28W+ukNSg5L++LRU/nXKQunbpRQL0CUNFaplTnhHXcB2wMDKrOdvp9s
F49Gy4CswznJuz/kqT85eh33rDlx0TnCACOP1DaIrgxn4RoJRsWMoM22FzBNYAkH
ILDP6YnI99ABQEp2YaH/L9VPp35t3gNVBt/ca+xT+Y0LDg2/4cumTfWzLwMddO30
AyCbn6rUKo6TfDYVuGZV
=Ity+
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

--===============7240925083794621687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7240925083794621687==--
