From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Update SMDKs for WM8580 -codec
	removal
Date: Tue, 9 Aug 2011 13:27:56 +0100
Message-ID: <4E4127CC.9070206@ti.com>
References: <1312361087-29466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 707221038EA
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:28:00 +0200 (CEST)
In-Reply-To: <1312361087-29466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 03/08/11 09:44, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/samsung/smdk_wm8580.c    |    6 +++---
>  sound/soc/samsung/smdk_wm8580pcm.c |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
> index 3d26f66..20deecf 100644
> --- a/sound/soc/samsung/smdk_wm8580.c
> +++ b/sound/soc/samsung/smdk_wm8580.c
> @@ -210,7 +210,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
>  		.cpu_dai_name = "samsung-i2s.0",
>  		.codec_dai_name = "wm8580-hifi-playback",
>  		.platform_name = "samsung-audio",
> -		.codec_name = "wm8580-codec.0-001b",
> +		.codec_name = "wm8580.0-001b",
>  		.init = smdk_wm8580_init_paifrx,
>  		.ops = &smdk_ops,
>  	},
> @@ -220,7 +220,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
>  		.cpu_dai_name = "samsung-i2s.0",
>  		.codec_dai_name = "wm8580-hifi-capture",
>  		.platform_name = "samsung-audio",
> -		.codec_name = "wm8580-codec.0-001b",
> +		.codec_name = "wm8580.0-001b",
>  		.init = smdk_wm8580_init_paiftx,
>  		.ops = &smdk_ops,
>  	},
> @@ -230,7 +230,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
>  		.cpu_dai_name = "samsung-i2s.x",
>  		.codec_dai_name = "wm8580-hifi-playback",
>  		.platform_name = "samsung-audio",
> -		.codec_name = "wm8580-codec.0-001b",
> +		.codec_name = "wm8580.0-001b",
>  		.init = smdk_wm8580_init_paifrx,
>  		.ops = &smdk_ops,
>  	},
> diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
> index 0d12092..4b9c734 100644
> --- a/sound/soc/samsung/smdk_wm8580pcm.c
> +++ b/sound/soc/samsung/smdk_wm8580pcm.c
> @@ -127,7 +127,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
>  		.cpu_dai_name = "samsung-pcm.0",
>  		.codec_dai_name = "wm8580-hifi-playback",
>  		.platform_name = "samsung-audio",
> -		.codec_name = "wm8580-codec.0-001b",
> +		.codec_name = "wm8580.0-001b",
>  		.ops = &smdk_wm8580_pcm_ops,
>  	}, {
>  		.name = "WM8580 PAIF PCM TX",
> @@ -135,7 +135,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
>  		.cpu_dai_name = "samsung-pcm.0",
>  		.codec_dai_name = "wm8580-hifi-capture",
>  		.platform_name = "samsung-audio",
> -		.codec_name = "wm8580-codec.0-001b",
> +		.codec_name = "wm8580.0-001b",
>  		.ops = &smdk_wm8580_pcm_ops,
>  	},
>  };
