From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Ensure we only run Speyside WM8962
 bias level callbacks once
Date: Mon, 22 Aug 2011 11:23:23 +0100
Message-ID: <4E522E1B.4050907@ti.com>
References: <1313925642-7555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BA64A24525
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:23:32 +0200 (CEST)
In-Reply-To: <1313925642-7555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 21/08/11 12:20, Mark Brown wrote:
> We get called once per DAPM context but only need to run once. When DAPM
> was serialized this was a series of noops but now it can run in parallel
> we need to take proper care.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/speyside_wm8962.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
> index 753e1c2..3820a6b 100644
> --- a/sound/soc/samsung/speyside_wm8962.c
> +++ b/sound/soc/samsung/speyside_wm8962.c
> @@ -23,6 +23,9 @@ static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
>  	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
>  	int ret;
>  
> +	if (dapm->dev != codec_dai->dev)
> +		return 0;
> +
>  	switch (level) {
>  	case SND_SOC_BIAS_PREPARE:
>  		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
> @@ -57,6 +60,9 @@ static int speyside_wm8962_set_bias_level_post(struct snd_soc_card *card,
>  	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
>  	int ret;
>  
> +	if (dapm->dev != codec_dai->dev)
> +		return 0;
> +
>  	switch (level) {
>  	case SND_SOC_BIAS_STANDBY:
>  		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,

Acked-by: Liam Girdwood <lrg@ti.com>
