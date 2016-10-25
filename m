From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: core: add component_dev_list on
	Card
Date: Tue, 25 Oct 2016 11:38:19 +0200
Message-ID: <8aad617c-f913-1a81-6e95-3f2c88dc9964@metafoo.de>
References: <87vawhb5el.wl%kuninori.morimoto.gx@renesas.com>
 <87twc1b5d9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A05260083
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 11:38:27 +0200 (CEST)
In-Reply-To: <87twc1b5d9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/25/2016 03:20 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current Card has Codec list (= codec_dev_list), but Codec will be
> removed in the future. Because of this reason, this patch adds
> new Component list in Card.
> In the same time, current Card has AUX list (= aux_comp_list).
> This patch replaces it by Component list and new flag (= has_auxliary)
> too
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Looks mostly good, thanks.

> ---
>  include/sound/soc.h  |  7 ++++---
>  sound/soc/soc-core.c | 21 ++++++++++++++++-----
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 1ed9371..69f2ebf 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -807,9 +807,10 @@ struct snd_soc_component {
>  
>  	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
>  	unsigned int registered_as_component:1;
> +	unsigned int has_auxiliary:1; /* for auxiliary component of the card */

I'd name it just auxiliary. "has" is not really the right word here.

>  
>  	struct list_head list;
> -	struct list_head list_aux; /* for auxiliary component of the card */
> +	struct list_head card_list;
>  
>  	struct snd_soc_dai_driver *dai_drv;
>  	int num_dai;
