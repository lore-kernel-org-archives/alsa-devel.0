From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] ASoC: stm32: sai: remove set but not
 used variables 'mask, cr1'
Date: Mon, 18 Feb 2019 17:41:33 +0300
Message-ID: <20190218144133.GF17104@kadam>
References: <20190218134836.107220-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 84CC0265525
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 15:41:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190218134836.107220-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2019 at 01:48:36PM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
> sound/soc/stm/stm32_sai_sub.c:902:11: warning:
>  variable 'mask' set but not used [-Wunused-but-set-variable]
> sound/soc/stm/stm32_sai_sub.c:902:6: warning:
>  variable 'cr1' set but not used [-Wunused-but-set-variable]
> 
> It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
> mclk clock provider")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index d4825700b63f..a00640f1df06 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  				     struct snd_pcm_hw_params *params)
>  {
>  	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
> -	int cr1, mask, div = 0;
> +	int div = 0;
>  	int sai_clk_rate, mclk_ratio, den;
>  	unsigned int rate = params_rate(params);
>  
> @@ -944,8 +944,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  			if (sai->mclk_rate) {
>  				mclk_ratio = sai->mclk_rate / rate;
>  				if (mclk_ratio == 512) {
> -					mask = SAI_XCR1_OSR;
> -					cr1 = SAI_XCR1_OSR;
> +					;
>  				} else if (mclk_ratio != 256) {


Please, no...

				if (mclk_ratio != 512 && mclk_ratio != 256) {
					dev_err(...

regards,
dan carpenter
