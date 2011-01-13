From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin AC97: fix build error after
 multi-component update
Date: Thu, 13 Jan 2011 13:54:58 +0000
Message-ID: <20110113135458.GB11840@opensource.wolfsonmicro.com>
References: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CA0710385E
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:54:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 07:57:33PM -0500, Mike Frysinger wrote:
> We need to tweak how we query the active capture/playback state after
> the recent overhauls of common code.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Ccing in Liam - Mike, please remember to CC maintainers on patches.

> ---
>  sound/soc/blackfin/bf5xx-ac97.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
> index c5f856e..ffbac26 100644
> --- a/sound/soc/blackfin/bf5xx-ac97.c
> +++ b/sound/soc/blackfin/bf5xx-ac97.c
> @@ -260,9 +260,9 @@ static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
>  	pr_debug("%s : sport %d\n", __func__, dai->id);
>  	if (!dai->active)
>  		return 0;
> -	if (dai->capture.active)
> +	if (dai->capture_active)
>  		sport_rx_stop(sport);
> -	if (dai->playback.active)
> +	if (dai->playback_active)
>  		sport_tx_stop(sport);
>  	return 0;
>  }
> -- 
> 1.7.4.rc1
> 
