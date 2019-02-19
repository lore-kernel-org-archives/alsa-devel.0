From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Date: Tue, 19 Feb 2019 11:06:48 -0600
Message-ID: <eba29760-9ef7-9490-9f46-b3dbdf43ee05@ti.com>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin.Ciubotariu@microchip.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: dannenberg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/19/19 10:29 AM, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> The ADCs are sleeping when the SLEEP bit is set and running when it's
> cleared, so the bit should be inverted.
> Tested on pcm1863.
> 

Did this work for you before? Strange it would if reversed, I wonder if
the SLEEP bit is really doing anything here. Can investigate later, for
this patch:

Acked-by: Andrew F. Davis <afd@ti.com>

> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>  - none;
> 
>  sound/soc/codecs/pcm186x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
> index c36a391fec8a..c5fcc632f670 100644
> --- a/sound/soc/codecs/pcm186x.c
> +++ b/sound/soc/codecs/pcm186x.c
> @@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
>  };
>  
>  static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
> @@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
> -	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
> +	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
>  };
>  
>  static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
> 
