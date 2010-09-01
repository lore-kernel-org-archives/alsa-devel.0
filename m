From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Added a missing 32-bit PCM format,
 to the wm8994 codec.
Date: Wed, 01 Sep 2010 12:46:08 +0100
Message-ID: <1283341568.3081.147.camel@odin>
References: <1283295394.1831.12.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 407AA2453A
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 13:46:12 +0200 (CEST)
Received: by wyb32 with SMTP id 32so8907665wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 04:46:11 -0700 (PDT)
In-Reply-To: <1283295394.1831.12.camel@Tapajos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfson Patches <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-31 at 23:56 +0100, Ian Lartey wrote:
> Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index e03072c..23d9227 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3498,7 +3498,7 @@ static int wm8994_set_tristate(struct snd_soc_dai *codec_dai, int tristate)
>  #define WM8994_RATES SNDRV_PCM_RATE_8000_96000
>  
>  #define WM8994_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
> -			SNDRV_PCM_FMTBIT_S24_LE)
> +			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>  
>  static struct snd_soc_dai_ops wm8994_aif1_dai_ops = {
>  	.set_sysclk	= wm8994_set_dai_sysclk,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
