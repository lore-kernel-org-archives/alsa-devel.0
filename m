From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8741: Remove unneeded startup()
 callback
Date: Mon, 30 Jan 2017 09:22:59 +0000
Message-ID: <20170130092259.GE1754@localhost.localdomain>
References: <1485560145-12908-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C81026681D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 10:22:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1485560145-12908-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 28, 2017 at 12:35:45AM +0100, Sergej Sawazki wrote:
> Do not apply rate constraints in the startup() callback. The machine driver
> can change the sysclk and hence the supported frame rates in its hw_params().
> This callback is unneeded since commit e369bd006fd6 ("ASoC: wm8741: Allow
> master clock switching").
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---
>  sound/soc/codecs/wm8741.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index b8c1940..d6e540a 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -176,20 +176,6 @@ static const struct snd_pcm_hw_constraint_list constraints_36864 = {
>  	.list	= rates_36864,
>  };
>  
> -static int wm8741_startup(struct snd_pcm_substream *substream,
> -			  struct snd_soc_dai *dai)
> -{
> -	struct snd_soc_codec *codec = dai->codec;
> -	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
> -
> -	if (wm8741->sysclk)
> -		snd_pcm_hw_constraint_list(substream->runtime, 0,
> -				SNDRV_PCM_HW_PARAM_RATE,
> -				wm8741->sysclk_constraints);
> -
> -	return 0;
> -}
> -

This function should not be removed it is performing a useful
function. If a sysclk has already been configured by the machine
driver then we should inform user-space of the rates we can
support from that clock. Without this that information is not
available to user-space, so instead of user-space being able to
resample appropriately it would just error out from hw_params.

Are you perhaps missing a call to clear the sysclk from your
machine driver? Usually a dai_set_sysclk call with a rate of
zero, also I find if it is a machine driver supporting multiple
rates you are best to use ignore_pmdown_time on the DAI link,
assuming the devices don't have long bring up times.

Thanks,
Charles
