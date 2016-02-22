From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 1/3] ALSA: hda - Create common chmap object
Date: Mon, 22 Feb 2016 15:14:10 +0530
Message-ID: <20160222094404.GA7922@subhransu-desktop>
References: <1456128040-12141-1-git-send-email-subhransu.s.prusty@intel.com>
 <1456128040-12141-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5hziut2iq6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 405C126047F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 10:44:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hziut2iq6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2016 at 10:32:33AM +0100, Takashi Iwai wrote:
> On Mon, 22 Feb 2016 09:00:38 +0100,
> Subhransu S. Prusty wrote:
> > 
> > Common chmap object represents multichannel capablity and
> > contains chmap ops. Legacy driver is udpated to use this and
> > later ASoC hdac hdmi driver will also use.
> > 
> > In the mixer control callback handlers, information specific to
> > driver are accessed through ops. Also during chmap control
> > registration, use the common hdmi_chmap object instead of
> > hda_codec.
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> To make review easier, could you split this patch into two, one for 
> just moving the hdmi_chmap out of spec, and another is the addition of
> new ops, get_chmap, set_chmap, etc.

Sure, will do it.

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  include/sound/hdmi_chmap.h |  39 ++++++++++++
> >  sound/pci/hda/patch_hdmi.c | 145 ++++++++++++++++++++++++++++-----------------
> >  2 files changed, 131 insertions(+), 53 deletions(-)
> >  create mode 100644 include/sound/hdmi_chmap.h
> > 
> > diff --git a/include/sound/hdmi_chmap.h b/include/sound/hdmi_chmap.h
> > new file mode 100644
> > index 0000000..e5ea02a
> > --- /dev/null
> > +++ b/include/sound/hdmi_chmap.h
> > @@ -0,0 +1,39 @@
> > +/*
> > + * For multichannel support
> > + */
> > +
> > +#ifndef __SOUND_HDMI_CHMAP_H
> > +#define __SOUND_HDMI_CHMAP_H
> > +
> > +#include <sound/hdaudio.h>
> > +
> > +struct cea_channel_speaker_allocation;
> > +
> > +struct hdmi_chmap_ops {
> > +	/*
> > +	 * Helpers for producing the channel map TLVs. These can be overridden
> > +	 * for devices that have non-standard mapping requirements.
> > +	 */
> > +	int (*chmap_cea_alloc_validate_get_type)
> > +		(struct cea_channel_speaker_allocation *cap, int channels);
> > +	void (*cea_alloc_to_tlv_chmap)
> > +		(struct cea_channel_speaker_allocation *cap,
> > +		unsigned int *chmap, int channels);
> > +
> > +	/* check that the user-given chmap is supported */
> > +	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
> > +
> > +	void (*get_chmap)(struct hdac_device *hdac, int pcm_idx,
> > +					unsigned char *chmap);
> > +	void (*set_chmap)(struct hdac_device *hdac, int pcm_idx,
> > +			unsigned char *chmap, int prepared);
> > +	bool (*is_monitor_connected)(struct hdac_device *hdac, int pcm_idx);
> > +};
> > +
> > +struct hdmi_chmap {
> > +	unsigned int channels_max; /* max over all cvts */
> > +	struct hdmi_chmap_ops ops;
> > +	struct hdac_device *hdac;
> > +};
> > +
> > +#endif /* __SOUND_HDMI_CHMAP_H */
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index f4443b5..d73698c 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -37,8 +37,10 @@
> >  #include <sound/jack.h>
> >  #include <sound/asoundef.h>
> >  #include <sound/tlv.h>
> > +
> >  #include <sound/hdaudio.h>
> >  #include <sound/hda_i915.h>
> > +#include <sound/hdmi_chmap.h>
> >  #include "hda_codec.h"
> >  #include "hda_local.h"
> >  #include "hda_jack.h"
> > @@ -101,7 +103,6 @@ struct hdmi_spec_per_pin {
> >  };
> >  
> >  struct cea_channel_speaker_allocation;
> > -
> >  /* operations used by generic code that can be overridden by patches */
> >  struct hdmi_ops {
> >  	int (*pin_get_eld)(struct hda_codec *codec, hda_nid_t pin_nid,
> > @@ -122,15 +123,6 @@ struct hdmi_ops {
> >  	int (*setup_stream)(struct hda_codec *codec, hda_nid_t cvt_nid,
> >  			    hda_nid_t pin_nid, u32 stream_tag, int format);
> >  
> > -	/* Helpers for producing the channel map TLVs. These can be overridden
> > -	 * for devices that have non-standard mapping requirements. */
> > -	int (*chmap_cea_alloc_validate_get_type)(struct cea_channel_speaker_allocation *cap,
> > -						 int channels);
> > -	void (*cea_alloc_to_tlv_chmap)(struct cea_channel_speaker_allocation *cap,
> > -				       unsigned int *chmap, int channels);
> > -
> > -	/* check that the user-given chmap is supported */
> > -	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
> >  };
> >  
> >  struct hdmi_pcm {
> > @@ -155,7 +147,6 @@ struct hdmi_spec {
> >  	 * bit 1 means the second playback PCM, and so on.
> >  	 */
> >  	unsigned long pcm_in_use;
> > -	unsigned int channels_max; /* max over all cvts */
> >  
> >  	struct hdmi_eld temp_eld;
> >  	struct hdmi_ops ops;
> > @@ -171,6 +162,8 @@ struct hdmi_spec {
> >  	/* i915/powerwell (Haswell+/Valleyview+) specific */
> >  	struct i915_audio_component_audio_ops i915_audio_ops;
> >  	bool i915_bound; /* was i915 bound in this driver? */
> > +
> > +	struct hdmi_chmap chmap;
> >  };
> >  
> >  #ifdef CONFIG_SND_HDA_I915
> > @@ -2096,8 +2089,8 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
> >  	per_cvt->channels_min = 2;
> >  	if (chans <= 16) {
> >  		per_cvt->channels_max = chans;
> > -		if (chans > spec->channels_max)
> > -			spec->channels_max = chans;
> > +		if (chans > spec->chmap.channels_max)
> > +			spec->chmap.channels_max = chans;
> >  	}
> >  
> >  	err = snd_hda_query_supported_pcm(codec, cvt_nid,
> > @@ -2321,10 +2314,10 @@ static int hdmi_chmap_ctl_info(struct snd_kcontrol *kcontrol,
> >  			       struct snd_ctl_elem_info *uinfo)
> >  {
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> > -	struct hda_codec *codec = info->private_data;
> > -	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_chmap *chmap = info->private_data;
> > +
> >  	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> > -	uinfo->count = spec->channels_max;
> > +	uinfo->count = chmap->channels_max;
> >  	uinfo->value.integer.min = 0;
> >  	uinfo->value.integer.max = SNDRV_CHMAP_LAST;
> >  	return 0;
> > @@ -2358,12 +2351,49 @@ static void hdmi_cea_alloc_to_tlv_chmap(struct cea_channel_speaker_allocation *c
> >  	WARN_ON(count != channels);
> >  }
> >  
> > +static void hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
> > +					unsigned char *chmap)
> > +{
> > +	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
> > +
> > +	/* chmap is already set to 0 in caller */
> > +	if (!per_pin)
> > +		return;
> > +
> > +	memcpy(chmap, per_pin->chmap, ARRAY_SIZE(per_pin->chmap));
> > +}
> > +
> > +static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
> > +				unsigned char *chmap, int prepared)
> > +{
> > +	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
> > +
> > +	mutex_lock(&per_pin->lock);
> > +	per_pin->chmap_set = true;
> > +	memcpy(per_pin->chmap, chmap, ARRAY_SIZE(per_pin->chmap));
> > +	if (prepared)
> > +		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
> > +	mutex_unlock(&per_pin->lock);
> > +}
> > +
> > +static bool is_hdmi_monitor_connected(struct hdac_device *hdac, int pcm_idx)
> > +{
> > +	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
> > +
> > +	return per_pin ? true:false;
> > +}
> > +
> >  static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
> >  			      unsigned int size, unsigned int __user *tlv)
> >  {
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> > -	struct hda_codec *codec = info->private_data;
> > -	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_chmap *chmap = info->private_data;
> >  	unsigned int __user *dst;
> >  	int chs, count = 0;
> >  
> > @@ -2373,13 +2403,14 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
> >  		return -EFAULT;
> >  	size -= 8;
> >  	dst = tlv + 2;
> > -	for (chs = 2; chs <= spec->channels_max; chs++) {
> > +	for (chs = 2; chs <= chmap->channels_max; chs++) {
> >  		int i;
> >  		struct cea_channel_speaker_allocation *cap;
> >  		cap = channel_allocations;
> >  		for (i = 0; i < ARRAY_SIZE(channel_allocations); i++, cap++) {
> >  			int chs_bytes = chs * 4;
> > -			int type = spec->ops.chmap_cea_alloc_validate_get_type(cap, chs);
> > +			int type = chmap->ops.chmap_cea_alloc_validate_get_type(
> > +								cap, chs);
> >  			unsigned int tlv_chmap[8];
> >  
> >  			if (type < 0)
> > @@ -2396,7 +2427,7 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
> >  				return -ENOMEM;
> >  			size -= chs_bytes;
> >  			count += chs_bytes;
> > -			spec->ops.cea_alloc_to_tlv_chmap(cap, tlv_chmap, chs);
> > +			chmap->ops.cea_alloc_to_tlv_chmap(cap, tlv_chmap, chs);
> >  			if (copy_to_user(dst, tlv_chmap, chs_bytes))
> >  				return -EFAULT;
> >  			dst += chs;
> > @@ -2411,20 +2442,17 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
> >  			      struct snd_ctl_elem_value *ucontrol)
> >  {
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> > -	struct hda_codec *codec = info->private_data;
> > -	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_chmap *hchmap = info->private_data;
> >  	int pcm_idx = kcontrol->private_value;
> > -	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
> > +	unsigned char chmap[8];
> >  	int i;
> >  
> > -	if (!per_pin) {
> > -		for (i = 0; i < spec->channels_max; i++)
> > -			ucontrol->value.integer.value[i] = 0;
> > -		return 0;
> > -	}
> > +	memset(chmap, 0, sizeof(chmap));
> > +	hchmap->ops.get_chmap(hchmap->hdac, pcm_idx, chmap);
> > +
> > +	for (i = 0; i < sizeof(chmap); i++)
> > +		ucontrol->value.integer.value[i] = chmap[i];
> >  
> > -	for (i = 0; i < ARRAY_SIZE(per_pin->chmap); i++)
> > -		ucontrol->value.integer.value[i] = per_pin->chmap[i];
> >  	return 0;
> >  }
> >  
> > @@ -2432,19 +2460,17 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
> >  			      struct snd_ctl_elem_value *ucontrol)
> >  {
> >  	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
> > -	struct hda_codec *codec = info->private_data;
> > -	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_chmap *hchmap = info->private_data;
> >  	int pcm_idx = kcontrol->private_value;
> > -	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
> >  	unsigned int ctl_idx;
> >  	struct snd_pcm_substream *substream;
> > -	unsigned char chmap[8];
> > +	unsigned char chmap[8], per_pin_chmap[8];
> >  	int i, err, ca, prepared = 0;
> >  
> >  	/* No monitor is connected in dyn_pcm_assign.
> >  	 * It's invalid to setup the chmap
> >  	 */
> > -	if (!per_pin)
> > +	if (!hchmap->ops.is_monitor_connected(hchmap->hdac, pcm_idx))
> >  		return 0;
> >  
> >  	ctl_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
> > @@ -2464,22 +2490,20 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
> >  	memset(chmap, 0, sizeof(chmap));
> >  	for (i = 0; i < ARRAY_SIZE(chmap); i++)
> >  		chmap[i] = ucontrol->value.integer.value[i];
> > -	if (!memcmp(chmap, per_pin->chmap, sizeof(chmap)))
> > +
> > +	hchmap->ops.get_chmap(hchmap->hdac, pcm_idx, per_pin_chmap);
> > +	if (!memcmp(chmap, per_pin_chmap, sizeof(chmap)))
> >  		return 0;
> >  	ca = hdmi_manual_channel_allocation(ARRAY_SIZE(chmap), chmap);
> >  	if (ca < 0)
> >  		return -EINVAL;
> > -	if (spec->ops.chmap_validate) {
> > -		err = spec->ops.chmap_validate(ca, ARRAY_SIZE(chmap), chmap);
> > +	if (hchmap->ops.chmap_validate) {
> > +		err = hchmap->ops.chmap_validate(ca, ARRAY_SIZE(chmap), chmap);
> >  		if (err)
> >  			return err;
> >  	}
> > -	mutex_lock(&per_pin->lock);
> > -	per_pin->chmap_set = true;
> > -	memcpy(per_pin->chmap, chmap, sizeof(chmap));
> > -	if (prepared)
> > -		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
> > -	mutex_unlock(&per_pin->lock);
> > +
> > +	hchmap->ops.set_chmap(hchmap->hdac, pcm_idx, chmap, prepared);
> >  
> >  	return 0;
> >  }
> > @@ -2638,7 +2662,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
> >  		if (err < 0)
> >  			return err;
> >  		/* override handlers */
> > -		chmap->private_data = codec;
> > +		chmap->private_data = &spec->chmap;
> >  		kctl = chmap->kctl;
> >  		for (i = 0; i < kctl->count; i++)
> >  			kctl->vd[i].access |= SNDRV_CTL_ELEM_ACCESS_WRITE;
> > @@ -2762,11 +2786,16 @@ static const struct hdmi_ops generic_standard_hdmi_ops = {
> >  	.pin_setup_infoframe			= hdmi_pin_setup_infoframe,
> >  	.pin_hbr_setup				= hdmi_pin_hbr_setup,
> >  	.setup_stream				= hdmi_setup_stream,
> > +};
> > +
> > +static const struct hdmi_chmap_ops chmap_ops = {
> >  	.chmap_cea_alloc_validate_get_type	= hdmi_chmap_cea_alloc_validate_get_type,
> >  	.cea_alloc_to_tlv_chmap			= hdmi_cea_alloc_to_tlv_chmap,
> > +	.get_chmap				= hdmi_get_chmap,
> > +	.set_chmap				= hdmi_set_chmap,
> > +	.is_monitor_connected			= is_hdmi_monitor_connected,
> >  };
> >  
> > -
> >  static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
> >  					     hda_nid_t nid)
> >  {
> > @@ -2868,6 +2897,8 @@ static int patch_generic_hdmi(struct hda_codec *codec)
> >  
> >  	spec->ops = generic_standard_hdmi_ops;
> >  	mutex_init(&spec->pcm_lock);
> > +	spec->chmap.ops = chmap_ops;
> > +	spec->chmap.hdac = &codec->core;
> >  	codec->spec = spec;
> >  	hdmi_array_init(spec, 4);
> >  
> > @@ -3483,9 +3514,12 @@ static int patch_nvhdmi(struct hda_codec *codec)
> >  	spec = codec->spec;
> >  	spec->dyn_pin_out = true;
> >  
> > -	spec->ops.chmap_cea_alloc_validate_get_type =
> > +	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
> >  		nvhdmi_chmap_cea_alloc_validate_get_type;
> > -	spec->ops.chmap_validate = nvhdmi_chmap_validate;
> > +	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
> > +	spec->chmap.ops.get_chmap = hdmi_get_chmap;
> > +	spec->chmap.ops.set_chmap = hdmi_set_chmap;
> > +	spec->chmap.ops.is_monitor_connected = is_hdmi_monitor_connected;
> >  
> >  	return 0;
> >  }
> > @@ -3992,10 +4026,15 @@ static int patch_atihdmi(struct hda_codec *codec)
> >  
> >  	if (!has_amd_full_remap_support(codec)) {
> >  		/* override to ATI/AMD-specific versions with pairwise mapping */
> > -		spec->ops.chmap_cea_alloc_validate_get_type =
> > +		spec->chmap.ops.chmap_cea_alloc_validate_get_type =
> >  			atihdmi_paired_chmap_cea_alloc_validate_get_type;
> > -		spec->ops.cea_alloc_to_tlv_chmap = atihdmi_paired_cea_alloc_to_tlv_chmap;
> > -		spec->ops.chmap_validate = atihdmi_paired_chmap_validate;
> > +		spec->chmap.ops.cea_alloc_to_tlv_chmap =
> > +				atihdmi_paired_cea_alloc_to_tlv_chmap;
> > +		spec->chmap.ops.chmap_validate = atihdmi_paired_chmap_validate;
> > +		spec->chmap.ops.get_chmap = hdmi_get_chmap;
> > +		spec->chmap.ops.set_chmap = hdmi_set_chmap;
> > +		spec->chmap.ops.is_monitor_connected =
> > +				is_hdmi_monitor_connected;
> >  	}
> >  
> >  	/* ATI/AMD converters do not advertise all of their capabilities */
> > @@ -4007,7 +4046,7 @@ static int patch_atihdmi(struct hda_codec *codec)
> >  		per_cvt->maxbps = max(per_cvt->maxbps, 24u);
> >  	}
> >  
> > -	spec->channels_max = max(spec->channels_max, 8u);
> > +	spec->chmap.channels_max = max(spec->chmap.channels_max, 8u);
> >  
> >  	return 0;
> >  }
> > -- 
> > 1.9.1
> > 

-- 
