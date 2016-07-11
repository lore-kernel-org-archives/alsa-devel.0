From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [alsa-devel] [PATCH -next v2] ASoC: mediatek: mt2701: fix non
 static symbol warning
Date: Mon, 11 Jul 2016 09:31:25 +0800
Message-ID: <1468200685.32731.1.camel@mtksdaap41>
References: <1467985293-9041-1-git-send-email-weiyj_lk@163.com>
	 <1467985621-13755-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467985621-13755-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: weiyj_lk@163.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2016-07-08 at 13:47 +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warning:
> 
> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:72:5: warning:
>  symbol 'mt2701_dai_num_to_i2s' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Garlic Tseng <garlic.tseng@mediatek.com>

> ---
>  sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> index 15522c0..34a6123 100644
> --- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> +++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> @@ -69,7 +69,7 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
>  	{ .rate = 352800, .regvalue = 24 },
>  };
>  
> -int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
> +static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
>  {
>  	int val = num - MT2701_IO_I2S;
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
