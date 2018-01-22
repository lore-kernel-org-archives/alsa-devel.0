From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH - alsa-lib 1/1] Patch for two bugs in
 snd_pcm_area_silence().
Date: Mon, 22 Jan 2018 23:48:41 +0900
Message-ID: <77fbb9d8-f5c2-ac97-5b77-4f7792fcc270@sakamocchi.jp>
References: <1516505223-16067-1-git-send-email-alsa2@bushytails.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516505223-16067-1-git-send-email-alsa2@bushytails.net>
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
To: alsa2@bushytails.net, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 21 2018 12:27, alsa2@bushytails.net wrote:
> From: furrywolf <alsa2@bushytails.net>
> 
> First, after silencing the buffer 64 bits at a time, any remaining samples
> need to be silenced by the following width-specific code.  However, instead
> of silencing the end of the buffer, the code instead re-silences the start
> of the buffer, leaving the end unsilenced.  To fix this, update the pointer
> used by the width-specific code to point to the end of the area just
> silenced, instead of leaving it pointing to the start of the buffer.
> 
> Second, the code for 24 bit samples can only silence a single sample, as
> there's no loop for multiple samples as with other formats.  To fix this,
> add a loop similar to the ones used for every other width.
> 
> The symptoms of these bugs are random data at the end of every supposedly
> silenced buffer with certain format/buffer size combinations, resulting in
> pops and noise.
> 
> Signed-off-by: furrywolf <alsa2@bushytails.net>
> 
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 69d7d66..1753cda 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -2955,6 +2955,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
>   			*dstp++ = silence;
>   		if (samples == 0)
>   			return 0;
> +		dst = (char *)dstp;
>   	}
>   	dst_step = dst_area->step / 8;
>   	switch (width) {
> @@ -2996,16 +2997,20 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
>   		}
>   		break;
>   	}
> -	case 24:
> +	case 24: {
> +		while (samples-- > 0) {
>   #ifdef SNDRV_LITTLE_ENDIAN
> -		*(dst + 0) = silence >> 0;
> -		*(dst + 1) = silence >> 8;
> -		*(dst + 2) = silence >> 16;
> +			*(dst + 0) = silence >> 0;
> +			*(dst + 1) = silence >> 8;
> +			*(dst + 2) = silence >> 16;
>   #else
> -		*(dst + 2) = silence >> 0;
> -		*(dst + 1) = silence >> 8;
> -		*(dst + 0) = silence >> 16;
> +			*(dst + 2) = silence >> 0;
> +			*(dst + 1) = silence >> 8;
> +			*(dst + 0) = silence >> 16;
>   #endif
> +			dst += dst_step;
> +		}
> +	}
>   		break;
>   	case 32: {
>   		uint32_t sil = silence;

I'm under reviewing this patch, but need a bit more time (I'm writing 
test program to check these functions.).

However, as you noted, this patch includes two issues. There's a space 
to consider about splitting this into two patches, each of which handles 
each issue you addressed.


Regards

Takashi Sakamoto
