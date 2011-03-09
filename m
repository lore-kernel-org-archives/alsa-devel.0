From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Wed, 9 Mar 2011 09:55:07 +0000
Message-ID: <20110309095506.GA6923@opensource.wolfsonmicro.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
	<20110307121502.GG13471@opensource.wolfsonmicro.com>
	<AANLkTinKpvgBokSHpsVf1KVX+m6sD0Xp_dFe8Y+HzY-7@mail.gmail.com>
	<20110307145931.GK13471@opensource.wolfsonmicro.com>
	<AANLkTi=e1xDz6fhBU7NL32DXL1J9Y1CDD2bHQVL6oASw@mail.gmail.com>
	<20110307155508.GM13471@opensource.wolfsonmicro.com>
	<AANLkTim6bQGKCuzAgxNS93LQkq2iqxjcCW49NBArafK1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B5432457B
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 10:55:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTim6bQGKCuzAgxNS93LQkq2iqxjcCW49NBArafK1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: cliff.cai@analog.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 09, 2011 at 01:08:03AM -0500, Mike Frysinger wrote:
> On Mon, Mar 7, 2011 at 10:55, Mark Brown wrote:

> > At a bare minimum suddenly stopping and starting the firmware while
> > audio is going through it is unlikely to work well (you'd most likely
> > get a hard stop of the audio followed by a sudden hard start which sound
> > very unpleasant to listeners) and so should be prevented. =A0There's a
> > bunch of options for doing this (including refusing to change, ensuring
> > the DSP output is muted during the change or routing around the DSP
> > while doing the change).

> you would probably get the "normal" clicks and pops, but i guess your
> view of "wrong" is much more strict than mine ;).  i'm not sure our
> parts allow routing around the DSP (Cliff would have to comment).  as
> for the rest, i think it'd be best to let the user space app dictate
> how they want to handle things.  perhaps clicks/pops are fine with
> them.  or they arent, and so the userspace app would make sure to
> pause/mute/whatever the stream.  either way, this sounds like a policy
> that shouldnt be hard coded in the codec driver.

Muting the DSP output during firmware reboots seems like an entirely
reasonable way of doing this if there's no ability to route round the
DSP or otherwise deal with the issue, and given how cheap the
mute/unmute is it's hard to see where a user would find that a problem.
Either they'll want to deal with the issue or they won't care.

Bear in mind that people are trying to do things like run off the shelf
PulseAudio as their system audio manager in embedded systems - the
kernel should make some effort to behave sanely.

> > The standard tools should also be able to manage the mechanics of
> > actually getting the new data into the kernel at appropriate moments.
> > This includes both offering control via UIs such as alsamixer and being
> > able to include configuration of the data in UCM configurations.

> exposing this via alsamixer and friends would be a useful debugging
> tool so people can toy around with known working configurations.  and
> have code examples to see how to do it.

The ALSA APIs are also the userspace interface to the audio subsystem,
any userspace application interacting with the audio hardware is
expected to use them.

> > I'm not sure you're following what's being said here. =A0The above cont=
rol
> > discussed above full system configuration of all the control offered by
> > the system, not tuning the parameters of an individual algorithm. =A0Th=
is
> > includes volume controls, routing controls, algorithms, coefficients and
> > anything else that can be changed. =A0A scenario where you want to chan=
ge
> > the set of algorithms the hardware can support is certainly included in
> > that.

> i just meant that the use cases we've been dealing with involve the
> people developing the application taking care of picking which
> firmwares to load at any particular time.  having the end user (the
> guy who buys the actual device) select firmwares doesnt make much
> sense.  but this particular qualification probably is irrelevant to
> the framework you're proposing in the end.

In a modern Linux system the user will rarely see an application that
exposes ALSA directly unless they go looking (in an embedded system they
may not be able to go looking due to the limits of the UI), they'll see
a higher level abstraction.  In the desktop case the primary interface
the user has is with GUIs that control PulseAudio which abstract away
the actual control offered by the drivers.  Embedded systems tend to
either use Pulse or brew their own equivalent.
