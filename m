From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: cs53l30: Fix non static symbol
 warnings
Date: Fri, 17 Jun 2016 10:35:02 -0700
Message-ID: <20160617173501.GA21670@Asurada-Nvidia>
References: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: weiyj_lk@163.com
Cc: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2016 at 05:22:00PM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warnings:
> 
> sound/soc/codecs/cs53l30.c:182:20: warning:
>  symbol 'input1_sel_values' was not declared. Should it be static?
> sound/soc/codecs/cs53l30.c:202:20: warning:
>  symbol 'input2_sel_values' was not declared. Should it be static?
> sound/soc/codecs/cs53l30.c:734:20: warning:
>  symbol 'cs53l30_src_rates' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/codecs/cs53l30.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
> index 714e579..a9949ad 100644
> --- a/sound/soc/codecs/cs53l30.c
> +++ b/sound/soc/codecs/cs53l30.c
> @@ -179,7 +179,7 @@ static const char * const input1_sel_text[] = {
>  	"DMIC1 Off ADC1 Off",
>  };
>  
> -unsigned int const input1_sel_values[] = {
> +static unsigned int const input1_sel_values[] = {
>  	CS53L30_CH_TYPE,
>  	CS53L30_ADCxB_PDN | CS53L30_CH_TYPE,
>  	CS53L30_ADCxA_PDN | CS53L30_CH_TYPE,
> @@ -199,7 +199,7 @@ static const char * const input2_sel_text[] = {
>  	"DMIC2 Off ADC2 Off",
>  };
>  
> -unsigned int const input2_sel_values[] = {
> +static unsigned int const input2_sel_values[] = {
>  	0x0,
>  	CS53L30_ADCxB_PDN,
>  	CS53L30_ADCxA_PDN,
> @@ -731,7 +731,7 @@ static int cs53l30_set_tristate(struct snd_soc_dai *dai, int tristate)
>  				  CS53L30_ASP_3ST_MASK, val);
>  }
>  
> -unsigned int const cs53l30_src_rates[] = {
> +static unsigned int const cs53l30_src_rates[] = {
>  	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
>  };
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
