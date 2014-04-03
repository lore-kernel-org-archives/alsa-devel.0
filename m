From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register
	mux
Date: Thu, 03 Apr 2014 10:27:17 +0200
Message-ID: <533D1B65.3030405@metafoo.de>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-019.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 74136265558
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 10:26:28 +0200 (CEST)
In-Reply-To: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: Songhee Baek <sbaek@nvidia.com>, alsa-devel@alsa-project.org, swarren@wwwdotorg.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/03/2014 05:11 AM, Arun Shamanna Lakshmi wrote:

This looks essentially good to me. A few minor issues, once those are fixed 
things should be good to go.

[...]
>   struct snd_soc_dapm_update {
>   	struct snd_kcontrol *kcontrol;
> -	int reg;
> -	int mask;
> -	int val;
> +	int reg[3];
> +	int mask[3];
> +	int val[3];

Make the 3 a define and check against it in the put handler.

> +	int num_regs;

unsigned int

>   };
[...]
> +/*
> + * Soc Enum Type
> + *
> + * @NONE:    soc_enum type for SINGLE, DOUBLE or VIRTUAL mux
> + * @ONEHOT:  soc_enum type for one hot encoding mux
> + */


This should be kernel doc style so

/**
  * enum snd_soc_enum_type - Type of the ASoC enum control
  * @SND_SOC_ENUM_NONE: ...
  * ...
  */


> +enum snd_soc_enum_type {
> +	SND_SOC_ENUM_NONE = 0,

I'm not sure if NONE is the right term. Maybe BINARY is better.

> +	SND_SOC_ENUM_ONEHOT = 1,
> +};
> +
[...]
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c8a780d..19b004a 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -511,13 +511,26 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
>   	const struct snd_kcontrol_new *kcontrol)
>   {
>   	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> -	unsigned int val, item;
> +	unsigned int val, item, bit_pos = -1;

default for bit_pos should probably be 0.

[...]
> @@ -1575,8 +1588,12 @@ static void dapm_widget_update(struct snd_soc_card *card)
>   	if (!w)
>   		return;
>
> -	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
> -				  update->val);
> +	/* dapm update for multiple registers */
> +	for (i = 0; i < update->num_regs; i++) {
> +		ret |= soc_widget_update_bits_locked(w, update->reg[i],
> +					update->mask[i], update->val[i]);

I'd prefer
	ret = soc_widget_update_bits_locked(...);
	if (ret < 0)
		break;

> +	}
> +
>   	if (ret < 0)
>   		dev_err(w->dapm->dev, "ASoC: %s DAPM update failed: %d\n",
>   			w->name, ret);
[...]
> @@ -2984,6 +3002,112 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
>   EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
>
>   /**
> + * snd_soc_dapm_get_enum_onehot - dapm enumerated onehot mixer get callback
> + * @kcontrol: mixer control
> + * @ucontrol: control element information
> + *
> + * Callback to get the value of a dapm enumerated onehot encoded mixer control
> + *
> + * Returns 0 for success.
> + */
> +int snd_soc_dapm_get_enum_onehot(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int reg_val, val, bit_pos = -1, reg_idx;

Here as well, default for bit_pos should be 0.

> +
> +	for (reg_idx = 0; reg_idx < e->num_regs; reg_idx++) {
> +		reg_val = snd_soc_read(codec, e->reg[reg_idx]);
> +		val = reg_val & e->mask[reg_idx];
> +		if (val != 0) {
> +			bit_pos = __ffs(val) + (8 * codec->val_bytes * reg_idx);
> +			break;
> +		}
> +	}
> +
> +	ucontrol->value.enumerated.item[0] =
> +			snd_soc_enum_val_to_item(e, bit_pos);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_onehot);
> +
> +/**
> + * snd_soc_dapm_put_enum_onehot - dapm enumerated onehot mixer put callback
> + * @kcontrol: mixer control
> + * @ucontrol: control element information
> + *
> + * Callback to put the value of a dapm enumerated onehot encoded mixer control
> + *
> + * Returns 0 for success.
> + */
> +int snd_soc_dapm_put_enum_onehot(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
> +	struct snd_soc_card *card = codec->card;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int *item = ucontrol->value.enumerated.item;
> +	unsigned int change = 0, reg_idx = 0, value, bit_pos;
> +	struct snd_soc_dapm_update update;
> +	int ret = 0, reg_val = 0, i, update_idx = 0;
> +
> +	if (item[0] >= e->items)
> +		return -EINVAL;
> +
> +	value = snd_soc_enum_item_to_val(e, item[0]);
> +
> +	if (value >= 0) {

value is unsigned int, so this is never false.

> +		/* get the register index and value to set */
> +		reg_idx = value / (8 * codec->val_bytes);
> +		bit_pos = value % (8 * codec->val_bytes);
> +		reg_val = BIT(bit_pos);
> +	}
> +
> +	for (i = 0; i < e->num_regs; i++) {
> +		if (i == reg_idx) {
> +			change = snd_soc_test_bits(codec, e->reg[i],
> +							e->mask[i], reg_val);

change |=

> +			/* set the selected register */
> +			update.reg[e->num_regs - 1] = e->reg[reg_idx];
> +			update.mask[e->num_regs - 1] = e->mask[reg_idx];
> +			update.val[e->num_regs - 1] = reg_val;
> +		} else {
> +			/* accumulate the change to update the DAPM path
> +			    when none is selected */
> +			change |= snd_soc_test_bits(codec, e->reg[i],
> +							e->mask[i], 0);
> +
> +			/* clear the register when not selected */
> +			update.reg[update_idx] = e->reg[i];
> +			update.mask[update_idx] = e->mask[i];
> +			update.val[update_idx++] = 0;
> +		}
> +	}
> +
> +	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> +
> +	if (change) {
> +		update.kcontrol = kcontrol;
> +		update.num_regs = 3;

Should be e->num_regs;

> +		card->update = &update;
> +
> +		ret = soc_dapm_mux_update_power(card, kcontrol, item[0], e);
> +
> +		card->update = NULL;
> +	}
> +
