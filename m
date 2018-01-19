From: "Mahendran Kuppusamy (RBEI/ECF3)" <Mahendran.Kuppusamy@in.bosch.com>
Subject: Re: [PATCH 4/6] alsa-lib:pcm: fix the hw_ptr update
 until the boundary available.
Date: Fri, 19 Jan 2018 05:56:52 +0000
Message-ID: <f7eff12c88f249dfa82a77840e9d2fe5@SGPMBX1008.APAC.bosch.com>
References: <1483079367-28931-1-git-send-email-sutar.mounesh@gmail.com>
 <s5hk2adtvg6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-v.fe.bosch.de (smtp6-v.fe.bosch.de [139.15.237.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EC223266E71
 for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2018 06:56:56 +0100 (CET)
In-Reply-To: <s5hk2adtvg6.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "sutar.mounesh@gmail.com" <sutar.mounesh@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mounesh_sutar@mentor.com" <mounesh_sutar@mentor.com>
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwan, Hello Sutar,

Sorry for the late response. 

Yes, Fractional calculation is required for the overwrapping case only. So, Please do optimization and go ahead of "doing this conditionally only for the overwrapping case".

Please let me know, Any changes required for me.

Thanks in advance.

Best regards,

Mahendran Kuppusamy
RBEI/ECF3  

Tel. +91 80 6136-4450 


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Monday, January 02, 2017 7:29 PM
To: sutar.mounesh@gmail.com
Cc: alsa-devel@alsa-project.org; mounesh_sutar@mentor.com; Mahendran Kuppusamy (RBEI/ECF32) <Mahendran.Kuppusamy@in.bosch.com>
Subject: Re: [PATCH 4/6] alsa-lib:pcm: fix the hw_ptr update until the boundary available.

On Fri, 30 Dec 2016 07:29:27 +0100,
sutar.mounesh@gmail.com wrote:
> 
> From: mahendran.k <mahendran.kuppusamy@in.bosch.com>
> 
> For long time test case, the slave_hw_ptr will exceed the boundary and 
> wraparound the slave_hw_ptr. This slave boundary wraparound will cause 
> the rate->hw_ptr to wraparound irrespective of the rate->boundary 
> availability and due to that the available size goes wrong.
> 
> Hence, To get the correct available size,
> - Its necessary to increment the rate->hw_ptr upto the rate->boundary 
> and then wraparound the rate->hw_ptr.
> - While handling fraction part of slave period, rounded value will be 
> introduced by input_frames(). To eliminate rounding issue on 
> rate->hw_ptr, subtract last rounded value from rate->hw_ptr and add 
> new rounded value of present slave_hw_ptr fraction part to rate->hw_ptr.
> 
> Signed-off-by: mahendran.k <mahendran.kuppusamy@in.bosch.com>
> Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>

Thanks, it's been a long-standing issue, indeed.

I applied this one (again) with a slight coding style fix now.
But...

> diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c index 
> 1f830dd..5bee77c 100644
> --- a/src/pcm/pcm_rate.c
> +++ b/src/pcm/pcm_rate.c
> @@ -50,7 +50,7 @@ typedef struct _snd_pcm_rate snd_pcm_rate_t;
>  
>  struct _snd_pcm_rate {
>  	snd_pcm_generic_t gen;
> -	snd_pcm_uframes_t appl_ptr, hw_ptr;
> +	snd_pcm_uframes_t appl_ptr, hw_ptr, last_slave_hw_ptr;
>  	snd_pcm_uframes_t last_commit_ptr;
>  	snd_pcm_uframes_t orig_avail_min;
>  	snd_pcm_sw_params_t sw_params;
> @@ -563,14 +563,28 @@ static inline void 
> snd_pcm_rate_sync_hwptr0(snd_pcm_t *pcm, snd_pcm_uframes_t sl  {
>  	snd_pcm_rate_t *rate = pcm->private_data;
>  
> +	snd_pcm_sframes_t slave_hw_ptr_diff = slave_hw_ptr - rate->last_slave_hw_ptr;
> +	snd_pcm_sframes_t last_slave_hw_ptr_frac;
> +
>  	if (pcm->stream != SND_PCM_STREAM_PLAYBACK)
>  		return;
> -	/* FIXME: boundary overlap of slave hw_ptr isn't evaluated here!
> -	 *        e.g. if slave rate is small... 
> -	 */
> -	rate->hw_ptr =
> -		(slave_hw_ptr / rate->gen.slave->period_size) * pcm->period_size +
> -		rate->ops.input_frames(rate->obj, slave_hw_ptr % rate->gen.slave->period_size);
> +
> +	if (slave_hw_ptr_diff < 0)
> +		slave_hw_ptr_diff += rate->gen.slave->boundary; /* slave boundary wraparound */
> +	else if (slave_hw_ptr_diff == 0)
> +		return;
> +	last_slave_hw_ptr_frac = rate->last_slave_hw_ptr % rate->gen.slave->period_size;
> +	/* While handling fraction part fo slave period, rounded value will be introduced by input_frames().
> +	 * To eliminate rounding issue on rate->hw_ptr, subtract last rounded value from rate->hw_ptr and
> +	 * add new rounded value of present slave_hw_ptr fraction part to rate->hw_ptr. Hence,
> +	 * rate->hw_ptr += [ (no. of updated slave periods * pcm rate period size) -
> +	 * 				fractional part of last_slave_hw_ptr rounded value +
> +	 * 				fractional part of updated slave hw ptr's rounded value ] */
> +	rate->hw_ptr += (
> +			(((last_slave_hw_ptr_frac + slave_hw_ptr_diff) / rate->gen.slave->period_size) * pcm->period_size) -
> +			rate->ops.input_frames(rate->obj, last_slave_hw_ptr_frac) +
> +			rate->ops.input_frames(rate->obj, (last_slave_hw_ptr_frac + slave_hw_ptr_diff) % rate->gen.slave->period_size));
> +	rate->last_slave_hw_ptr = slave_hw_ptr;

.... this ended up with a substantial increase of computation.
Can we optimize, e.g. doing this conditionally only for the overwrapping case?


thanks,

Takashi
