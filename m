From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320aic3x: Add support for high
 power analog output
Date: Mon, 29 Apr 2019 14:27:15 +0300
Message-ID: <507b9ee8-2505-8014-114e-563dc5995e8f@ti.com>
References: <20190427194005.7308-1-sravanhome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427194005.7308-1-sravanhome@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Saravanan Sekar <sravanhome@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 27/04/2019 22.40, Saravanan Sekar wrote:
> Add support to power and output level control for the analog high power
> output drivers HPOUT and HPCOM.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index 516d17cb2182..d4bafac802eb 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -419,6 +419,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
>  	/* Pop reduction */
>  	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
>  	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
> +
> +	/* Analog HPOUT, HPCOM power and output level controls */
> +	SOC_DOUBLE_R("Analog output power control", HPROUT_CTRL,
> +			HPRCOM_CTRL, 0, 1, 0),

bit 0 of HPROUT_CTRL and HPRCOM_CTRL is handled by DAPM:
"Right HP Out"
"Right HP Com"

> +	SOC_DOUBLE_R("Analog output level control", HPROUT_CTRL,
> +			HPRCOM_CTRL, 4, 9, 0),

and this will modify the HPR and HPRCOM (right channels) only.

You should add two controls:

/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);

SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4, 9,
0, hp_tlv);

SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL, 4,
9, 0, hp_tlv);


>  };
>  
>  /* For other than tlv320aic3104 */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
