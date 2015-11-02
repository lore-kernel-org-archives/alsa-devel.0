From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7219: Use logical instead of
 bitwise OR for boolean expression
Date: Mon, 2 Nov 2015 11:14:44 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460BEEC@SW-EX-MBX01.diasemi.com>
References: <1445668113.26836.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id AE7292607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 12:14:47 +0100 (CET)
In-Reply-To: <1445668113.26836.0.camel@ingics.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On October 24, 2015 07:29, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/da7219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index abba4b3..86c528a 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1306,7 +1306,7 @@ static int da7219_hw_params(struct snd_pcm_substream
> *substream,
>  	}
> 
>  	channels = params_channels(params);
> -	if ((channels < 1) | (channels > DA7219_DAI_CH_NUM_MAX)) {
> +	if ((channels < 1) || (channels > DA7219_DAI_CH_NUM_MAX)) {
>  		dev_err(codec->dev,
>  			"Invalid number of channels, only 1 to %d supported\n",
>  			DA7219_DAI_CH_NUM_MAX);
> --
> 2.1.4

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
