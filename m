From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH] ASoC: da7219: Connect output enable register to DAIOUT
Date: Fri, 28 Oct 2016 09:36:04 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A333BA@SW-EX-MBX01.diasemi.com>
References: <1477616547-20714-1-git-send-email-smbarber@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477616547-20714-1-git-send-email-smbarber@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Barber <smbarber@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hsin-Yu Chao <hychao@chromium.org>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 28 October 2016 02:02, Steve Barber wrote:

> da7219 output (for headset capture) should be set to high-impedance when
> not in use, since it will otherwise interfere with output from other
> codecs attached to the same DAI.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> ---
>  sound/soc/codecs/da7219.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 2610fc5..9960162 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -959,7 +959,8 @@ static const struct snd_soc_dapm_widget
> da7219_dapm_widgets[] = {
>  			    SND_SOC_DAPM_PRE_PMU |
> SND_SOC_DAPM_POST_PMD),
> 
>  	/* DAI */
> -	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("DAIOUT", "Capture", 0,
> DA7219_DAI_TDM_CTRL,
> +			     DA7219_DAI_OE_SHIFT, DA7219_NO_INVERT),
>  	SND_SOC_DAPM_AIF_IN("DAIIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
> 
>  	/* Output Muxes */
> --
> 2.8.0.rc3.226.g39d4020

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
