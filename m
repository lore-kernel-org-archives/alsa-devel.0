From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 09:53:21 +0300
Message-ID: <200910090953.21066.peter.ujfalusi__48688.9618252919$1255071707$gmane$org@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<200910081638.24229.peter.ujfalusi@nokia.com>
	<20091008135342.GJ29176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091008135342.GJ29176@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 08 October 2009 16:53:42 ext Mark Brown wrote:
> On Thu, Oct 08, 2009 at 04:38:24PM +0300, Peter Ujfalusi wrote:
> > On Thursday 08 October 2009 15:52:13 ext Mark Brown wrote:
> > > On Thu, Oct 08, 2009 at 02:58:50PM +0300, Eduardo Valentin wrote:
> > > > +struct tpa6130a2_platform_data {
> > > > +	int (*set_power)(int state);
> > > > +};
> > >
> > > Why is this a callback and not just a GPIO number?  That'd seem simpl=
er
> > > for users.
> >
> > Well, same amount of code, but in different place if the power is enabl=
ed
> =

> Until someone adds a second board, at which point they need to copy the
> code to acquire and release the GPIO.
> =

> > through a GPIO. But if the power is controlled via different means
> > (nothing comes to mind, but there are exotic systems out there), in this
> > way it is simple to handle
> =

> I suspect we can deal with that adequately when it crops up, for example
> by having the driver set up a default callback function if a GPIO is
> specified instead of a callback.

Good point.
I'll replace the .set_power with power_gpio.

> =

> > > > +	pdata =3D (struct tpa6130a2_platform_data
> > > > *)client->dev.platform_data; +	/* Set default register values */
> > > > +	data->regs[TPA6130A2_REG_CONTROL] =3D TPA6130A2_SWS |
> > > > +					    TPA6130A2_HP_EN_R |
> > > > +					    TPA6130A2_HP_EN_L;
> > >
> > > This looks like you could implement stereo paths with individual power
> > > control?
> >
> > Can we put something in between DAPM_OUTPUT and DAPM_HP to handle the
> > stereo path correctly?
> =

> Yes.

Great. I can add one SND_SOC_DAPM_PGA_E per channel, which enables/disables=
 the =

channel.
Adding a widget with actual alsa control seams to be problematic, since tho=
se =

are working with the codec's registers, so adding such a widget would requi=
re to =

implement a new set of .info .get  and .set functions for the TPA alone.

> =

> > We could have two paths from codec to the "TPA6130A2 Headphone", which =
is
> > needed to actually control the power of the amplifier.
> =

> Or make "TPA6130A2 Headphone" be a SND_SOC_DAPM_SUPPLY() connected to
> the individual channels for the headphone outputs, which should do the
> right thing.

I see, using the event/event_flags with the DAPM_SUPPLY should do it.
So is it OK if I modify the tpa6130a2 DAPM path to be like this:
PGA_E("TPA6130A2 Left")  -> SUPPLY("TPA6130A2 power") -> HP("TPA6130A2 =

Headphone")

PGA_E("TPA6130A2 Right") -> SUPPLY("TPA6130A2 power") -> HP("TPA6130A2 =

Headphone")

Or should I add individual HP for the two channels:
HP("TPA6130A2 Headphone Left")
HP("TPA6130A2 Headphone Right")

Than in machine driver just connect (for example rx51):
{"TPA6130A2 Left", NULL, "LLOUT"},
{"TPA6130A2 Right", NULL, "RLOUT"},


> =

> > At the end we are not really gaining much, but one more level of switch
> > on the path.
> > We could have simple mute alsa controls in tpa6130a2_controls for the
> > amplifier itself...
> =

> It'd mean that mono outputs would only need to enable one of the
> channels.  Depending on the hardware feeding the amp this may behave
> better - there may be some noise or leakage on the idle channel which
> it'd be better to avoid amplifying - and it should certainly use a
> little less power.

OK, Does my proposal above feasible?

> =

> > > > +	err =3D tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> > > > +				 TPA6130A2_VERSION_MASK;
> > > > +	if ((err !=3D 1) && (err !=3D 2)) {
> > > > +		dev_err(dev, "Unexpected headphone amplifier chip version "
> > > > +		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
> > > > +		err =3D -ENODEV;
> > >
> > > This seems a bit excessive - is it really likely that the register map
> > > would be changed incompatibly in a future version?
> >
> > Hmm, we have only seen these versions of the chip, and we know that the
> > driver works with these. Also we don't have any information on different
> > versions, but I would think that the register map is not changing (the
> > reset values for some registers are different)
> =

> It's fairly common to see some incompatible changes in early silicon
> revisions but once things get properly launched it's fairly unusual.
> I'd be more inclined to print a warning here rather than fail - chances
> are that the driver will work fine with any new revisions that are
> produced.

Right, going to be warning (with text change).

> =


Thanks,
P=E9ter
