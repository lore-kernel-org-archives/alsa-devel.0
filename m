From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 3/3] ALSA: core: set kcontrol's count field
	correctly
Date: Wed, 24 Aug 2011 19:46:13 +0800
Message-ID: <20110824114613.GA1811@guanqun-laptop.ccr.corp.intel.com>
References: <20110824031234.5279.46501.stgit@localhost6.localdomain6>
	<20110824031243.5279.93859.stgit@localhost6.localdomain6>
	<s5hy5yjpclx.wl%tiwai@suse.de>
	<20110824061757.GF3551@guanqun-laptop.sh.intel.com>
	<s5hsjorpbo8.wl%tiwai@suse.de> <s5hfwkrp5eq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 10C75103942
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:46:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfwkrp5eq.wl%tiwai@suse.de>
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
Cc: ALSA <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 04:42:05PM +0800, Takashi Iwai wrote:
> ---
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 5d6074f..9f5f55d 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -813,6 +813,33 @@ struct snd_ctl_elem_info {
>  	unsigned char reserved[64-4*sizeof(unsigned short)];
>  };
>  
> +/* The struct used for ELEM_ADD and ELEM_REPLACE ioctls;
> + * This is is identical with snd_ctl_elem_info, but just owner field is
> + * different, keeping the number of elements to be created.
> + * The unused fields are stripped for simplicity.
> + */
> +struct snd_ctl_elem_add_info {
> +	struct snd_ctl_elem_id id;	/* element ID */
> +	snd_ctl_elem_type_t type;	/* value type */
> +	unsigned int access;		/* value access (bitmask) */
> +	unsigned int count;		/* count of values */
> +	__kernel_pid_t elem_count;	/* # of elements to create (0=1) */
> +	union {
> +		struct {
> +			long min;		/* R: minimum value */
> +			long max;		/* R: maximum value */
> +			long step;		/* R: step (0 variable) */
> +		} integer;
> +		struct {
> +			long long min;		/* R: minimum value */
> +			long long max;		/* R: maximum value */
> +			long long step;		/* R: step (0 variable) */
> +		} integer64;
> +		unsigned char reserved[128];
> +	} value;
> +	unsigned char reserved[64];
> +};
> +
>  struct snd_ctl_elem_value {
>  	struct snd_ctl_elem_id id;	/* W: element ID */
>  	unsigned int indirect: 1;	/* W: indirect access - obsoleted */
> @@ -854,8 +881,8 @@ struct snd_ctl_tlv {
>  #define SNDRV_CTL_IOCTL_ELEM_LOCK	_IOW('U', 0x14, struct snd_ctl_elem_id)
>  #define SNDRV_CTL_IOCTL_ELEM_UNLOCK	_IOW('U', 0x15, struct snd_ctl_elem_id)
>  #define SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS _IOWR('U', 0x16, int)
> -#define SNDRV_CTL_IOCTL_ELEM_ADD	_IOWR('U', 0x17, struct snd_ctl_elem_info)
> -#define SNDRV_CTL_IOCTL_ELEM_REPLACE	_IOWR('U', 0x18, struct snd_ctl_elem_info)
> +#define SNDRV_CTL_IOCTL_ELEM_ADD	_IOWR('U', 0x17, struct snd_ctl_elem_add_info)
> +#define SNDRV_CTL_IOCTL_ELEM_REPLACE	_IOWR('U', 0x18, struct snd_ctl_elem_add_info)
>  #define SNDRV_CTL_IOCTL_ELEM_REMOVE	_IOWR('U', 0x19, struct snd_ctl_elem_id)
>  #define SNDRV_CTL_IOCTL_TLV_READ	_IOWR('U', 0x1a, struct snd_ctl_tlv)
>  #define SNDRV_CTL_IOCTL_TLV_WRITE	_IOWR('U', 0x1b, struct snd_ctl_tlv)
> diff --git a/sound/core/control.c b/sound/core/control.c
> index dc2a440..15c171d 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1064,7 +1064,7 @@ static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
>  }
>  
>  static int snd_ctl_elem_add(struct snd_ctl_file *file,
> -			    struct snd_ctl_elem_info *info, int replace)
> +			    struct snd_ctl_elem_add_info *info, int replace)
>  {
>  	struct snd_card *card = file->card;
>  	struct snd_kcontrol kctl, *_kctl;
> @@ -1099,7 +1099,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>  	if (err < 0)
>  		return err;
>  	memcpy(&kctl.id, &info->id, sizeof(info->id));
> -	kctl.count = info->owner ? info->owner : 1;
> +	kctl.count = info->elem_count ? info->elem_count : 1;

Hi Takashi,

I don't how this approach can solve this problem. There's still an
implicit assumption here that user space application will clear
info->elem_count to zero before it issues the REPLACE ioctl, right?

>  	access |= SNDRV_CTL_ELEM_ACCESS_USER;
>  	kctl.info = snd_ctl_elem_user_info;
>  	if (access & SNDRV_CTL_ELEM_ACCESS_READ)
> @@ -1139,7 +1139,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>  	ue = kzalloc(sizeof(struct user_element) + private_size, GFP_KERNEL);
>  	if (ue == NULL)
>  		return -ENOMEM;
> -	ue->info = *info;
> +	memcpy(&ue->info, info, sizeof(*info));

Should we add some assertion here checking the size of these two
structure should be the same?

>  	ue->info.access = 0;
>  	ue->elem_data = (char *)ue + sizeof(*ue);
>  	ue->elem_data_size = private_size;
> @@ -1164,9 +1164,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
>  }
>  
>  static int snd_ctl_elem_add_user(struct snd_ctl_file *file,
> -				 struct snd_ctl_elem_info __user *_info, int replace)
> +				 struct snd_ctl_elem_add_info __user *_info,
> +				 int replace)
>  {
> -	struct snd_ctl_elem_info info;
> +	struct snd_ctl_elem_add_info info;
>  	if (copy_from_user(&info, _info, sizeof(info)))
>  		return -EFAULT;
>  	return snd_ctl_elem_add(file, &info, replace);

-- 
guanqun
