From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 6/8] ASoC: atmel: support CCF based clks
Date: Mon, 17 Mar 2014 17:55:54 +0800
Message-ID: <5326C6AA.7030200@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
 <1395049541-28128-7-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F19260799
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 10:56:23 +0100 (CET)
In-Reply-To: <1395049541-28128-7-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, nicolas.ferre@atmel.com
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Boris BREZILLON <b.brezillon@overkiz.com>
List-Id: alsa-devel@alsa-project.org

On 03/17/2014 05:45 PM, Bo Shen wrote:
> From: Boris BREZILLON <b.brezillon@overkiz.com>
>
> Provide dev to clk_get function if we're using CCF based clks.
> CCF based prog clks support automatic parent selection when asking for a
> specific rate: remove the clk32k clk retrieval if we're using these clks.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> [voice.shen@atmel.com: switch to devm manage function]
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Oh, sorry for multi SOBs. Please remove it when apply.

> ---
>
>   sound/soc/atmel/atmel_wm8904.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
> index b4e3690..a797d33 100644
> --- a/sound/soc/atmel/atmel_wm8904.c
> +++ b/sound/soc/atmel/atmel_wm8904.c
> @@ -170,25 +170,26 @@ static int atmel_asoc_wm8904_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	mclk = clk_get(NULL, "pck0");
> +	mclk = devm_clk_get(&pdev->dev, "pck0");
>   	if (IS_ERR(mclk)) {
>   		dev_err(&pdev->dev, "failed to get pck0\n");
>   		ret = PTR_ERR(mclk);
>   		goto err_set_audio;
>   	}
>
> -	clk_src = clk_get(NULL, "clk32k");
> -	if (IS_ERR(clk_src)) {
> -		dev_err(&pdev->dev, "failed to get clk32k\n");
> -		ret = PTR_ERR(clk_src);
> -		goto err_set_audio;
> -	}
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK)) {
> +		clk_src = devm_clk_get(&pdev->dev, "clk32k");
> +		if (IS_ERR(clk_src)) {
> +			dev_err(&pdev->dev, "failed to get clk32k\n");
> +			ret = PTR_ERR(clk_src);
> +			goto err_set_audio;
> +		}
>
> -	ret = clk_set_parent(mclk, clk_src);
> -	clk_put(clk_src);
> -	if (ret != 0) {
> -		dev_err(&pdev->dev, "failed to set MCLK parent\n");
> -		goto err_set_audio;
> +		ret = clk_set_parent(mclk, clk_src);
> +		if (ret != 0) {
> +			dev_err(&pdev->dev, "failed to set MCLK parent\n");
> +			goto err_set_audio;
> +		}
>   	}
>
>   	dev_info(&pdev->dev, "setting pck0 to %dHz\n", MCLK_RATE);
>

Best Regards,
Bo Shen
