From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH] snd-core: enlarge snd_card.components for
	up to 4	codecs
Date: Tue, 7 Oct 2008 17:11:18 +0800
Message-ID: <1223370680.794179.10698@de>
References: <1223362567.716898.9499@de> <s5htzboomf0.wl%tiwai@suse.de>
	<1223368470.894420.10038@de> <s5hljx0n5jp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C42010380F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 11:14:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hljx0n5jp.wl%tiwai@suse.de>
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

On Tue, Oct 07, 2008 at 11:00:26AM +0200, Takashi Iwai wrote:
> At Tue, 7 Oct 2008 16:34:29 +0800,
> > FYI, this is the debug patch and kernel message(lookout the first line) on HP 2230s:
> > 
> > diff --git a/sound/core/init.c b/sound/core/init.c
> > index 8af467d..704d7e8 100644
> > --- a/sound/core/init.c
> > +++ b/sound/core/init.c
> > @@ -706,6 +706,8 @@ int snd_component_add(struct snd_card *card, const char *component)
> >  			return 1;
> >  	}
> >  	if (strlen(card->components) + 1 + len + 1 > sizeof(card->components)) {
> > +		snd_printk(KERN_ERR "components = %s + %s\n",
> > +				card->components, component);
> >  		snd_BUG();
> >  		return -ENOMEM;
> >  	}
> > 
> > 
> > [   12.590150] ALSA sound/core/init.c:710: components = HDA:11d4194a,103c3037,00100400 HDA:11c11040,103c1378,00100200 + HDA:80862802,80860101,00100000
> > [   12.590163] ------------[ cut here ]------------
> > [   12.590166] WARNING: at sound/core/init.c:711 snd_component_add+0xfa/0x110 [snd]()
> > [   12.590168] BUG?
> (snip)
> 
> Argh, that's bad. 
> Then I agree with increasing the components as a simple workaround.
> 
> How about the patch below?  The control protocol number is increased
> for this change as well.

The modified patch looks fine, I'll test it out in the following days.

So far grep gives the following referees:

./alsa-driver/acore/ioctl32/ioctl32_new.c:      MAP_COMPAT(SNDRV_CTL_IOCTL_CARD_INFO),
./alsa-driver/acore/ioctl32/ioctl32_old.c:      MAP_COMPAT(SNDRV_CTL_IOCTL_CARD_INFO),
./alsa-kernel/sound/core/control_compat.c:      case SNDRV_CTL_IOCTL_CARD_INFO:
./alsa-kernel/sound/core/control.c:     case SNDRV_CTL_IOCTL_CARD_INFO:
./alsa-kernel/include/sound/asound.h:   SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct snd_ctl_card_info),
./alsa-lib/src/control/control_shm.c:   ctrl->cmd = SNDRV_CTL_IOCTL_CARD_INFO;
./alsa-lib/src/control/control_hw.c:    if (ioctl(hw->fd, SNDRV_CTL_IOCTL_CARD_INFO, info) < 0) {
./alsa-lib/src/control/control_hw.c:            SYSERR("SNDRV_CTL_IOCTL_CARD_INFO failed");
./alsa-lib/aserver/aserver.c:   case SNDRV_CTL_IOCTL_CARD_INFO:
./alsa-lib/include/sound/asound.h:      SNDRV_CTL_IOCTL_CARD_INFO = _IOR('U', 0x01, struct sndrv_ctl_card_info),

Thanks,
Fengguang
---

> 
> thanks,
> 
> Takashi
> 
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 3eaf155..fbfe992 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -696,7 +696,7 @@ struct snd_timer_tread {
>   *                                                                          *
>   ****************************************************************************/
>  
> -#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 5)
> +#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
>  
>  struct snd_ctl_card_info {
>  	int card;			/* card number */
> @@ -707,8 +707,7 @@ struct snd_ctl_card_info {
>  	unsigned char longname[80];	/* name + info text about soundcard */
>  	unsigned char reserved_[16];	/* reserved for future (was ID of mixer) */
>  	unsigned char mixername[80];	/* visual mixer identification */
> -	unsigned char components[80];	/* card components / fine identification, delimited with one space (AC97 etc..) */
> -	unsigned char reserved[48];	/* reserved for future */
> +	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
>  };
>  
>  typedef int __bitwise snd_ctl_elem_type_t;
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 558b962..221554e 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -114,7 +114,7 @@ struct snd_card {
>  	char shortname[32];		/* short name of this soundcard */
>  	char longname[80];		/* name of this soundcard */
>  	char mixername[80];		/* mixer name */
> -	char components[80];		/* card components delimited with
> +	char components[128];		/* card components delimited with
>  								space */
>  	struct module *module;		/* top-level module */
>  
