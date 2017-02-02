From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC] [ALSA][CONTROL] Added 2 ioctls for reading/writing values
 of multiple controls in one go (at once)
Date: Thu, 2 Feb 2017 12:45:48 +0900
Message-ID: <a68d296b-9f31-51e1-357c-d75e90b24420@sakamocchi.jp>
References: <CGME20170202031525epcas1p2164b4ca25afe9fb5cd418d004da961f5@epcas1p2.samsung.com>
 <1486005286-25625-1-git-send-email-satendra.t@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486005286-25625-1-git-send-email-satendra.t@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satendra Singh Thakur <satendra.t@samsung.com>, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, hemanshu.s@samsung.com, nishant.s4@samsung.com, ycheon.song@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 2 2017 12:14, Satendra Singh Thakur wrote:
> From: satendra singh thakur <satendra.t@samsung.com>
>
> -Added 2 ioctls in alsa driver's control interface
> -Added an ioctl to read values of multiple elements at once
> -Added an ioctl to write values of multiple elements at once
> -In the absence of above ioctls user needs to call N ioctls to
>  read/write value of N elements which requires N context switches
> -Proposed ioctls will allow accessing N elements' values in a single
>  context switch
> -Above mentioned ioctl will be useful for alsa utils such as amixer
>  which reads all controls of given sound card
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  include/uapi/sound/asound.h |    8 +++++
>  sound/core/control.c        |   69 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)

I'm _strongly_ interested in your two patches, because it has a  
potentiality to purge ASoC abuse of TLV feature, which was introduced in  
2014 with a bad reviewing process.

Unfortunately, I have a short vacation in this weekend, so my reviewing  
is postponed to next week, sorry...

Anyway, in next time, please post them as one patchset so that reviewers  
easily pick them up. 'git format-patch' and 'git send-email' will assist  
you.

> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index be353a7..a0dcee7 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -948,6 +948,11 @@ struct snd_ctl_tlv {
>  	unsigned int length;	/* in bytes aligned to 4 */
>  	unsigned int tlv[0];	/* first TLV */
>  };
> +/*Struct to read/write multiple element values */
> +struct snd_ctl_elem_values {
> +	unsigned int num_vals;/* Number of values*/
> +	struct snd_ctl_elem_value *pvals;/* Pointer to the array of values */
> +};
>
>  #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
>  #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
> @@ -974,6 +979,9 @@ struct snd_ctl_tlv {
>  #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
>  #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
>  #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
> +/*Multipe controls' values read and write*/
> +#define SNDRV_CTL_IOCTL_ELEMS_READ	_IOWR('U', 0xe0, struct snd_ctl_elem_values)
> +#define SNDRV_CTL_IOCTL_ELEMS_WRITE	_IOWR('U', 0xe1, struct snd_ctl_elem_values)
>
>  /*
>   *  Read interface.
> diff --git a/sound/core/control.c b/sound/core/control.c
> index fb096cb..d60dc98 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -942,6 +942,7 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
>  	return result;
>  }
>
> +
>  static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
>  			      struct snd_ctl_elem_value *control)
>  {
> @@ -1000,6 +1001,70 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
>  	return result;
>  }
>
> +/**
> + * snd_ctl_elems_rw_user - Read/Write values of more than one element,
> + * one by one
> + * @card: the card to which element belongs to
> + * @pucontrols: user-space pointer to struct snd_ctl_elem_values
> + * @write_flag: this flag distinguises write or read type request
> + *
> + * This function reads/writes the value of controls with the given IDs
> + * of the same card
> + * Return: On full/partial success, It returns number of successful
> + *		controls read/written.
> + *		On failure, it returns appropriate error
> + */
> +static int snd_ctl_elems_rw_user(struct snd_ctl_file *file,
> +				struct snd_ctl_elem_values __user *pucontrols,
> +				bool write_flag)
> +{
> +	struct snd_ctl_elem_values controls;
> +	struct snd_ctl_elem_value control;
> +	struct snd_ctl_elem_value __user *puvals;
> +	struct snd_card *card = file->card;
> +	int result;
> +	int vals;
> +	int controls_count = 0;
> +
> +	if (copy_from_user(&controls, pucontrols, sizeof(controls)))
> +		return -EFAULT;
> +	if (!controls.num_vals || controls.num_vals > card->controls_count)
> +		return -EINVAL;
> +	/*assign user-space pointer**/
> +	puvals = (struct snd_ctl_elem_value __user *) controls.pvals;
> +	for (vals = 0; vals < controls.num_vals; vals++) {
> +		if (copy_from_user(&control, puvals + vals, sizeof(control)))
> +			return -EFAULT;
> +		snd_power_lock(card);
> +		result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
> +		if (result >= 0) {
> +			if (write_flag == true)
> +				result = snd_ctl_elem_write(card, file,
> +						&control);
> +			else
> +				result = snd_ctl_elem_read(card,  &control);
> +		}
> +		snd_power_unlock(card);
> +		if (result < 0) {
> +			/**If control failed to set/get
> +			 * inform user by sending back -1 in reserved field
> +			 * so that one can try again for failed elements
> +			 */
> +			control.reserved[0] = (unsigned char) -1;
> +			pr_err("ALSA: control: snd_ctl_elem_write/read failed\
> +			for control name = %s\n", control.id.name);
> +		} else {
> +			controls_count++;
> +		}
> +		if (copy_to_user(puvals + vals, &control, sizeof(control)))
> +			return -EFAULT;
> +	}
> +	pr_debug("ALSA: control: Num values successfully read/written %u\n",\
> +	controls_count);
> +	/**Return successful control count to user**/
> +	return controls_count;
> +}
> +
>  static int snd_ctl_elem_lock(struct snd_ctl_file *file,
>  			     struct snd_ctl_elem_id __user *_id)
>  {
> @@ -1515,8 +1580,12 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  		return snd_ctl_elem_info_user(ctl, argp);
>  	case SNDRV_CTL_IOCTL_ELEM_READ:
>  		return snd_ctl_elem_read_user(card, argp);
> +	case SNDRV_CTL_IOCTL_ELEMS_READ:
> +		return snd_ctl_elems_rw_user(ctl, argp, false);
>  	case SNDRV_CTL_IOCTL_ELEM_WRITE:
>  		return snd_ctl_elem_write_user(ctl, argp);
> +	case SNDRV_CTL_IOCTL_ELEMS_WRITE:
> +		return snd_ctl_elems_rw_user(ctl, argp, true);
>  	case SNDRV_CTL_IOCTL_ELEM_LOCK:
>  		return snd_ctl_elem_lock(ctl, argp);
>  	case SNDRV_CTL_IOCTL_ELEM_UNLOCK:


Thanks

Takashi Sakamoto
