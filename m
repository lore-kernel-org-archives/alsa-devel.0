From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ALSA: ak4531_codec: Use common error
 handling code in snd_ak4531_mixer()
Date: Sun, 12 Nov 2017 12:29:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711121228370.2084@hadrien>
References: <5615b3be-55ab-c4c1-bc7d-a7c7ba3620f3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 9777E266A73
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 12:29:10 +0100 (CET)
In-Reply-To: <5615b3be-55ab-c4c1-bc7d-a7c7ba3620f3@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On Sun, 12 Nov 2017, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 12 Nov 2017 10:56:19 +0100
>
> * Add a jump target so that a bit of exception handling can be better
>   reused at the end of this function.
>
>   This issue was detected by using the Coccinelle software.
>
> * The script "checkpatch.pl" pointed information out like the following.
>
>   ERROR: do not use assignment in if condition

These don't seem to belong in the same patch.

julia

>
>   Thus fix three affected source code places.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/pci/ak4531_codec.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
> index 2fb1fbba3e5e..208c96d6ae0f 100644
> --- a/sound/pci/ak4531_codec.c
> +++ b/sound/pci/ak4531_codec.c
> @@ -399,10 +399,10 @@ int snd_ak4531_mixer(struct snd_card *card,
>  		return -ENOMEM;
>  	*ak4531 = *_ak4531;
>  	mutex_init(&ak4531->reg_mutex);
> -	if ((err = snd_component_add(card, "AK4531")) < 0) {
> -		snd_ak4531_free(ak4531);
> -		return err;
> -	}
> +	err = snd_component_add(card, "AK4531");
> +	if (err < 0)
> +		goto free_ac;
> +
>  	strcpy(card->mixername, "Asahi Kasei AK4531");
>  	ak4531->write(ak4531, AK4531_RESET, 0x03);	/* no RST, PD */
>  	udelay(100);
> @@ -413,16 +413,16 @@ int snd_ak4531_mixer(struct snd_card *card,
>  		ak4531->write(ak4531, idx, ak4531->regs[idx] = snd_ak4531_initial_map[idx]);	/* recording source is mixer */
>  	}
>  	for (idx = 0; idx < ARRAY_SIZE(snd_ak4531_controls); idx++) {
> -		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_ak4531_controls[idx], ak4531))) < 0) {
> -			snd_ak4531_free(ak4531);
> -			return err;
> -		}
> +		err = snd_ctl_add(card,
> +				  snd_ctl_new1(&snd_ak4531_controls[idx],
> +					       ak4531));
> +		if (err < 0)
> +			goto free_ac;
>  	}
>  	snd_ak4531_proc_init(card, ak4531);
> -	if ((err = snd_device_new(card, SNDRV_DEV_CODEC, ak4531, &ops)) < 0) {
> -		snd_ak4531_free(ak4531);
> -		return err;
> -	}
> +	err = snd_device_new(card, SNDRV_DEV_CODEC, ak4531, &ops);
> +	if (err < 0)
> +		goto free_ac;
>
>  #if 0
>  	snd_ak4531_dump(ak4531);
> @@ -430,6 +430,10 @@ int snd_ak4531_mixer(struct snd_card *card,
>  	if (rak4531)
>  		*rak4531 = ak4531;
>  	return 0;
> +
> +free_ac:
> +	snd_ak4531_free(ak4531);
> +	return err;
>  }
>
>  /*
> --
> 2.15.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
