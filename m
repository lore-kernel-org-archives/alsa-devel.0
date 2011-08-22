From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Initial WM8962 DSP2 support
Date: Mon, 22 Aug 2011 11:24:54 +0100
Message-ID: <4E522E76.4020701@ti.com>
References: <1313927551-10382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 607D92451F
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:24:58 +0200 (CEST)
In-Reply-To: <1313927551-10382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 21/08/11 12:52, Mark Brown wrote:
> The WM8962 features a DSP providing a number of signal processing
> features including HD Bass and Virtual Surround Sound (VSS).  Enable
> initial support for this, allowing users to enable and disable the
> algorithms using the default coefficient sets.  Further patches will
> add support for runtime configuration of the DSP coefficients.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |  157 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 156 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 8526383..c9e07aa 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -63,6 +63,8 @@ struct wm8962_priv {
>  	int fll_fref;
>  	int fll_fout;
>  
> +	u16 dsp2_ena;
> +
>  	struct delayed_work mic_work;
>  	struct snd_soc_jack *jack;
>  
> @@ -967,7 +969,7 @@ static const struct wm8962_reg_access {
>  	[584] = { 0x002D, 0x002D, 0x0000 }, /* R584   - IRQ Debounce */
>  	[586] = { 0xC000, 0xC000, 0x0000 }, /* R586   -  MICINT Source Pol */
>  	[768] = { 0x0001, 0x0001, 0x0000 }, /* R768   - DSP2 Power Management */
> -	[1037] = { 0x0000, 0x003F, 0x0000 }, /* R1037  - DSP2_ExecControl */
> +	[1037] = { 0x0000, 0x003F, 0xFFFF }, /* R1037  - DSP2_ExecControl */
>  	[4096] = { 0x3FFF, 0x3FFF, 0x0000 }, /* R4096  - Write Sequencer 0 */
>  	[4097] = { 0x00FF, 0x00FF, 0x0000 }, /* R4097  - Write Sequencer 1 */
>  	[4098] = { 0x070F, 0x070F, 0x0000 }, /* R4098  - Write Sequencer 2 */
> @@ -1988,6 +1990,122 @@ static const unsigned int classd_tlv[] = {
>  };
>  static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
>  
> +static int wm8962_dsp2_write_config(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +
> +static int wm8962_dsp2_set_enable(struct snd_soc_codec *codec, u16 val)
> +{
> +	u16 adcl = snd_soc_read(codec, WM8962_LEFT_ADC_VOLUME);
> +	u16 adcr = snd_soc_read(codec, WM8962_RIGHT_ADC_VOLUME);
> +	u16 dac = snd_soc_read(codec, WM8962_ADC_DAC_CONTROL_1);
> +
> +	/* Mute the ADCs and DACs */
> +	snd_soc_write(codec, WM8962_LEFT_ADC_VOLUME, 0);
> +	snd_soc_write(codec, WM8962_RIGHT_ADC_VOLUME, WM8962_ADC_VU);
> +	snd_soc_update_bits(codec, WM8962_ADC_DAC_CONTROL_1,
> +			    WM8962_DAC_MUTE, WM8962_DAC_MUTE);
> +
> +	snd_soc_write(codec, WM8962_SOUNDSTAGE_ENABLES_0, val);
> +
> +	/* Restore the ADCs and DACs */
> +	snd_soc_write(codec, WM8962_LEFT_ADC_VOLUME, adcl);
> +	snd_soc_write(codec, WM8962_RIGHT_ADC_VOLUME, adcr);
> +	snd_soc_update_bits(codec, WM8962_ADC_DAC_CONTROL_1,
> +			    WM8962_DAC_MUTE, dac);
> +
> +	return 0;
> +}
> +
> +static int wm8962_dsp2_start(struct snd_soc_codec *codec)
> +{
> +	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
> +
> +	wm8962_dsp2_write_config(codec);
> +
> +	snd_soc_write(codec, WM8962_DSP2_EXECCONTROL, WM8962_DSP2_RUNR);
> +
> +	wm8962_dsp2_set_enable(codec, wm8962->dsp2_ena);
> +
> +	return 0;
> +}
> +
> +static int wm8962_dsp2_stop(struct snd_soc_codec *codec)
> +{
> +	wm8962_dsp2_set_enable(codec, 0);
> +
> +	snd_soc_write(codec, WM8962_DSP2_EXECCONTROL, WM8962_DSP2_STOP);
> +
> +	return 0;
> +}
> +
> +#define WM8962_DSP2_ENABLE(xname, xshift) \
> +{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
> +	.info = wm8962_dsp2_ena_info, \
> +	.get = wm8962_dsp2_ena_get, .put = wm8962_dsp2_ena_put, \
> +	.private_value = xshift }
> +
> +static int wm8962_dsp2_ena_info(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
> +
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = 1;
> +
> +	return 0;
> +}
> +
> +static int wm8962_dsp2_ena_get(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	int shift = kcontrol->private_value;
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = !!(wm8962->dsp2_ena & 1 << shift);
> +
> +	return 0;
> +}
> +
> +static int wm8962_dsp2_ena_put(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	int shift = kcontrol->private_value;
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
> +	int old = wm8962->dsp2_ena;
> +	int ret = 0;
> +	int dsp2_running = snd_soc_read(codec, WM8962_DSP2_POWER_MANAGEMENT) &
> +		WM8962_DSP2_ENA;
> +
> +	mutex_lock(&codec->mutex);
> +
> +	if (ucontrol->value.integer.value[0])
> +		wm8962->dsp2_ena |= 1 << shift;
> +	else
> +		wm8962->dsp2_ena &= ~(1 << shift);
> +
> +	if (wm8962->dsp2_ena == old)
> +		goto out;
> +
> +	ret = 1;
> +
> +	if (dsp2_running) {
> +		if (wm8962->dsp2_ena)
> +			wm8962_dsp2_set_enable(codec, wm8962->dsp2_ena);
> +		else
> +			wm8962_dsp2_stop(codec);
> +	}
> +
> +out:
> +	mutex_unlock(&codec->mutex);
> +
> +	return ret;
> +}
> +
>  /* The VU bits for the headphones are in a different register to the mute
>   * bits and only take effect on the PGA if it is actually powered.
>   */
> @@ -2146,6 +2264,11 @@ SOC_DOUBLE_R_TLV("EQ4 Volume", WM8962_EQ3, WM8962_EQ23,
>  		 WM8962_EQL_B4_GAIN_SHIFT, 31, 0, eq_tlv),
>  SOC_DOUBLE_R_TLV("EQ5 Volume", WM8962_EQ3, WM8962_EQ23,
>  		 WM8962_EQL_B5_GAIN_SHIFT, 31, 0, eq_tlv),
> +
> +WM8962_DSP2_ENABLE("VSS Switch", WM8962_VSS_ENA_SHIFT),
> +WM8962_DSP2_ENABLE("HPF1 Switch", WM8962_HPF1_ENA_SHIFT),
> +WM8962_DSP2_ENABLE("HPF2 Switch", WM8962_HPF2_ENA_SHIFT),
> +WM8962_DSP2_ENABLE("HD Bass Switch", WM8962_HDBASS_ENA_SHIFT),
>  };
>  
>  static const struct snd_kcontrol_new wm8962_spk_mono_controls[] = {
> @@ -2405,6 +2528,31 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
>  	}
>  }
>  
> +static int dsp2_event(struct snd_soc_dapm_widget *w,
> +		      struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		if (wm8962->dsp2_ena)
> +			wm8962_dsp2_start(codec);
> +		break;
> +
> +	case SND_SOC_DAPM_PRE_PMD:
> +		if (wm8962->dsp2_ena)
> +			wm8962_dsp2_stop(codec);
> +		break;
> +
> +	default:
> +		BUG();
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const char *st_text[] = { "None", "Right", "Left" };
>  
>  static const struct soc_enum str_enum =
> @@ -2527,6 +2675,9 @@ SND_SOC_DAPM_SUPPLY("SYSCLK", WM8962_CLOCKING2, 5, 0, sysclk_event,
>  SND_SOC_DAPM_SUPPLY("Charge Pump", WM8962_CHARGE_PUMP_1, 0, 0, cp_event,
>  		    SND_SOC_DAPM_POST_PMU),
>  SND_SOC_DAPM_SUPPLY("TOCLK", WM8962_ADDITIONAL_CONTROL_1, 0, 0, NULL, 0),
> +SND_SOC_DAPM_SUPPLY_S("DSP2", 1, WM8962_DSP2_POWER_MANAGEMENT,
> +		      WM8962_DSP2_ENA_SHIFT, 0, dsp2_event,
> +		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
>  
>  SND_SOC_DAPM_MIXER("INPGAL", WM8962_LEFT_INPUT_PGA_CONTROL, 4, 0,
>  		   inpgal, ARRAY_SIZE(inpgal)),
> @@ -2622,11 +2773,13 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
>  	{ "ADCL", NULL, "TOCLK" },
>  	{ "ADCL", NULL, "MIXINL" },
>  	{ "ADCL", NULL, "DMIC" },
> +	{ "ADCL", NULL, "DSP2" },
>  
>  	{ "ADCR", NULL, "SYSCLK" },
>  	{ "ADCR", NULL, "TOCLK" },
>  	{ "ADCR", NULL, "MIXINR" },
>  	{ "ADCR", NULL, "DMIC" },
> +	{ "ADCR", NULL, "DSP2" },
>  
>  	{ "STL", "Left", "ADCL" },
>  	{ "STL", "Right", "ADCR" },
> @@ -2638,11 +2791,13 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
>  	{ "DACL", NULL, "TOCLK" },
>  	{ "DACL", NULL, "Beep" },
>  	{ "DACL", NULL, "STL" },
> +	{ "DACL", NULL, "DSP2" },
>  
>  	{ "DACR", NULL, "SYSCLK" },
>  	{ "DACR", NULL, "TOCLK" },
>  	{ "DACR", NULL, "Beep" },
>  	{ "DACR", NULL, "STR" },
> +	{ "DACR", NULL, "DSP2" },
>  
>  	{ "HPMIXL", "IN4L Switch", "IN4L" },
>  	{ "HPMIXL", "IN4R Switch", "IN4R" },

Acked-by: Liam Girdwood <lrg@ti.com>
