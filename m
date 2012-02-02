From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Thu, 2 Feb 2012 13:26:18 +0000
Message-ID: <20120202132618.GL7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
 <20120202131716.GF9773@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8JyeaiReRNoiMDS"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120202131716.GF9773@S2101-09.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhao <richard.zhao@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--c8JyeaiReRNoiMDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 09:17:18PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 12:09:01PM +0000, Mark Brown wrote:

> > Since the audmux is a part of the SoC silicon shouldn't the SoC just
> > register the device without individual boards having to do anything
> > (possibly conditional on ASoC being selected in Kconfig or something)?
> > It's going to be connected in exactly the same fashion on any system
> > using the SoC.

> Hmm, we are trying to save adding the device for those boards which do
> not route any audmux pins out at all.

That's why I'm saying perhaps make it conditional on having ASoC built
(or even on having the AUDMUX driver built).

--c8JyeaiReRNoiMDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKo7zAAoJEBus8iNuMP3dM00P/1qAY+Rftmm22Dga8B9vg80L
vqNXCoDPBEFbUFUfEk9f8vLi7l7U3A8oIf38d/+9xSAXu4sdIySgdUWBOT4rgvph
NnzFwgY/zchLZu8qunSahBjRsLjo0zEaWd+AO4lpqqiHdGpPUacsRIAQq3YJmlRb
cpP3afumprCehuBgfegIOrQ+dgUnW9WDl9CevBHD9noHOIDs3vQoFUZmWtGskMWf
RU8H0bWBmBbuOg7iXfeBx+rGqWKU0QYxONF0ElWITZ42oTL0KBiv99Ffg19AI1qq
geCiC0MrpijSvak3F3X5mApVOT4CNWNpr+FF4ll1u4unW2IHFUaKyt0VDL/u1B1v
cW9uM1dF7GabALwEgXtSDV88b0SMMp/BjFPbmM64FOsFTaAVskTHpxI1F+pwZ9Dy
u6vTgspnbNoumP2AFodznoSsowW8iDKlZKBFfkz4b2adNAYTLRVHjj870kA/PAKh
3nXNjwoI6ZX9lZD0dIRNbXLcbeTFHtU3bvd+hEPZcRkn0gHKo8hqBhJTSCQYcSlW
YgVIyF+llO7XomCOEeBRkYp00WtWhnkKxmH4EtbVaXxZfvHjqDZv4I1iL3VNL4N7
bIbRInOGJezd8LAqoGrXqutN0Ccie7OjVj1wNR45/VrHCTZJlHvHxiEoRZePn2jd
Gq6W0vKkJ3NDMeaQ3XxW
=cJF/
-----END PGP SIGNATURE-----

--c8JyeaiReRNoiMDS--
