From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec
	driver
Date: Tue, 5 May 2015 11:53:27 +0100
Message-ID: <20150505105327.GZ22845@sirena.org.uk>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150504113943.GB15510@sirena.org.uk>
 <20150505092411.GA15549@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2579490098064728190=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62817261643
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 12:53:40 +0200 (CEST)
In-Reply-To: <20150505092411.GA15549@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2579490098064728190==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4OzcLsYxzreNWMPE"
Content-Disposition: inline


--4OzcLsYxzreNWMPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 10:24:12AM +0100, Richard Fitzgerald wrote:
> On Mon, May 04, 2015 at 12:39:43PM +0100, Mark Brown wrote:
> > On Fri, May 01, 2015 at 04:15:18PM +0100, Richard Fitzgerald wrote:

> > > +		val = snd_soc_read(codec, ARIZONA_ASYNC_SAMPLE_RATE_1 + val);
> > > +		if (val >= 0x11)
> > > +			dev_warn(codec->dev, "Unsupported ASRC rate2\n");

> > ...some random other register.

> ARIZONA_ASRC_RATE2 register can only have the values 8 or 9 and we don't
> provide a way to set it to illegal values.

That's trusting of future maintainers of this code, and it doesn't look
great when bounds checking and validation code has some fairly obviously
missing bounds checking and validation.

> > > +static const char * const wm8998_inmux_texts[] = {
> > > +	"A",
> > > +	"B",

> > Those are some fun input names...

> ... that's what the mux positions are called and it seems nice to have consistent
> naming for all similar muxes across channels and across future codecs. Like for
> example to switch both muxes of a stereo input you set them both to the same
> position name (both "A" or both "B") is clearer, and quicker to spot in a dump
> of ALSA control settings, than having the two muxes set to different enumeration
> strings that actually mean the same mux position.

Equally when setting the muxes settings called A and B that's not really
telling people what they do.

--4OzcLsYxzreNWMPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSKEnAAoJECTWi3JdVIfQUWkH/iAm+V+tRy2vusGvhDMPVdg3
tYedikVyumurF5RLgPISiAv7mndeLSXb1R/Mhf/ugGMe4fZUkrE1CUGAI46TXX4K
kPo/1qKN4V+Me7hEPTfMg1+KS9dgW1gjBgvDiIZrzRd79t8QQMpXolI3Xn+74h/6
qPRDCelHwXDro5joFm9yTk+RhxdOaM15tQSPMzn1qj5Lf8kS2cDmlG9nyVnExcc7
BeJT3bc9Z2w5BYGDFnSdkEw2difn2t983UjOZRVHlqRLv138bL6NlidnWMkfhP0a
l0+9x0OWy3umKaJE5x8lynM0ZFNbK9t6oTTxjMSCrD0TzDENQc0f5HZLircReFU=
=+uCo
-----END PGP SIGNATURE-----

--4OzcLsYxzreNWMPE--

--===============2579490098064728190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2579490098064728190==--
