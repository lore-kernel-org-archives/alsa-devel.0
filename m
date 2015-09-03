From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: [RFC PATCH (alsa-lib)] pcm: Modify check condition
 in snd_pcm_sw_params_set_avail_min
Date: Thu, 3 Sep 2015 15:45:46 +0800
Message-ID: <1441266346.32609.18.camel@mtksdaap41>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 07EA82605FB
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 09:45:53 +0200 (CEST)
In-Reply-To: <s5hfv2wvv35.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, lgirdwood@gmail.com, srv_heupstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-03 at 09:08 +0200, Takashi Iwai wrote:
> On Thu, 03 Sep 2015 05:20:54 +0200,
> Koro Chen wrote:
> > 
> > When we use a ping-ping buffer in capture, and if hw_ptr reported
> > at IRQ is a little smaller than period_size:
> > 
> > |xxxxxxxxxxxxxxxxxxxxxxxxxxxx--|-----------------------------|
> >                             hw_ptr < period_size
> 
> How this happens?  The period size is the size where irq (or wakeup)
> wakes up for read/write.  Why the driver wakes up even if there is no
> enough data?
> 
Yes it is odd to what we would normally expect. Due to our HW design,
when irq comes, audio HW actually has collected a full period of data,
but there is a buffer between the audio HW and memory, so at that moment
some samples are still in the buffer, not on the memory. Add a small
delay between triggering capture HW and enabling IRQ can also fix this,
although I think changing the avail_min should be better. 

> > This available buffer will not be read since its size is smaller than
> > avail_min (which is set to be period_size), and read thread continues
> > to sleep. If the next hw_ptr is just a little larger than buffer_size,
> > overrun occurs.
> > 
> > This could be resolved by setting a small avail_min to kernel,
> > for example, 1, so read thread wakes up and reads every data at IRQ.
> > But current alsa-lib only allows avail_min to be at least period_size.
> > Remove the constraint and only check for zero case.
> 
> The restriction was introduced for avoiding CPU hogs with rate plugin
> in many years ago.  avail_min=1 *might* work now because of the later
> fix for rate plugin, but this must be verified.
> 
Sounds a little dangerous...How should I verify this? It this problem
platform dependent?
> 
> thanks,
> 
> Takashi
> 
> > 
> > Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> > ---
> >  src/pcm/pcm.c |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> > index f5fc728..8492689 100644
> > --- a/src/pcm/pcm.c
> > +++ b/src/pcm/pcm.c
> > @@ -5958,12 +5958,8 @@ int snd_pcm_sw_params_set_avail_min(snd_pcm_t *pcm, snd_pcm_sw_params_t *params,
> >  #endif
> >  {
> >  	assert(pcm && params);
> > -	/* Fix avail_min if it's below period size.  The period_size
> > -	 * defines the minimal wake-up timing accuracy, so it doesn't
> > -	 * make sense to set below that.
> > -	 */
> > -	if (val < pcm->period_size)
> > -		val = pcm->period_size;
> > +	if (!val)
> > +		val = 1;
> >  	params->avail_min = val;
> >  	return 0;
> >  }
> > -- 
> > 1.7.9.5
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
