From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
Date: Fri, 2 Nov 2012 14:24:44 +0000
Message-ID: <20121102142444.GY4413@opensource.wolfsonmicro.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
 <20121101144315.GM4413@opensource.wolfsonmicro.com>
 <5093312D.4070408@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RUh7Gb6wQL2PrpWP"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5093312D.4070408@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--RUh7Gb6wQL2PrpWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2012 at 10:34:21AM +0800, Bo Shen wrote:
> On 11/1/2012 22:43, Mark Brown wrote:
> >On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:

> >>+dai: dai {
> >>+	compatible = "atmel,atmel-ssc-dai";
> >>+	atmel,dai-master = <&ssc0>;
> >>+};

> >This seems to be a purely virtual device which remaps the SSC onto the
> >Linux audio subsystem?  If that is the case then it shouldn't appear in
> >the device tree,

> Yes. This is a purely virtual device. I add this as to the following reason.

> In our case, the ssc can connect to audio codec, DAC and other
> devices. In order to avoid duplicate the code, so keep ssc as a
> library, register it directly in Linux and use remap method to let
> it work onto other different subsystem.

Your quote appears to have deleted the bit of my mail where I told you
how to fix this.  Is there something unclear in my suggestion that the
machine driver directly reference the SSC node?

--RUh7Gb6wQL2PrpWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk9eKAAoJELSic+t+oim9eWwP/15cY43ihmhBpcmAxrgJtm0l
N+siOIOnjfF3Jhyy3r0hNdAQ6SaeW4LYB3lbUYMC6/eNSiiRNLC447ki/FgciOdx
SQ/qapzewV1MuzCi66SvonXav0TclbXIB+T9TupTnYRRzeAGCXDtLZa0uEATI3OD
osSaVPUOf7tO3UBfvDuV0r4otLUgFV2lS2MljuGdG6xb7YGc5+RZ9cbeABM8N4QQ
oh/oy3+BA1X/lIK0hlgQn8M7pHxjwY5/1LkxFd6unXqzROb/KuFi1NGRTS1LUQTK
8TCSd9qjt9j7I8QzAhk95qlcJsMF2LBbTAYUk7XCG+i3+lGHx+BPLzlX/v/U8lkC
Yt1l5/7BLPx4W5aiyWUuEy0X+/B6VgrTW2uBawxbXLX6fFpDoK+9GiO+5cTveW8Y
cElo5QvxMeDrl5+YBh9sXPL7LFiXq7/nrsYF86JaT6wHGZTkTrRKgN/wlIOBb4Yr
dVTDKGldX/WDnQsABPF9DLwGv0rLQdlCisZzLKat/VD71qpNjHAUi1z97j8FH3u9
fAEi32gB33FXDEmPF0fDwr0vVl2/9qareTj8Dw/fjZixB/ZQ8dOmntAZAQsj2H74
w8uo7oAn/cEwRD9peieMZOQCRLS67FEbmB+1RV36emO+QUw9kocNcmzNqVN9krrm
x9z079ILBed39bq7Eyk0
=3OZ0
-----END PGP SIGNATURE-----

--RUh7Gb6wQL2PrpWP--
