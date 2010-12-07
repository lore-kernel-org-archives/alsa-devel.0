From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8580: Debug BCLK and sample size
Date: Tue, 07 Dec 2010 12:48:32 +0000
Message-ID: <1291726112.3275.23.camel@odin>
References: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 72782103A20
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 13:48:39 +0100 (CET)
Received: by ewy1 with SMTP id 1so7435534ewy.29
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 04:48:39 -0800 (PST)
In-Reply-To: <1291717387-11961-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: sbkim73@samsung.com, kgene.kim@samsung.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-07 at 19:23 +0900, Jassi Brar wrote:
> In case of SNDRV_PCM_FORMAT_S32_LE, we need to set WM8580_AIF_LENGTH_32,
> rather than WM8580_AIF_LENGTH_24.
> Also, the BCLK has to be 64fs, for sample size of 20, 24 and 32 bits.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  sound/soc/codecs/wm8580.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
> index cb7765f..45efc94 100644
> --- a/sound/soc/codecs/wm8580.c
> +++ b/sound/soc/codecs/wm8580.c
> @@ -491,16 +491,16 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
>  		paifa |= 0x8;
>  		break;
>  	case SNDRV_PCM_FORMAT_S20_3LE:
> -		paifa |= 0x10;
> +		paifa |= 0x0;

Any reason why we are OR ing paifa with 0 ?

>  		paifb |= WM8580_AIF_LENGTH_20;
>  		break;
>  	case SNDRV_PCM_FORMAT_S24_LE:
> -		paifa |= 0x10;
> +		paifa |= 0x0;
>  		paifb |= WM8580_AIF_LENGTH_24;
>  		break;
>  	case SNDRV_PCM_FORMAT_S32_LE:
> -		paifa |= 0x10;
> -		paifb |= WM8580_AIF_LENGTH_24;
> +		paifa |= 0x0;
> +		paifb |= WM8580_AIF_LENGTH_32;
>  		break;
>  	default:
>  		return -EINVAL;

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
