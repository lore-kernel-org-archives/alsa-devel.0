From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: da7213: Default to 64 BCLKs per
 WCLK to support all formats
Date: Mon, 8 Aug 2016 09:52:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1608080952110.17128@pmeerw.net>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com> <a8c37924c9193e760f7488370cb80cb616696c12.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a8c37924c9193e760f7488370cb80cb616696c12.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> Previously code defaulted to 32 BCLKS per WCLK which meant 24 and
> 32 bit DAI formats would not work properly. This patch fixes the
> issue by defaulting to 64 BCLKs per WCLK.

Tested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  sound/soc/codecs/da7213.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index e5527bc..bcf1834 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1247,8 +1247,8 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
>  		return -EINVAL;
>  	}
>  
> -	/* By default only 32 BCLK per WCLK is supported */
> -	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_32;
> +	/* By default only 64 BCLK per WCLK is supported */
> +	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
>  
>  	snd_soc_write(codec, DA7213_DAI_CLK_MODE, dai_clk_mode);
>  	snd_soc_update_bits(codec, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
