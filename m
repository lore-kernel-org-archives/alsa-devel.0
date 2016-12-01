From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt5670: Enable Braswell platform
 workaround for Dell Wyse 3040
Date: Thu, 1 Dec 2016 09:00:58 +0530
Message-ID: <20161201033058.GI6408@localhost>
References: <20161130161920.10817-1-tiwai@suse.de>
 <20161130163615.GG6408@localhost> <s5h60n52an2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 471A7266685
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 04:21:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h60n52an2.wl-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 30, 2016 at 05:30:25PM +0100, Takashi Iwai wrote:
> On Wed, 30 Nov 2016 17:36:15 +0100,
> Vinod Koul wrote:
> > 
> > On Wed, Nov 30, 2016 at 05:19:20PM +0100, Takashi Iwai wrote:
> > > Dell Wyse 3040 requires the platform workaround for enabling dmic and
> > > jack detection as defined for Braswell CRB.
> > > 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > 
> > > ---
> > > 
> > > I guess the platform data should be applied generically to all CHT
> > > machines instead of DMI matching?  DMI matching doesn't scale,
> > > obviously.
> > 
> > we ahve been doing this on other RT codecs like RT286/298 as well for combo
> > jack to work. Yeah a better solution would be welcomed :)
> 
> Well, the question is how generic the given platform-specific setup
> is.  I guess we can keep the dmi thingy for a while, although we'll
> need more generic solution (or a pattern matching for a wider range of
> machines). 

Mostly if people stuck to Intel ref designs, then it would same, which has
been a problem on embedded side, but who knows.. :(

> So, if you think the addition of DMI entries is OK, give
> your ack :)

Absolutely atm :)

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
