From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [GIT PULL] ASoC updates for v4.15
Date: Wed, 15 Nov 2017 10:03:05 +0530
Message-ID: <20171115043305.GT3187@localhost>
References: <20171113115242.pmc7asf4yumj5ubk@sirena.co.uk>
 <s5h4lpyb2e2.wl-tiwai@suse.de>
 <20171113163014.qtdfgpqiign5xahk@sirena.co.uk>
 <s5hshdi9lvr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2D426751C
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 05:29:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hshdi9lvr.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 13, 2017 at 05:36:08PM +0100, Takashi Iwai wrote:
> On Mon, 13 Nov 2017 17:30:14 +0100,
> Mark Brown wrote:
> > 
> > On Mon, Nov 13, 2017 at 04:54:13PM +0100, Takashi Iwai wrote:
> > 
> > > BTW, one thing Linus requested in the last KS is to avoid merging to a
> > > stub branch when you're managing topic branches.  If any, just smash
> > > the rest branches into one of your branches, instead of merging into
> > > the upstream point.  Just a reminder for the next time.
> > 
> > I saw the LWN writeup after Vinod mentioned it but what he seemed to be
> > talking about was the practice of doing incremental merges to master
> > each time a topic branch is updated and instead requesting that
> > everything just get merged down at the end which is what I do.  Unless
> > he says something directly I'm going to assume my understanding is
> > correct, it's how I send all the stuff I send directly to him so if it
> > was bothering him I guess he'd have said something.  I can't see that
> > picking a random topic branch is going to be especially helpful either,
> > it'd end up being one of the fixes branches as they go first which'd
> > quite likely already be in his tree anyway and end up looking like an
> > empty branch based off a non-tag which'd probably upset him more.  It's
> > also the mechanism I'm using to merge fixes from him so there is stuff
> > on there relative to the other branches.
> > 
> > If it's an actual problem I'm sure he'll say something.
> 
> Yeah, that's why I also took your pull request as is at this time.
> Let's see :)

I have the same work flow where I merge the topic branches into for-linus
and tag it and send. I did ask him to check and let me know if he wants any
changes. Since he has merged both my tree and sound today, I am assuming our
workflow is good for now :)

> My understanding is that it's git-request-pull containing the marginal
> stuff that annoys him.  He usually compares the diffstat between the
> pull-request and the actual merge result, and it doesn't work when the
> pull-request already contains the old commits in itself.

And he seemed not to like missing help text for SND_SOC_INTEL_SST_TOPLEVEL,
will send a patch

-- 
~Vinod
