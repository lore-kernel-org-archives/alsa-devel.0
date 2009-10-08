From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Thu, 8 Oct 2009 16:38:24 +0300
Message-ID: <200910081638.24229.peter.ujfalusi__26555.2894714803$1255009881$gmane$org@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-2-git-send-email-eduardo.valentin@nokia.com>
	<20091008125213.GA29176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091008125213.GA29176@rakim.wolfsonmicro.main>
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

On Thursday 08 October 2009 15:52:13 ext Mark Brown wrote:
> On Thu, Oct 08, 2009 at 02:58:50PM +0300, Eduardo Valentin wrote:
> > +struct tpa6130a2_platform_data {
> > +	int (*set_power)(int state);
> > +};
> =

> Why is this a callback and not just a GPIO number?  That'd seem simpler
> for users.

Well, same amount of code, but in different place if the power is enabled =

through a GPIO. But if the power is controlled via different means (nothing =

comes to mind, but there are exotic systems out there), in this way it is s=
imple =

to handle

> =

> > +int tpa6130a2_add_controls(struct snd_soc_codec *codec)
> > +{
> > +	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
> > +				ARRAY_SIZE(tpa6130a2_dapm_widgets));
> > +
> > +	return snd_soc_add_controls(codec, tpa6130a2_controls,
> > +				ARRAY_SIZE(tpa6130a2_controls));
> > +
> > +}
> > +EXPORT_SYMBOL(tpa6130a2_add_controls);
> =

> All the ASoC APIs are EXPORT_SYMBOL_GPL().

Right.

> =

> > +	pdata =3D (struct tpa6130a2_platform_data *)client->dev.platform_data;
> > +	/* Set default register values */
> > +	data->regs[TPA6130A2_REG_CONTROL] =3D TPA6130A2_SWS |
> > +					    TPA6130A2_HP_EN_R |
> > +					    TPA6130A2_HP_EN_L;
> =

> This looks like you could implement stereo paths with individual power
> control?

Can we put something in between DAPM_OUTPUT and DAPM_HP to handle the stere=
o =

path correctly?
We could have two paths from codec to the "TPA6130A2 Headphone", which is n=
eeded =

to actually control the power of the amplifier.
At the end we are not really gaining much, but one more level of switch on =
the =

path.
We could have simple mute alsa controls in tpa6130a2_controls for the ampli=
fier =

itself...

> =

> > +	data->regs[TPA6130A2_REG_VOL_MUTE] =3D TPA6130A2_VOLUME(20);
> =

> The standard thing is to use hardware defaults and leave decisions like
> this up to user space.

OK, The reset value is 0 (-59.5 dB)

> =

> > +	data->set_power =3D pdata->set_power;
> > +	if (!pdata->set_power) {
> > +		data->power_state =3D 1;
> > +		tpa6130a2_initialize();
> > +	}
> > +	tpa6130a2_power(1);
> > +
> > +	/* Read version */
> > +	err =3D tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> > +				 TPA6130A2_VERSION_MASK;
> > +	if ((err !=3D 1) && (err !=3D 2)) {
> > +		dev_err(dev, "Unexpected headphone amplifier chip version "
> > +		       "of 0x%02x, was expecting 0x01 or 0x02\n", err);
> > +		err =3D -ENODEV;
> =

> This seems a bit excessive - is it really likely that the register map
> would be changed incompatibly in a future version?

Hmm, we have only seen these versions of the chip, and we know that the dri=
ver =

works with these. Also we don't have any information on different versions,=
 but =

I would think that the register map is not changing (the reset values for s=
ome =

registers are different)

-- =

P=E9ter
