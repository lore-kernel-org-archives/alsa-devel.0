Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46238F8065C
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 16:54:57 +0200 (CEST)
Date: Tue, 30 Apr 2019 20:24:44 +0530
From: Vfiinod Koul <vkoul@kernel.org>
Message-ID: <20190430145444.GU3845@vkoul-mobl.Dlink>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190430085153.GS3845@vkoul-mobl.Dlink>
 <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-ID: <alsa-devel@alsa-project.org>

On 30-04-19, 08:38, Pierre-Louis Bossart wrote:
> On 4/30/19 3:51 AM, Vinod Koul wrote:
> > On 15-04-19, 08:09, Pierre-Louis Bossart wrote:
> > > 
> > > > > 
> > > > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > ---
> > > > >    drivers/soundwire/Kconfig          |   2 +-
> > > > >    drivers/soundwire/bus.c            |  87 ++++++++--------
> > > > >    drivers/soundwire/bus.h            |  16 +--
> > > > >    drivers/soundwire/bus_type.c       |   4 +-
> > > > >    drivers/soundwire/cadence_master.c |  87 ++++++++--------
> > > > >    drivers/soundwire/cadence_master.h |  22 ++--
> > > > >    drivers/soundwire/intel.c          |  87 ++++++++--------
> > > > >    drivers/soundwire/intel.h          |   4 +-
> > > > >    drivers/soundwire/intel_init.c     |  12 +--
> > > > >    drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
> > > > >    drivers/soundwire/slave.c          |  10 +-
> > > > >    drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> > > > 
> > > > I would prefer this to be a patch per module. It doesnt help to have a
> > > > single patch for all the files!
> > > > 
> > > > It would be great to have cleanup done per logical group, for example
> > > > typos in a patch, aligns in another etc...
> > > 
> > > You've got to be kidding. I've never seen people ask for this sort of
> > > detail.
> > 
> > Nope this is the way it should be. A patch is patch and which
> > should do one thing! Even if it is a cleanup one.
> > 
> > I dislike a patch which touches everything, core, modules, so please
> > split up. As a said in review it takes guesswork to find why a change
> > was done, was it whitespace fix, indentation or not, so please split up
> > based on type of fixes.
> 
> With all due respect, you are not helping here but rather slowing things
> down. I've done dozens of cleanups in the ALSA tree and I didn't go in this
> sort of details. 

Thats fine, it is upto people, everyone has different views, mine is
different from Takashi's. We all know for example networking has
different stable and code style rule. That is how it is and I dont think
we would have one rule for all kernel.

All I ask is to be able to review and split up accordingly, I guess that
is a fair request

> The fact that the series was tagged as Reviewed by Takashi
> on April 11 and we are still discussing trivial changes tells me the
> integration model is broken. 

Is it? you got feedback on 15th (that too after my 2 week conf/vacation
break) and I got called crazy for that, not helping!!


> It's not just me the patches related to
> runtime-pm from your own Linaro colleagues posted on March 28 went nowhere
> either.

Does it matter it was a Linaro colleague or not, a patch was posted,
feedback given (similar to cadence one) we agreed that the fix
is not correct and so patch was not applied. I don't think Srini cried
over it!

> Moving forward, I suggest we merge SoundWire-related patches through the
> sound tree. There will be dependencies in the coming weeks between SOF and
> SoundWire and it makes no sense to have separate maintainers and make the
> life of early adopters more complicated than it needs to be. If we have
> 3-week delays for trivial stuff, I can't imagine what the pace will be when
> I publish the next 20-odd patches I am still working on, and the code needed
> for the SoundWire audio device class being standardized as we speak. Things
> were fine up to now since no one was actually using the code, we are in a
> different model now.

I disagree and wont accept it. I dont think you understand that you are
not the most important person in the whole world, the 20 patches series
you are cooking would sure be greatest ever, but that is not the point.
The kernel has a process, you got a feedback, please fix that and post
v2 rather than cribbing, complaining and calling crazy. The energy would
have been better spent on fixing the feedback provided.

Dependencies are _always_ there in kernel development and we know how to
deal with it. Am sure Takashi, Mark and me can come to reasonable
agreement, I wouldn't worry about that!

What we dont do is create new model for your 20 patches.

And I guess I dont have anything more to say on this thread, so I wont
bother replying, please feel free to post v2 and I shall review.

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
