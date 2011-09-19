From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: sn95031: Staticize
	sn95031_pcm_hw_params
Date: Mon, 19 Sep 2011 14:05:20 +0530
Message-ID: <1316421320.26662.5.camel@vkoul-udesk3>
References: <1316421268.23109.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DCCEF2495E
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 10:39:20 +0200 (CEST)
In-Reply-To: <1316421268.23109.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <harshapriya@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-09-19 at 16:34 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/sn95031.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
> index b4f1cb4..29945b0 100644
> --- a/sound/soc/codecs/sn95031.c
> +++ b/sound/soc/codecs/sn95031.c
> @@ -658,7 +658,7 @@ static int sn95031_pcm_spkr_mute(struct snd_soc_dai *dai, int mute)
>  	return 0;
>  }
>  
> -int sn95031_pcm_hw_params(struct snd_pcm_substream *substream,
> +static int sn95031_pcm_hw_params(struct snd_pcm_substream *substream,
>  		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>  {
>  	unsigned int format, rate;

Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
