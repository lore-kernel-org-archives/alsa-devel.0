From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Clear any outstanding WM8962 FLL
 lock completions before waiting
Date: Mon, 22 Aug 2011 11:38:43 +0100
Message-ID: <4E5231B3.3040806@ti.com>
References: <1313943559-13993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id DE41E24511
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:38:49 +0200 (CEST)
In-Reply-To: <1313943559-13993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.cm>
List-Id: alsa-devel@alsa-project.org

On 21/08/11 17:19, Mark Brown wrote:
> Ensure that we don't spuriously trigger early.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index c9e07aa..d2db512 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2356,6 +2356,8 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMU:
>  		if (fll) {
> +			try_wait_for_completion(&wm8962->fll_lock);
> +
>  			snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
>  					    WM8962_FLL_ENA, WM8962_FLL_ENA);
>  			if (wm8962->irq) {
> @@ -3456,6 +3458,8 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
>  	snd_soc_write(codec, WM8962_FLL_CONTROL_7, fll_div.lambda);
>  	snd_soc_write(codec, WM8962_FLL_CONTROL_8, fll_div.n);
>  
> +	try_wait_for_completion(&wm8962->fll_lock);
> +
>  	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
>  			    WM8962_FLL_FRAC | WM8962_FLL_REFCLK_SRC_MASK |
>  			    WM8962_FLL_ENA, fll1);


Acked-by: Liam Girdwood <lrg@ti.com>
