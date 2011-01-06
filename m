From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Thu, 6 Jan 2011 00:59:51 +0000
Message-ID: <20110106005951.GC12153@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D3FF0103827
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 01:59:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 04:20:04PM -0800, Stephen Warren wrote:

> One of the nice things about ALSA on desktop is that everything just works
> without having to fiddle around setting up routing etc. from user-space e.g.
> using alsamixer or custom code.

If you look at the desktop case on a modern system a fair chunk of the
configuration is actually being handled by PulseAudio rather than the
driver - the driver exposes a standard view of the cards but Pulse
figures out how it should be configured.  Probably at some point after
the media controller API (or something like it) makes it into mainline
we'll start to see some efforts at similar managment for embedded
systems, but the diversity of the hardware makes this a much more
difficult problem.

> Isn't ASoC attempting to set up a reasonably good routing/configuration on a
> per-board basis, driven by knowledge in the machine (board?) driver? Then,
> let people tweak it /if/ they want? It kinda sounds like you're pushing for a

No, it's delegating everything to userspace.

> model where simply loading the driver may or may not have things set up right,
> then one has to configure everything from user-space before audio will work.
> Am I grossly misunderstanding?

No, that's exactly it.  The bulk of the reason is that the hardware is
very diverse, plus the fact that the edit/compile/run cycle for dropping
the configuration into the kernel is pretty slow and painful and it's
very hard to maintain stuff in mainline when you can't test the settings.

You can't do stuff in the CODEC driver because everything depends on the
system and what physical configuration it has, plus user taste.  Doing
stuff in the machine driver means you're very fragile in the face of any
changes in the CODEC driver (and CPU drivers as CPUs get more
functionality) and means that stuff is still in the kernel.

Things get even more entertaining when you consider that things like
smartphones can have vastly different configurations depending on the
use case they're using - it's often not just a case of tweaks, it can be
a substantially different setup.

Worse, if you hard code stuff into the kernel you end up causing pain
for userspace people when they want to change use cases - they own
part of the configuration but not all of it, which increases the
coupling between the software components in the system.  Adding a new
use case becomes much more likey to require kernel changes (and consider
what happens on a board that's used by multiple userspace groups, all of
who may have diverging ideas of what's the optimal setup for any given
use case).

> Related to this, there's a lot of code in the-original-Tegra-driver-that-I-
> based-my-submission-on which pokes all kinds of registers in the codec from
> the machine driver to set up recording; e.g. mic mux selection, mic volume
> or gain, bias on/off, mono/stereo etc. based off detailed knowledge of the
> Harmony board. Seaboard, Ventana, ... would have similar but subtly different
> configuration logic. I stripped this out to simplify things initially. Is
> such configuration not meant to be part of the machine driver, but provided
> by manually setting everything up with alsamixer for example (and perhaps
> shipping a saved alsamixer state file)?

The intention is that userspace would ship a bunch of different
configuration files here; you should never be configuring any of this
stuff in kernel space.  When used in conjunction with mainline drivers
such register writes are often actively disruptive - they overwite
settings applications might try to change, confuse the internal state of
the CODEC driver or otherwise upset things.  Stage one when people run
into issues is often to strip such code from drivers.

Bias management in particular should never be being done from the
machine driver - the ASoC core may well get confused if you do that by
hand.

Both basic alsa-lib and UCM have support for loading different
configurations based on board name, and userspace can in general do
whatever it likes to handle per-board setup - what makes sense is going
to vary depending on how the application layer is set up.

> > Oh, hrm.  That wasn't clear from your code.  Would mapping controller n
> > to port n work for Harmony?

> Yes, Harmony just happens to use controller ID 1 and port ID 1.

OK, then the straight through mapping sounds like a good bet for initial
submission.  If we don't get better support in before 2.6.39 goes out
then we can always expose the API to machine drivers as a stopgap.
