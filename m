From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 08/12] ASoC: qcom: Remove useless function
 call
Date: Mon, 21 Aug 2017 01:08:16 -0700
Message-ID: <20170821080816.GA8000@codeaurora.org>
References: <1503207837-16310-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503207837-16310-1-git-send-email-dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 20, 2017 at 01:43:57PM +0800, Peng Donglin wrote:
> The function platform_set_drvdata(pdev, data) copies the value of
> the variable data to pdev->dev.driver_data,but when calling
> snd_soc_register_card,the function dev_set_drvdata(card->dev, card)
> will override it, so i think that the former copy operation is
> useless and can be removed.
> 
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>

Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

> ---
>  sound/soc/qcom/apq8016_sbc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index d084d74..5292591 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -191,7 +191,6 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->spkr_iomux))
>  		return PTR_ERR(data->spkr_iomux);
>  
> -	platform_set_drvdata(pdev, data);
>  	snd_soc_card_set_drvdata(card, data);
>  
>  	return devm_snd_soc_register_card(&pdev->dev, card);
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
