From: Liam Girdwood <lrg@kernel.org>
Subject: Re: get rid of controls with snd_ctl_remove
Date: Fri, 29 Aug 2008 14:56:33 +0100
Message-ID: <1220018193.6499.49.camel@odin>
References: <200808291454.42441.harryrat@postnuklear.de>
	<s5hhc94gel4.wl%tiwai@suse.de> <1220015812.6499.42.camel@odin>
	<s5h8wuggcqm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id CF8FE24434
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 15:56:36 +0200 (CEST)
In-Reply-To: <s5h8wuggcqm.wl%tiwai@suse.de>
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
Cc: Harald Radke <harryrat@postnuklear.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-08-29 at 15:41 +0200, Takashi Iwai wrote:
> At Fri, 29 Aug 2008 14:16:52 +0100,
> Liam Girdwood wrote:

> > I'd prefer an addition to our API to handle this more _common_ case
> > rather than just removing controls. 
> > 
> > Something where we can mark controls as "disabled" so alsamixer and
> > friends wont render/get them. This would also allow scenario code to
> > disable relevant mixers and then re-enable when required.
> 
> Something like below?
> 
> 
> Takashi
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 3c5e746..c6f7062 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -410,6 +410,52 @@ int snd_ctl_remove_id(struct snd_card *card, struct snd_ctl_elem_id *id)
>  EXPORT_SYMBOL(snd_ctl_remove_id);
>  
>  /**
> + * snd_ctl_activate_id - activate/inactivate the control of the given id
> + * @card: the card instance
> + * @id: the control id to activate/inactivate
> + * @active: non-zero to activate
> + *
> + * Finds the control instance with the given id, and activate or
> + * inactivate the control together with notification, if changed.
> + * 
> + * Returns 0 if unchanged, 1 if changed, or a negative error code on failure.
> + */
> +int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
> +			int active)
> +{
> +	struct snd_kcontrol *kctl;
> +	struct snd_kcontrol_volatile *vd;
> +	unsigned int index_offset;
> +	int ret;
> +
> +	down_write(&card->controls_rwsem);
> +	kctl = snd_ctl_find_id(card, id);
> +	if (kctl == NULL) {
> +		up_write(&card->controls_rwsem);
> +		return -ENOENT;
> +	}
> +	index_offset = snd_ctl_get_ioff(kctl, &control->id);
> +	vd = &kctl->vd[index_offset];
> +	ret = 0;
> +	if (active) {
> +		if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_INACTIVE))
> +			goto unlock;
> +		vd->access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
> +	} else {
> +		if (vd->access & SNDRV_CTL_ELEM_ACCESS_INACTIVE)
> +			goto unlock;
> +		vd->access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
> +	}
> +	ret = 1;
> + unlock:
> +	up_write(&card->controls_rwsem);
> +	if (ret)
> +		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
> +	return ret;
> +}
> +EXPORT_SYMBOL(snd_ctl_activate_id);
> +
> +/**
>   * snd_ctl_remove_unlocked_id - remove the unlocked control of the given id and release it
>   * @file: active control handle
>   * @id: the control id to remove

Wow - that was quick !

Yes, exactly :) We can now add this to our machine drivers to disable
never used controls (for each machine) and also call this when scenario
changes too.

Even more interestingly, it could also be called by DAPM......

Cheers

Liam
