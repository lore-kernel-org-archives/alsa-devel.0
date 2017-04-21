From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 3/3] timer: obsolete legacy
	rtctimer instance
Date: Sat, 22 Apr 2017 00:15:17 +0900
Message-ID: <9adb91d1-809d-7926-eed0-e0eda51406ca@sakamocchi.jp>
References: <20170421150820.18199-1-o-takashi@sakamocchi.jp>
 <20170421150820.18199-4-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8E869267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:15:25 +0200 (CEST)
In-Reply-To: <20170421150820.18199-4-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Apr 22 2017 00:08, Takashi Sakamoto wrote:
> At v4.7 development, ALSA timer interface dropped device instance based on
> legacy rtctimer implementation. User space applications should not use the
> device instance.
>
> This commit drops a macro corresponding to the instance.

Oops. This patch doesn't drop it... I should have written that 'This 
commit adds comments to notify a corresponding macro should not be used 
anymore.'

Hmm. It's better for me to post v2 patchset...

> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/sound/asound.h | 2 +-
>  include/timer.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 9887361..fb8d7d7 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -675,7 +675,7 @@ enum {
>
>  /* global timers (device member) */
>  #define SNDRV_TIMER_GLOBAL_SYSTEM	0
> -#define SNDRV_TIMER_GLOBAL_RTC		1
> +#define SNDRV_TIMER_GLOBAL_RTC		1	/* unused */
>  #define SNDRV_TIMER_GLOBAL_HPET		2
>  #define SNDRV_TIMER_GLOBAL_HRTIMER	3
>
> diff --git a/include/timer.h b/include/timer.h
> index 2803f53..8b8a8ea 100644
> --- a/include/timer.h
> +++ b/include/timer.h
> @@ -112,7 +112,7 @@ typedef struct _snd_timer_tread {
>  /** global timer - system */
>  #define SND_TIMER_GLOBAL_SYSTEM 0
>  /** global timer - RTC */
> -#define SND_TIMER_GLOBAL_RTC 	1
> +#define SND_TIMER_GLOBAL_RTC	1	/* unused */
>  /** global timer - HPET */
>  #define SND_TIMER_GLOBAL_HPET	2
>  /** global timer - HRTIMER */


Regards

Takashi Sakamoto
