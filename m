From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Sun, 17 Oct 2010 23:11:26 +0100
Message-ID: <20101017221126.GA11666@opensource.wolfsonmicro.com>
References: <20100930162123.21348.86482.stgit@localhost.localdomain>
	<20101002230610.GA21181@sirena.org.uk>
	<20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
	<20101017103626.GB6311@opensource.wolfsonmicro.com>
	<s5hk4lhul3j.wl%tiwai@suse.de>
	<20101017161808.GA4437@opensource.wolfsonmicro.com>
	<s5h39s4v6wi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BB3A24438
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 00:11:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h39s4v6wi.wl%tiwai@suse.de>
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

On Sun, Oct 17, 2010 at 11:36:13PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> OK, but what makes it different from keeping the stuff in sound tree
> rather than staging tree?  Or you are suggesting to remove the driver
> from staging tree, either?

I do have some qualms about staging but given Greg's active policing of
it and work to push things into the actual trees the warnings about its
quality and general mainlineness are much more meaningful than those for
experimental.  There's also the tainting of kernels, which is really
useful.

> > > So, what I'm trying to say is:
> > > - we can accept the present solution in a certain level, rather then
> > >   just refusing it

> > I think this is the wrong approach.  I think this says to embedded CPU
> > vendors that they can go off and reinvent the wheel with their own
> > embedded audio stacks.

> If this brings really benefit to _user_, why not?

We've got multiple classes of users here - system integrators are
involved too - and there's also the issue of how we maintain stuff going
forward if users get shiny new machines and we have to work out what the
patched audio drivers that come with them actually mean.

> >  If all the CPU vendors already in mainline were
> > to have gone down this route we'd have sixteen different ways to add
> > support for a new board right now, with lots of redundancy in the CODEC

> OS exists for supporting the hardware.
> Yes, we have now a great framework, and h/w vendors should support it.
> But, why we must restrict ourselves by this, and don't allow us to
> use the full hardware features at all?  The hardware encoding/decoding
> are nice and long-wanted features, indeed.

I'm sorry I don't really understand what you're saying here.  The
encoder offload stuff is all totally orthogonal to the issue of using
the ASoC APIs.  On the CPU side the ASoC API is mostly a thin wrapper
around the standard ALSA API so anything that works in ALSA should slot
fairly readily into ASoC.  What I'd expect to see happen is that the
CODEC and board stuff would get pulled out and everything else would
stay pretty much as-is, including the DSP.

CPUs like OMAP (which are obviously already in the ASoC framework) also
support this sort of stuff, the issues with mainline for them have been
around the API to the DSP, though it looks like the TI stuff in staging
is getting sorted out now.

> > Please bear in mind that we've already seen similar stacks from other
> > vendors (Marvell and TI being the main ones I've been aware of) getting
> > replaced as part of mainlining, and a couple of others I'm aware of but
> > NDAed with doing the same thing.  If you're saying you'll accept this
> > approach and bypass the existing embedded audio stack then the pressure
> > on vendors to do the right thing and move over to the Linux embedded
> > audio stack is greatly reduced.

> Well, think about it from the user's POV.
>  "Why can't I use the h/w audio decoding feature on linux?"
>  "Because it doesn't match with the philosophy of the existing linux
>   audio framework." 

Like I say I'm having real trouble connecting the above with what I
wrote.

> > We already have an existing framework for embedded audio devices.  We
> > may want to extend or improve it but I don't see a pressing need to
> > develop a new one.  Whenever we end up with two different ways of doing
> > the same thing it's not great, it just makes for confusion and
> > redundancy.

> So, are you saying that we can extend ASoC to provide the support this
> kind of hardware feature?  If yes, then we can work on it first. 

I'm saying I see nothing about this hardware which should prevent it
working with ASoC right now.  As I have said in terms of the overall
structure of the device it's not really doing anything that hasn't been
done elsewhere.  There's stuff we'd have to bodge in the short term, but
only fairly small bits that can be handled fairly straightforwardly.
