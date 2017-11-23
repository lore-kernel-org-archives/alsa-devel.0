From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Disable DAPM for click avoidance ?
Date: Thu, 23 Nov 2017 15:32:26 +0100
Message-ID: <alpine.DEB.2.11.1711231512490.27895@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
 <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A74266B02
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 15:32:34 +0100 (CET)
In-Reply-To: <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
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


On Thu, 23 Nov 2017, Mark Brown wrote:

> If you don't copy any actual people the chances of getting a response
> are vastly reduced.

My point has been that I don't want to pester any specific people ... but =

point taken that otherwise it just ends up as an FYI.

> > Of course, one solution would be to change the driver to enable the out=
put =

> > already at the _STANDBY level. It does seem to me that that would viola=
te =

> > part of the whole point of DAPM, on the other hand, I would think that =

> > at some point power management must take a second seat to actually gett=
ing =

> > a good user experience.
> =

> Yes, you'll need to do something like leave the outputs enabled.  Most
> devices have some facility to keep VMID switched to the outputs, though
> I did see a few where someone thought it was a good idea to power on
> from cold always.  A device that old isn't going to be that competitive
> power wise anyway even if it were well implemented which this one seems
> to not have been.

In my case the codec is only a couple of years old, so I'd say it =

qualifies as 'modern'. There's a table in the data sheet describing the =

power consumption for various combinations of the PM control bits but =

unfortunately the case of having the outbut buffer enabled but not the DAC =

is not listed. I could always ask the manufacturer directly of course. Or =

simply measure it myself on an evaluation board to get an idea.

> > > This is why we've got the digital_mute() callback - the idea is that =
the =

> > > output is just going to be discarded until the interface has had a =

> > > chance to settle down.
> =

> > The problems we've had have been on the CPU side, with I2S interfaces t=
hat =

> > have problems synchronizing to an ongoing I2S stream when the CPU AIF i=
s =

> =

> That's what the digital mute handling is for - we're just throwing away
> any garbage the CPU puts out before it's stable.  We're not expecting it
> to work around any CODEC side issues.

During which time period is the digital mute enabled? From the first =

stream startup until everything is up and running?
> =

> > in slave mode, to the extent that in some cases its impossible to =

> > determine if the first sample received by or sent from the I2S interfac=
e =

> > is the left or right channel. If the DAIs had been set up once and been =

> > allowed to run continuously even when there is no actual audio to =

> > transfer, it would have helped this situation. Agreed, I'd rather have =
a =

> > DAI that worked properly, but sometimes one doesn't have that luxery. :=
-(
> =

> If you're getting L/R swap issues on some startups leaving things
> enabled all the time will mean that your random swap issue gets moved to
> boot.

Basically the situation I had was that it worked fine on first startup, it =

was on subsequent startups/shutdowns that the problems occurred, as
shutting down the audio streams seemed to leave the CPU DAI in some =

intermediate state, from which it could only recover if completely reset, =

which did not play well with the concept of for instance having a capture =

stream running continuously while a playback stream was started and =

stopped.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
