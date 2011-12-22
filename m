From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 2/6] core: add support for compressed
 devices
Date: Thu, 22 Dec 2011 13:45:45 +0530
Message-ID: <1324541745.1641.10128.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-3-git-send-email-vinod.koul@linux.intel.com>
	<s5hzkelnjpq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B64124450
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 09:15:52 +0100 (CET)
In-Reply-To: <s5hzkelnjpq.wl%tiwai@suse.de>
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
Cc: lrg@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-22 at 08:34 +0100, Takashi Iwai wrote:
> At Tue, 13 Dec 2011 14:32:56 +0530,
> Vinod Koul wrote:
> > 
> > From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
> > 
> > Use the two minor numbers 2 and 3 for audio compressed offload devices.
> > Also add support for these devices in core
> > 
> > Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > ---
> >  include/sound/core.h   |    1 +
> >  include/sound/minors.h |    7 ++++++-
> >  sound/core/sound.c     |    6 ++++++
> >  3 files changed, 13 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/sound/core.h b/include/sound/core.h
> > index 3be5ab7..5ab255f 100644
> > --- a/include/sound/core.h
> > +++ b/include/sound/core.h
> > @@ -62,6 +62,7 @@ typedef int __bitwise snd_device_type_t;
> >  #define	SNDRV_DEV_BUS		((__force snd_device_type_t) 0x1007)
> >  #define	SNDRV_DEV_CODEC		((__force snd_device_type_t) 0x1008)
> >  #define	SNDRV_DEV_JACK          ((__force snd_device_type_t) 0x1009)
> > +#define	SNDRV_DEV_COMPRESS	((__force snd_device_type_t) 0x100A)
> >  #define	SNDRV_DEV_LOWLEVEL	((__force snd_device_type_t) 0x2000)
> >  
> >  typedef int __bitwise snd_device_state_t;
> > diff --git a/include/sound/minors.h b/include/sound/minors.h
> > index 8f76420..faaeb64 100644
> > --- a/include/sound/minors.h
> > +++ b/include/sound/minors.h
> > @@ -35,7 +35,8 @@
> >  #define SNDRV_MINOR_TIMER		33	/* SNDRV_MINOR_GLOBAL + 1 * 32 */
> >  
> >  #ifndef CONFIG_SND_DYNAMIC_MINORS
> > -						/* 2 - 3 (reserved) */
> > +#define SNDRV_MINOR_COMPR_PLAYBACK	2
> > +#define SNDRV_MINOR_COMPR_CAPTURE	3
> 
> If you'd share both playback and capture to a single device (as you
> already did in patch 5/6), no need to provide distinct numbers here.
> This would be simply
> 
> #define SNDRV_MINOR_COMPR		2
> 
> and define the single SNDRV_DEVICE_TYPE_COMPR.
> Then you'll have to up to two devices for the static minors and more
> for dynamic minors.  So, the below would be:
Oops, I thought i had fixed it up as well, thanks below is right :)
> 
> > diff --git a/sound/core/sound.c b/sound/core/sound.c
> > index 828af35..2b680dd 100644
> > --- a/sound/core/sound.c
> > +++ b/sound/core/sound.c
> > @@ -233,6 +233,12 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
> >  			return -EINVAL;
> >  		minor = SNDRV_MINOR(card->number, type + dev);
> >  		break;
> > +	case SNDRV_DEVICE_TYPE_COMPR_PLAYBACK:
> > +	case SNDRV_DEVICE_TYPE_COMPR_CAPTURE:
> > +		if (snd_BUG_ON(!card))
> > +			return -EINVAL;
> > +		minor = SNDRV_MINOR(card->number, type);
> > +		break;
> 
> Instead of this, just add case SNDRV_DEVICE_TYPE_COMPR in the cases of
> other types like PCM and RAWMIDI, i.e.
right
> 
> > +		minor = SNDRV_MINOR(card->number, type + dev);
> 
> 
> Takashi


-- 
~Vinod
