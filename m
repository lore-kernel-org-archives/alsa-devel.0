From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Mon, 10 Aug 2015 17:32:32 -0700
Message-ID: <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
 <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DC026260420
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 02:32:33 +0200 (CEST)
Received: by vkbf67 with SMTP id f67so623137vkb.2
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 17:32:33 -0700 (PDT)
In-Reply-To: <20150804094757.GE20873@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, mfelton1@nuvoton.com, So KC <kcso@nuvoton.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>, Dylan Reid <dgreid@google.com>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Hi

On Tue, Aug 4, 2015 at 2:47 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 03, 2015 at 08:13:40PM -0700, Anatol Pomozov wrote:
>> On Fri, Jul 31, 2015 at 11:27 AM, Mark Brown <broonie@kernel.org> wrote:
>> > On Mon, Jul 27, 2015 at 04:13:57PM -0700, Anatol Pomozov wrote:
>
>> >> +     /* Setup SAR ADC */
>> >> +     regmap_write(regmap, NAU8825_REG_SAR_CTRL, 0x0280);
>
>> > Lots of magic numbers in these things...

Okay, I moved the magic number to board configuration options. Now
most of these numbers can be configured via dts.

>> >> +     /* Setup ADC x128 OSR */Moved to
>> >> +     regmap_write(regmap, NAU8825_REG_ADC_RATE, 0x0002);
>> >> +     /* Setup DAC x128 OSR */
>> >> +     regmap_write(regmap, NAU8825_REG_DAC_CTRL1, 0x0082);
>
>> > I'd expect this to be user controllable.
>
>> The oversampling configuration is important for chip audio quality.
>> There is audible hissing without these settings.
>
>> My understanding that all users need to set these values and it is
>> better to move it to the driver initialization sequence.
>
> That sounds like spectacularly poor quality of implementation, but even
> if there's a noticeable reduction in audio quality the control should
> still be given to the user, they may have an application where power is
> much more important than audio quality (eg, if they are doing some form
> of recognition on the audio then all they need is something good enough
> for their algorithm).

Moved it to ALSA controls. Though I still feel a bit uncomfortable
that the default control value is not usable.
I have to set "ADC Decimation Rate" and "DAC Oversampling Rate"
controls in userspace from its defaults to "128".

>> > I'd expect any initial register initialistion to happen here (if only so
>> > we save power until the card registers).
>
>> Moved most of the initialization here. The only part is left in
>> codec_probe() is interruption initialization via I2S master mode
>> toggling. That toggling trick depends on MCLK signal to initialize
>> interruption block correctly. In our case (a tegra SoC device) MCLK is
>> initialized later at audio platform driver probe.
>
> If you need to control MCLK you should be using the clock API to get
> MCLK which you can do in the driver model probe.  Relying on the machine
> driver to control MCLK for you in this way is at best fragile.

After discussing it with my teammates who works on Intel+NAU8825
platform I found that they use MCLK only at playback/capture time. The
rest of the time VCO is suppose to be sysclk source. Thus using
get_clk() is not flexible for all cases.

What I propose is to initialize driver with VCO as a sysclk source.
And later a platform driver can change it to MCLK. Added set_sysclk()
stub that works well with VCO->MCKL transition, tested it on TegraX1.
Follow-up changes should improve VCO/FLL configuration.

> > +     codec: nau8825@1a {
> > +             compatible = "nuvoton,nau8825";
> > +             reg = <0x1a>;
> > +             nuvoton,jkdet-pullup = "true";
>
> ...this isn't how boolean properties are done, the property simply needs
> to exist.

Fixed.

>
> > +static int nau8825_output_driver_event(struct snd_soc_dapm_widget *w,
> > +     struct snd_kcontrol *kcontrol, int event)
> > +{
> > +     struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> > +     struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> > +     struct regmap *regmap = nau8825->regmap;
> > +
> > +     if (SND_SOC_DAPM_EVENT_ON(event)) {
> > +             /* Power Up L and R Output Drivers */
> > +             regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3c,
> > +                     0x3c);
> > +             /* Power up Main Output Drivers (The main driver must be turned
> > +                on after the predriver to avoid pops) */
> > +             regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3,
> > +                     0x3);
> > +     } else {
> > +             /* Power Down L and R Output Drivers */
> > +             regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3f,
> > +                     0x0);
>
> You should be able to implement this with _S widgets without requiring
> explicit code, they're designed for exactly this situation.

I've decided to split this function into 6 different widgets. And it
seems enough. No audible pop/clicks here.

>
> > +int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
> > +                             struct snd_soc_jack *jack)
> > +{
> > +     struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> > +
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > +     snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
>
> The driver shouldn't do this - it's up to the system integration to
> define how the buttons are mapped.

I was following code from ts3a227e driver that does the same.

>
> > +
> > +     nau8825->jack = jack;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
>
> This function doesn't appear to affect the hardware.  I would expect
> that the jack detection hardware is turned off when not in use.

Disabling jack detection means disable HeadsetCompletion IRQ. But the
IRQ handler does a bunch of manual stuff like grounding/ungrounding
jack pins. If IRQ handler is not called then neither playback nor
capture will not work.


At this point this function just sets jack structure needed later in
IRQ handler.

>
> > +static void nau8825_setup_buttons(struct regmap *regmap)
> > +{
> > +     /* Setup Button Detect (Debounce, number of buttons, and Hysteresis) */
> > +     regmap_write(regmap, NAU8825_REG_KEYDET_CTRL, 0x7311);
> > +
> > +     /* Setup 4 buttons impedane according to Android specification
> > +      * https://source.android.com/accessories/headset-spec.html
> > +      * Button 0 - 0-70 Ohm
> > +      * Button 1 - 110-180 Ohm
> > +      * Button 2 - 210-290 Ohm
> > +      * Button 3 - 360-680 Ohm
> > +      */
> > +     regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_1, 0x0f1f);
> > +     regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_2, 0x325f);
> > +}
>
> This looks like system configuration...

Moved to DTS.

>
> > +     /* The interrupt clock is gated by x1[10:8],
> > +      * one of them needs to be enabled all the time for
> > +      * interrupts to happen. */
> > +     snd_soc_dapm_force_enable_pin(&codec->dapm, "DDACR");
> > +     snd_soc_dapm_sync(&codec->dapm);
>
> This should be tied to jack detection, not done unconditionally.
