From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Remove support for Intel
 MID DMA from firmware loader
Date: Wed, 18 Mar 2015 13:59:47 +0000
Message-ID: <20150318135947.GJ2869@sirena.org.uk>
References: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150318114355.GE2869@sirena.org.uk>
 <1426679640.14897.359.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4014840591312945592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD99B26047A
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 14:59:53 +0100 (CET)
In-Reply-To: <1426679640.14897.359.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4014840591312945592==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aznLbwQ42o7LEaqN"
Content-Disposition: inline


--aznLbwQ42o7LEaqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 01:54:00PM +0200, Andy Shevchenko wrote:
> On Wed, 2015-03-18 at 11:43 +0000, Mark Brown wrote:
> > On Wed, Mar 18, 2015 at 10:07:19AM +0200, Jarkko Nikula wrote:

> > > Intel MID DMA driver is going to be removed by the coming commit
> > > 36111da7838e ("dmaengine: intel-mid-dma: remove the driver") in spi.git
> > > tree. Since there are no users for SST_DMA_TYPE_MID type the support for it
> > > can be removed from here in advance.

> > So "only user" wasn't exactly true there then...

> SST has support of both intel_mid_dma and dw_dmac for a while, but SPI
> DW hasn't. That's why the only user.

OK, so that's "only thing that relies on it" or something rather than
only user - only user suggests there's no need to worry about cleanup of
dependencies and users elsewhere.

--aznLbwQ42o7LEaqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCYTTAAoJECTWi3JdVIfQq+QH/i9MAG3fd72fzPdq9SAcGFiw
OwImsc8HvTFQj6WF8BvuRKRQXbG6pnIZWDnZLbSg5fc+3fxgOW4pnyKU2QMfRgNh
rdz9TR1+wQSkGs9NPvpqdjaUgdYc4HNtPh9aEM9eL2N8QbMkAeiLZULU8RgIqhiQ
/u7Rl0NWYx20ynMFDXVNOdRBpihbAco45iRdrURPejLyzZ2JR9A+bZa3Dt+umBXY
Is7br4CdKSls9QMP+HtrFgql1fkH2eo3q92uOrZsrCLEVXnYLrm6f1mWVPMHrcIN
bFlfRYnidAv2hGvGm6x49Q8vTTPNbbtrFVC3uDmBMp2/HrD+JJYHvsIXFwfGyg4=
=mnqY
-----END PGP SIGNATURE-----

--aznLbwQ42o7LEaqN--

--===============4014840591312945592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4014840591312945592==--
