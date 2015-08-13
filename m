From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Thu, 13 Aug 2015 12:26:39 +0100
Message-ID: <20150813112639.GB1654@sirena.org.uk>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2639526739064406776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3C202617E0
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 13:26:47 +0200 (CEST)
In-Reply-To: <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: mfelton1@nuvoton.com, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============2639526739064406776==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 04:08:31PM -0700, Anatol Pomozov wrote:
> >> Moved it to ALSA controls. Though I still feel a bit uncomfortable
> >> that the default control value is not usable.
> >> I have to set "ADC Decimation Rate" and "DAC Oversampling Rate"
> >> controls in userspace from its defaults to "128".

> >Setting the default isn't too bad in this case (especially with a
> >comment explaining why) - that doesn't preclude also providing user
> >configuration.

> What is the best way to set default control value? Just a regmap_write()?

Yes.

> > I'm sorry, I don't understand.  What makes you say that "using get_clk()
> > is not flexible for all cases", I can't quite parse that bit?

> My initial assumption was that you are talking about moving complete
> clock handling (clock initialization, MCLK frequency calculation based
> on rate, policy of switching clock sources i.e. everything that
> platform drivers do) to the the driver code.

That is the ideal thing.

> I've looked at other codec drivers and did not find many examples of
> using clk api. The drivers seems expect clock signal is pre-configured
> already. e.g. tegra has a utility function that configures audio
> clocks tegra_asoc_utils_set_rate() and it actively used in tegra-based
> platform drivers.

Most of these drivers predate the clock API, while there's no pressing
need to update things (and it's pretty disruptive to existing systems
especially older ones) if you're running into problems with new code
that are best fixed with the clock API then you should do that.

> Locally I tried to move clock initialization out of platform code to
> codec itself. Codec calls devm_clk_get() in init and sets frequency in
> nau8825_set_sysclk(). See it here
> https://github.com/anatol/linux/tree/nau8825  It works fine on a
> Tegra-based device. But I found that devm_clk_get() is DTS specific
> and does not work with ACPI. We need NAU8825 driver for Intel platform
> as well.

No, that is not the case at all - what makes you claim that devm_clk_get()
is DT specific?

> >> I was following code from ts3a227e driver that does the same.

> > That device is specifically tied to Chromebooks which have a defined
> > mapping, as opposed to being a generic device which is usable on a range
> > of devices.

> I do not see anything Chromebook specific about this chip

> http://www.ti.com/product/ts3a227e

My understanding is that the accessories it supports are
Chrombook/Android ones (note that there's no configuration of ranges for
detection in the code).

> >> At this point this function just sets jack structure needed later in
> >> IRQ handler.

> > I can see what it's doing, I'd just also expect it to also be starting
> > and stopping the detection in the hardware.

> If we move IRQ enabling from init() function to enable_jack_detect()
> then it means chip will be unusable after the init(). It won't be able
> to playback nor capture audio. All developers will be forced to call
> nau88225_enable_jack_detect() from their platform driver to enable
> basic chip functionality. I think it is better if basic functionality
> is enabled during driver init and does not require additional steps.

I very much doubt that this will be a problem for all boards.  To repeat
what I said in my previous reply:

| The assumption would be that if the system doesn't have or need jack
| detection then the jack pins won't be reconfigurable anyway.

Your board may be wired up with jack detection configured in a way that
needs this, I would be surprised if all boards were.

> It is better if I rename nau8825_enable_jack_detect() to
> nau8825_set_jack() to make cleaner what the function suppose to do. It
> sets jack structure that driver uses to report events to upper level.
> If the jack pointer is not set then driver still handles jack
> insert/eject internally but does not report it to the userspace.

No, that doesn't help.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzH7uAAoJECTWi3JdVIfQsrgH/i3GT1GiIsWdmMmk38l+EIMy
mNYqu9uOtZrv6aBPxZfdqcqvQHPUNNNV5Ult8VyuJz5E9HC4yvTsg5zFotTlJTVa
uuPNqwGthwH3C4OWaByfmCxb+fkBoMh9BKPoAZvUSeqG5+i/j/ADZCpXvGWB2MYJ
of9my/AXyiHhsoLw/rsdleXk12frVRBEDXluHsl9mkCNBSp5NUM0+kjfzVnYMoEb
nBN21yEXm0BvP+vtmoPSIJR46UiwfFEjs/uV4mSTjc/Qxnn3ARzawcdjSvbu2ImJ
8yHe3icz1z/weN39T/bnMXxGw+m83rnsTEwar2cQ5H+RhIgSLxbb6ydwnQ+nWhc=
=9QN3
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

--===============2639526739064406776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2639526739064406776==--
