From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ALSA: Fireface: Use common error handling code in
 pcm_open()
Date: Wed, 23 Aug 2017 22:50:54 +0900
Message-ID: <d80e0859-eded-b93b-7bc7-dc60fdc606c9@sakamocchi.jp>
References: <05f76303-7370-ea37-20c2-116c04b850db@users.sourceforge.net>
 <bd318065-7a0b-efd5-8ce0-0dffe37b92cf@sakamocchi.jp>
 <05c137e8-e417-162b-c588-f5fc22be5ed6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05c137e8-e417-162b-c588-f5fc22be5ed6@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Aug 23 2017 21:54, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 23 Aug 2017 14:45:20 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2:
> It seems that a source code adjustment was requested by Takashi Sakamoto
> for another if branch.
> 
>   sound/firewire/fireface/ff-pcm.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
> index d12a0e3a4219..e3c16308363d 100644
> --- a/sound/firewire/fireface/ff-pcm.c
> +++ b/sound/firewire/fireface/ff-pcm.c
> @@ -138,16 +138,12 @@ static int pcm_open(struct snd_pcm_substream *substream)
>   		return err;
>   
>   	err = pcm_init_hw_params(ff, substream);
> -	if (err < 0) {
> -		snd_ff_stream_lock_release(ff);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto release_lock;
>   
>   	err = ff->spec->protocol->get_clock(ff, &rate, &src);
> -	if (err < 0) {
> -		snd_ff_stream_lock_release(ff);
> -		return err;
> -	}
> +	if (err < 0)
> +		goto release_lock;
>   
>   	if (src != SND_FF_CLOCK_SRC_INTERNAL) {
>   		for (i = 0; i < CIP_SFC_COUNT; ++i) {
> @@ -159,8 +155,8 @@ static int pcm_open(struct snd_pcm_substream *substream)
>   		 * streaming engine can't support.
>   		 */
>   		if (i >= CIP_SFC_COUNT) {
> -			snd_ff_stream_lock_release(ff);
> -			return -EIO;
> +			err = -EIO;
> +			goto release_lock;
>   		}
>   
>   		substream->runtime->hw.rate_min = rate;
> @@ -177,6 +173,10 @@ static int pcm_open(struct snd_pcm_substream *substream)
>   	snd_pcm_set_sync(substream);
>   
>   	return 0;
> +
> +release_lock:
> +	snd_ff_stream_lock_release(ff);
> +	return err;
>   }
>   
>   static int pcm_close(struct snd_pcm_substream *substream)


Thanks

Takashi Sakamoto
