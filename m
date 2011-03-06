From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] ASoC: Improve EP93xx I2S clocks management.
Date: Mon, 07 Mar 2011 11:02:56 +1300
Message-ID: <4D740490.8060200@bluewatersys.com>
References: <1299286635.27359.106.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 81EB12414C
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2011 23:03:04 +0100 (CET)
In-Reply-To: <1299286635.27359.106.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/05/2011 01:57 PM, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Improve EP93xx I2S clocks management.
> Some freqs values are set not exact as they requested for MCLK and
> original code was not able to find divisors for SCLK and LRCLK.
> This code just picks up nearest value from 3 possible variants.
> This patch makes 44100 and 192000 rates working and fixes
> capture function.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---
>  sound/soc/ep93xx/ep93xx-i2s.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
> index 0458dd4..3d4c086 100644
> --- a/sound/soc/ep93xx/ep93xx-i2s.c
> +++ b/sound/soc/ep93xx/ep93xx-i2s.c
> @@ -242,7 +242,7 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
>  	unsigned word_len, div, sdiv, lrdiv;
> -	int found = 0, err;
> +	int err;
>  
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> @@ -275,15 +275,14 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
>  	 * the codec uses.
>  	 */
>  	div = clk_get_rate(info->mclk) / params_rate(params);
> -	for (sdiv = 2; sdiv <= 4; sdiv += 2)
> -		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1)
> -			if (sdiv * lrdiv == div) {
> -				found = 1;
> -				goto out;
> -			}
> -out:
> -	if (!found)
> -		return -EINVAL;
> +	sdiv = 4;
> +	if (div > (256 + 512) / 2) {
> +		lrdiv = 128;
> +	} else {
> +		lrdiv = 64;
> +		if (div < (128 + 256) / 2)
> +			sdiv = 2;
> +	}

I don't understand where the magic numbers above come from? Does it work
correctly for all rates? I think a comment is needed to explain how this
works.

An alternative would be to keep the existing loop form, but try and find
the closest match rather than an exact match. Something like this
(untested):

	unsigned long diff, lowest_diff = ULONG_MAX;

	/* Find the closest match for sdiv/lrdiv */
	best_sdiv  = 2;
	best_lrdiv = 64;
	for (sdiv = 2; sdiv <= 4; sdiv += 2) {
		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1) {
			diff = abs(div - (sdiv * lrdiv));
			if (diff < lowest_diff) {
				lowest_diff = diff;
				best_sdiv   = sdiv;
				best_lrdiv  = lrdiv;
			}
		}
	}

	sdiv  = best_sdiv;
	lrdiv = best_lrdiv;

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
