From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Support mono capture
Date: Mon, 8 Jan 2018 16:01:15 -0800
Message-ID: <20180109000115.GA184703@google.com>
References: <20180105221242.22083-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105221242.22083-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

El Fri, Jan 05, 2018 at 02:12:42PM -0800 Matthias Kaehlcke ha dit:

> The Rockchip I2S controller only allows to configure even numbers of
> capture channels. It is still possible to capture monophonic audio by
> using dual-channel mode and ignoring the 'data' from the second
> channel.

Due to different issues in our audio recording path I couldn't test
this properly, and only looked at the .wav data in audacity, which
appeared to look ok. After putting some of the missing pieces
together and I noticed that mono capture doesn't work as intended,
the recorded audio is slowed down. I think this is because the I2S
controller keeps generating a two-channel stream, however the sound
system interprets it as a monophonic stream because of the channel
configuration.

Not sure if there is a clean solution for this if we can't tell the
hardware to generate a single-channel stream. Any suggestions or do
we have to revert the patch?

Sorry about the mess :(

> ---
>  sound/soc/rockchip/rockchip_i2s.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index 908211e1d6fc..cc22ab3d10dd 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -328,6 +328,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
>  		val |= I2S_CHN_4;
>  		break;
>  	case 2:
> +	case 1:
>  		val |= I2S_CHN_2;
>  		break;
>  	default:
> @@ -460,7 +461,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
>  	},
>  	.capture = {
>  		.stream_name = "Capture",
> -		.channels_min = 2,
> +		.channels_min = 1,
>  		.channels_max = 2,
>  		.rates = SNDRV_PCM_RATE_8000_192000,
>  		.formats = (SNDRV_PCM_FMTBIT_S8 |
> @@ -654,7 +655,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
> -		if (val >= 2 && val <= 8)
> +		if (val >= 1 && val <= 8)
>  			soc_dai->capture.channels_max = val;
>  	}
>  
