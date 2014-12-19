From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN
	trigger
Date: Fri, 19 Dec 2014 06:29:33 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195C25F9@SHSMSX103.ccr.corp.intel.com>
References: <1418888164-41117-1-git-send-email-libin.yang@intel.com>
 <s5htx0tjr7y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B0F82605E9
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 07:29:56 +0100 (CET)
In-Reply-To: <s5htx0tjr7y.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for review, please see my comments.


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, December 18, 2014 4:30 PM
> To: Yang, Libin
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org;
> liam.r.girdwood@linux.intel.com; Jie, Yang
> Subject: Re: [PATCH 1/2] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN trigger
> 
> At Thu, 18 Dec 2014 15:36:03 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > Add SNDRV_PCM_TRIGGER_DRAIN trigger for pcm drain.
> >
> > Some audio devices require notification of drain events in order to
> > properly drain and shutdown an audio stream.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > ---
> >  include/sound/pcm.h     | 1 +
> >  sound/core/pcm_native.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h index
> > 8bb00a2..bb77aa3 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -109,6 +109,7 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_TRIGGER_PAUSE_RELEASE	4
> >  #define SNDRV_PCM_TRIGGER_SUSPEND	5
> >  #define SNDRV_PCM_TRIGGER_RESUME	6
> > +#define SNDRV_PCM_TRIGGER_DRAIN		7
> >
> >  #define SNDRV_PCM_POS_XRUN		((snd_pcm_uframes_t)-1)
> >
> > diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c index
> > 166d59c..15fe682 100644
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> > @@ -1517,6 +1517,11 @@ static int snd_pcm_do_drain_init(struct
> > snd_pcm_substream *substream, int state)  {
> >  	struct snd_pcm_runtime *runtime = substream->runtime;
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > +
> > +		if (substream->runtime->trigger_master == substream)
> > +			substream->ops->trigger(substream,
> > +					SNDRV_PCM_TRIGGER_DRAIN);
> 
> The return value check is missing.

Actually, the code doesn't care the return value and I don't want to let the
trigger return value impact the snd_pcm_do_drain_init() flow just like
snd_pcm_do_stop(). 

> 
> Besides, this patch will break many drivers.  Many of them will spew errors if
> an unexpected trigger command is issued.  So, you have to limit this trigger
> only to some drivers.  A typical workaround is to add a new
> SNDRV_PCM_INFO_* and issue the trigger only when the flag is set, as done
> for resume and pause operations.

Yes, that's a good suggestion. Thanks for reminding me.

> 
> Also, do you want to see this trigger even if the stream isn't started before
> drain is issued?  Also, why no need for this trigger for capture streams?

In this case, the trigger action will be started. For the stream not started
case, if I skip the trigger , I don't know where I can have the chance to 
trigger later. And I didn't find the suitable place to trigger my code. 
Put the trigger at the end of the function snd_pcm_do_drain_init() or 
in the function snd_pcm_post_drain_init() will be OK? 

I didn't include the capture case because we found the capture currently 
don't need the trigger.

Our issue is the fw don't know when to stop fetching the data. For playback
we need fill silence data when draining, otherwise the fw will get the old data.
But for capture, after the driver has fetched the data, it will stopped and no
old data will be fetched.

> 
> 
> (BTW, while looking at this patch, I found a bug in the current  draining code.
> Will submit the fix...)
> 
> 
> Takashi


Regards,
Libin
