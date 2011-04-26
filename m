From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Don't warn if the WM8962 SYSCLK FLL
 setting doesn't match reality
Date: Tue, 26 Apr 2011 09:27:24 +0100
Message-ID: <1303806444.3332.18.camel@odin>
References: <1303752505-21675-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E35310385A
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 10:27:27 +0200 (CEST)
Received: by wyg36 with SMTP id 36so284103wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 01:27:26 -0700 (PDT)
In-Reply-To: <1303752505-21675-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-25 at 18:28 +0100, Mark Brown wrote:
> When bringing up audio low power modes boards may configure SYSCLK before
> they actually start the FLL as we do much of the clocking setup prior to
> the power up sequence.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index d6b78b2..7d6ace3 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2991,7 +2991,6 @@ static int wm8962_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  	case WM8962_SYSCLK_FLL:
>  		wm8962->sysclk = WM8962_SYSCLK_FLL;
>  		src = 1 << WM8962_SYSCLK_SRC_SHIFT;
> -		WARN_ON(freq != wm8962->fll_fout);
>  		break;
>  	default:
>  		return -EINVAL;

Acked-by: Liam Girdwood <lrg@ti.com>
