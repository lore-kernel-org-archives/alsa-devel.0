From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: max98357a: Make 'sdmode-gpios'
 dts property optional
Date: Sun, 12 Jul 2015 12:31:01 +0200
Message-ID: <55A241E5.1030807@metafoo.de>
References: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-235.synserver.de
 [212.40.185.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 8044D2606FB
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 12:31:06 +0200 (CEST)
In-Reply-To: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, alsa-devel@alsa-project.org
Cc: kwestfie@codeaurora.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/12/2015 08:56 AM, Anatol Pomozov wrote:
[...]
> @@ -61,7 +64,7 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
>   	struct gpio_desc *sdmode;
>
>   	sdmode = devm_gpiod_get(codec->dev, "sdmode", GPIOD_OUT_LOW);
> -	if (IS_ERR(sdmode)) {
> +	if (IS_ERR(sdmode) && (PTR_ERR(sdmode) != -ENOENT)) {

There is is devm_gpiod_get_optional() exactly for this use case. It will 
return NULL if no GPIO is specified.

>   		dev_err(codec->dev, "%s() unable to get sdmode GPIO: %ld\n",
>   				__func__, PTR_ERR(sdmode));
>   		return PTR_ERR(sdmode);
>
