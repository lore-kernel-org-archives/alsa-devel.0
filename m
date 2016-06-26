From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use generic FW
 functions
Date: Sun, 26 Jun 2016 12:42:06 +0100
Message-ID: <20160626114206.GM28202@sirena.org.uk>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
 <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
 <20160621232116.GG28202@sirena.org.uk>
 <CAJZ5v0g47+igo+Z+gZZE9sOix8oCs7Jy+H-i=HcBUB+RVib3+g@mail.gmail.com>
 <20160623100148.GV28202@sirena.org.uk>
 <CAJZ5v0hjQ=j+KOV8PMR47vx+=LLZMHqGdrVBZtDsF6WhFGkcQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PoUpPrJlcBv0qM6G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hjQ=j+KOV8PMR47vx+=LLZMHqGdrVBZtDsF6WhFGkcQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--PoUpPrJlcBv0qM6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2016 at 02:57:35PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2016 at 12:01 PM, Mark Brown <broonie@kernel.org> wrote:

> > That works too, if I do that I'll make a tag in case it needs to get
> > pulled elsewhere.

> Sounds good, thanks!

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/dev-prop-named-child

for you to fetch changes up to 613e97218ccbd7f33895cad4525d861810a9d5d5:

  device property: Add function to search for named child of device (2016-06-26 12:39:03 +0100)

----------------------------------------------------------------
device property: Add function to search for named child of device

This adds a function to the device property API allowing us to look up
the named child of a device.

----------------------------------------------------------------
Adam Thomson (1):
      device property: Add function to search for named child of device

 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  7 +++++++
 include/linux/acpi.h     |  6 ++++++
 include/linux/of.h       | 14 +++++++-------
 include/linux/property.h |  3 +++
 5 files changed, 51 insertions(+), 7 deletions(-)

--PoUpPrJlcBv0qM6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb7+LAAoJECTWi3JdVIfQGOwH/irmsQV2M9wEm6hToXlbABV4
ViP4eMVAOo3ltNWL+y0vmwQoy1JNUR5HhO2sLE3ybO2LpScK8F0oYybg4izaNoEV
z7pFB1Cdiv1szC9UG+upXRwgoSG0Z3gnItzNc8u9vtxX0n+UHQ2AYTYqaqjkGDrE
gwcrzUo066eOr3fY90c/Pgyqe8Fv6pTYEG9JxjuZjvltc9AHWhKqtyeBdHvd9hML
BUVntyH6Bk+Ld2vORS129hESSonAypkQSB9kr5fn+3BCAIXa/qUOfPS2afjLFUUl
JkmomWgRVoaeFgpETtIqYGD2OF+SVA/fKWebdE+OGdaEliXpglGkCw8BskUoE0o=
=Slty
-----END PGP SIGNATURE-----

--PoUpPrJlcBv0qM6G--
