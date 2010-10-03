From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 3 Oct 2010 13:30:42 -0700
Message-ID: <20101003201943.GA31764@opensource.wolfsonmicro.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CF47103803
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 22:30:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101003112244.488282fd@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 03, 2010 at 11:22:44AM +0100, Alan Cox wrote:
> > Having things as a series does make things easier for review, reducing
> > reviewer fatigue if nothing else.  I've given this a bit of a once
> > over below but not a deep dive - splitting the series would really
> > help with reviewability.

> It really wouldn't help in this case for most people I think. You end up
> with what there is in the original which is a series of patches for old
> code all quite large and just a big one chopped into chunks, followed
> by a series of updates that fix half the bugs you found reviewing the
> first big splat.

IIRC at least one version had a split where the ALSA integration stuff
was separated out from the underlying DSP interface code - that was
pretty helpful since it helps focus on the ALSA specifics.

> I did think about it, but what history we have is fairly basic because
> it was basically  written then fired in my direction to help sort out

Yeah, I wasn't thinking about history so much as about helping break
down the areas covered for comprehensibility.

> > To be honest all this stuff looks sufficiently generic that it might
> > be worth considering factoring out an abstraction which can be used by
> > other offload engines - having a standard kernel API for them would
> > be a real win.  That's just a nice to have, though.

> Agreed, although gstreamer is pretty good at that it would save work if
> it can be partly generic. It's not trivial however because the offload

Plus the fact that not everyone is using gstreamer at the application
level :/

> interface with suitable firmware loaded does things other than PCM and
> you have very firmware specific interfaces for configuring those.

We ought to be able to come up with something for the core streaming
stuff, though.  Like I say, it's just a nice to have though.

> So are you happy for it to go into staging. I'm hoping that way at
> least all the changes will be visible and trackable. I'll start by
> sending GregKH a follow up patch which is a TODO list summary based on
> your feedback

Happy is a strong term but this looks like exactly the sort of stuff
staging is there for so yes, it should go in.  Probably best to look for
feedback from at least Takashi and/or Jaroslav as well, but obviously we
can update the TODO later.

I do have some nervousness about the concept of staging for embedded
stuff since I worry that inclusion in staging can send the wrong message
to vendors but that's a completely separate issue to this driver.
