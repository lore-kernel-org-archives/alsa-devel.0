From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix master mode clock
	I2S bus clocks
Date: Mon, 12 Feb 2018 08:17:38 -0600
Message-ID: <b582d1d1-a027-f7cf-1f2e-a09a411f1354@ti.com>
References: <20180212140646.3268-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id E1BC9267545
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 15:17:40 +0100 (CET)
In-Reply-To: <20180212140646.3268-1-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/12/2018 08:06 AM, Peter Ujfalusi wrote:
> In the reset state of the codec we do not have complete playback or capture
> routes.
> 
> The audio playback/capture will not work due to missing clock signals on
> the I2S bus if PLL, MDAC/NDAC/DAC MADC/NADC/ADC is powered down.
> 
> To make sure that even if all output/input is disconnected the codec is
> generating clocks, we need to have valid DAPM route in every case to power
> up the must needed parts of the codec.
> 

If all output/input is disconnected why do we need the I2C clocks?

Or do you mean if only one is disconnected the PLL goes down? If that is
the case then it would be better to fix the DAPM route so both paths
correctly lead back to the PLL.

> I have verified that switching DAC (during playback) or ADC (during
> capture) will stop the I2S clocks, so the only solution is to connect the
> 'Off' routes as well to output/input.
> 
> Tested on am43x-epos-evm with aic3111 codec in master mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/codecs/tlv320aic31xx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
> index 858cb8be445f..d42a23eb916e 100644
> --- a/sound/soc/codecs/tlv320aic31xx.c
> +++ b/sound/soc/codecs/tlv320aic31xx.c
> @@ -586,9 +586,11 @@ common31xx_audio_map[] = {
>  	{"DAC Left Input", "Left Data", "DAC IN"},
>  	{"DAC Left Input", "Right Data", "DAC IN"},
>  	{"DAC Left Input", "Mono", "DAC IN"},
> +	{"DAC Left Input", "Off", "DAC IN"},
>  	{"DAC Right Input", "Left Data", "DAC IN"},
>  	{"DAC Right Input", "Right Data", "DAC IN"},
>  	{"DAC Right Input", "Mono", "DAC IN"},
> +	{"DAC Right Input", "Off", "DAC IN"},
>  	{"DAC Left", NULL, "DAC Left Input"},
>  	{"DAC Right", NULL, "DAC Right Input"},
>  
> @@ -601,6 +603,9 @@ common31xx_audio_map[] = {
>  	{"HP Right", "Switch", "Output Right"},
>  	{"HPR Driver", NULL, "HP Right"},
>  	{"HPR", NULL, "HPR Driver"},
> +
> +	{"HPL", NULL, "DAC Left"},
> +	{"HPR", NULL, "DAC Right"},
>  };
>  
>  static const struct snd_soc_dapm_route
> @@ -621,16 +626,20 @@ aic31xx_audio_map[] = {
>  	{"MIC1LP P-Terminal", "FFR 10 Ohm", "MIC1LP"},
>  	{"MIC1LP P-Terminal", "FFR 20 Ohm", "MIC1LP"},
>  	{"MIC1LP P-Terminal", "FFR 40 Ohm", "MIC1LP"},
> +	{"MIC1LP P-Terminal", "Off", "MIC1LP"},
>  	{"MIC1RP P-Terminal", "FFR 10 Ohm", "MIC1RP"},
>  	{"MIC1RP P-Terminal", "FFR 20 Ohm", "MIC1RP"},
>  	{"MIC1RP P-Terminal", "FFR 40 Ohm", "MIC1RP"},
> +	{"MIC1RP P-Terminal", "Off", "MIC1RP"},
>  	{"MIC1LM P-Terminal", "FFR 10 Ohm", "MIC1LM"},
>  	{"MIC1LM P-Terminal", "FFR 20 Ohm", "MIC1LM"},
>  	{"MIC1LM P-Terminal", "FFR 40 Ohm", "MIC1LM"},
> +	{"MIC1LM P-Terminal", "Off", "MIC1LM"},
>  
>  	{"MIC1LM M-Terminal", "FFR 10 Ohm", "MIC1LM"},
>  	{"MIC1LM M-Terminal", "FFR 20 Ohm", "MIC1LM"},
>  	{"MIC1LM M-Terminal", "FFR 40 Ohm", "MIC1LM"},
> +	{"MIC1LM M-Terminal", "Off", "MIC1LM"},
>  
>  	{"MIC_GAIN_CTL", NULL, "MIC1LP P-Terminal"},
>  	{"MIC_GAIN_CTL", NULL, "MIC1RP P-Terminal"},
> 
