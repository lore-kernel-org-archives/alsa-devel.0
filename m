From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH -next] ASoC: qdsp6: q6asm-dai: remove duplicated include
 from q6asm-dai.c
Date: Fri, 14 Sep 2018 09:34:04 +0100
Message-ID: <b3aaddd8-0aa6-d1b3-75e7-a08930471e0c@linaro.org>
References: <1536888964-55681-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536888964-55681-1-git-send-email-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Niklas Cassel <niklas.cassel@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 14/09/18 02:36, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
		
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index c75fab3..c3806d7 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -8,7 +8,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <sound/soc.h>
> -#include <sound/soc.h>
>   #include <sound/soc-dapm.h>
>   #include <sound/pcm.h>
>   #include <asm/dma.h>
> 
> 
> 
