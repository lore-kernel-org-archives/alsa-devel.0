From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 00/18] ALSA: hdac: move hdac helpers to core
Date: Wed, 7 Oct 2015 10:52:18 +0000
Message-ID: <1444215136.25504.55.camel@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
 <s5hk2qzamsf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C0F265AFC
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:52:25 +0200 (CEST)
In-Reply-To: <s5hk2qzamsf.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <1BB3AE5EB202434BA993E057EF51C7AF@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-06 at 20:12 +0200, Takashi Iwai wrote:
> On Tue, 06 Oct 2015 17:07:37 +0200,
> Vinod Koul wrote:
> > 
> > Hi Takashi,
> > 
> > Here is the second version which updates the users.
> > 
> > This update was done using coccinelle scripts. I also noticed that the
> > coccinelle is reformaing the change lines, but changes looked good to me so
> > I have kept them, please do let me know if you would like these to be
> > removed.
> 
> Erm, sorry, I didn't want to motivate you in that direction.
> Basically it's better to keep the old API as is for an old driver like
> HDA since it makes stable kernel backporting much easier.  So, what
> we'd need is a lazier solution, just to replace the old API as a
> static inline function wrapping the new API.  The end result is same,
> but it's still compatible with older kernels in the source code
> level.

Ah ...

Even while doing this I was thinking that we have few wrappers and should update
users..

So are you going to hold off update or do it after some point of time

I will send updated one, though I think at some point of time we need to bite this
bullet

-- 
~Vinod
