From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: Set dai_link id to each dai_link
Date: Thu, 8 Nov 2018 13:56:35 +0000
Message-ID: <9eb276ed-5b4c-9926-a885-2cfd08d4d126@linaro.org>
References: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541684500-32728-1-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

Hi Rohit,

On 08/11/18 13:41, Rohit kumar wrote:
> Frontend dai_link id is used for closing ADM sessions.
> During concurrent usecase when one session is closed,
> it closes other ADM session associated with other usecase
> too. Dai_link->id should always point to Frontend dai id.
> Set cpu_dai id as dai_link id to fix the issue.
> 
Nice catch! thanks for fixing this!

> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/common.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index eb1b9da..4715527 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -13,6 +13,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   	struct device_node *cpu = NULL;
>   	struct device *dev = card->dev;
>   	struct snd_soc_dai_link *link;
> +	struct of_phandle_args args;
>   	int ret, num_links;
>   
>   	ret = snd_soc_of_parse_card_name(card, "model");
> @@ -47,12 +48,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   			goto err;
>   		}
>   
> -		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> -		if (!link->cpu_of_node) {
> +		ret = of_parse_phandle_with_args(cpu, "sound-dai",
> +					"#sound-dai-cells", 0, &args);
> +		if (ret) {
>   			dev_err(card->dev, "error getting cpu phandle\n");
> -			ret = -EINVAL;
>   			goto err;
>   		}
> +		link->cpu_of_node = args.np;
> +		link->id = args.args[0];
>   
>   		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
>   		if (ret) {
> 
