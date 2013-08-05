From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] rme96 synchronization support
Date: Mon, 05 Aug 2013 15:18:59 +0200
Message-ID: <51FFA643.7060504@ladisch.de>
References: <51FF9C55.80701@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 804F2261603
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 15:19:04 +0200 (CEST)
In-Reply-To: <51FF9C55.80701@t-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Knut Petersen wrote:
>  			      SNDRV_PCM_INFO_MMAP_VALID |
> +                              SNDRV_PCM_INFO_SYNC_START |

Please use tabs like in other similar parts of the file.

>  static void
> -snd_rme96_playback_start(struct rme96 *rme96,
> +snd_rme96_playcap_start(struct rme96 *rme96,
>  			 int from_pause)
>  {
>  	if (!from_pause) {
>  		writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
> +		writel(0, rme96->iobase + RME96_IO_RESET_REC_POS);
>  	}
> -
> -	rme96->wcreg |= RME96_WCR_START;
> +	rme96->wcreg |= (RME96_WCR_START | RME96_WCR_START_2);
>  	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
>  }
>
>  static void
> +snd_rme96_playback_start(struct rme96 *rme96,
> +			 int from_pause)
> +{
> +	if ((rme96->playback_substream && rme96->capture_substream) &&
> +	    (rme96->playback_substream->group == rme96->capture_substream->group)) {
> +		snd_rme96_playcap_start(rme96,from_pause);
> +	} else {
> +		if (!from_pause) {
> +			writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
> +		}
> +		rme96->wcreg |= RME96_WCR_START;
> +		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
> +	}
> +}

This is hard to maintain because there is duplicated code.

The proper way to write a synchronized start/stop trigger is to collect
the needed register bits first, and then apply them at once to the
register; this works for both single and grouped usage:

trigger_start()
{
	unsigned int wc_bits = 0;

	snd_pcm_group_for_each_entry(s, substream) {
		if (s == playback_substream) {
			bits |= RME96_WCR_START;
			snd_pcm_trigger_done(s, substream);
		} else if (s == capture_substream) {
			bits |= RME96_WCR_START_2;
			snd_pcm_trigger_done(s, substream);
		}
	}
	rme96->wcreg |= bits;
	writel(rme96->wcreg, ...);
}

> -	
> +

Are these whitespace changes deliberate?


Regards,
Clemens
