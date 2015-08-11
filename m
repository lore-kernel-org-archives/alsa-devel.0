From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Tue, 11 Aug 2015 17:39:54 +0100
Message-ID: <20150811163954.GM10748@sirena.org.uk>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0443896919086051706=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE66B260542
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 18:40:02 +0200 (CEST)
In-Reply-To: <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
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


--===============0443896919086051706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OQhbRXNHSL5w/5po"
Content-Disposition: inline


--OQhbRXNHSL5w/5po
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2015 at 05:32:32PM -0700, Anatol Pomozov wrote:
> On Tue, Aug 4, 2015 at 2:47 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 03, 2015 at 08:13:40PM -0700, Anatol Pomozov wrote:

> >> >> +     /* Setup ADC x128 OSR */Moved to
> >> >> +     regmap_write(regmap, NAU8825_REG_ADC_RATE, 0x0002);
> >> >> +     /* Setup DAC x128 OSR */
> >> >> +     regmap_write(regmap, NAU8825_REG_DAC_CTRL1, 0x0082);

> >> > I'd expect this to be user controllable.

> >> The oversampling configuration is important for chip audio quality.
> >> There is audible hissing without these settings.

> >> My understanding that all users need to set these values and it is
> >> better to move it to the driver initialization sequence.

> > That sounds like spectacularly poor quality of implementation, but even
> > if there's a noticeable reduction in audio quality the control should
> > still be given to the user, they may have an application where power is

> Moved it to ALSA controls. Though I still feel a bit uncomfortable
> that the default control value is not usable.
> I have to set "ADC Decimation Rate" and "DAC Oversampling Rate"
> controls in userspace from its defaults to "128".

Setting the default isn't too bad in this case (especially with a
comment explaining why) - that doesn't preclude also providing user
configuration. =20

> > If you need to control MCLK you should be using the clock API to get
> > MCLK which you can do in the driver model probe.  Relying on the machine
> > driver to control MCLK for you in this way is at best fragile.

> After discussing it with my teammates who works on Intel+NAU8825
> platform I found that they use MCLK only at playback/capture time. The
> rest of the time VCO is suppose to be sysclk source. Thus using
> get_clk() is not flexible for all cases.

I'm sorry, I don't understand.  What makes you say that "using get_clk()
is not flexible for all cases", I can't quite parse that bit?

> > > +int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
> > > +                             struct snd_soc_jack *jack)
> > > +{
> > > +     struct nau8825 *nau8825 =3D snd_soc_codec_get_drvdata(codec);


> > > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> > > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);

> > The driver shouldn't do this - it's up to the system integration to
> > define how the buttons are mapped.

> I was following code from ts3a227e driver that does the same.

That device is specifically tied to Chromebooks which have a defined
mapping, as opposed to being a generic device which is usable on a range
of devices.

> > > +     nau8825->jack =3D jack;

> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);

> > This function doesn't appear to affect the hardware.  I would expect
> > that the jack detection hardware is turned off when not in use.

> Disabling jack detection means disable HeadsetCompletion IRQ. But the
> IRQ handler does a bunch of manual stuff like grounding/ungrounding
> jack pins. If IRQ handler is not called then neither playback nor
> capture will not work.

The assumption would be that if the system doesn't have or need jack
detection then the jack pins won't be reconfigurable anyway.

> At this point this function just sets jack structure needed later in
> IRQ handler.

I can see what it's doing, I'd just also expect it to also be starting
and stopping the detection in the hardware.

--OQhbRXNHSL5w/5po
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyiVZAAoJECTWi3JdVIfQNM4H/jCXipjiNPxUEEvMhtO0pD+V
SoILO+G2UfjsTbAp1MTPJfhIwcV09z9HNx2NHUyphDNZLzIdck3XXlt3wx+qZjHX
2XVS/MR5Ux9PzvnGtC9cdxE/h0KG0riC7VzarFOMm7JPteWc7xzEUIbjqrx4CBo5
oozecvzGssojwQku+do6pIHl02yf+pQm0pVOh4mTJmI5mQFa83Q691tFh3K/UQfW
KDA6mYivRmvSSwafAfg3m6+2VbA01Pojob6hZ2G9YdgW52pwXsKiqwAgvDHOVHr7
qctvcpgWzfbbogfjGc6B0XULfcH7ekBwsMWuMAURh/8j2E0c0wXRWJCHeGDiQJY=
=3FEs
-----END PGP SIGNATURE-----

--OQhbRXNHSL5w/5po--

--===============0443896919086051706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0443896919086051706==--
