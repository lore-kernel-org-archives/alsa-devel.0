From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Tue, 4 Aug 2015 10:47:57 +0100
Message-ID: <20150804094757.GE20873@sirena.org.uk>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3065560121565233541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E8BC2657EE
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 11:48:07 +0200 (CEST)
In-Reply-To: <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, mfelton1@nuvoton.com, So KC <kcso@nuvoton.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>, Dylan Reid <dgreid@google.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============3065560121565233541==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwSkEpePV3aFlXly"
Content-Disposition: inline


--wwSkEpePV3aFlXly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 08:13:40PM -0700, Anatol Pomozov wrote:
> On Fri, Jul 31, 2015 at 11:27 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 27, 2015 at 04:13:57PM -0700, Anatol Pomozov wrote:

> >> +     /* Setup SAR ADC */
> >> +     regmap_write(regmap, NAU8825_REG_SAR_CTRL, 0x0280);

> > Lots of magic numbers in these things...

> These init config settings recommended by Nuvoton engineers. I found
> that chip requires quite a lot of initial preconfiguration to get it
> into operating state.

Random register write lists from the vendor for documented registers are
not generally a good thing to rely on too much, they frequently set up
use case specific things in the middle of other perhaps useful changes.

> > some of them I can guess
> > what's going on but this one is a bit obscure, perhaps it should be user
> > controllable?

> This setting configures SARADC (ADC for sensing button presses). It
> sets sample rate, series resistor and ADC voltage range. It does not
> look like they need to be user-controllable.

Those sound like they may well be system dependent, the sample rate
will most likely feed back into the sensitivity of the detection (how
long the button needs to be pressed for and so on) and the other bits
sound like they could change depending on the configuration of the
accessory.

> >> +     /* Setup ADC x128 OSR */Moved to
> >> +     regmap_write(regmap, NAU8825_REG_ADC_RATE, 0x0002);
> >> +     /* Setup DAC x128 OSR */
> >> +     regmap_write(regmap, NAU8825_REG_DAC_CTRL1, 0x0082);

> > I'd expect this to be user controllable.

> The oversampling configuration is important for chip audio quality.
> There is audible hissing without these settings.

> My understanding that all users need to set these values and it is
> better to move it to the driver initialization sequence.

That sounds like spectacularly poor quality of implementation, but even
if there's a noticeable reduction in audio quality the control should
still be given to the user, they may have an application where power is
much more important than audio quality (eg, if they are doing some form
of recognition on the audio then all they need is something good enough
for their algorithm).

> > I'd expect any initial register initialistion to happen here (if only so
> > we save power until the card registers).

> Moved most of the initialization here. The only part is left in
> codec_probe() is interruption initialization via I2S master mode
> toggling. That toggling trick depends on MCLK signal to initialize
> interruption block correctly. In our case (a tegra SoC device) MCLK is
> initialized later at audio platform driver probe.

If you need to control MCLK you should be using the clock API to get
MCLK which you can do in the driver model probe.  Relying on the machine
driver to control MCLK for you in this way is at best fragile.

--wwSkEpePV3aFlXly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwIpNAAoJECTWi3JdVIfQJTIH/0nNzKMcDKP8U+6otmZuFtnO
jQUDA5oiRX+2x7cL8vW5uyXzZquMVLbEF0k9NoYQypYhnVq/PLOGMcNucdqRUAWr
T1wnZFzlESjjFSaC0WJbuxbHMpr9feKJtyBGRE/bgRnUIhDXhanV7HQzMOsH7pB3
wg3kLw8Rjh1REEnWCWow/JXgjbskfEK9x5luf7NWFSlDFkBMp9OMlSclSpD4cjO5
PdPDfTPjBc7UcKCdGkpG0gVcF51oO6KlJgws5dlWtU3HsRpuA7n3TPRh9WNO/2B3
EK1qIUYQB8sz+lz6q+47snjtC5zV99n5V105aXs9lsV8+3jTYBwvLqo7kvF1UA4=
=GaRb
-----END PGP SIGNATURE-----

--wwSkEpePV3aFlXly--

--===============3065560121565233541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3065560121565233541==--
