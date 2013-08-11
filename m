From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH 1/2] ASoC: cs4271: Convert to table based
	control init
Date: Sun, 11 Aug 2013 14:33:52 +0200
Message-ID: <1376224432.11976.0.camel@r60e>
References: <1376223377-23047-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward2l.mail.yandex.net (forward2l.mail.yandex.net
 [84.201.143.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F34264F42
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 14:33:57 +0200 (CEST)
In-Reply-To: <1376223377-23047-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello!

On Sun, 2013-08-11 at 13:16 +0100, Mark Brown wrote: 
> From: Mark Brown <broonie@linaro.org>
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

> ---
>  sound/soc/codecs/cs4271.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 03036b3..65ad56c 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -576,8 +576,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
>  				   CS4271_MODE2_MUTECAEQUB,
>  				   CS4271_MODE2_MUTECAEQUB);
>  
> -	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
> -		ARRAY_SIZE(cs4271_snd_controls));
> +	return 0;
>  }
>  
>  static int cs4271_remove(struct snd_soc_codec *codec)
> @@ -596,6 +595,9 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
>  	.remove			= cs4271_remove,
>  	.suspend		= cs4271_soc_suspend,
>  	.resume			= cs4271_soc_resume,
> +
> +	.controls		= cs4271_snd_controls,
> +	.num_controls		= ARRAY_SIZE(cs4271_snd_controls),
>  };
>  
>  #if defined(CONFIG_SPI_MASTER)
