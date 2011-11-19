From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] ASoC: cs4271: Fix wrong mask parameter in
 some snd_soc_update_bits calls
Date: Sat, 19 Nov 2011 08:59:15 +0100
Message-ID: <1321689555.5405.2.camel@r60e>
References: <1321684867.4103.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 30CB4103B4C
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 08:59:21 +0100 (CET)
In-Reply-To: <1321684867.4103.2.camel@phoenix>
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
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello!

According to changes in API, fix is correct.
Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

On Sat, 2011-11-19 at 14:41 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/cs4271.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 23d1bd5..69fde15 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -434,7 +434,8 @@ static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
>  {
>  	int ret;
>  	/* Set power-down bit */
> -	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0, CS4271_MODE2_PDN);
> +	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN,
> +				  CS4271_MODE2_PDN);
>  	if (ret < 0)
>  		return ret;
>  	return 0;
> @@ -501,8 +502,9 @@ static int cs4271_probe(struct snd_soc_codec *codec)
>  		return ret;
>  	}
>  
> -	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0,
> -		CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
> +	ret = snd_soc_update_bits(codec, CS4271_MODE2,
> +				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
> +				  CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
>  	if (ret < 0)
>  		return ret;
>  	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
