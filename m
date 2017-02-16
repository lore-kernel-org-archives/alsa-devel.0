From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] clk: x86: add "mclk" alias for
	Baytrail/Cherrytrail
Date: Thu, 16 Feb 2017 10:31:10 +0000
Message-ID: <20170216103109.ljlnpk5xppsjfrhe@sirena.org.uk>
References: <1486937212-10093-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20170214190456.GV25384@codeaurora.org>
 <bc29984e-cc58-69ed-d6ca-b4808d6514dc@linux.intel.com>
 <20170216005623.GY25384@codeaurora.org>
 <CAHp75Vdm3v6UdKgVhUjQebQ8QYrughezuxbaZXmM9gw=qgJ2VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3513190955452651212=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06A002666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 11:31:29 +0100 (CET)
In-Reply-To: <CAHp75Vdm3v6UdKgVhUjQebQ8QYrughezuxbaZXmM9gw=qgJ2VQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3513190955452651212==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hy7rxqv6jg7bmv7s"
Content-Disposition: inline


--hy7rxqv6jg7bmv7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2017 at 04:05:19AM +0200, Andy Shevchenko wrote:
> On Thu, Feb 16, 2017 at 2:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> > and then freeing that lookup with clkdev_drop in the remove of
> > the driver. "mclk" is really generic for a connection name
> > without an associated device id, so you may want to pass some
> > device as the last argument here, but dev_name(&pdev->dev) seems
> > odd because that's the clock controller device, not whatever
> > device would be calling clk_get() with this created lookup in
> > mind.

> Here is the problem with CLK framework since it's (was?) too oriented
> to ARM and clock trees.

That's not really much more of a problem for x86 than it is for ARM,
things got easier for ARM with the introduction of device tree but this
stuff all predates device tree.

> The best option for x86 is to place it in some platform code, which is
> bad idea per se.
> For example, GPIO, PWM, etc have static look up tables and glue
> drivers (like PCI part of the driver, or I2C, or similar) can fill
> that table based on ID.

Platform code seems fine?

> My personal opinion that the best place is not the clock driver for
> that, rather converting existing drivers to take clock name based on
> some (platform related) ID.

That doesn't scale so well, you end up needing the platform code anyway
and it's one more thing to go wrong when configuring the platform code
so you may as well just do something idiomatic with the platform code.
Some systems did historically do things like this, that's where the use
of the device pointer for namespacing came from.

--hy7rxqv6jg7bmv7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlilf20ACgkQJNaLcl1U
h9BRaQgAgKNlcDX3hkJC6Qw0K4jGulvx87nakbv9kn2+gYC81C09MvafJpJA8Vqk
99/pSS6F4X9Ss9WmnJ1Lzs/Z1Y3SzrkZpFJBVFMomzuFTWRciyksa/Ub02njIMd6
wW6mHWKdIc+akTKgN329Q7X/foU5ZfBe4GBco5NnpRx9JYMcfoTMHDxJ5J0X4QwO
YDKW1KyDRf+Li6PWXRLT14HRjlizEu+CIPczQMlwy51E5+UCZPiRJp/eW/MHljIc
iSeZ77LilEp4pAEyXKeYgu5Ilx8jASX7QF4xn3M9Ru/AiWRKe4Fqe7evfSYJv4Y2
V9JoVJ0vNSdMkWqlDX2eHYJdrIsALQ==
=nfEp
-----END PGP SIGNATURE-----

--hy7rxqv6jg7bmv7s--

--===============3513190955452651212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3513190955452651212==--
