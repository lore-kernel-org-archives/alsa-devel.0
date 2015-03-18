From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Remove support for Intel
 MID DMA from firmware loader
Date: Wed, 18 Mar 2015 11:43:55 +0000
Message-ID: <20150318114355.GE2869@sirena.org.uk>
References: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4978247872764006372=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 273E12605F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 12:44:01 +0100 (CET)
In-Reply-To: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4978247872764006372==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 10:07:19AM +0200, Jarkko Nikula wrote:
> Intel MID DMA driver is going to be removed by the coming commit
> 36111da7838e ("dmaengine: intel-mid-dma: remove the driver") in spi.git
> tree. Since there are no users for SST_DMA_TYPE_MID type the support for it
> can be removed from here in advance.

So "only user" wasn't exactly true there then...

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCWT6AAoJECTWi3JdVIfQLOgH/1bex7hY/hxiyR6+zMxQRPN3
cwQbShPdbxOP8Ppz+BBbW8Xi5IHNqKLGB0Z/SKfL01C+gBbEg+uEWhQ/9kHPHwlS
NaiP4ry6E6tfLXVsW7Bfg+ODQsi3XDAOTAr6rhBwk/LjcFPzt4d0mIhefLiz8Tv+
xrIPkVKqw9Qu4yhO9Kxyxgaru+BQIK2uJYeATKVlJV4V2qgarRKGFFA5FviKI07y
m/DYAiiC1g8o1Q4NjBtc4o36MFjEkieq8gQaou00mOPc7dpqz+G12k/UJW1o1INE
aCG/ZWqAx425C6tnHRaLs8pJkpHsKmQqDEnXRt+i0en0hNxXeSn6iVWxWN9/hZs=
=wgfy
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--

--===============4978247872764006372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4978247872764006372==--
