From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] extcon: arizona: Clear trig_sts bits on all paths
Date: Tue, 13 Aug 2013 19:05:56 +0900
Message-ID: <520A0504.6060203@samsung.com>
References: <1375874234-30549-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1375874234-30549-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Charles,

On 08/07/2013 08:17 PM, Charles Keepax wrote:
> We want the trig_sts bits to be cleared in all cases where we consider
> the jack detection interrupt to have been handled. Specifically, if a
> duplicate detection event was suppressed these bits were not cleared
> causing the CODEC to not enter a low power state. This patch clears the
> bits on the duplicate detection code path.
> 
> Reported-by: Ryo Tsutsui <ryo.tsutsui@wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/extcon/extcon-arizona.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 7a1b4a7..4df68de 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1034,6 +1034,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
>  	else
>  		info->micd_timeout = DEFAULT_MICD_TIMEOUT;
>  
> +out:
>  	/* Clear trig_sts to make sure DCVDD is not forced up */
>  	regmap_write(arizona->regmap, ARIZONA_AOD_WKUP_AND_TRIG,
>  		     ARIZONA_MICD_CLAMP_FALL_TRIG_STS |
> @@ -1041,7 +1042,6 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
>  		     ARIZONA_JD1_FALL_TRIG_STS |
>  		     ARIZONA_JD1_RISE_TRIG_STS);
>  
> -out:
>  	mutex_unlock(&info->lock);
>  
>  	pm_runtime_mark_last_busy(info->dev);
> 

Applied it.

Thanks.
Chanwoo Choi
