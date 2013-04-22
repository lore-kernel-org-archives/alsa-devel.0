From: Bard <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Mon, 22 Apr 2013 15:03:05 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB8718BB3D46@rtitmbs7.realtek.com.tw>
References: <1366121437-19396-1-git-send-email-bardliao@realtek.com>
 <20130416143807.GJ26958@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 799E22602AD
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 09:03:11 +0200 (CEST)
In-Reply-To: <20130416143807.GJ26958@opensource.wolfsonmicro.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Dear Mark,

Please see my reply below.

Thanks.

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
Sent: Tuesday, April 16, 2013 10:38 PM
To: Bard
Cc: Flove; Oder Chiou; swarren@nvidia.com; bard
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver

On Tue, Apr 16, 2013 at 10:10:37PM +0800, bardliao@realtek.com wrote:

Please remember to post things to the list...  just a quick scan through
here:

> +static int rt5640_reg_init(struct snd_soc_codec *codec) {
> +	int i;
> +	for (i = 0; i < RT5640_INIT_REG_LEN; i++)
> +		snd_soc_write(codec, init_list[i].reg, init_list[i].val);
> +	return 0;
> +}

This should be converted over to regmap.  There's support for paging in the core, look at regmap_range.

Bard: I will use regmap_register_patch to do that.

> +/* IN1/IN2 Input Type */
> +static const char * const rt5640_input_mode[] = {
> +	"Single ended", "Differential"};
> +
> +static const SOC_ENUM_SINGLE_DECL(
> +	rt5640_in1_mode_enum, RT5640_IN1_IN2,
> +	RT5640_IN_SFT1, rt5640_input_mode);
> +
> +static const SOC_ENUM_SINGLE_DECL(
> +	rt5640_in2_mode_enum, RT5640_IN3_IN4,
> +	RT5640_IN_SFT2, rt5640_input_mode);

Platform data...

Bard: Can I export a function that machine can configure it by this function?

> +static int rt5640_vol_rescale_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol) {
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	unsigned int val, val2;
> +
> +	val = VOL_RESCALE_MAX_VOL - ucontrol->value.integer.value[0];
> +	val2 = VOL_RESCALE_MAX_VOL - ucontrol->value.integer.value[1];
> +	return snd_soc_update_bits_locked(codec, mc->reg, RT5640_L_VOL_MASK |
> +			RT5640_R_VOL_MASK, val << mc->shift | val2); }

This looks like a variant on the _RANGE controls?

Bard: Yes, we want to limit the max value of volume.
     If it is not good, I will change it.

> +static int hp_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event) {
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		break;
> +
> +	case SND_SOC_DAPM_PRE_PMD:
> +		break;
> +
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}

Remove this, it doesn't actually do anything any more.

Bard: I will remove it.

------Please consider the environment before printing this e-mail.
