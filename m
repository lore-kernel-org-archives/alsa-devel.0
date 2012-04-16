From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Return -ENOTSUPP instead of
 -EINVAL if mute is not supported
Date: Mon, 16 Apr 2012 16:00:33 +0100
Message-ID: <1334588433.2255.2.camel@odin>
References: <1334341345-19274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 2159E1041B6
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 17:00:37 +0200 (CEST)
Received: by wibhr17 with SMTP id hr17so7827517wib.3
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 08:00:35 -0700 (PDT)
In-Reply-To: <1334341345-19274-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-04-13 at 19:22 +0100, Mark Brown wrote:
> This helps us ignore errors in callers if the operation failed due to not
> being available as opposed to an error.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 1ff0161..b957e68 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3090,7 +3090,7 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
>  	if (dai->driver && dai->driver->ops->digital_mute)
>  		return dai->driver->ops->digital_mute(dai, mute);
>  	else
> -		return -EINVAL;
> +		return -ENOTSUPP;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
>  

Acked-by: Liam Girdwood <lrg@ti.com>
