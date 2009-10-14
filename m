From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
	Instruments tlv320dac33 codec
Date: Wed, 14 Oct 2009 15:56:50 +0300
Message-ID: <200910141556.50396.peter.ujfalusi@nokia.com>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091014111409.GE20639@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 247752435B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 14:57:00 +0200 (CEST)
In-Reply-To: <20091014111409.GE20639@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 14 October 2009 14:14:10 ext Mark Brown wrote:
> On Tue, Oct 13, 2009 at 03:03:11PM +0300, Peter Ujfalusi wrote:
> > b) The nSample mode implementation uses one interrupt line from DAC33 to
> =

> Just a thought, but could a timer based approach work here?

Yes, there is a mode, when instead of interrupt, host side timer can be use=
d.
This mode needs slightly different way of configuration than the interrupt =
mode, =

and it has not been tested. So this is the reason, why it is not implemente=
d in =

the driver.

> =

> > +	case SND_SOC_BIAS_PREPARE:
> > +		break;
> > +	case SND_SOC_BIAS_STANDBY:
> > +		dac33_soft_power(codec, 0);
> > +		break;
> > +	case SND_SOC_BIAS_OFF:
> > +		break;
> > +	}
> =

> It'd be nice to do the full power down in BIAS_OFF for future use.

The full power off is taken when the dac33_soc_suspend is called (the hard_=
power =

is restored in the dac33_soc_resume function).
I can move it here, than add dac33_hard_power(codec, 1) to _PREPARE, if the =

previous state was _OFF.
Than I can remove the dac33_soc_suspend and dac33_soc_resume?

> =

> > +static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
> > +{
> > +	struct snd_soc_codec *codec =3D dev;
> > +	struct tlv320dac33_priv *dac33 =3D codec->private_data;
> > +
> > +	if (dac33->state =3D=3D DAC33_PLAYBACK)
> > +		queue_work(dac33->dac33_wq, &dac33->work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> =

> Should that return IRQ_HANDLED if it's not expecting an interrupt?

Good point. Interrupts are only coming, if the codec is running in nSample =
mode.
The work is scheduled only, if the state is PLAYBACK, the other case would =
be =

the FLUSH state when there is a possibility to receive interrupt, but if th=
e =

state already FLUSH, than we have had a work scheduled to write the command=
 to =

the dac33.

The interrupt is actually handled, but there is nothing need to be done, so=
 I =

think it is valid to return with IRQ_HANDLED.

> I'd also expect to see something that either acknowledges the interrupt to
> deassert it or

The interrupt is self cleaning on dac33 side (in the mode, which we are usi=
ng =

it, there is a mode, where additional write is needed to clear the interrup=
t =

status).

> keeps it masked until the work has had a chance to do
> something.

Hmm, yes, but with the current implementation there is no need for that:
The interrupt is triggered on rising edge.
We only use the alarm threshold interrupt from dac33.
1. At startup I configure the dac33 to have the alarm threshold to be 10ms
   of audio in the buffer.
   Initially dac33 will read at least 20ms of audio (it can be more)
2. dac33 will asserts the interrupt line, when the buffer usage reaches the
   alarm threshold, and keeps it high until the load level is under the ala=
rm
   threshold value
3. We instruct the dac33 to read nSample amount (at least 20ms of audio).
   This is done in the dac33_work:DAC33_PLAYBACK
4. The interrupt line will be de-asserted, when the fill rate is above the =
alarm
   threshold (10ms)
5. dac33 recives the nSample amount of audio data, and only plays audio fro=
m the
   buffer.
6. goto 2.

Than on trigger STOP, I set the state to FLUSH and schedule the work, if an =

interrupt comes, it is ignored, since the work has been scheduled.
In dac33_work, the FIFO flush is enabled, which means the the dac33 will pl=
ay =

out the remaining samples and will not ask for a new one (interrupt line is=
 not =

going to be asserted).

Now this part needs further tuning, since it is possible that at shutdown w=
e =

actually leave some samples unplayed in the buffer and stop the dac33.

> =

> > +	pdata =3D (struct tlv320dac33_platform_data *)client->dev.platform_da=
ta;
> =

> Unneeded cast.

Oh, I've missed that.

> =

> > +	dac33->dac33_wq =3D create_rt_workqueue("tlv320dac33");
> > +	if (dac33->dac33_wq =3D=3D NULL) {
> > +		ret =3D -ENOMEM;
> > +		goto error_wq;
> > +	}
> =

> Might be nice to skip the workqueue stuff if we don't have an IRQ.

Yes.

> Conditional registration of the nSample controls based on having the IRQ
> may also be nice.

Will do that.

> =

> > +	ret =3D snd_soc_register_codec(codec);
> > +	if (ret !=3D 0) {
> > +		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
> > +		goto error_codec;
> > +	}
> >
> > +	ret =3D snd_soc_register_dai(&dac33_dai);
> > +	if (ret !=3D 0) {
> > +		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
> > +		snd_soc_unregister_codec(codec);
> > +		goto error_codec;
> > +	}
> =

> I'd do these last so that we don't have ASoC level init trying to use
> the device only to have it yanked from underneath it by a failure in the
> following code.

I'll move these


Thanks,
P=E9ter
