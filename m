From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Mon, 13 Jan 2014 21:18:58 +0000
Message-ID: <20140113211858.GK29039@sirena.org.uk>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1624722518905936772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0BE12608D8
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 22:19:05 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============1624722518905936772==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DQ8UAJma2QEM50Gm"
Content-Disposition: inline


--DQ8UAJma2QEM50Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2014 at 06:32:38PM +0000, Opensource [Adam Thomson] wrote:
> On Thu, 9 Jan 2014 20:24:46 +0000, Mark Brown wrote:

> > If you want to support any additional CODEC only devices with compatible
> > register maps that exist you just need to add something like less than a
> > hundred lines of mostly boilerplate code to do so in the ASoC driver.
> > It's hard to see any difference to devices that have both I2C and SPI or
> > both PCI and platform buses here.  Those devices should have separate
> > device ID entries anyway.

> The point is here is that it's unnecessary what you're suggesting. You're
> basically adding more code to instantiate the Codec from the PMIC, removing the
> valid I2C code from the Codec driver, and then if a user/customer wants to use
> the Codec standalone then they need to add that code again. Agreed that new
> device Ids should be added in the future for new standalone variants, but that
> should not mean having to add all of the I2C boilerplate code again. It think
> it makes things unnecessarily messy, on top of the additional effort required.

We also get people complaining about other stylistic things that they
get asked to fix and people going round fixing style issues - the whole
reason this broke is that people noticed and fixed the fact that the
drivers looked wrong to inspection without realising that there were
multiple drivers for the device because it's not done in the manner we
usually do this (that's definitely why the CODEC driver was changed, I
picked up on it during review on submission).  It's really useful to
have things follow common patterns, it makes maintianing the system
easier and it makes factoring out shareable code easier.  Things like
interfaces to the rest of the system tend to get particular focus.

Please, this isn't helping...

> Well, the truth is that there are default I2C addresses for both PMIC and Codec
> but as they are standalone devices, albeit in one package, both addresses can
> be changed. This is one more reason why I don't believe we should be taking your
> method of implementation here. If you just make sure PMIC and Codec drivers

...but on the other hand this sounds like an actual technical issue
which could be a good reason to do something different - it's a bit
surprising that it didn't come up before.  What exactly is the
flexibility the devices have here?  It's a pretty unusual hardware
design.

> have unique Ids then the problem is solved. If you are worried about people
> changing this again in the future (although for the life of me I don't know
> why they would), then we can add a glaring comment to dissuade them, or point
> them at the codec driver.

That's definitely required.

--DQ8UAJma2QEM50Gm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1Fg/AAoJELSic+t+oim9Hh8P/1LkiZr3+OFy2PMcuREZ/e6X
OVQMHnMJYEXAriH32soYSvjd7YaFaYthJ+pSk8jDCuPTfA/WnZSJSxyCesn5ZGJ5
MHwHNahzofau45JzbEWBquk3YK4KgzFturD8aTnh1qt7WEj3AqBoVOIGdZQdC+WU
p8sB0vfxSe1fwn7wVJRX/BA26lLaxqQco8dVabDTC3NR0bIIyunAdqlLl6tGp5R6
RaPgSDOebE8pOSqYJOPRxIr1fZkOeICq8Gas7/vUHAy58ez+yl2a1ql+LXYg93ip
ody02XxKmPVXcl3bEeaoybIL/OBCumpCN7HQcfehPc0ozipq475/Jii66JUrnoGe
6GxwB72xzUH4/B51E02hKbOdaCw8tZL3rKtCjF7er/x7L2/hRUdGdRQIKLF0uhex
3wQeJUmeHK8vNsGX6E30U3rgh4W20Ib6aDFpFOgKKkh3IJFLMBgmIVzca4vXPhlU
7fWrMxdz7EM5VG+FTqMce81k7EFF97qfd+/e1D+b15flg1fWtOCDLFQyxoSxW4w9
8jdMXzyvPZb1vR1YtiqS5nuyHkuqeCfO8ckwvZTLrbrWuxXsAatOyPh1N5JN3lNN
6Q7s/ZzQF/ehs/2RDYBfymzLzESLpo9pes8VSUcSWCHAJp/7lo+gqrKPSYNm8hr3
bsh+SIbFyuZsjgON7RXo
=Ahm/
-----END PGP SIGNATURE-----

--DQ8UAJma2QEM50Gm--

--===============1624722518905936772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1624722518905936772==--
