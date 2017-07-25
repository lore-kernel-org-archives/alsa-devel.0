From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] ASoC: codecs: msm8916-analog: fix
 DIG_CLK_CTL_RXD3_CLK_EN define
Date: Tue, 25 Jul 2017 20:27:28 +0100
Message-ID: <f1a39cca-171c-99a7-e596-54919622f185@linaro.org>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
 <20170725175126.26578-2-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id C1682266CD2
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 21:27:31 +0200 (CEST)
Received: by mail-wr0-f176.google.com with SMTP id 33so66546186wrz.4
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 12:27:31 -0700 (PDT)
In-Reply-To: <20170725175126.26578-2-damien.riegel@savoirfairelinux.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org



On 25/07/17 18:51, Damien Riegel wrote:
> The wrong bit is assigned to DIG_CLK_CTL_RXD3_CLK_EN, change it for the
> correct one.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>   sound/soc/codecs/msm8916-wcd-analog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index aec1e1626993..0c351700044a 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -36,7 +36,7 @@
>   #define CDC_D_CDC_DIG_CLK_CTL		(0xf04A)
>   #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
>   #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
> -#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(3)
> +#define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
>   #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
>   #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
>   #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
> 

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
