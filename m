From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 17 Oct 2010 17:18:08 +0100
Message-ID: <20101017161808.GA4437@opensource.wolfsonmicro.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
	<20101017103626.GB6311@opensource.wolfsonmicro.com>
	<s5hk4lhul3j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB9911037F3
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 18:18:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4lhul3j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 17, 2010 at 01:14:56PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I'm really concerned about this idea.  Allowing embedded vendors to push
> > drivers into mainline which don't work with the standard frameworks for
> > what they're doing sets a bad precedent which makes it much harder to
> > push back on other vendors who also want to push their own stacks.

> We've had (and still have) many pre-ASoC drivers, but the
> _maintenance_ cost of them were relatively small from the global
> sound-tree POV.  As long as the driver is self-contained, there is no
> big hustle for maintenance.

You're only seeing what goes on upstream.  Outside of upstream you'll
usually find a lot of people doing a lot of redundant work to get their
boards working, code that never finds its way upstream and quite often
gets done fairly reptitvely.  It's no hassle upstream because nobody
ever bothers upstreaming anything much after the original driver but for
system integrators trying to use the driver on their platform which
differs from the vendor reference and distributors trying to support
multiple machines it's a different kettle of fish. 

> Of course, the further _development_ is a totally different question.
> If the development diverges to too many different h/w components, a
> certain framework would be certainly needed.  This is how ASoC was
> introduced and developed by Liam and you.

This is pretty much a given in the embedded marketplace if a CPU is at
all successful - apart from anything else the embedded audio state of
the art is on much quicker cycles than most components so the components
which are leading edge today may not make quite so much sense in a year.
The hardware is all constructed with standard interfaces between the
parts (though there are no standards at all for the control of the
devices) so these sorts of changes are very straightforward for the
hardware guys to do, meaning that the software stack needs to be
similarly modularised.

> So, what I'm trying to say is:
> - we can accept the present solution in a certain level, rather then
>   just refusing it

I think this is the wrong approach.  I think this says to embedded CPU
vendors that they can go off and reinvent the wheel with their own
embedded audio stacks.  If all the CPU vendors already in mainline were
to have gone down this route we'd have sixteen different ways to add
support for a new board right now, with lots of redundancy in the CODEC
side between them and each with a different set of features and
limitations in how you can customise for your board (especially if you
want to get code upstream).  That wouldn't be terribly pleasant, it'd
put Linux's audio support right back where all the other embedded OSs
are.

Please bear in mind that we've already seen similar stacks from other
vendors (Marvell and TI being the main ones I've been aware of) getting
replaced as part of mainlining, and a couple of others I'm aware of but
NDAed with doing the same thing.  If you're saying you'll accept this
approach and bypass the existing embedded audio stack then the pressure
on vendors to do the right thing and move over to the Linux embedded
audio stack is greatly reduced.

> - it can be taken into the main sound tree as an EXPERIMENTAL one,
>   instead of keeping it in staging tree forever

I definitely think EXPERIMENTAL is too weak a pushback - I can't see
that stopping anyone going out there and saying they have standard audio
drivers in mainline which is the check box people are looking for.
Even distributors routinely enable EXPERIMENTAL.

Like I say, this is not just a concern for this driver it's also a big
worry with other CPU vendors and with future Intel chips.

> These don't mean that the current driver will be necessarily regarded
> as the standard.  We might need to end up developing the new better
> standard framework for similar devices.  It doesn't conflict with
> merging the merge action.

We already have an existing framework for embedded audio devices.  We
may want to extend or improve it but I don't see a pressing need to
develop a new one.  Whenever we end up with two different ways of doing
the same thing it's not great, it just makes for confusion and
redundancy.
