From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: ak4642: fixup snd_soc_update_bits
 mask	for PW_MGMT2
Date: Thu, 7 Jul 2011 10:20:38 +0100
Message-ID: <4E157A66.8040208@ti.com>
References: <87liwadhyr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E966324460
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jul 2011 11:20:41 +0200 (CEST)
In-Reply-To: <87liwadhyr.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 07/07/11 01:58, Kuninori Morimoto wrote:
> mask didn't cover update-data
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch based on asoc/for-3.1
> 
>  sound/soc/codecs/ak4642.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
> index 4be0570..65f4604 100644
> --- a/sound/soc/codecs/ak4642.c
> +++ b/sound/soc/codecs/ak4642.c
> @@ -357,7 +357,7 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	default:
>  		return -EINVAL;
>  	}
> -	snd_soc_update_bits(codec, PW_MGMT2, MS, data);
> +	snd_soc_update_bits(codec, PW_MGMT2, MS | MCKO | PMPLL, data);
>  	snd_soc_update_bits(codec, MD_CTL1, BCKO_MASK, bcko);
>  
>  	/* format type */

Acked-by: Liam Girdwood <lrg@ti.com>
