From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Add ADAU1977 driver
Date: Tue, 4 Feb 2014 12:12:24 +0000
Message-ID: <20140204121224.GW22609@sirena.org.uk>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
 <1391439428-3198-2-git-send-email-lars@metafoo.de>
 <20140203184026.GL22609@sirena.org.uk> <52F0CC16.50302@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7463505842407589743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F552617AA
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 13:25:51 +0100 (CET)
In-Reply-To: <52F0CC16.50302@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7463505842407589743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T2qahi4UwJNXfvXD"
Content-Disposition: inline


--T2qahi4UwJNXfvXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 12:16:38PM +0100, Lars-Peter Clausen wrote:
> On 02/03/2014 07:40 PM, Mark Brown wrote:

> >>  sound/soc/codecs/adau1977-i2c.c        |  58 ++
> >>  sound/soc/codecs/adau1977-spi.c        |  73 +++

> >This isn't the general style, if we want to do that we should be
> >converting all the other drivers.

> I think we want to change it. Cause as it is right now we always get
> issues when the SPI core is build-in, but the I2C core is built as a
> module. Using the scheme used in this driver the core module for the
> driver does not depend on either framework, but provides a library
> to the bus specific modules. E.g. if SPI is built-in and the SPI
> driver for the ADAU1977 is built-in the core will also be built-in,
> but it is still possible to build I2C as a module and also build the
> ADAU1977 I2C driver as a module. And I know there is
> SND_SOC_I2C_AND_SPI, but in my opinion it's a hack to work around
> the issue. E.g. if you have a board driver and the board driver
> selects the CODEC driver, the board driver also has to depend on
> SND_SOC_I2C_AND_SPI to avoid any issues (None of the board drivers
> do this right now).

I'm having a hard time seeing that as a meaningful issue to be honest -
only I2C has the modular option and I'm never terribly convinced about
the realism of scenarios that trigger this.  In any case the main thing
is that we shouldn't be silently putting something like this into driver
submissions, we should be actively making the change to all drivers.

> >Please make these user visible if OF is in use.

> Was there a resolution on how to best do this? Make them always
> visible, or only when CONFIG_OF is selected?

Always visible if their dependencies are enabled.

--T2qahi4UwJNXfvXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8NklAAoJELSic+t+oim9kzUP/i6v9GjozEP8yuSanT/ZcF+F
22RVvXt6dMHVXI3j2lV/0svKUndwiuGxW0X8mh+Y3k/xyHzvC4zy2HrBQR9dRZYc
5hmj/e/Ui/jzQwuAU82cAJql5oJeKMWO6+FxPWvwsPFh7B//av+mez7WxnklCmXu
x00pT1nukOj4J2HnIJHMh2OAEBdVhgEWPBNEfyAjnTpbA/+rsRUdoQxTlo/LUkJ0
yfNqgjORRoimWhlPISy3V6jjI6FfuxIHJ2x0JW90kPqTBs2POol54eNuXC193MIb
Bpbk2zJWFYy3asoSzJzuHEnM4QMS1dWlgCeQymCc0fpJh1uFzjgjQkL41erO25hM
tmh5VQ/M/Q7202RL27MnK7xmxqdq0bx8FV9q9yXjJ7xAWjlr6mk5r/7DOXA/faC2
LPyQTfqRgq5MSTRi/9POlfF9GuaJi5psUA4beAQAR6RFpNtGqIe57OgEjupQghAw
H69JaLCj9SY6NTliJpz9fM22v5IrYgV10ZQ0pvJ2S8r5IBsYNNYJ+eLxHiJi+vqv
aWrWoM4yLabxhIcgtPaUOTn9YtSV3O+vbtXliYiW0Xn6yewh20NubmdRDBw5wOyv
mPesGIuE0KfRZvsjZ3cjSY2aNXq2OfcNJBEiMXv6sDAqFd2vumwo3C4C6EMlSlr1
l+id8y53qu+tSm9DsxEt
=I4zh
-----END PGP SIGNATURE-----

--T2qahi4UwJNXfvXD--

--===============7463505842407589743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7463505842407589743==--
