From: Vinod <vkoul@kernel.org>
Subject: Re: GFP_ATOMIC in Intel code
Date: Wed, 24 Oct 2018 09:08:08 +0100
Message-ID: <20181024080808.GI25374@vkoul-mobl>
References: <137cd457-9587-c257-d021-53fc48945a46@linux.intel.com>
 <20181023084927.GC25374@vkoul-mobl> <s5hwoq7q15m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 589E526759E
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 10:08:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwoq7q15m.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 24-10-18, 09:00, Takashi Iwai wrote:
> On Tue, 23 Oct 2018 10:49:27 +0200,
> Vinod wrote:
> > 
> > On 22-10-18, 12:22, Pierre-Louis Bossart wrote:
> > > Looking at the latest for-next branch, by accident I saw a number of
> > > GFP_ATOMIC references.
> > > 
> > > With my extended break I don't remember much but didn't we agree that none
> > > of those were needed? If yes I'll send a patch to fix all this.
> > 
> > 
> > I thought that someone had fixed up all these instances,
> 
> Looking back at the git history, "someone" was mostly you :)

Yeah that is right :)

Jia-Ju Bai initially reported this and fixed few I did rest at that time

> A few of them below seem to be new codes that copied the bad past
> examples, some are overlooked one, and some are mailbox codes that
> aren't 100% sure to safe to replace (although I guess it is).
> 
> > looks like few
> > missed, so yes please do fix them up and Welcome back :-)

Am not sure why were they missed but yes lets fix them and keep an eye
to not get copy-pasted back in from downstream code (which i suspect is
using these and people basing these off...)

-- 
~Vinod
