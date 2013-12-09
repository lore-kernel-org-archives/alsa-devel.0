From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [Patch v2 2/2] ASoC: atmel: sam9x5_wm8731: remove platform_set_drvdata
Date: Mon, 9 Dec 2013 11:20:05 +0100
Message-ID: <52A59955.8000100@atmel.com>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com> <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: plagnioj@jcrosoft.com, richard.genoud@gmail.com, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 27/11/2013 11:05, Bo Shen :
> When call snd_soc_register_card, it will set driver data to this
> device through dev_set_drvdata, then in driver, no need to call
> platform_set_drvdata again, so remove it.
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> Change in v2:
>    - NONE

Hi Mark,

It seems that this patch has not been applied to your "next" branch (aka 
ping)...

BTW, it seems that we also collected this tag:
Tested-by: Richard Genoud <richard.genoud@gmail.com>

Bye,

> ---
>   sound/soc/atmel/sam9x5_wm8731.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 1b37228..ce9cd29 100644
> --- a/sound/soc/atmel/sam9x5_wm8731.c
> +++ b/sound/soc/atmel/sam9x5_wm8731.c
> @@ -155,8 +155,6 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>   	of_node_put(codec_np);
>   	of_node_put(cpu_np);
>
> -	platform_set_drvdata(pdev, card);
> -
>   	ret = snd_soc_register_card(card);
>   	if (ret) {
>   		dev_err(&pdev->dev,
>


-- 
Nicolas Ferre
