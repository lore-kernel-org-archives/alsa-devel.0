From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: XRUN handling
Date: Mon, 19 Jul 2010 16:43:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007191642050.9258@eeebox2.perex-int.cz>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
	<AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
	<alpine.LNX.2.00.1007062034050.15497@eeebox2.perex-int.cz>
	<AANLkTinwkbuyFBxGAABNKaY_CVxK4OedlPHnY2NOf8ck@mail.gmail.com>
	<AANLkTintdXC7pwQAi8qc8OyHRZw9jL2C7JphkIAwLXIf@mail.gmail.com>
	<alpine.LNX.2.00.1007191612120.9258@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 67FDE103832
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 16:43:52 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1007191612120.9258@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 19 Jul 2010, Jaroslav Kysela wrote:

> On Wed, 14 Jul 2010, melwyn lobo wrote:
>
>> Another query, if setting runtime parameters like:
>> runtime->silence_threshold = runtime->boundary;
>> runtime->silence_size = runtime->boundary;
>> runtime->stop_threshold = runtime->boundary;
>>
>> Also to avoid the bug in snd_pcm_playback_silence()  i.e.,
>> snd_BUG_ON(frames > runtime->buffer_size),
>> I have added a tweak in the driver IRQ handler:
>
> This patch might fix this problem:
>
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index bcf95d3..e23e0e7 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -67,6 +67,8 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
>  	} else {
>  		if (new_hw_ptr == ULONG_MAX) {	/* initialization */
>  			snd_pcm_sframes_t avail = snd_pcm_playback_hw_avail(runtime);
> +			if (avail > runtime->buffer_size)
> +				avail = runtime->buffer_size;
>  			runtime->silence_filled = avail > 0 ? avail : 0;
>  			runtime->silence_start = (runtime->status->hw_ptr +
>  						  runtime->silence_filled) %
>
> But it looks that you do something wrong with hw_ptr or appl_ptr in your
> driver, because this condition would be true only when an large underrun
> occurs immediatelly.

Not underrun but overfill (but this should not occur - the PCM core 
functions check for this). Could you print appl_ptr, hw_ptr and 
buffer_size before you call snd_pcm_elapsed()?

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
