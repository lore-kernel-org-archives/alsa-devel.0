From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Fix SOC_DOUBLE_R_SX_TLV volume mixer
	arguments
Date: Mon, 23 Jun 2014 11:25:48 -0500
Message-ID: <alpine.DEB.2.02.1406231125260.25941@heelrod>
References: <1403540300-15271-1-git-send-email-ryan.harvey@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 32959265869
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:23:18 +0200 (CEST)
In-Reply-To: <1403540300-15271-1-git-send-email-ryan.harvey@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Harvey <ryan.harvey@cirrus.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2014, Ryan Harvey wrote:

> Remove unnecessary bit shifts. Correct min value to match datasheet. #Steps equals number of steps between min and max.
>
> This patch depends on 8f0367b53d887726b1f4b0b39e0f09b7cca2f79f
> ASoC: cs42l56: Fix stereo channel register assignment for Headphone and
> LineOut volume mixers.
>
> Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
> ---
> sound/soc/codecs/cs42l52.c |   14 +++++++-------
> sound/soc/codecs/cs42l56.c |   12 ++++++------
> sound/soc/codecs/cs42l73.c |    2 +-
> 3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
> index c0581c5..7aed07e 100644
> --- a/sound/soc/codecs/cs42l52.c
> +++ b/sound/soc/codecs/cs42l52.c
> @@ -399,15 +399,15 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
> 			      CS42L52_MASTERB_VOL, 0, 0x34, 0xE4, hl_tlv),
>
> 	SOC_DOUBLE_R_SX_TLV("Headphone Volume", CS42L52_HPA_VOL,
> -			      CS42L52_HPB_VOL, 0, 0x34, 0xCC, hpd_tlv),
> +			      CS42L52_HPB_VOL, 0, 0x34, 0xC0, hpd_tlv),
>
> 	SOC_ENUM("Headphone Analog Gain", hp_gain_enum),
>
> 	SOC_DOUBLE_R_SX_TLV("Speaker Volume", CS42L52_SPKA_VOL,
> -			      CS42L52_SPKB_VOL, 0, 0x1, 0xff, hl_tlv),
> +			      CS42L52_SPKB_VOL, 0, 0x40, 0xC0, hl_tlv),
>
> 	SOC_DOUBLE_R_SX_TLV("Bypass Volume", CS42L52_PASSTHRUA_VOL,
> -			      CS42L52_PASSTHRUB_VOL, 6, 0x18, 0x90, pga_tlv),
> +			      CS42L52_PASSTHRUB_VOL, 0, 0x88, 0x90, pga_tlv),
>
> 	SOC_DOUBLE("Bypass Mute", CS42L52_MISC_CTL, 4, 5, 1, 0),
>
> @@ -417,10 +417,10 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
> 	SOC_ENUM("MIC Bias Level", mic_bias_level_enum),
>
> 	SOC_DOUBLE_R_SX_TLV("ADC Volume", CS42L52_ADCA_VOL,
> -			      CS42L52_ADCB_VOL, 7, 0x80, 0xA0, ipd_tlv),
> +			      CS42L52_ADCB_VOL, 0, 0xA0, 0x78, ipd_tlv),
> 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
> 			     CS42L52_ADCA_MIXER_VOL, CS42L52_ADCB_MIXER_VOL,
> -				6, 0x7f, 0x19, ipd_tlv),
> +				0, 0x19, 0x7F, ipd_tlv),
>
> 	SOC_DOUBLE("ADC Switch", CS42L52_ADC_MISC_CTL, 0, 1, 1, 0),
>
> @@ -428,11 +428,11 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
> 		     CS42L52_ADCB_MIXER_VOL, 7, 1, 1),
>
> 	SOC_DOUBLE_R_SX_TLV("PGA Volume", CS42L52_PGAA_CTL,
> -			    CS42L52_PGAB_CTL, 0, 0x28, 0x30, pga_tlv),
> +			    CS42L52_PGAB_CTL, 0, 0x28, 0x24, pga_tlv),
>
> 	SOC_DOUBLE_R_SX_TLV("PCM Mixer Volume",
> 			    CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL,
> -				0, 0x7f, 0x19, mix_tlv),
> +				0, 0x19, 0x7f, mix_tlv),
> 	SOC_DOUBLE_R("PCM Mixer Switch",
> 		     CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL, 7, 1, 1),
>
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index 8e68ef5..24fbffe 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> @@ -421,15 +421,15 @@ static const struct soc_enum ng_delay_enum =
> static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
>
> 	SOC_DOUBLE_R_SX_TLV("Master Volume", CS42L56_MASTER_A_VOLUME,
> -			      CS42L56_MASTER_B_VOLUME, 0, 0x34, 0xfd, adv_tlv),
> +			      CS42L56_MASTER_B_VOLUME, 0, 0x34, 0xE4, adv_tlv),
> 	SOC_DOUBLE("Master Mute Switch", CS42L56_DSP_MUTE_CTL, 0, 1, 1, 1),
>
> 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume", CS42L56_ADCA_MIX_VOLUME,
> -			      CS42L56_ADCB_MIX_VOLUME, 0, 0x88, 0xa9, hl_tlv),
> +			      CS42L56_ADCB_MIX_VOLUME, 0, 0x88, 0x90, hl_tlv),
> 	SOC_DOUBLE("ADC Mixer Mute Switch", CS42L56_DSP_MUTE_CTL, 6, 7, 1, 1),
>
> 	SOC_DOUBLE_R_SX_TLV("PCM Mixer Volume", CS42L56_PCMA_MIX_VOLUME,
> -			      CS42L56_PCMB_MIX_VOLUME, 0, 0x88, 0xa9, hl_tlv),
> +			      CS42L56_PCMB_MIX_VOLUME, 0, 0x88, 0x90, hl_tlv),
> 	SOC_DOUBLE("PCM Mixer Mute Switch", CS42L56_DSP_MUTE_CTL, 4, 5, 1, 1),
>
> 	SOC_SINGLE_TLV("Analog Advisory Volume",
> @@ -438,16 +438,16 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
> 			  CS42L56_DIGINPUT_ADV_VOLUME, 0, 0x00, 1, adv_tlv),
>
> 	SOC_DOUBLE_R_SX_TLV("PGA Volume", CS42L56_PGAA_MUX_VOLUME,
> -			      CS42L56_PGAB_MUX_VOLUME, 0, 0x34, 0xfd, pga_tlv),
> +			      CS42L56_PGAB_MUX_VOLUME, 0, 0x34, 0x24, pga_tlv),
> 	SOC_DOUBLE_R_TLV("ADC Volume", CS42L56_ADCA_ATTENUATOR,
> 			      CS42L56_ADCB_ATTENUATOR, 0, 0x00, 1, adc_tlv),
> 	SOC_DOUBLE("ADC Mute Switch", CS42L56_MISC_ADC_CTL, 2, 3, 1, 1),
> 	SOC_DOUBLE("ADC Boost Switch", CS42L56_GAIN_BIAS_CTL, 3, 2, 1, 1),
>
> 	SOC_DOUBLE_R_SX_TLV("Headphone Volume", CS42L56_HPA_VOLUME,
> -			      CS42L56_HPB_VOLUME, 0, 0x44, 0x55, hl_tlv),
> +			      CS42L56_HPB_VOLUME, 0, 0x84, 0x48, hl_tlv),
> 	SOC_DOUBLE_R_SX_TLV("LineOut Volume", CS42L56_LOA_VOLUME,
> -			      CS42L56_LOB_VOLUME, 0, 0x44, 0x55, hl_tlv),
> +			      CS42L56_LOB_VOLUME, 0, 0x84, 0x48, hl_tlv),
>
> 	SOC_SINGLE_TLV("Bass Shelving Volume", CS42L56_TONE_CTL,
> 			0, 0x00, 1, tone_tlv),
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> index 7f28c58..bdb8316 100644
> --- a/sound/soc/codecs/cs42l73.c
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -401,7 +401,7 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
> 			CS42L73_LOBAVOL, 0, 0x41, 0x4B, hpaloa_tlv),
>
> 	SOC_DOUBLE_R_SX_TLV("Input PGA Analog Volume", CS42L73_MICAPREPGAAVOL,
> -			CS42L73_MICBPREPGABVOL, 5, 0x34,
> +			CS42L73_MICBPREPGABVOL, 0, 0x34,
> 			0x24, micpga_tlv),
>
> 	SOC_DOUBLE_R("MIC Preamp Switch", CS42L73_MICAPREPGAAVOL,
> -- 
> 1.7.9.5
>
>
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
