From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: Fireface: Use common error handling code in
 pcm_open()
Date: Wed, 23 Aug 2017 09:22:53 +0900
Message-ID: <bd318065-7a0b-efd5-8ce0-0dffe37b92cf@sakamocchi.jp>
References: <05f76303-7370-ea37-20c2-116c04b850db@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05f76303-7370-ea37-20c2-116c04b850db@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 23 2017 04:51, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 22 Aug 2017 21:45:42 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   sound/firewire/fireface/ff-pcm.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
> index d12a0e3a4219..40975395a64a 100644
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


A line to return for err is still left after applying this patch.

148         if (src != SND_FF_CLOCK_SRC_INTERNAL) {
149                 for (i = 0; i < CIP_SFC_COUNT; ++i) {
150                         if (amdtp_rate_table[i] == rate)
151                                 break;
152                 }
153                 /*
154                  * The unit is configured at sampling frequency 
which packet
155                  * streaming engine can't support.
156                  */
157                 if (i >= CIP_SFC_COUNT) {
158                         snd_ff_stream_lock_release(ff);
159                         return -EIO;
160                 }
161


Regards

Takashi Sakamoto
