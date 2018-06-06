From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: apq8096: set card as device drvdata
Date: Wed, 6 Jun 2018 10:16:51 +0100
Message-ID: <27a8b03f-a276-e3fd-7921-1fde47284237@linaro.org>
References: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/06/18 09:55, Rohit kumar wrote:
> snd_soc_card is retrieved as device drvdata during unbind().
> Set it as drvdata during bind() to avoid memory corruption during
> unbind().
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Thanks for the patch,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/qcom/apq8096.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
> index 561cd42..239b8cb 100644
> --- a/sound/soc/qcom/apq8096.c
> +++ b/sound/soc/qcom/apq8096.c
> @@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
>   
>   	component_bind_all(dev, card);
>   	card->dev = dev;
> +	dev_set_drvdata(dev, card);
>   	ret = apq8096_sbc_parse_of(card);
>   	if (ret) {
>   		dev_err(dev, "Error parsing OF data\n");
> 
