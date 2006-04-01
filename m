From: Adrian Bunk <bunk@stusta.de>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Date: Sat, 1 Apr 2006 11:21:36 +0200
Message-ID: <20060401092136.GD28310@stusta.de>
References: <20060326054542.GA11961@hermes.uziel.local> <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe> <20060329144303.GA24146@hermes.uziel.local> <20060331211240.GD22677@stusta.de> <1143841995.27146.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750755AbWDAJVi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1143841995.27146.25.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 31, 2006 at 04:53:13PM -0500, Lee Revell wrote:
> On Fri, 2006-03-31 at 23:12 +0200, Adrian Bunk wrote:
> > > Actually, the changes in Linus' current git have fixed the hang for
> > me.
> > > Good job - thanks a lot, guys!
> > > 
> > > Kind regards,
> > > Chris
> > 
> > Takashi, would it be possible getting the fixes for this hard lookup 
> > into 2.6.16.2?
> > 
> 
> Is a 225 line patch to fix a driver that's never worked appropriate for
> -stable?

If it was only "not working" it wasn't that bad, but "hard lockup" is 
really bad.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
