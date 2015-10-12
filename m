From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Skylake - Add Skylake RT286
 I2S machine driver
Date: Mon, 12 Oct 2015 17:17:36 +0100
Message-ID: <20151012161736.GG4238@sirena.org.uk>
References: <201510101650.2oGqByd9%fengguang.wu@intel.com>
 <1444619526.3544.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5356917971830040743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E75442625EE
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 18:17:47 +0200 (CEST)
In-Reply-To: <1444619526.3544.6.camel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lkp <lkp@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Abdullah,
 Omair M" <omair.m.abdullah@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5356917971830040743==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 03:12:07AM +0000, Koul, Vinod wrote:
> On Sat, 2015-10-10 at 16:42 +0800, kbuild test robot wrote:

> > [auto build test ERROR on next-20151009 -- if it's inappropriate base, please
> > ignore]

> > config: arm-allmodconfig (attached as .config)
> > reproduce:

> That's nice, thanks. We should add a depends on X86 for this to not compile on non
> X86 code

> Will send updated patch

It looks like the missing functions are just readl() and writel() which
means that they're probably only working on x86 through implicit
inclusion rather than intentionally - if that's the case adding (IIRC)
linux/io.h is a better fix.

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWG90fAAoJECTWi3JdVIfQbLEH/0gADMPSMm1tB67MvoF1rKRr
wDJuyZvv4xpnu8m1+hCC1qsX1MoINtuZ47tNU9cCcPeCdG59Maf5D5nZxOhZFeq2
g9D1X7/cjefS755g/dE1tn+nJiwf4SxLumURS4XMrYlGnY2k44ZKZrMCsmuYNvRc
UkHBXqU+S0Ve7/q/qEngLvsyj8zJs9iERcG2kwB4FtYNHoQnIMdrSN/PA0Z5dERV
a+t8eeNWdHywW1G/an2dE8ss6BUrrQp9rWDOM6GGGQMkEpE3GVM9Y12wPKXxiURP
6qWUM0c1BdB4uM9YqQ4uc9g3NkX0y8iJbTbHrYeSRnAvfi5gYNw2jk9Yhl9VtcI=
=6vO9
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--

--===============5356917971830040743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5356917971830040743==--
