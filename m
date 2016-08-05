From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 4/4] ASoC: da7213: Improve 32KHz mode PLL
 locking
Date: Fri, 5 Aug 2016 11:04:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1608051102420.11835@pmeerw.net>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
 <497bb3724104ba16dc3588287f6071f0b7cce09e.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id AC2E1266730
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 11:04:54 +0200 (CEST)
In-Reply-To: <497bb3724104ba16dc3588287f6071f0b7cce09e.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, c.huber@bct-electronic.com
List-Id: alsa-devel@alsa-project.org


> To aid PLL in locking on to a 32KHz MCLK, some register mods
> are made during PLL configuration, and when enabling the DAI,
> to achieve the full range of sample rates.

thanks for the patch series; we are about to test...

some comments below
 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  sound/soc/codecs/da7213.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 79b8324..095fe40 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -750,11 +750,18 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
>  		snd_soc_update_bits(codec, DA7213_PC_COUNT,
>  				    DA7213_PC_FREERUN_MASK, 0);
> 
> -		/* Slave mode, if SRM not enabled no need for status checks */
> +		/* If SRM not enabled then nothing more to do */
>  		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
>  		if (!(pll_ctrl & DA7213_PLL_SRM_EN))
>  			return 0;
> 
> +		/* Assist 32KHz mode PLL lock */
> +		if (pll_ctrl & DA7213_PLL_32K_MODE) {

these registers cannot not found in the datasheet;
maybe add descriptive #defines in da7213.h

> +			snd_soc_write(codec, 0xF0, 0x8B);
> +			snd_soc_write(codec, 0xF2, 0x03);
> +			snd_soc_write(codec, 0xF0, 0x00);
> +		}
> +
>  		/* Check SRM has locked */
>  		do {
>  			pll_status = snd_soc_read(codec, DA7213_PLL_STATUS);
> @@ -771,6 +778,14 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
> 
>  		return 0;
>  	case SND_SOC_DAPM_POST_PMD:
> +		/* Revert 32KHz PLL lock udpates if applied previously */
> +		pll_ctrl = snd_soc_read(codec, DA7213_PLL_CTRL);
> +		if (pll_ctrl & DA7213_PLL_32K_MODE) {
> +			snd_soc_write(codec, 0xF0, 0x8B);
> +			snd_soc_write(codec, 0xF2, 0x01);
> +			snd_soc_write(codec, 0xF0, 0x00);
> +		}
> +
>  		/* PC free-running */
>  		snd_soc_update_bits(codec, DA7213_PC_COUNT,
>  				    DA7213_PC_FREERUN_MASK,
> @@ -1428,6 +1443,14 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
>  			    DA7213_PLL_INDIV_MASK | DA7213_PLL_MODE_MASK,
>  			    pll_ctrl);
> 
> +	/* Assist 32KHz mode PLL lock */
> +	if (source == DA7213_SYSCLK_PLL_32KHZ) {
> +		snd_soc_write(codec, 0xF0, 0x8B);
> +		snd_soc_write(codec, 0xF1, 0x03);
> +		snd_soc_write(codec, 0xF1, 0x01);
> +		snd_soc_write(codec, 0xF0, 0x00);
> +	}
> +
>  	return 0;
>  }

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
