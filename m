From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/13 v1] Enhancement for Dice driver
Date: Mon, 19 May 2014 17:36:07 +0900
Message-ID: <5379C277.9090804@sakamocchi.jp>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140519095816.21acbc71@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 78EDC261A74
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 10:36:22 +0200 (CEST)
In-Reply-To: <20140519095816.21acbc71@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

(May 19 2014 16:58), Stefan Richter wrote:
> On May 18 Takashi Sakamoto wrote:
>> Takashi Sakamoto (13):
>>    dice: Rename structure and its members
>>    dice: Move file to its own directory
>>    dice: Split transaction functionality into a file
>>    dice: Split stream functionality into a file
>>    dice: Split PCM functionality into a file
>>    dice: Split hwdep functionality into a file
>>    dice: Split proc functionality into a file
>>    dice: Add new functions for limitation of PCM parameters
>>    dice: Change the way to start stream
>>    dice: Add support for duplex streams with synchronization
>>    dice: Support for non SYT-Match sampling clock source mode
>>    dice: Add support for PCM capture
>>    dice: Add support for MIDI capture/playback
>
> Patch 02/12 apparently didn't get through to the mailinglist.  It is this one,
> https://github.com/takaswie/sound/commit/ad9a912161a3b6d2e48d19e185b50d4619ea5a53
> right?

Yes.

This patch includes more lines than these mailing lists (alsa-devel and 
ffado-devel) allow. So it needs approval by administrator.

Jonathan and Iwai-san, would you please approve this patch to be blasted?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

>>From ad9a912161a3b6d2e48d19e185b50d4619ea5a53 Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Fri, 16 May 2014 22:11:47 +0900
> Subject: [PATCH] dice: Move file to its own directory
>
> In followed commits, dice driver is split into several files. For easily
> managing these files, this commit adds subdirectory and move file into
> the directory.
>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   sound/firewire/Makefile                    |  3 +--
>   sound/firewire/dice/Makefile               |  2 ++
>   sound/firewire/{ => dice}/dice-interface.h |  0
>   sound/firewire/{ => dice}/dice.c           | 15 ++++++++-------
>   4 files changed, 11 insertions(+), 9 deletions(-)
>   create mode 100644 sound/firewire/dice/Makefile
>   rename sound/firewire/{ => dice}/dice-interface.h (100%)
>   rename sound/firewire/{ => dice}/dice.c (99%)
>
> diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
> index e297995cf7f7..edbe61d9ad1b 100644
> --- a/sound/firewire/Makefile
> +++ b/sound/firewire/Makefile
> @@ -1,11 +1,10 @@
>   snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
>   			 fcp.o cmp.o amdtp.o
> -snd-dice-objs := dice.o
>   snd-isight-objs := isight.o
>   snd-scs1x-objs := scs1x.o
>
>   obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
> -obj-$(CONFIG_SND_DICE) += snd-dice.o
> +obj-$(CONFIG_SND_DICE) += dice/
>   obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
>   obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
>   obj-$(CONFIG_SND_FIREWORKS) += fireworks/
> diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
> new file mode 100644
> index 000000000000..af05d7e9119a
> --- /dev/null
> +++ b/sound/firewire/dice/Makefile
> @@ -0,0 +1,2 @@
> +snd-dice-objs := dice.o
> +obj-m += snd-dice.o
> diff --git a/sound/firewire/dice-interface.h b/sound/firewire/dice/dice-interface.h
> similarity index 100%
> rename from sound/firewire/dice-interface.h
> rename to sound/firewire/dice/dice-interface.h
> diff --git a/sound/firewire/dice.c b/sound/firewire/dice/dice.c
> similarity index 99%
> rename from sound/firewire/dice.c
> rename to sound/firewire/dice/dice.c
> index d18e7a68155d..cf8dc05c1596 100644
> --- a/sound/firewire/dice.c
> +++ b/sound/firewire/dice/dice.c
> @@ -26,9 +26,9 @@
>   #include <sound/initval.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> -#include "amdtp.h"
> -#include "iso-resources.h"
> -#include "lib.h"
> +#include "../amdtp.h"
> +#include "../iso-resources.h"
> +#include "../lib.h"
>   #include "dice-interface.h"
>
>
> @@ -133,7 +133,7 @@ static inline u64 global_address(struct snd_dice *dice, unsigned int offset)
>   	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
>   }
>
> -// TODO: rx index
> +/* TODO: rx index */
>   static inline u64 rx_address(struct snd_dice *dice, unsigned int offset)
>   {
>   	return DICE_PRIVATE_SPACE + dice->rx_offset + offset;
> @@ -710,13 +710,14 @@ static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
>   		event.lock_status.status = dice->dev_lock_count > 0;
>   		dice->dev_lock_changed = false;
>
> -		count = min(count, (long)sizeof(event.lock_status));
> +		count = min_t(long, count, sizeof(event.lock_status));
>   	} else {
> -		event.dice_notification.type = SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
> +		event.dice_notification.type =
> +					SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
>   		event.dice_notification.notification = dice->notification_bits;
>   		dice->notification_bits = 0;
>
> -		count = min(count, (long)sizeof(event.dice_notification));
> +		count = min_t(long, count, sizeof(event.dice_notification));
>   	}
>
>   	spin_unlock_irq(&dice->lock);
