From: "Bandarupalli, Sailaja" <sailaja.bandarupalli@intel.com>
Subject: Re: [PATCH 3/5] [RFC]intel_hdmi_audio: driver module
	-	ALSA intereaction
Date: Thu, 25 Nov 2010 11:10:53 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039EEC@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-3-git-send-email-ramesh.babu@intel.com>
	<s5h7hg3nkti.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B35A103B88
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 06:41:24 +0100 (CET)
In-Reply-To: <s5h7hg3nkti.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Babu,
	Ramesh" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

> > +/*standard module options for ALSA. This module supports only one
> card*/
> > +int hdmi_card_index = SNDRV_DEFAULT_IDX1;
> > +char *hdmi_card_id = SNDRV_DEFAULT_STR1;
> > +
> > +module_param(hdmi_card_index, int, 0444);
> > +MODULE_PARM_DESC(hdmi_card_index,
> > +		"Index value for INTEL Intel HDMI Audio controller.");
> > +module_param(hdmi_card_id, charp, 0444);
> > +MODULE_PARM_DESC(hdmi_card_id,
> > +		"ID string for INTEL Intel HDMI Audio controller.");
> 
> Drivers should expose the standard module options "index" and "id"
> like others.  Also they should be static.
> 
Agree.
> > +
> > +/* hardware capability structure */
> > +static const struct snd_pcm_hardware snd_intel_hadstream = {
> > +	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
> > +		SNDRV_PCM_INFO_DOUBLE |
> > +		SNDRV_PCM_INFO_PAUSE |
> > +		SNDRV_PCM_INFO_RESUME |
> 
> You have to implement corresponding stuff if you mark the driver as
> RESUME-able.

Yes we have implemented SNDRV_PCM_TRIGGER_PAUSE_RELEASE

> 
> > +		SNDRV_PCM_INFO_MMAP|
> > +		SNDRV_PCM_INFO_MMAP_VALID |
> > +		SNDRV_PCM_INFO_BATCH |
> > +		SNDRV_PCM_INFO_SYNC_START),
> 
> Is sync stuff implemented?

It's not implemented, we will remove it.

> 
> 
> > +	pr_debug("had: snd_intelhad_open called\n");
> > +
> > +	intelhaddata = snd_pcm_substream_chip(substream);
> 
> So... you assign the global variable at this open callback?
> Any race?
>
It's not required, since its global variable. We will remove this.

> > +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> > +	if (!stream)
> > +		return -ENOMEM;
> > +	stream->stream_status = STREAM_INIT;
> > +	runtime->private_data = stream;
> > +	intelhaddata->reg_ops->hdmi_audio_write_register(AUD_HDMI_STATUS,
> 0);
> > +	retval = snd_pcm_hw_constraint_integer(runtime,
> > +			 SNDRV_PCM_HW_PARAM_PERIODS);
> 
> stream is leaked when the error returned here.
> 

We will free the stream in error path.

> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +		pr_debug("had: Trigger Start\n");
> > +		caps = HDMI_AUDIO_UNDERRUN | HDMI_AUDIO_BUFFER_DONE;
> > +		retval = query_ops->hdmi_audio_set_caps(
> > +					HAD_SET_ENABLE_AUDIO_INT, &caps);
> > +		if (retval)
> > +			return retval;
> > +		retval = query_ops->hdmi_audio_set_caps(
> > +					HAD_SET_ENABLE_AUDIO, NULL);
> > +		if (retval)
> > +			return retval;
> 
> Don't you need to reset audio_caps at error?

ENABLE_AUDIO_INT and ENABLE_AUDIO just sets register bits and no 
impact even if it fails.

> > +	intelhaddata->playback_cnt++;
> > +	intelhaddata->stream_info.str_id = intelhaddata->playback_cnt;
> 
> Note that the prepare callback might be called multiple times before
> triggering.  This counter doesn't work.  If any, it should be counted
> in the open/close callback.

We will move the counters to _open.

> > +
> > +/*PCM operations structure and the calls back for the same */
> > +struct snd_pcm_ops snd_intelhad_playback_ops = {
> 
> Does it need to be global?

We will make it static.

> 
> Any reason to allocate extra two *_ops instead of just put these flat
> in the structure itself?  I mean,
>     struct intelhda {
>         ...
>         struct hdmi_audio_registers_ops reg_ops;
>         struct hdmi_audio_query_set_ops query_ops;
>         ...
>     }
> 
> then you don't need to malloc them.

We will declare them as flat structures.

> 
> Overall I feel uneasy about the handling of global variables.
> They should be cleaned up more...

We will clean up the global variables.

Thanks,
Sailaja and Ramesh.
