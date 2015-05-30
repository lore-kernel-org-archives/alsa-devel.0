From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: control: add dimension validator
 for kernel driver
Date: Sat, 30 May 2015 11:05:39 +0900
Message-ID: <55691AF3.5010105@sakamocchi.jp>
References: <1432889937-15413-1-git-send-email-o-takashi@sakamocchi.jp>
 <1432889937-15413-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1432889937-15413-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@alsa-project.org, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 29 2015 17:58, Takashi Sakamoto wrote:
> Currently, kernel drivers are allowed to set arbitrary dimen
> information to control elements. The total number of channels
> calculated by the dimen information should be within the number
> of channels in the control element, while there's no validator.
> When userspace applications have quite simple implementation,
> this can cause buffer-over-run over struct snd_ctl_elem_value
> data.
> 
> This commit adds the validation. Unfortunately, the dimen information
> is set at runtime, thus the validation cannot run in advance.
> 
> As of Linux 4.1, there's no drivers to use the dimen information
> except for Echo Audio PCI cards. All of them already have valid dimen
> information. This patch doesn't cause any regressions.

Oops. This patch brings a bug for control elements added by Echo Audio
PCI card drivers...

The drivers add 'Monitor Mixer Volume', 'VMixer Volume' and 'VU-meters'
with dimen information. They have 'count = 1' except for the last one,
even if the dimen information shows it has more elements in its matrix.

As long as seeing userspace application (echomixer), for these control
elements, the count is ignored to process them. They just evaluate dimen
information.


Regards

Takashi Sakamoto

> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/core/control.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 9b77afd..1370a39 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -836,28 +836,37 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
>  	down_read(&card->controls_rwsem);
>  	kctl = snd_ctl_find_id(card, &info->id);
>  	if (kctl == NULL) {
> -		up_read(&card->controls_rwsem);
> -		return -ENOENT;
> +		result = -ENOENT;
> +		goto end;
>  	}
>  #ifdef CONFIG_SND_DEBUG
>  	info->access = 0;
>  #endif
>  	result = kctl->info(kctl, info);
> -	if (result >= 0) {
> -		snd_BUG_ON(info->access);
> -		index_offset = snd_ctl_get_ioff(kctl, &info->id);
> -		vd = &kctl->vd[index_offset];
> -		snd_ctl_build_ioff(&info->id, kctl, index_offset);
> -		info->access = vd->access;
> -		if (vd->owner) {
> -			info->access |= SNDRV_CTL_ELEM_ACCESS_LOCK;
> -			if (vd->owner == ctl)
> -				info->access |= SNDRV_CTL_ELEM_ACCESS_OWNER;
> -			info->owner = pid_vnr(vd->owner->pid);
> -		} else {
> -			info->owner = -1;
> -		}
> +	if (result < 0)
> +		goto end;
> +
> +	snd_BUG_ON(info->access);
> +
> +	/* This is a driver bug. */
> +	if (!validate_dimen(info)) {
> +		result = -ENODATA;
> +		goto end;
> +	}
> +
> +	index_offset = snd_ctl_get_ioff(kctl, &info->id);
> +	vd = &kctl->vd[index_offset];
> +	snd_ctl_build_ioff(&info->id, kctl, index_offset);
> +	info->access = vd->access;
> +	if (vd->owner) {
> +		info->access |= SNDRV_CTL_ELEM_ACCESS_LOCK;
> +		if (vd->owner == ctl)
> +			info->access |= SNDRV_CTL_ELEM_ACCESS_OWNER;
> +		info->owner = pid_vnr(vd->owner->pid);
> +	} else {
> +		info->owner = -1;
>  	}
> +end:
>  	up_read(&card->controls_rwsem);
>  	return result;
>  }
