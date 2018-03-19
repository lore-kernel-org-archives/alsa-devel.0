From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Disable DAPM for click avoidance ?
Date: Mon, 19 Mar 2018 16:53:23 +0100
Message-ID: <alpine.DEB.2.11.1803191641250.14045@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EDDCE267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 16:53:31 +0100 (CET)
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


Hi Mark,

Picking up an old thread here, I'm working on a VMID based codec with =

associated driver from AKM, where the VMID and audio outputs are only =

switched on when the devices is actually outputting audio data (in the =

playback case), causing loud clicks when a stream is started and stopped.

On Wed, 22 Nov 2017, Mark Brown wrote:

> On Wed, Nov 22, 2017 at 01:33:37PM +0100, Ricard Wanderlof wrote:
> =

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

I was tracing through what actually is called in the codec driver when a =

stream is started, and from what I can see ALSA sequences through the =

STANDBY, PREPARE and ON states when a stream is started, with no other =

calls to set_bias_level prior to that. So it would seem that the STANDBY =

level is reached during the process of starting the stream, in other =

words, VMID and the outputs would have to be enabled already in the OFF =

state.

In our system, the power consumed by the codec is negligible compared to =

the rest of the system at all times, so it's not a problem to leave =

basically the whole codec up, but I am trying understand what is the =

Right Thing to do here.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
