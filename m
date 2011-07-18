From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: make comments fit the code
Date: Mon, 18 Jul 2011 13:03:25 +0100
Message-ID: <4E24210D.3050308@ti.com>
References: <1310918426-24194-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 48BD22455F
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 14:03:32 +0200 (CEST)
In-Reply-To: <1310918426-24194-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 17/07/11 17:00, Wolfram Sang wrote:
> In one comment, cpu_dai was mentioned although codec_dai was used in the
> code. Also, fix the name for the card dai list which has no seperation
> into card_dai and codec_dai.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/soc-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d75043e..ba95444 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1631,7 +1631,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  			}
>  		}
>  		cpu_dai->probed = 1;
> -		/* mark cpu_dai as probed and add to card cpu_dai list */
> +		/* mark cpu_dai as probed and add to card dai list */
>  		list_add(&cpu_dai->card_list, &card->dai_dev_list);
>  	}
>  
> @@ -1672,7 +1672,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  			}
>  		}
>  
> -		/* mark cpu_dai as probed and add to card cpu_dai list */
> +		/* mark codec_dai as probed and add to card dai list */
>  		codec_dai->probed = 1;
>  		list_add(&codec_dai->card_list, &card->dai_dev_list);
>  	}
