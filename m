From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Fri, 29 May 2015 13:45:44 +0530
Message-ID: <20150529081544.GC3140@localhost>
References: <20150525135854.GV21391@sirena.org.uk>
 <s5h617f29os.wl-tiwai@suse.de>
 <20150526133256.GQ21577@sirena.org.uk>
 <s5hr3q3cv77.wl-tiwai@suse.de>
 <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
 <20150527183406.GM21577@sirena.org.uk>
 <s5hpp5lde48.wl-tiwai@suse.de>
 <20150528195359.GG21577@sirena.org.uk>
 <s5hk2vsasjz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 423C4260417
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 10:14:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk2vsasjz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 29, 2015 at 06:58:24AM +0200, Takashi Iwai wrote:
> At Thu, 28 May 2015 20:53:59 +0100,
> Mark Brown wrote:
> > 
> > On Wed, May 27, 2015 at 09:17:27PM +0200, Takashi Iwai wrote:
> > > Mark Brown wrote:
> > 
> > > > I'm unclear how that would (practically speaking) be accomplished if
> > > > they're in two separate worlds for matching.  Come to think of it how
> > > > does this work if we have more than one matching system in use - how
> > > > does the driver model code cope with that, what happens if one match
> > > > function ends up looking at data for another match type?
> > 
> > > The matching function does the same thing, but it just looks at the
> > > different embedded id tables.  The bus match function already checks
> > > each device/driver type beforehand.
> > 
> > How do we safely do the looking at different tables bit though?  I
> > should probably go back and look again at the original patch...
> 
> There is the device type check in hda_bus_match() before calling
> hda_driver->match(), so it must be safe.  But as already mentioned,
> the match isn't the thing to worry too much, as it'll be unified
> sooner or later.  The rest (still unseen) stuff is more worrisome.
> 
> > > > > The fact you might be missing from the beginning of the story is that
> > > > > we need to implement two different driver sets for ASoC, both for
> > > > > controller and codec drivers.  They can't be unified with legacy HDA
> > > > > unless we merge ASoC core codes into ALSA core (e.g. DPCM or DAPM into
> > > > > ALSA core).  Also ASoC has the different ways of registration, too.
> > > > 
> > > > Wow, that's not what I'd have expected to be happening at all and really
> > > > should have been mentioned at some point.  I need to think about this
> > > > further.
> > 
> > > > What I had expected to see for ASoC/HDA integration was something where
> > > > ASoC devices were providing a standard HDA controller and then use the
> > > > same CODEC drivers as everything else.  Not doing that means that we
> > > > inveitably have some duplication for at least things like CODEC quirks
> > > > and device specific support which doesn't seem like the best idea.
> > > > There's also userspace interfaces for things like the HDA device graph
> > > > that'd need looking at.
> > 
> > > Actually that's the exact plan -- the codec graph will be parsed in
> > > user-space (or pre-parsed) and mapped via DFW.
> > 
> > OK, more surprises!
> > 
> > Looking at the Broadwell based I2S systems that don't work with any
> > released set of upstream software (they need alsa-lib from git) I'm
> > wondering how close these systems are to getting into the hands of users
> > and what the transition from existing HDA to userspace parsing HDA is
> > going to look like.
well userspace parsing is only for the pin mapping and changes which
users want to do on their systems. For basic things the default graph
will be read by existing HDA parser and codec driver will create
widgets based on that. The generic HDA codec library should do most and
the HDA ASoC codecs should do device specfic work (like existing
patch_xxx)

Yes I agree it will take a while before all things fall into place and "Just
work".

> > I guess older distros will just bind the existing HDA controller drivers
> > to them and use the hardware without any of the shiny new features which
> > ought to be fine and I'm sure that once everyone has got the new stuff
> > it will all be glorious, it's the space where people are upgrading
> > (possibly upgrading the kernel or userspace separately) that worries me.
> > Especially the bit where people ask me to make their sound work when
> > they see their system uses ASoC!
For HDA based systems, unless someone really wants ASoC features we
should not enable them yet. I2S systems will be using ASoC. I expect
the next generation to be mature enough for us to make HDA systems
also use ASoC :) by default

> 
> Right, the time is still a question.  Vinod and Liam can answer at
> best.
For BDW, Liam is the best guy. I will be supporting platforms from SKL
onwards, so feel free to redirect them to me.

> 
> And it's the reason I suggested for pending merge until the codec side
> is ready.  We need the topology stuff merged at first, then HDA-codec
> driver together with user-space side.
I dont mind if code doesnt get merged into next merge window and put
in one after that. But in needs to get accepted is some topic branch
so that subsequent series can be  psted and reviewed, merged. Btw
users will not see unless we have machine driver. I will add the
disable feature after this series, so no user conflicts occur

> 
> > > The quirks are still open questions.  Currently, ASoC HDA is targeted
> > > only to the new systems with SKL.  The rest will keep supported by the
> > > existing driver.  So, we expect that the amount of quirks can be
> > > reduced much (starting from zero).
> > 
> > I'm sure that our hardware engineering colleagues wouldn't want us to be
> > bored and will give us something to do there :)
> 
> I have no doubt about it, too :)
> 
> > > > Having HDA use ASoC doesn't seem like a terrible idea, there are aspects
> > > > of HDA that map quite well onto ASoC, but doesn't seem to be the
> > > > intention here and I'm ambivalent about it being worth the effort.  I
> > > > don't think it would need us to move ASoC into the core any more than
> > > > any other driver, it'd just make it much more widely used.
> > 
> > > Heh, that's the very reason why we started implementing a different
> > > driver set, after all.  The new driver code is written in minimalistic
> > > manner to fit better with ASoC.  The heavy part has been already
> > > shifted into HDA core side, that is basically a stripped version from
> > > the old HDA code.
> > 
> > > ASoC implementation was requested rather due to DPCM, compress
> > > support, etc, which is currently ASoC-specific features.  The current
> > > patchset we've seen is really a tip of iceberg...
> > 
> > Right, and I'm aware of the reuse potential with sharing features with
> > the embedded side (like we're already seeing with the I2S Broadwells) so
> > if we don't integrate the two somehow we end up with duplicated drivers
> > which would be sad.  It's just that I'd anticipated that this would be
> > being handled by black boxing the HDA part of the system from the ASoC
> > point of view.
For us, the main issue was managing DSP along with HDA. The SKL DSP
requires us to instantiate DSP toplogy and manage them, without DAPM n
DPCM this was unthinkable. So we leaned on bringing HDA into ASoC. To
use HDA controller the core HDA is in place now

Codecs are different beast here, esp HDA issue of pin mapping and jack
retasking. So idea is to have codec generic parser which creates ASOC
widgets based on parsing and actual codec driver use this or load
their own quirks. For pin mapping, machines can override configuration
using toplogy and change a system to 7.1 audio or three stereo outputs
or 2 stereo audio and 1 mic,. Using toplogy they can write and load
their own configuration, thus moving these configuration out of kernel
and getting us rid of platform hacks


> 
> Yes, blackboxing the existing HDA was the first plan.  But it has
> obvious drawbacks when joined to ASoC (inheriting a huge amount of
> quirks, different designs; HDA legacy is very self-contained, does
> DAPM-like path controls and jack-retasking by itself, etc).
> 
> Potentially it's still possible to implement in that way, as a plan B,
> if a cleaner implementation from scratch fails.  Let's see...
Yes I would still think our plan A is a good one. I dont expect us to
solve all probelms right away but by the time we meet again for u-Conf
we shoudl have dealt with most and can discuss remaining ones.
Pls do add this as topic :)

So Mark, Takashi,

Now that we have debated this and I guess all have the big picture
here, how do we go about this. Do you guys need changes in this series
or this is good for now?

-- 
~Vinod
