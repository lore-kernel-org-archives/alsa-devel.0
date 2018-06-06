From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: pcm512x: enable set_sysclk
 callback
Date: Wed, 6 Jun 2018 14:58:22 +0100
Message-ID: <20180606135822.GA9174@sirena.org.uk>
References: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
 <20180604104029.GA7536@sirena.org.uk>
 <a933ad0d-70a8-b046-a0a0-3bdf5fb07d2e@linux.intel.com>
 <20180604162757.GH7536@sirena.org.uk>
 <f2e83538-31a1-60af-44f4-6e9f1e59c0b9@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2151395765443230385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10DC4266F0F
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 15:58:27 +0200 (CEST)
In-Reply-To: <f2e83538-31a1-60af-44f4-6e9f1e59c0b9@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2151395765443230385==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 01:14:10PM -0500, Pierre-Louis Bossart wrote:
> On 06/04/2018 11:27 AM, Mark Brown wrote:
> > On Mon, Jun 04, 2018 at 08:48:40AM -0500, Pierre-Louis Bossart wrote:

> > > Bottom line there is an 'easy' solution for this specific case and a more
> > > complicated one but potentially more generic based on the clock API - hence
> > > the RFC.

> > As far as I can see the two aren't that far off - creating a fixed
> > frequency clock based on DMI data shouldn't be that much harder than
> > doing a set_sysclk().

> Not sure how DMI could be used for devices with connectors? The information
> should come from the additional ASL code that we typically add to SSDT or
> initrd, e.g. [1]. This ASL code can add additional information clock as
> needed, e.g. with _DSD properties, but the link with the clock API isn't
> there atm.

Presumably there's some way you can add IDs for quirking with these?
This is the idiomatic way of handling this sort of stuff in ACPI as far
as I can tell.  Otherwise presumably whatever works for letting you call
set_sysclk() would let you set up a clock instead?

It really feels like some of the ACPI users need to step up here and do
the work on handling clocks.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsX6HsACgkQJNaLcl1U
h9BPLQf9GS1vvsGjRwzzkqCs589hAoWZqx7p5ZxLI8MYasf8B8u5GNXcfoLDCGcN
vej2CrHxXlLBGZyP+DoW0IuQhFALiWTHBx9IYuB+0ajr+3olg40eFXgziLuGTS0P
ytuQR5arlQbya6juLL1BU8HlMgoM6hSoJCNouWGLAeCXQbRqXj9FF0TbJT+V7Yk0
NV02rtytXbqEdQ0dLbbKhidLdDSTEbgqreycOizs5O0FsMSgoGOFAcxgvsSQsYgR
cUI4tG6zH59XJd87gjbSG1aAvKVpQuuir6FETrOdsTSqzYBuGTP/V2kWlFaBA8F3
uLSvZZYI8e/+aYCGQZlw19QuGqUwmw==
=2L1U
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============2151395765443230385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2151395765443230385==--
