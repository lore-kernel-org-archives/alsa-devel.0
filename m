From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH 09/12] ASoC: qcom: Remove unnecessary
 function call
Date: Mon, 21 Aug 2017 01:09:49 -0700
Message-ID: <20170821080949.GB8000@codeaurora.org>
References: <1503207898-16378-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 23456266BCF
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:09:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1503207898-16378-1-git-send-email-dolinux.peng@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 20, 2017 at 01:44:58PM +0800, Peng Donglin wrote:
> First of all,the address of pdev->dev is assigned to card->dev,then
> the function platform_set_drvdata copies the value the variable card
> to pdev->dev.driver_data, but when calling snd_soc_register_card,the
> function dev_set_drvdata(card->dev, card) will also do the same copy
> operation,so i think that the former copy operation can be removed.
> 
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>

Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

> ---
>  sound/soc/qcom/storm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
> index c5207af..a9fa972 100644
> --- a/sound/soc/qcom/storm.c
> +++ b/sound/soc/qcom/storm.c
> @@ -99,7 +99,6 @@ static int storm_platform_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	card->dev = &pdev->dev;
> -	platform_set_drvdata(pdev, card);
>  
>  	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>  	if (ret) {
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
