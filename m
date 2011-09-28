From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix setting adau1373_dai->master for
	SND_SOC_DAIFMT_CBS_CFS
Date: Wed, 28 Sep 2011 09:22:09 +0200
Message-ID: <4E82CB21.5060401@metafoo.de>
References: <1317194096.2498.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-141.synserver.de (smtp-out-142.synserver.de
	[212.40.185.142])
	by alsa0.perex.cz (Postfix) with SMTP id B9B19103884
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 09:22:35 +0200 (CEST)
In-Reply-To: <1317194096.2498.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/28/2011 09:14 AM, Axel Lin wrote:
> In the case of SND_SOC_DAIFMT_CBS_CFS, adau1373_dai->master should be false.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  sound/soc/codecs/adau1373.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
> index 2aa40c3..1ccf8dd 100644
> --- a/sound/soc/codecs/adau1373.c
> +++ b/sound/soc/codecs/adau1373.c
> @@ -974,7 +974,7 @@ static int adau1373_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		ctrl = 0;
> -		adau1373_dai->master = true;
> +		adau1373_dai->master = false;
>  		break;
>  	default:
>  		return -EINVAL;
