From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/4] ASoC: codecs: da7213: fix invalid usage of bitwise
 operation in loop condition
Date: Tue, 2 May 2017 14:02:34 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142AAE602@SW-EX-MBX01.diasemi.com>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
 <20170502133303.19622-2-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170502133303.19622-2-o-takashi@sakamocchi.jp>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "# 4 . 4+" <stable@vger.kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 02 May 2017 14:33, Takashi Sakamoto wrote:

> AND bitwise operation is used for retry counter and lock status, however in
> this case, it's invalid as condition statement.
> 
> This commit fixes this bug with simpler representation. This bug is
> detected by sparse with below warning:
> 
> sound/soc/codecs/da7213.c:775:57: warning: dubious: x & !y
> 
> Fixes: d575b0b0f01a ("ASoC: da7213: Add checking of SRM lock status before
> enabling DAI")

Agreed that the current '&' operator usage is technically invalid although the
code does operate correctly. Would rather you just change '&' to '&&' here
though rather than refactoring as I think the existing representation is clearer
to read in my opinion, and it's just a 1 line change. Please take that approach.

> Cc: <stable@vger.kernel.org> # 4.4+
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/soc/codecs/da7213.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 6dd7578..11d257c 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -737,7 +737,6 @@ static int da7213_dai_event(struct snd_soc_dapm_widget
> *w,
>  	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
>  	u8 pll_ctrl, pll_status;
>  	int i = 0;
> -	bool srm_lock = false;
> 
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMU:
> @@ -766,15 +765,12 @@ static int da7213_dai_event(struct snd_soc_dapm_widget
> *w,
>  		/* Check SRM has locked */
>  		do {
>  			pll_status = snd_soc_read(codec, DA7213_PLL_STATUS);
> -			if (pll_status & DA7219_PLL_SRM_LOCK) {
> -				srm_lock = true;
> -			} else {
> -				++i;
> -				msleep(50);
> -			}
> -		} while ((i < DA7213_SRM_CHECK_RETRIES) & (!srm_lock));
> +			if (pll_status & DA7219_PLL_SRM_LOCK)
> +				break;
> +			msleep(50);
> +		} while (++i < DA7213_SRM_CHECK_RETRIES);
> 
> -		if (!srm_lock)
> +		if (i >= DA7213_SRM_CHECK_RETRIES)
>  			dev_warn(codec->dev, "SRM failed to lock\n");
> 
>  		return 0;
> --
> 2.9.3
