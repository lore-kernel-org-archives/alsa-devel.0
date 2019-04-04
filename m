From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH][next] ASoC: sprd: Fix spelling mistake "faied" ->
 "failed"
Date: Thu, 4 Apr 2019 13:30:21 +0530
Message-ID: <c2339d07-4b8b-070c-6741-0bd2a9b34aeb@codeaurora.org>
References: <20190404075603.11680-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404075603.11680-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 4/4/2019 1:26 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two identical spelling mistakes in dev_err messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   sound/soc/sprd/sprd-pcm-compress.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
> index dc84257cffc2..e008525a6cb3 100644
> --- a/sound/soc/sprd/sprd-pcm-compress.c
> +++ b/sound/soc/sprd/sprd-pcm-compress.c
> @@ -282,13 +282,13 @@ static int sprd_platform_compr_set_params(struct snd_compr_stream *cstream,
>   	 */
>   	ret = sprd_platform_compr_dma_config(cstream, params, 1);
>   	if (ret) {
> -		dev_err(dev, "faied to config stage 1 DMA: %d\n", ret);
> +		dev_err(dev, "failed to config stage 1 DMA: %d\n", ret);
>   		return ret;
>   	}
>   
>   	ret = sprd_platform_compr_dma_config(cstream, params, 0);
>   	if (ret) {
> -		dev_err(dev, "faied to config stage 0 DMA: %d\n", ret);
> +		dev_err(dev, "failed to config stage 0 DMA: %d\n", ret);
>   		goto config_err;
>   	}
>   
