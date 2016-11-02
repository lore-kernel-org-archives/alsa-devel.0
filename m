From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Accurate delay reporting from dshare
Date: Wed, 2 Nov 2016 14:17:10 +0000
Message-ID: <5819F566.2000404@IEE.org>
References: <5810BDF9.1020204@IEE.org> <s5hinseoygk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1384A26583C
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 15:17:12 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id u144so3298075wmu.0
 for <alsa-devel@alsa-project.org>; Wed, 02 Nov 2016 07:17:12 -0700 (PDT)
In-Reply-To: <s5hinseoygk.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/10/16 11:52, Takashi Iwai wrote:
> On Wed, 26 Oct 2016 16:30:17 +0200,
> Alan Young wrote:
>> Hi,
>>
>> When the kernel reports current (playback) delay via a call to
>> snd_pcm_status() or snd_pcm_delay() for a normal hardware PCM, then
>> the delay value reported is the sum of space used in the ring buffer
>> plus any delay reported from the underlying runtime driver.
>>
>> snd_pcm_dshare_status() and snd_pcm_dshare_delay() discard this
>> refinement and simply report the use of some ring buffer. Why does it
>> do this and how could the reporting be improved?
> The lack of delay calculation is just for simplicity.  We're tracking
> the different hw_avail per each d-* PCM, the delay value has to be
> re-calculated for each as in the current way. But we may put the
> additional delay computed from the slave PCM, indeed.

Why does it have to be re-calculated? Under what circumstances would 
"snd_pcm_mmap_playback_delay(pcm)" and "slave_status.avail -  
dshare->spcm->buffer_size" (from your patched source) yield different 
results?
> Basically d*-plugins share the same ring buffer as the underlying
> slave PCM hw layer.  The d-plugins have the buffers in shared memory
> in addition for keeping the 32bit data for clipping.
This is only the case for dmix, right?
> But in general
> the ring buffer size and the position are same as the hw.

> Well, basically the additional delay can be deduced from
>    delay - buffer_size - avail
> (This is applied for playback.  For capture, it's slightly different.)
>
> A patch like below *might* work (totally untested!)
>

Thanks, this does seem to help but is not totally reliable.

I am wondering if the earlier call to snd_pcm_dshare_sync_ptr(pcm), 
which I guess forms the basis for the result of 
snd_pcm_mmap_playback_delay(pcm), may be operating on a different set of 
data (because of an intervening interrupt) to that returned by 
snd_pcm_status().

Thanks,
Alan.

> thanks,
>
> Takashi
>
> ---
> diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
> index c5b3178a4990..8e21a6ec5fc2 100644
> --- a/src/pcm/pcm_dshare.c
> +++ b/src/pcm/pcm_dshare.c
> @@ -214,6 +214,7 @@ static int snd_pcm_dshare_sync_ptr(snd_pcm_t *pcm)
>   static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
>   {
>   	snd_pcm_direct_t *dshare = pcm->private_data;
> +	snd_pcm_status_t slave_status;
>   
>   	switch (dshare->state) {
>   	case SNDRV_PCM_STATE_DRAINING:
> @@ -225,12 +226,15 @@ static int snd_pcm_dshare_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
>   	}
>   	memset(status, 0, sizeof(*status));
>   	snd_pcm_status(dshare->spcm, status);
> +	slave_status = *status;
>   	status->state = snd_pcm_state(dshare->spcm);
>   	status->trigger_tstamp = dshare->trigger_tstamp;
>   	status->avail = snd_pcm_mmap_playback_avail(pcm);
>   	status->avail_max = status->avail > dshare->avail_max ? status->avail : dshare->avail_max;
>   	dshare->avail_max = 0;
>   	status->delay = snd_pcm_mmap_playback_delay(pcm);
> +	status->delay += slave_status.delay + slave_status.avail -
> +		dshare->spcm->buffer_size;
>   	return 0;
>   }
>   
