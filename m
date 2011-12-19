From: "Shen, Voice" <Voice.Shen@atmel.com>
Subject: FW: [PATCH] atmel ac97c: using software reset instead hardware reset if not available
Date: Mon, 19 Dec 2011 10:49:00 +0800
Message-ID: <4C79549CB6F772498162A641D92D532803BC848F@penmb01.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sound-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-sound-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, "Egtvedt, Hans-Christian" <Hans-Christian.Egtvedt@atmel.com>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, "Lin, JM" <JM.Lin@atmel.com>, "Xu, Hong" <Hong.Xu@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi Sir,
  Add patch to Atmel AC97C.

  Object: using software reset instead hardware reset if not available

Best Regards,
Voice Shen
-----Original Message-----
From: Nicolas Ferre [mailto:nicolas.ferre@atmel.com] 
Sent: Thursday, November 24, 2011 18:44 voice
To: Shen, Voice
Cc: linux-kernel@vger.kernel.org; linux-sound@vger.kernel.org; Lin, JM;
Xu, Hong
Subject: Re: [PATCH] atmel ac97c: using software reset instead hardware
reset if not available

On 11/23/2011 11:05 AM, voice :
> Using software reset instead hardware reset if not available
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

You may need to sent it to the sound subsystem mailing-list and
maintainers.

Anyway, I let you follow this patch... As it is a fixup and will benefit
to existing platforms, I think that it can make its way to mainline
during 3.2 phase.

Best regards,

> ---
>  sound/atmel/ac97c.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
> index 6e5adde..73516f6 100644
> --- a/sound/atmel/ac97c.c
> +++ b/sound/atmel/ac97c.c
> @@ -899,6 +899,10 @@ static void atmel_ac97c_reset(struct atmel_ac97c
*chip)
>  		/* AC97 v2.2 specifications says minimum 1 us. */
>  		udelay(2);
>  		gpio_set_value(chip->reset_pin, 1);
> +	} else {
> +		ac97c_writel(chip, MR, AC97C_MR_WRST | AC97C_MR_ENA);
> +		udelay(2);
> +		ac97c_writel(chip, MR, AC97C_MR_ENA);
>  	}
>  }
>  
-- 
Nicolas Ferre
