From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 1/2] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN
	trigger
Date: Tue, 30 Dec 2014 08:42:28 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195C40F2@SHSMSX103.ccr.corp.intel.com>
References: <1418888164-41117-1-git-send-email-libin.yang@intel.com>
 <s5htx0tjr7y.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195C25F9@SHSMSX103.ccr.corp.intel.com>
 <s5hfvccja9t.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195C2CEF@SHSMSX103.ccr.corp.intel.com>
 <s5hwq5ghwe6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 83EF32605EB
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 09:43:03 +0100 (CET)
In-Reply-To: <s5hwq5ghwe6.wl-tiwai@suse.de>
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

Regards,
Libin


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, December 25, 2014 6:11 PM
> To: Yang, Libin
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org;
> liam.r.girdwood@linux.intel.com; Jie, Yang
> Subject: Re: [PATCH 1/2] [ALSA] add SNDRV_PCM_TRIGGER_DRAIN trigger
> 
> At Mon, 22 Dec 2014 07:42:38 +0000,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > > > Besides, this patch will break many drivers.  Many of them will
> > > > > spew errors if an unexpected trigger command is issued.  So, you
> > > > > have to limit this trigger only to some drivers.  A typical
> > > > > workaround is to add a new
> > > > > SNDRV_PCM_INFO_* and issue the trigger only when the flag is
> > > > > set, as done for resume and pause operations.
> > > >
> > > > Yes, that's a good suggestion. Thanks for reminding me.
> > >
> > > OTOH, the info flag will be exposed to user-space while this is a
> > > kernel-space- only information.  So, in the code copying the info
> > > flag
> > > (snd_pcm_hw_refine()) would need to drop this bit, too.
> >
> > Thanks, I will drop this bit in snd_pcm_hw_refine().
> >
> > >
> > > Alternatively, we may add just a new flag in struct snd_pcm or
> > > struct snd_pcm_substream and let the driver setting it manually.
> > > This might need more changes in ASoC side, though, as the PCM
> > > creation isn't directly done by the driver.
> >
> > Yes, it is a little complex for asoc if using this method.
> > Not sure if it is OK we set the flag in snd_soc_ops->startup() each
> > time when the function is called.
> >
> > What do you think we just use the first method?
> >
> > >
> > >
> > > > > Also, do you want to see this trigger even if the stream isn't
> > > > > started before drain is issued?  Also, why no need for this
> > > > > trigger for
> > > capture streams?
> > > >
> > > > In this case, the trigger action will be started. For the stream
> > > > not started case, if I skip the trigger , I don't know where I can
> > > > have the chance to trigger later. And I didn't find the suitable
> > > > place to trigger my
> > > code.
> > > > Put the trigger at the end of the function snd_pcm_do_drain_init()
> > > > or in the function snd_pcm_post_drain_init() will be OK?
> > > >
> > > > I didn't include the capture case because we found the capture
> > > > currently don't need the trigger.
> > > >
> > > > Our issue is the fw don't know when to stop fetching the data. For
> > > > playback we need fill silence data when draining, otherwise the fw
> > > > will get
> > > the old data.
> > > > But for capture, after the driver has fetched the data, it will
> > > > stopped and no old data will be fetched.
> > >
> > > A similar problem here.  If you extend the API, don't build up only
> > > from the bottom.  Rather define from a higher POV.
> > >
> > > If calling the drain trigger for capture stream doesn't make *any*
> > > sense for all hardware, then we shouldn't add it.  This would be the
> > > only reason not to do it.  What about empty streams...?
> > >
> > > That being said, we need to define the proper abstraction, what this
> > > trigger does for which purpose, not specific to a certain hardware.
> > > That is, the requirement goes up from your hardware level while the
> > > design comes down from the abstraction level.
> >
> > Right. I will include the capture.
> >
> > My patch will be like:
> >
> > @@ -1566,6 +1567,11 @@ static int snd_pcm_do_drain_init(struct
> snd_pcm_substream *substream, int state)
> >  			snd_pcm_post_stop(substream, new_state);
> >  		}
> >  	}
> > +
> > +	if (substream->runtime->trigger_master == substream &&
> > +		(substream->runtime->hw.info &
> SNDRV_PCM_INFO_DRAIN_TRIGGER))
> > +		return substream->ops->trigger(substream,
> > +				SNDRV_PCM_TRIGGER_DRAIN);
> > +
> >  	return 0;
> >  }
> >
> > I moved the trigger at the end of the function. Or do you think we
> > need trigger before snd_pcm_do_stop() for capture case based on your
> knowledge?
> 
> The place would be OK, but you can't call it unconditionally there.
> In some cases (e.g. XRUN), the trigger won't be called at all.
> The trigger state change is a bit tricky, so be careful to track the state change
> there.
> 

Right. What do you think the following code?

@@ -1518,6 +1519,8 @@ static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream, int state
 static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	int trigger = 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (runtime->status->state) {
 		case SNDRV_PCM_STATE_PREPARED:
@@ -1525,10 +1528,12 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 			if (! snd_pcm_playback_empty(substream)) {
 				snd_pcm_do_start(substream, SNDRV_PCM_STATE_DRAINING);
 				snd_pcm_post_start(substream, SNDRV_PCM_STATE_DRAINING);
+				trigger = 1;
 			}
 			break;
 		case SNDRV_PCM_STATE_RUNNING:
 			runtime->status->state = SNDRV_PCM_STATE_DRAINING;
+			trigger = 1;
 			break;
 		case SNDRV_PCM_STATE_XRUN:
 			runtime->status->state = SNDRV_PCM_STATE_SETUP;
@@ -1545,6 +1550,12 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 			snd_pcm_post_stop(substream, new_state);
 		}
 	}
+
+	if (substream->runtime->trigger_master == substream && trigger &&
+		(substream->runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER))
+		return substream->ops->trigger(substream,
+				SNDRV_PCM_TRIGGER_DRAIN);
+
 	return 0;
 }

> >
> > And in the snd_pcm_hw_refine():
> >
> > @@ -420,7 +420,8 @@ int snd_pcm_hw_refine(struct
> snd_pcm_substream
> > *substream,
> >
> >  	hw = &substream->runtime->hw;
> >  	if (!params->info) {
> > -		params->info = hw->info &
> ~SNDRV_PCM_INFO_FIFO_IN_FRAMES;
> > +		params->info = hw->info &
> ~SNDRV_PCM_INFO_FIFO_IN_FRAMES
> > +			& ~SNDRV_PCM_INFO_DRAIN_TRIGGER;
> >  		if (!hw_support_mmap(substream))
> >  			params->info &= ~(SNDRV_PCM_INFO_MMAP |
> >  					  SNDRV_PCM_INFO_MMAP_VALID);
> >
> > Do you think whether it is OK?
> 
> Yes.
> 
> 
> thanks,
> 
> Takashi
