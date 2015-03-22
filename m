From: Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH] ASoC:pcm512x: Fix divide by zero issue.
Date: Sun, 22 Mar 2015 21:16:10 +0000
Message-ID: <d68a8abc921f45619e077d52d444a7f7@EMAIL.axentia.se>
References: <1426886025-10731-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426886025-10731-1-git-send-email-hm@hmbedded.co.uk>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Mitchell <hm@hmbedded.co.uk>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "corbet@lwn.net" <corbet@lwn.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Howard Mitchell wrote;
> If den=1 and pllin_rate>20MHz then den and num are adjusted to 0
> causing a divide by zero error a few lines further on. Therefore
> this patch correctly scales num and den such that
> pllin_rate/den < 20MHz as required in the device data sheet.

Yep, the old code is plain broken and never actually ran, we have been
using 16MHz pllin_rate, and I apparently never hit this code path.

> Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> ---
>  sound/soc/codecs/pcm512x.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
> index 5301c4a..8472099 100644
> --- a/sound/soc/codecs/pcm512x.c
> +++ b/sound/soc/codecs/pcm512x.c
> @@ -713,8 +713,8 @@ static int pcm512x_find_pll_coeff(struct snd_soc_dai
> *dai,
> 
>  	/* pllin_rate / P (or here, den) cannot be greater than 20 MHz */
>  	if (pllin_rate / den > 20000000 && num < 8) {
> -		num *= 20000000 / (pllin_rate / den);
> -		den *= 20000000 / (pllin_rate / den);
> +		num *= DIV_ROUND_UP(pllin_rate / den, 20000000);
> +		den *= DIV_ROUND_UP(pllin_rate / den, 20000000);
>  	}
>  	dev_dbg(dev, "num / den = %lu / %lu\n", num, den);
> 
> --
> 1.7.9.5
