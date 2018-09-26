From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v4 11/14] ASoC: wcd9335: add mbhc support
Date: Wed, 26 Sep 2018 02:31:59 -0700
Message-ID: <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 9/16/2018 5:57 PM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/codecs/wcd9335.c | 268 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 266 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index efbb698..6c95cff 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c

> @@ -89,12 +90,18 @@
>   #define  CF_MIN_3DB_75HZ		0x1
>   #define  CF_MIN_3DB_150HZ		0x2
>   
> +#define WCD9335_MBHC_MAX_BUTTONS	(8)
Though MBHC HW supports button detection up to 8, we are only supporting 
4 buttons in SW, right ?

> +
>   #define WCD9335_SLIM_RX_CH(p) \
>   	{.port = p + WCD9335_RX_START, .shift = p,}
>   
>   #define WCD9335_SLIM_TX_CH(p) \
>   	{.port = p, .shift = p,}

> @@ -3988,6 +4003,131 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
>   	return ret;
>   }
>   
> +static irqreturn_t wcd9335_mbhc_sw_irq(int irq, void *data)
Are we supporting only headset and headphone detection for now ? 
Extension cable and electrical detection will be supported later ?
And how about cases for slow insertion scenarios ?

> +{
> +	struct wcd9335_codec *wcd = data;
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
