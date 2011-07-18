From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Mark cache as dirty when suspending
Date: Mon, 18 Jul 2011 13:39:04 +0100
Message-ID: <4E242968.8040603@ti.com>
References: <1310963139-32251-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 03CED10380F
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 14:39:07 +0200 (CEST)
In-Reply-To: <1310963139-32251-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 18/07/11 05:25, Mark Brown wrote:
> Since quite a few drivers are not managing to flag the cache as needing
> to be resynced after suspend and it's a reasonable thing to do flag the
> cache as needing sync automatically when suspending.
> 
> The expectation is that systems will mainly only keep the CODEC powered
> when doing audio through the CODEC so we won't actually suspend the
> device anyway; drivers which want to can override this behaviour when
> they resume.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e44267f..93109a4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -577,6 +577,7 @@ int snd_soc_suspend(struct device *dev)
>  			case SND_SOC_BIAS_OFF:
>  				codec->driver->suspend(codec, PMSG_SUSPEND);
>  				codec->suspended = 1;
> +				codec->cache_sync = 1;
>  				break;
>  			default:
>  				dev_dbg(codec->dev, "CODEC is on over suspend\n");

Acked-by: Liam Girdwood <lrg@ti.com>
