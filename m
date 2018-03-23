From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Disable DAPM for click avoidance ?
Date: Fri, 23 Mar 2018 17:23:23 +0100
Message-ID: <alpine.DEB.2.11.1803231708350.14045@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1803191641250.14045@lnxricardw1.se.axis.com>
 <20180321023432.GV2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 60911266B0F
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 17:23:32 +0100 (CET)
In-Reply-To: <20180321023432.GV2186@sirena.org.uk>
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


On Wed, 21 Mar 2018, Mark Brown wrote:

> > > The CODEC driver is broken, it shouldn't be powering off on idle if it
> > > takes a second to ramp, it should be leaving VMID up while the system=
 is
> > > running - this is what the _STANDBY bias level is all about.  Look at
> > > what older CODEC drivers like the wm8731 do.
> =

> > I was tracing through what actually is called in the codec driver when =
a =

> > stream is started, and from what I can see ALSA sequences through the =

> > STANDBY, PREPARE and ON states when a stream is started, with no other =

> > calls to set_bias_level prior to that. So it would seem that the STANDB=
Y =

> > level is reached during the process of starting the stream, in other =

> > words, VMID and the outputs would have to be enabled already in the OFF =

> > state.
> =

> To repeat if you're setting idle_bias_off for a CODEC like this you're
> doing it wrong.  The device shouldn't be going to a bias level lower
> than _STANDBY while the system is out of suspend.

Thanks for the pointer, we've gotten the driver from the codec =

manufacturer so I haven't been very familiar with it, and I wasn't even =

aware this configuration option existed. The driver does indeed set =

idle_bias_off, and clearing this bit was the first step to getting it to =

work. I'll spare you the gory details.

My biggest issue here has really been understanding how ALSA expects the =

device to behave, and which options there are. Once I've got that clear =

getting the codec to behave correspondingly is mostly a question of =

reading the data sheet and writing code.

> Are you sure that the device doesn't have any facility for switching the
> outputs to a lower power maintenance state while things are idle?  This
> sounds like an extremely basic device, even by the standards of a decade
> ago.  The reason for powering down the outputs isn't just a power one,
> often especially with these older devices there's an audible noise floor
> even when playing silence which is distracting for users in quiet
> environments.  Powering down eliminates this noise floor.

Yes, there is a bit for setting the output amplifier in power save mode, =

which is handled as a PM bit in the driver. The specs aren't that bad, the =

worst case SNR is 80 dB, with 97 dB typical. The good thing about using =

this bit is that when the output amplifier is in power save mode, there is =

actually a high impedance connection to VMID, so that as long as the =

device is powered on properly, the outputs take a while to reach VMID =

depending on the value of the DC blocking cap on the output, and the slow =

ramp also avoids clicks when powering on the device (and we don't start an =

output stream until quite a while after powering on the system).

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
