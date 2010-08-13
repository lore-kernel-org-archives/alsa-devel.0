From: Mark Hills <mark@pogo.org.uk>
Subject: Re: alsa-lib: Rate conversion broken for non-S16?
Date: Fri, 13 Aug 2010 13:27:30 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1008131319550.31084@fgnk.ybpnyqbznva>
References: <alpine.LNX.2.01.1008012143460.13804@fgnk.ybpnyqbznva>
	<alpine.LNX.2.01.1008110859110.6434@fgnk.ybpnyqbznva>
	<s5hwrrx8qy8.wl%tiwai@suse.de> <s5hk4nx8n5o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hk4nx8n5o.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Abramo Bagnara <abramo@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Aug 2010, Takashi Iwai wrote:

> At Wed, 11 Aug 2010 10:59:59 +0200,
> I wrote:
> > 
> > At Wed, 11 Aug 2010 09:04:32 +0100 (BST),
> > Mark Hills wrote:
> > > 
> > > Hi, does anybody have any thoughts on my email below? The rate conversion 
> > > code looks stable and untouched for a while.
> > 
> > I guess it's a missing support of 3-byte formats in 16bit conversion,
> > so not specific to rate plugin.

Indeed, it's an obvious ommision now that you mention it! Thanks for the 
hint.
 
> > Adding the support shouldn't be too hard, since it's already found
> > in 32bit conversion.
> 
> A quick (untested) fix is below.

Thanks, I tested your patch.

There's a minor mistake that prevents it working, and a couple of comments 
don't seem quite right (see below). I'll follow this email with a revised 
patch.

With my modified patch, I was able to play back reliably in both aplay and 
xwax on my S24_3BE device with rate conversion.

> diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
> index 12e2e7f..01b6742 100644
> --- a/src/pcm/pcm_linear.c
> +++ b/src/pcm/pcm_linear.c
> @@ -114,10 +114,9 @@ int snd_pcm_linear_get32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst
>  
>  int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
>  {
> -	int sign, width, endian;
> +	int sign, width, pwidth, endian;
>  	sign = (snd_pcm_format_signed(src_format) != 
>  		snd_pcm_format_signed(dst_format));
> -	width = snd_pcm_format_width(dst_format) / 8 - 1;
>  #ifdef SND_LITTLE_ENDIAN
>  	endian = snd_pcm_format_big_endian(dst_format);
>  #else
> @@ -125,7 +124,23 @@ int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
>  #endif
>  	if (endian < 0)
>  		endian = 0;
> -	return width * 4 + endian * 2 + sign;
> +	pwidth = snd_pcm_format_physical_width(dst_format);
> +	width = snd_pcm_format_width(dst_format) / 8 - 1;

I concluded this conversion is mis-placed, as it is done again, below (and 
affects decision making when pwidth == 24)

> +	if (pwidth == 24) {
> +		switch (width) {
> +		case 24:
> +			width = 0; break;
> +		case 20:
> +			width = 1; break;
> +		case 18:
> +		default:
> +			width = 2; break;
> +		}
> +		return width * 4 + endian * 2 + sign + 16;
> +	} else {
> +		width = width / 8 - 1;

I left this conversion in.

> +		return width * 4 + endian * 2 + sign;
> +	}
>  }
>  
>  int snd_pcm_linear_put32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
> diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
> index 04220d6..0c63ca6 100644
> --- a/src/pcm/plugin_ops.h
> +++ b/src/pcm/plugin_ops.h
> @@ -407,7 +407,7 @@ get16_123_B2_18: sample = (_get_triple_s(src) >> 2) ^ 0x8000; goto GET16_END;
>  
>  #ifdef PUT16_LABELS
>  /* dst_wid dst_endswap sign_toggle */
> -static void *const put16_labels[4 * 2 * 2] = {
> +static void *const put16_labels[4 * 2 * 2 + 4 * 3] = {
>  	&&put16_12_1,		 /* 16h ->  8h */
>  	&&put16_12_9,		 /* 16h ^>  8h */
>  	&&put16_12_1,		 /* 16h ->  8s */
> @@ -424,6 +424,19 @@ static void *const put16_labels[4 * 2 * 2] = {
>  	&&put16_12_9200,	 /* 16h ^> 32h */
>  	&&put16_12_0021,	 /* 16h -> 32s */
>  	&&put16_12_0029,	 /* 16h ^> 32s */
> +	/* 3bytes format */
> +	&&put16_12_120,	 /* 16h -> 24h */
> +	&&put16_12_920,	 /* 16h ^> 24h */
> +	&&put16_12_021,	 /* 16h -> 24s */
> +	&&put16_12_029,	 /* 16h ^> 24h */
> +	&&put16_12_120_20,	 /* 16h -> 20h */
> +	&&put16_12_920_20,	 /* 16h ^> 20h */
> +	&&put16_12_021_20,	 /* 16h -> 20s */
> +	&&put16_12_029_20,	 /* 16h ^> 20h */
> +	&&put16_12_120_18,	 /* 16h -> 18h */
> +	&&put16_12_920_18,	 /* 16h ^> 18h */
> +	&&put16_12_021_18,	 /* 16h -> 18s */
> +	&&put16_12_029_18,	 /* 16h ^> 18h */

A couple of the comments here look wrong, as they are repeats. '20h' and 
'18h' become '20s' and '18s' respectively. I have corrected that in the 
follow up patch.

>  };
>  #endif
>
[...]

-- 
Mark
