From: Maeda <maeda1@free.fr>
Subject: Re: [bug] Volume at maximum when track with different
 frequency is played with my RME sound card
Date: Fri, 4 Dec 2015 18:13:50 +0100
Message-ID: <5661C9CE.8080600@free.fr>
References: <562A609E.6070205@free.fr> <5641E608.6060006@free.fr>
 <s5hfv007hpg.wl-tiwai@suse.de> <5650ACEE.5050402@free.fr>
 <s5hwptbxhjf.wl-tiwai@suse.de> <565EC3CF.1090301@free.fr>
 <s5hr3j5axqp.wl-tiwai@suse.de> <565F5804.7050501@free.fr>
 <s5hio4fn674.wl-tiwai@suse.de> <56616E72.20407@free.fr>
 <s5h4mfy1mwm.wl-tiwai@suse.de> <56618339.4000600@free.fr>
 <s5hwpsuz8h9.wl-tiwai@suse.de> <5661A22C.5080709@free.fr>
 <s5hlh9az3fx.wl-tiwai@suse.de> <5661AAE7.9080806@free.fr>
 <s5hfuziz1x2.wl-tiwai@suse.de> <5661ADF0.5090805@free.fr>
 <s5h8u5ayzyb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 165EC26583F
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 18:13:22 +0100 (CET)
In-Reply-To: <s5h8u5ayzyb.wl-tiwai@suse.de>
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

Good job :)
Thanks for help and debug.

I'm waiting for the release then.
I don't log anything to the bug report I did =

(https://bugzilla.kernel.org/show_bug.cgi?id=3D105771). Let me know if I =

have to do something in addition.

Le 04/12/2015 16:51, Takashi Iwai a =E9crit :
> On Fri, 04 Dec 2015 16:14:56 +0100,
> Maeda wrote:
>> OK :)
>>
>> Tested-by: Sylvain LABOISNE <maeda1@free.fr>
> Thanks, the official fix is below.  It'll be included in 4.4-rc5
> (slipped from rc4) and backported to stable kernels later.
>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: rme96: Fix unexpected volume reset after rate chan=
ges
>
> rme96 driver needs to reset DAC depending on the sample rate, and this
> results in resetting to the max volume suddenly.  It's because of the
> missing call of snd_rme96_apply_dac_volume().
>
> However, calling this function right after the DAC reset still may not
> work, and we need some delay before this call.  Since the DAC reset
> and the procedure after that are performed in the spinlock, we delay
> the DAC volume restore at the end after the spinlock.
>
> Reported-and-tested-by: Sylvain LABOISNE <maeda1@free.fr>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/rme96.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
> index 714df906249e..e4229d01cf6a 100644
> --- a/sound/pci/rme96.c
> +++ b/sound/pci/rme96.c
> @@ -741,10 +741,11 @@ snd_rme96_playback_setrate(struct rme96 *rme96,
>   	{
>   		/* change to/from double-speed: reset the DAC (if available) */
>   		snd_rme96_reset_dac(rme96);
> +		return 1; /* need to restore volume */
>   	} else {
>   		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
> +		return 0;
>   	}
> -	return 0;
>   }
>   =

>   static int
> @@ -980,6 +981,7 @@ snd_rme96_playback_hw_params(struct snd_pcm_substream=
 *substream,
>   	struct rme96 *rme96 =3D snd_pcm_substream_chip(substream);
>   	struct snd_pcm_runtime *runtime =3D substream->runtime;
>   	int err, rate, dummy;
> +	bool apply_dac_volume =3D false;
>   =

>   	runtime->dma_area =3D (void __force *)(rme96->iobase +
>   					     RME96_IO_PLAY_BUFFER);
> @@ -993,24 +995,24 @@ snd_rme96_playback_hw_params(struct snd_pcm_substre=
am *substream,
>   	{
>                   /* slave clock */
>                   if ((int)params_rate(params) !=3D rate) {
> -			spin_unlock_irq(&rme96->lock);
> -			return -EIO;
> -                }
> -	} else if ((err =3D snd_rme96_playback_setrate(rme96, params_rate(param=
s))) < 0) {
> -		spin_unlock_irq(&rme96->lock);
> -		return err;
> -	}
> -	if ((err =3D snd_rme96_playback_setformat(rme96, params_format(params))=
) < 0) {
> -		spin_unlock_irq(&rme96->lock);
> -		return err;
> +			err =3D -EIO;
> +			goto error;
> +		}
> +	} else {
> +		err =3D snd_rme96_playback_setrate(rme96, params_rate(params));
> +		if (err < 0)
> +			goto error;
> +		apply_dac_volume =3D err > 0; /* need to restore volume later? */
>   	}
> +	if ((err =3D snd_rme96_playback_setformat(rme96, params_format(params))=
) < 0)
> +		goto error;
>   	snd_rme96_setframelog(rme96, params_channels(params), 1);
>   	if (rme96->capture_periodsize !=3D 0) {
>   		if (params_period_size(params) << rme96->playback_frlog !=3D
>   		    rme96->capture_periodsize)
>   		{
> -			spin_unlock_irq(&rme96->lock);
> -			return -EBUSY;
> +			err =3D -EBUSY;
> +			goto error;
>   		}
>   	}
>   	rme96->playback_periodsize =3D
> @@ -1022,8 +1024,15 @@ snd_rme96_playback_hw_params(struct snd_pcm_substr=
eam *substream,
>   		writel(rme96->wcreg |=3D rme96->wcreg_spdif_stream, rme96->iobase + R=
ME96_IO_CONTROL_REGISTER);
>   	}
>   	spin_unlock_irq(&rme96->lock);
> +	err =3D 0;
>   		=

> -	return 0;
> + error:
> +	if (apply_dac_volume) {
> +		usleep_range(3000, 10000);
> +		snd_rme96_apply_dac_volume(rme96);
> +	}
> +
> +	return err;
>   }
>   =

>   static int
