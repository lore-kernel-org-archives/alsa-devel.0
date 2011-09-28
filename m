From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v3] ALSA: hdmi: expose ELD control
Date: Wed, 28 Sep 2011 21:26:37 +0800
Message-ID: <20110928132637.GA22186@localhost>
References: <1317156051-11884-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DE8BB24409
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 15:26:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317156051-11884-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis,

Some nit picks for reducing LOC :)

[snip]

> +static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_spec *spec;
> +	struct hdmi_spec_per_pin *per_pin;
> +	struct hdmi_eld *eld;
> +	int pin_idx;
> +
> +	spec = codec->spec;
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> +
> +	pin_idx = kcontrol->private_value;
> +	if (snd_BUG_ON(pin_idx < 0))
> +		return -EINVAL;
> +
> +	per_pin = &spec->pins[pin_idx];
> +	eld = &per_pin->sink_eld;
> +	uinfo->count = eld->eld_size;

The local variables @per_pin and @eld are referenced only and
hence looks unnecessary.

> +	return 0;
> +}
> +
> +static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_spec *spec;
> +	struct hdmi_spec_per_pin *per_pin;
> +	struct hdmi_eld *eld;
> +	int pin_idx;
> +	int size;
> +
> +	spec = codec->spec;
> +	pin_idx = kcontrol->private_value;
> +
> +	if (snd_BUG_ON(pin_idx < 0))
> +		return -EINVAL;

That check looks unnecessary since the pin_idx originates from 
the below hdmi_create_eld_ctl() which already checked it against 0.

> +	memset(ucontrol->value.bytes.data, 0, ELD_MAX_SIZE);
> +	per_pin = &spec->pins[pin_idx];
> +	eld = &per_pin->sink_eld;
> +	size = eld->eld_size;

@per_pin and @eld seems not necessary.

> +	memcpy(ucontrol->value.bytes.data, eld->eld_buffer, size);

The memset/memcpy could be merged into a single

        memcpy(ucontrol->value.bytes.data, eld->eld_buffer, ELD_MAX_SIZE);

> +	return 0;
> +}
> +
> +static struct snd_kcontrol_new eld_bytes_ctl = {
> +	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> +	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +	.name = "ELD",
> +	.info = hdmi_eld_ctl_info,
> +	.get = hdmi_eld_ctl_get,
> +};
> +
> +static int hdmi_create_eld_ctl(struct hda_codec *codec, int pin_idx,
> +			int device)
> +{
> +	struct snd_kcontrol *kctl;
> +	struct hdmi_spec *spec = codec->spec;
> +	int err;
> +
> +	if (pin_idx < 0)
> +		return -EINVAL;

Even that check looks unnecessary.. see below

> +	kctl = snd_ctl_new1(&eld_bytes_ctl, codec);
> +	if (!kctl)
> +		return -ENOMEM;
> +	kctl->private_value = pin_idx;
> +	kctl->id.device = device;
> +
> +	err = snd_hda_ctl_add(codec, spec->pins[pin_idx].pin_nid, kctl);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
>  #ifdef BE_PARANOID
>  static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
>  				int *packet_index, int *byte_index)
> @@ -1193,6 +1273,14 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
>  		if (err < 0)
>  			return err;
>  		snd_hda_spdif_ctls_unassign(codec, pin_idx);
> +
> +		/* add control for ELD Bytes */
> +		err = hdmi_create_eld_ctl(codec,
> +					pin_idx,
> +					spec->pcm_rec[pin_idx].device);

The above "pcm_rec[pin_idx]" will likely oops if ever pin_idx is
an invalid value, before hdmi_create_eld_ctl() checks pin_idx.
