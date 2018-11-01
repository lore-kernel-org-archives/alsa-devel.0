From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
Date: Thu, 1 Nov 2018 12:25:38 +0000
Message-ID: <9b8e6d31-a406-a0c6-fd6c-7e2b876e21ab@linaro.org>
References: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, niklas.cassel@linaro.org
List-Id: alsa-devel@alsa-project.org



On 01/11/18 11:51, Rohit kumar wrote:
> SD line mask for MI2S starts from BIT 0 instead of BIT 1.
> Fix all bit mask for MI2S SD lines.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 000775b..829b5e987 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -49,14 +49,14 @@
>   #define AFE_PORT_I2S_SD1		0x2
>   #define AFE_PORT_I2S_SD2		0x3
>   #define AFE_PORT_I2S_SD3		0x4
> -#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
> -#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
> -#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
> -#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
> -#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
> -#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
> -#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
> -#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
> +#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
> +#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
> +#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
> +#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
> +#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
> +#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
> +#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
> +#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
>   #define AFE_PORT_I2S_QUAD01		0x5
>   #define AFE_PORT_I2S_QUAD23		0x6
>   #define AFE_PORT_I2S_6CHS		0x7
> 
