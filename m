From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA-Lib: Playback overrun on initial PCM start
Date: Fri, 29 Jun 2007 11:24:09 -0400
Message-ID: <20070629112409.27e67cea.alsauser@pragmasoft.com>
References: <20070628150108.271f4493.alsauser@pragmasoft.com>
	<s5hmyyjcdtv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7.server.rpi.edu (smtp7.server.rpi.edu [128.113.2.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 07DA72454E
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 17:21:04 +0200 (CEST)
In-Reply-To: <s5hmyyjcdtv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Jun 2007 11:25:16 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 28 Jun 2007 15:01:08 -0400,
> J. Scott Merritt wrote:
> > 
> > Dear List,
> > 
> > Using SALSA-Lib 0.0.3, I call:	
> > 
> > snd_pcm_open (&playback_handle, argv[1], SND_PCM_STREAM_PLAYBACK, 0);
> > snd_pcm_hw_params_malloc (&hw_params);
> > snd_pcm_hw_params_any (playback_handle, hw_params);
> > snd_pcm_hw_params_set_access (playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
> > snd_pcm_hw_params_set_format (playback_handle, hw_params, SND_PCM_FORMAT_S16_LE));
> > snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100, 0);
> > snd_pcm_hw_params_set_channels (playback_handle, hw_params, 2);
> > snd_pcm_hw_params_set_buffer_size_last (playback_handle, hw_params, &bfrsize);
> > snd_pcm_hw_params_get_buffer_size (hw_params, &bfrsize);
> > snd_pcm_hw_params (playback_handle, hw_params);
> > snd_pcm_hw_params_free (hw_params);
> > 	
> > snd_pcm_sw_params_malloc (&sw_params);
> > snd_pcm_sw_params_current (playback_handle, sw_params);
> > snd_pcm_sw_params_set_avail_min (playback_handle, sw_params, 4096);
> > snd_pcm_sw_params_set_start_threshold (playback_handle, sw_params, 10000U);
> > snd_pcm_sw_params_set_xfer_align (playback_handle, sw_params, 1);
> > snd_pcm_sw_params (playback_handle, sw_params);
> > 	
> > state = snd_pcm_state (playback_handle);
> > frames_to_deliver = snd_pcm_avail_update (playback_handle);
> > 
> > while ((frames_to_deliver = snd_pcm_avail_update (playback_handle)) > 4096) {
> >    snd_pcm_writei (playback_handle, &buf, 4096) }
> > 
> > 
> > As soon as the buffer start threshold is reached, or alternatively
> > if I manually start PCM stream, the PCM stream reports an overrun
> > (i.e. "Broken Pipe").  If I then examine the PCM state, it is in the
> > overrun (XRUN) state.
> 
> What are the buffer and period sizes?  Did you try alsa-lib with hw,
> too, right?

In sample program above, buffer size is set to "last", which results
in a buffer size of 32768 (which matches the allocation in the kernel driver).
The sample programs above does not establish a period size and is unknown.

I added code to set the period size to 1024 frames and experienced the
same (overrun) result.   I also forced the buffer size to 8192 and lowered
the sample rate to 16 kHz and did not see any improvement.

Yes, the same exact code runs properly on the target hardware with
alsa-lib 1.0.13.
 
> > The code is being cross-compiled and tested on an ARM processor
> > (PXA270) which is running linux kernel 2.6.21.   This same code sequence
> > -does- operate properly (in the same ARM test environment) when compiled
> > against AlsaLib 1.0.13.
> 
> Well, it might not be a bug.  SALSA-lib is more straightforward
> communication to the driver, and skips many layers.  Thus it may
> behave differently.

Do you have any suggestions on how to debug an overrun problem that
occurs whenever PCM is started ?

Absent further suggestions or requests, I will simply switch back to
alsa-lib and give up on saving the extra 1/2 Mbyte of RAM.

Thanks, Scott.
