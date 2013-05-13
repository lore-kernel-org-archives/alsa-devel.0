From: Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH 11/11] sound/oxygen_io: take msecs_to_jiffies_min into
 use
Date: Mon, 13 May 2013 17:24:38 +0300
Message-ID: <1368455078.16445.135.camel@intelbox>
References: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
	 <1368188011-23661-11-git-send-email-imre.deak@intel.com>
	 <s5hr4hbq8sd.wl%tiwai@suse.de>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr4hbq8sd.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-05-13 at 16:00 +0200, Takashi Iwai wrote:
> At Fri, 10 May 2013 15:13:29 +0300,
> Imre Deak wrote:
> > 
> > Use msecs_to_jiffies_min instead of open-coding the same.
> > 
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > ---
> >  sound/pci/oxygen/oxygen_io.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
> > index 521eae4..132ecbe 100644
> > --- a/sound/pci/oxygen/oxygen_io.c
> > +++ b/sound/pci/oxygen/oxygen_io.c
> > @@ -108,7 +108,7 @@ static int oxygen_ac97_wait(struct oxygen *chip, unsigned int mask)
> >  	wait_event_timeout(chip->ac97_waitqueue,
> >  			   ({ status |= oxygen_read8(chip, OXYGEN_AC97_INTERRUPT_STATUS);
> >  			      status & mask; }),
> > -			   msecs_to_jiffies(1) + 1);
> > +			   msecs_to_jiffies_min(1));
> 
> This would change the behavior, I guess.  

Not to my understanding, the new macro should end up doing the same
thing.

> (Though, I'm not sure whether the original code was intentional.)

Well, I only assumed that.. But using wait_event_timeout() without the
+1 would make little sense to me. In that case we may not wait at all
for the condition to become true, if we are close to the next scheduling
clock tick.

> And, isn't msecs_to_jiffies_min(1) identical with msecs_to_jiffies(1)?

No, it should be one more in value.

--Imre
