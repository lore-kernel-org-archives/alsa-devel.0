From: Tim <terminator356@users.sourceforge.net>
Subject: Re: multi pcm and mmap problem
Date: Fri, 23 Nov 2007 20:31:03 -0500
Message-ID: <200711232031.03910.terminator356@users.sourceforge.net>
References: <200711210158.42108.terminator356@users.sourceforge.net>
	<s5h7ik9t6y0.wl%tiwai@suse.de> <s5h3auxt4g8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.rog.mail.re2.yahoo.com (smtp109.rog.mail.re2.yahoo.com
	[68.142.225.207]) by alsa0.perex.cz (Postfix) with SMTP id 150292472B
	for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2007 02:17:00 +0100 (CET)
In-Reply-To: <s5h3auxt4g8.wl%tiwai@suse.de>
Content-Disposition: inline
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

Thank you! Thank you! Thank you!
Freaking awesome!
You fixed two bugs in one!
I can now use recent ALSA versions (and linux distros),
 AND I can combine the two cards at 24 bits resolution,
 at any buffer size, instead of 16 bits (because mmap was 
 requiring me to use really small buffers).

||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|	I.O.U.
|	One case of <your favourite beverage>
|	Or one bottle of <something special>
|
|	Expires: Never.
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

OK, sure, I know I should run out and buy one of the
 newer 24 bit Creative cards so I don't have to convert,
 but hey, there's a lot of SBLive! cards out there...
I need it for the hardware soundfonts only.
Fluidsynth is good but a software solution.

* Anyways, initial tests are good. 
* I will test this weekend and let you know how it goes,
*  and after you can commit the patch for good.

A final 'note':
The envy24control app's Master Clock - Signal/No Signal 
 seems broken again. 
I know the cards are locked, but it still says 'No signal'
 when S/PDIF is selected. 
Some weirdness happening, seems to not actually lock sometimes,
 forcing me to switch back and forth between Int48000 and S/PDIF.
But at least it mostly works.

I really appreciate you listening to me and taking the time to fix things. 
I know that given precise information, you always squash these bugs quickly.
Tim.



On Friday 23 November 2007 09:35:35 am you wrote:
> At Fri, 23 Nov 2007 14:41:43 +0100,
>
> I wrote:
> > Try the patch below.  This should fix the problem.  Now the multi
> > plugin just shadows the slave buffers via mmap.
>
> There was a minor bug in the last patch.  The revised version is
> below.
>
>
> Takashi
>
> diff -r 3539f279ec38 src/pcm/pcm_multi.c
> --- a/src/pcm/pcm_multi.c	Wed Nov 21 12:19:43 2007 +0100
> +++ b/src/pcm/pcm_multi.c	Fri Nov 23 15:34:16 2007 +0100
> @@ -690,13 +690,44 @@ static snd_pcm_sframes_t snd_pcm_multi_m
>  	return size;
>  }
>
> -static int snd_pcm_multi_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
> +static int snd_pcm_multi_munmap(snd_pcm_t *pcm)
>  {
> +	free(pcm->mmap_channels);
> +	free(pcm->running_areas);
> +	pcm->mmap_channels = NULL;
> +	pcm->running_areas = NULL;
>  	return 0;
>  }
>
> -static int snd_pcm_multi_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
> +static int snd_pcm_multi_mmap(snd_pcm_t *pcm)
>  {
> +	snd_pcm_multi_t *multi = pcm->private_data;
> +	unsigned int c;
> +
> +	pcm->mmap_channels = calloc(pcm->channels,
> +				    sizeof(pcm->mmap_channels[0]));
> +	pcm->running_areas = calloc(pcm->channels,
> +				    sizeof(pcm->running_areas[0]));
> +	if (!pcm->mmap_channels || !pcm->running_areas) {
> +		snd_pcm_multi_munmap(pcm);
> +		return -ENOMEM;
> +	}
> +
> +	/* Copy the slave mmapped buffer data */
> +	for (c = 0; c < pcm->channels; c++) {
> +		snd_pcm_multi_channel_t *chan = &multi->channels[c];
> +		snd_pcm_t *slave;
> +		if (chan->slave_idx < 0) {
> +			snd_pcm_multi_munmap(pcm);
> +			return -ENXIO;
> +		}
> +		slave = multi->slaves[chan->slave_idx].pcm;
> +		pcm->mmap_channels[c] =
> +			slave->mmap_channels[chan->slave_channel];
> +		pcm->mmap_channels[c].channel = c;
> +		pcm->running_areas[c] =
> +			slave->running_areas[chan->slave_channel];
> +	}
>  	return 0;
>  }
>
> @@ -850,6 +881,7 @@ int snd_pcm_multi_open(snd_pcm_t **pcmp,
>  		return err;
>  	}
>  	pcm->mmap_rw = 1;
> +	pcm->mmap_shadow = 1; /* has own mmap method */
>  	pcm->ops = &snd_pcm_multi_ops;
>  	pcm->fast_ops = &snd_pcm_multi_fast_ops;
>  	pcm->private_data = multi;
