From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH]PM_QOS-to-use-handle-based-requests-pcm-update 5/5
Date: Wed, 2 Dec 2009 13:50:08 -0800
Message-ID: <20091202215008.GA6340@linux.intel.com>
References: <20091201213840.GE19688@linux.intel.com>
 <s5hiqcpy5b4.wl%tiwai@suse.de>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755759AbZLBVuI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hiqcpy5b4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, perex@perex.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 02, 2009 at 12:38:07PM +0100, Takashi Iwai wrote:
> At Tue, 1 Dec 2009 13:38:40 -0800,
> mark gross wrote:
> > 
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> (snip)
> > @@ -506,8 +508,8 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
> >  	if (substream->ops->hw_free)
> >  		result = substream->ops->hw_free(substream);
> >  	runtime->status->state = SNDRV_PCM_STATE_OPEN;
> > -	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
> > -		substream->latency_id);
> > +	pm_qos_remove_request(substream->latency_pm_qos_req);
> 
> The NULL check seems needed in the caller side because
> pm_qos_remove_request() doesn't do it.

ouch.  Thanks for noticing this.

> 
> Or, would you add a NULL check in pm_qos_remove_request()?
> It'd be more handy.

I can make the pm_qos_remove_request null pointer safe, its assumed to
be a slow path so it would be a good thing to do.


I'll add this to the next patch set that the e1000e guys are making me
do against linux-next.

Thanks!

--mgross

> 
> 
> thanks,
> 
> Takashi
