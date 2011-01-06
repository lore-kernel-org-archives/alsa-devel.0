From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Thu, 6 Jan 2011 22:13:01 +0000
Message-ID: <20110106221301.GA8408@opensource.wolfsonmicro.com>
References: <20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
	<20110106005951.GC12153@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567B85@HQMAIL01.nvidia.com>
	<20110106210238.GD8018@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567C04@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58098103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 23:12:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567C04@HQMAIL01.nvidia.com>
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

On Thu, Jan 06, 2011 at 01:58:22PM -0800, Stephen Warren wrote:
> Mark Brown wrote:
> > On Thu, Jan 06, 2011 at 09:46:10AM -0800, Stephen Warren wrote:

> > > "allows". It'd still be nice if the default (in the absence of any
> > > alsamixer or UCM setup) was that opening e.g. hw:0,0 would allow some
> > > simple use of the audio, e.g. playback to primary output, capture from
> > > primary input, so that simple testing could be performed without having

> > Probably the only people who'd get much from this are people who are
> > using a reference system with no userspace provided, which is fairly

> People who're bringup up a board without expecting they need to know
> anything about alsa-lib would get a bit out of this:-) :-)

The trouble is they're in a recursive problem where it's pretty
difficult to know what a sane setup is for their system/

> So I guess what'd help me through this the most is knowing exactly how
> the user-space is configured; is this all stuff in /etc/asound.conf or
> some other config file? When you were talking about user-space earlier,

This is up to userspace.  Some systems use asound.conf and
/usr/share/alsa/cards.  Some systems have init scripts which run amixer
commands.  Some systems use UCM or their own implementations of that
idea.  Some systems restore an 'alsactl store' dump in an init script.

Partly it depends on how much flexibility is needed - if you've only got
one input and one output (as is very common) then things are much like
on a PC, the bigger more complicated the system the more fun things get.

> I was thinking of writing a custom application per board/machine to
> configure the system at e.g. boot time (or libraries that apps would use),
> which didn't sound appealing; maybe that's part of my misunderstanding.

I was talking about a single application that can choose multiple
configuration files using some algorithm.

> Are there any public examples for ASoC in particular that I can read in
> concert with the driver source to get the idea? I did find
> alsa-lib.git/src/conf but that seems to only cover desktop PCs, not
> ASoC drivers.

Beagleboard is the most obvious example, and pretty close to the systems
you're working on in terms of features.  Not that I know off the top of
my head what exactly the various software stacks for that are doing or
where to find them.

Really there's no difference to PCs here, the userspace API is exactly
the same and anything that works on PCs should work on an embedded
system.  You'll generally get more knobs to twiddle but the mechanics of
doing so are identical.
