From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 1/2] ASoC: codec: wm8960: Refactor
	sysclk freq search
Date: Wed, 15 Mar 2017 16:22:32 +0000
Message-ID: <20170315162232.GJ6986@localhost.localdomain>
References: <1489591986-6302-1-git-send-email-daniel.baluta@nxp.com>
 <1489591986-6302-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DAE266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 17:21:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489591986-6302-2-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 15, 2017 at 05:33:05PM +0200, Daniel Baluta wrote:
> Add a separate function for finding (sysclk, lrclk, bclk)
> when the clock is auto or mclk. This makes code easier to
> read and reduces the indentation level in wm8960_configure_clocking.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/codecs/wm8960.c | 82 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 3bf081a..cb2ff2d 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -604,12 +604,71 @@ static const int bclk_divs[] = {
>  	120, 160, 220, 240, 320, 320, 320
>  };
>  
> +/**
> + * wm8960_configure_sysclk - checks if there is a sysclk frequency available
> + *	The sysclk must be chosen such that:
> + *		- sysclk     = MCLK / sysclk_divs
> + *		- lrclk      = sysclk / dac_divs
> + *		- 10 * bclk  = sysclk / bclk_divs
> + *
> + * @wm8960_priv: wm8960 codec private data
> + * @mclk: MCLK used to derive sysclk
> + * @_i: sysclk_divs index for found sysclk
> + * @_j: dac_divs index for found lrclk
> + * @_k: bclk_divs index for found bclk
> + *
> + * Returns:
> + * -1, in case no sysclk frequency available found
> + *  0, in case an exact match is found. See @_i, @_j, @_k
> + *
> + */
> +int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
> +		      int *_i, int *_j, int *_k)

This probably wants to be static.

> +{
> +	int sysclk, bclk, lrclk;
> +	int i, j, k;
> +	int diff;
> +
> +	bclk = wm8960->bclk;
> +	lrclk = wm8960->lrclk;
> +
> +	/* check if the sysclk frequency is available. */
> +	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
> +		if (sysclk_divs[i] == -1)
> +			continue;
> +		sysclk = mclk / sysclk_divs[i];
> +		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> +			if (sysclk != dac_divs[j] * lrclk)
> +				continue;
> +			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
> +				diff = sysclk - bclk * bclk_divs[k] / 10;
> +				if (diff == 0) {
> +					*_i = i;
> +					*_j = j;
> +					*_k = k;

I would be tempted to move these ...

> +					break;
> +				}
> +			}
> +			if (k != ARRAY_SIZE(bclk_divs))
> +				break;
> +		}
> +		if (j != ARRAY_SIZE(dac_divs))
> +			break;
> +	}
> +
> +	if (i != ARRAY_SIZE(sysclk_divs))
> +		return 0;
> +

Down here and give _i, _j, _k slightly more descriptive names, I
know the original code didn't have great names either but might
as well make things a bit nicer as we are factoring it out.

> +	return -1;
> +}
> +
>  static int wm8960_configure_clocking(struct snd_soc_codec *codec)
>  {
>  	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
>  	int sysclk, bclk, lrclk, freq_out, freq_in;
>  	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
>  	int i, j, k;
> +	int ret;
>  
>  	if (!(iface1 & (1<<6))) {
>  		dev_dbg(codec->dev,
> @@ -643,27 +702,10 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
>  	}
>  
>  	if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
> -		/* check if the sysclk frequency is available. */
> -		for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
> -			if (sysclk_divs[i] == -1)
> -				continue;
> -			sysclk = freq_out / sysclk_divs[i];
> -			for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
> -				if (sysclk != dac_divs[j] * lrclk)
> -					continue;
> -				for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
> -					if (sysclk == bclk * bclk_divs[k] / 10)
> -						break;
> -				if (k != ARRAY_SIZE(bclk_divs))
> -					break;
> -			}
> -			if (j != ARRAY_SIZE(dac_divs))
> -				break;
> -		}
> -
> -		if (i != ARRAY_SIZE(sysclk_divs)) {
> +		ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
> +		if (ret == 0)
>  			goto configure_clock;
> -		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
> +		else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {

If one clause of the if has brackets the other should too.

Otherwise, I think this looks fine.

Thanks,
Charles
