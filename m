From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for
 Analog Devices ADAU1701 SigmaDSP
Date: Mon, 7 Mar 2011 12:15:03 +0000
Message-ID: <20110307121502.GG13471@opensource.wolfsonmicro.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
	<20110307114142.GB13471@opensource.wolfsonmicro.com>
	<AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFC28103880
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:15:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikynw7vCsqqyNZW-LFuGUKKQEtG3s4YCZjpOvko@mail.gmail.com>
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

On Mon, Mar 07, 2011 at 06:50:15AM -0500, Mike Frysinger wrote:
> On Mon, Mar 7, 2011 at 06:41, Mark Brown wrote:

> > Is this needed by other trees?

> no

> >=A0I can't apply this driver until it's merged into ASoC via some means

> and andrew has been holding off on merging the firmware driver until
> something in mainline needs it.  once a driver gets to the point where
> you're fine with merging it, we can bug akpm to push the sigma
> firmware loader to linus.

It'd seem easier to just merge the two patches together rather than
trying to deal with cross-tree issues.

> > This presumably also needs to select the DSP API otherwise it's not
> > going to build.

> by "DSP API" i'm guessing you mean the Sigma firmware loader

Yes.

> > More generally this doesn't seem like a great interface - apparently the
> > device requries that firmware be loaded but the whole firmware load
> > process isn't at all joined up with the driver code meaning that the
> > application layer has to figure out when firmware needs to be reloaded,
> > there's no understanding on the part of the driver of what the firmware
> > on the device is doing or how it's glued into the audio subsystem.

> the API should allow for userspace to specify the firmware name, but
> that's about it.  it is up to the userspace application to arbitrarily
> load different firmware files on the fly into the codec without the
> codec caring what's going into it.  often times the firmware is DSP
> code to do different post processing on the audio stream (cleanup or
> whatever).

Right, and this isn't a particularly unusual requirement especially if
the driver isn't going to have any ability to interact with the DSP (at
which point it's just coefficient data, the fact that it's a DSP program
is uninteresting).  The problem is that this isn't a great interface for
doing that.

At a really basic level the code is not at all integrated with either
power management or stream handling in ASoC meaning that the user could
try to download firmware in the middle of an active audio stream (which
isn't going to be ideal).  Obviously the driver doesn't really support
any kind of power management at the minute but if it were improved in
this area you'd also have issues with trying to download firmware while
the device is off which probably isn't going to work either.

It's also not an interface which offers any kind of discoverability or
enumerability, meaning that it's not suitable for integration into
application layer code such as the use case manager.  Applications need
to be hard coded to know that a particular magic sysfs file needs to be
poked.  This would be a big step backwards in terms of the ability to
run off the shelf application software.
