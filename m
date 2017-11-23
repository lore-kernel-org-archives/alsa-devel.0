From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Disable DAPM for click avoidance ?
Date: Thu, 23 Nov 2017 10:41:33 +0100
Message-ID: <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B2E267295
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 10:41:42 +0100 (CET)
In-Reply-To: <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 22 Nov 2017, Mark Brown wrote:

> On Wed, Nov 22, 2017 at 01:33:37PM +0100, Ricard Wanderlof wrote:
> =

> Always CC maintainers on postings if you want them to be reliably
> seen...

Ok. I thought it was more of a general question than a maintainer question =

but I'll keep it in mind in future.

> > I'm having an issue with a codec where the normal DAPM procedure of =

> > disabling most of the codec when there is no stream ongoing results in =

> > large clicks when a playback stream starts and stops, because the outpu=
t =

> > jumps from 0V when the output is disabled to over a volt when the outpu=
t =

> > is enabled. =

> =

> > There appears to be a 'slow stop/start' feature in the codec, however, =
it =

> > takes about one second to ramp up and down the output voltage, and that=
 is =

> > too long a delay when starting a stream.
> =

> The CODEC driver is broken, it shouldn't be powering off on idle if it
> takes a second to ramp, it should be leaving VMID up while the system is
> running - this is what the _STANDBY bias level is all about.  Look at
> what older CODEC drivers like the wm8731 do.

It actually does leave VMID on as soon as the codec is not at the =

_OFF level, the problem is really that the output buffer is not enabled =

until a playback stream is set up, and its not until the output buffer is =

enabled that the output attains its operating level.

Of course, one solution would be to change the driver to enable the output =

already at the _STANDBY level. It does seem to me that that would violate =

part of the whole point of DAPM, on the other hand, I would think that =

at some point power management must take a second seat to actually getting =

a good user experience.

> > Another use for this feature is that we have had a lot of problems over =

> > the years with buggy I2S interfaces misbehaving when streams are starte=
d =

> > and stopped, and there would be an advantage to letting the AIF run the =

> > whole time after startup.
> =

> This is why we've got the digital_mute() callback - the idea is that the =

> output is just going to be discarded until the interface has had a =

> chance to settle down.

The problems we've had have been on the CPU side, with I2S interfaces that =

have problems synchronizing to an ongoing I2S stream when the CPU AIF is =

in slave mode, to the extent that in some cases its impossible to =

determine if the first sample received by or sent from the I2S interface =

is the left or right channel. If the DAIs had been set up once and been =

allowed to run continuously even when there is no actual audio to =

transfer, it would have helped this situation. Agreed, I'd rather have a =

DAI that worked properly, but sometimes one doesn't have that luxery. :-(

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
