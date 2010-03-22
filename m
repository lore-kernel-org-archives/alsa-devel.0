From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 16:04:56 +0200
Message-ID: <201003221604.56497.peter.ujfalusi@nokia.com>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100322134701.GB1379@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D5E10381A
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 15:05:13 +0100 (CET)
In-Reply-To: <20100322134701.GB1379@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 22 March 2010 15:47:01 ext Mark Brown wrote:
> On Mon, Mar 22, 2010 at 03:36:07PM +0200, Peter Ujfalusi wrote:
> > Gain controls on outputs affect the power consumption
> > when the gain is set to non 0 value.
> > To prevent amps beeing enabled, when they are not
> > needed, introduce the following workaround:
> > Track the state of each of this type of output.
> > In twl4030_write only allow actual write, when the
> > given output is enabled, otherwise only update
> > the reg_cache.
> > The PGA event handlers on power up will write the cached
> > value to the chip (restoring gain, routing selection).
> > On power down 0 is written to the register (disabling
> > the amp, and also just in case clearing the routing).
> =

> I'm not 100% clear on what the existing code is supposed to be doing so
> this explanation isn't entirely clear to me, sorry.

Sorry for that. So the purpose of this:
Most of the output register on the TWL looks like this (take PREDRIVEL):
PREDL_CTL (0x25):
bit 0: Voice enable
bit 1: Audio L1 enable
bit 2: Audio L2 enable
bit 3: Audio R2 enable
bit 4-5: Gain (0x0 - power down, 0x1 - 6dB, 0x2 - 0dB, 0x3 - -6dB)

Now bits 0 - 3 are part of the DAPM route implementation.
bit 4-5 (gain) has simple volume control.

If there is no audio activity, and user changes the routing, than the gain =
value =

will be also written to the chip, which causes the amp to be enabled.
Same goes, if the user changes the volume during inactive, the amp will be =

enabled.
The existing code did not handle this situation, it only muted the gain whe=
n the =

DAPM route got disabled.
So if the user modifies a gain, which is not part of the DAPM route, than t=
hat =

is going to be enabled all the time, since the DAPM off will not hit it.

In this way I can be sure, that no other gains are actually enabled, than t=
he =

ones which is needed.

Oh, and if these gain values are other than 0, than it means that the amp i=
s on, =

and consumes power. So I need to make sure, that they are off, when they ar=
e not =

needed.

> If it's supposed to be holding the controls at a mute value while the
> PGA is powered down then this is something that ASoC could benefit from
> in general - it'd be much better if we could keep amplifiers muted while
> not in active use and sequence the unmute into the power management at
> the end since this is good for pop/click management in general.  I'd
> started to look at this but not yet got enough time to finish off
> implementing it.

Yes, I have been also thinking about that, but I really don't know how it c=
an be =

done:

For the DAPM part it is kind of easy, since we can decide in the core when =
to =

write to the chip, and when only to the reg_cache.
But since I have the gain in the same register, when the user changing the =

volume, than that control don't have information about the associated DAPM =

widget's state.

> What I'd been thinking of doing was introducing a new control type which
> would be the inverse of supply - something that's switched on whenever
> its inputs are switched on, sequenced to power on at the end of the
> sequence and power off at the start.  This would support both events and
> a set of controls, with the controls doing what this looks like and only
> writing to the device when the widget is powered.  I've not actually
> tried implementing this properly yet, though - it'd involve adding a
> new bunch of control types, sadly.

Well, I think the core could have some basic support for similar cases, but=
 I'm =

not sure if it is possible to cover all cases in the core.

I do think, that at least the TWL codec has to be handled in a custom way. =
For =

now at least.

Should I add more explanation to the commit message to make the intention m=
ore =

clear?

-- =

P=E9ter
