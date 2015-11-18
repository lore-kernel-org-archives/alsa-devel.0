From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - hdmi playback without
 monitor in dynamic pcm bind mode
Date: Wed, 18 Nov 2015 14:40:01 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977BCFF@SHSMSX103.ccr.corp.intel.com>
References: <1447836419-34336-1-git-send-email-libin.yang@linux.intel.com>
 <1447836419-34336-2-git-send-email-libin.yang@linux.intel.com>
 <s5hziybef1z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A178F2657B4
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 15:43:43 +0100 (CET)
In-Reply-To: <s5hziybef1z.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, November 18, 2015 7:13 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC PATCH 1/2] ALSA: hda - hdmi playback
> without monitor in dynamic pcm bind mode
> 
> On Wed, 18 Nov 2015 09:46:58 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Pulseaudio requires open pcm successfully when probing.
> >
> > This patch handles playback without monitor in dynamic pcm
> assignment
> > mode. It tries to open/prepare/close pcm successfully even there is
> > no pin bound to the PCM. On the meantime, it will try to find a proper
> > converter for the PCM.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 163
> ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 152 insertions(+), 11 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 92e05fb..12fc506 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -135,6 +135,7 @@ struct hdmi_spec {
> >  	int num_pins;
> >  	struct snd_array pins; /* struct hdmi_spec_per_pin */
> >  	struct hda_pcm *pcm_rec[16];
> > +	struct mutex pcm_lock;
> 
> Ideally this should be a rw semaphore so that it won't block too
> much.  But we can optimize it later.
> 
> >  	unsigned int channels_max; /* max over all cvts */
> >
> >  	struct hdmi_eld temp_eld;
> > @@ -1388,6 +1389,17 @@ static void
> intel_verify_pin_cvt_connect(struct hda_codec *codec,
> >  					    mux_idx);
> >  }
> >
> > +static int intel_cvt_id_to_mux_idx(struct hdmi_spec *spec,
> > +			hda_nid_t cvt_nid)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < spec->num_cvts; i++)
> > +		if (spec->cvt_nids[i] == cvt_nid)
> > +			return i;
> > +	return -EINVAL;
> > +}
> 
> This is always a couple with intel_not_share_assigned_cvt().
> So better to have a helper doing both in a shot.
> (And give a comment what's doing.)

OK. I will add a helper for it.

> 
> 
> > +
> >  /* Intel HDMI workaround to fix audio routing issue:
> >   * For some Intel display codecs, pins share the same connection list.
> >   * So a conveter can be selected by multiple pins and playback on any
> of these
> > @@ -1439,6 +1451,77 @@ static void
> intel_not_share_assigned_cvt(struct hda_codec *codec,
> >  	}
> >  }
> >
> > +static int hdmi_find_available_cvt(struct hda_codec *codec,
> > +				int *cvt_id)
> > +{
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct hdmi_spec_per_cvt *per_cvt = NULL;
> > +	int cvt_idx;
> > +
> > +	/* Dynamically assign converter to stream */
> > +	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> > +		per_cvt = get_cvt(spec, cvt_idx);
> > +
> > +		/* Must not already be assigned */
> > +		if (!per_cvt->assigned)
> > +			break;
> > +	}
> > +
> > +	/* No free converters */
> > +	if (cvt_idx == spec->num_cvts)
> > +		return -EBUSY;
> > +
> > +	if (cvt_id)
> > +		*cvt_id = cvt_idx;
> > +
> > +	return 0;
> > +}
> 
> This could be merged into hdmi_choose_cvt().  Let per_pin = NULL if
> pin_idx < 0, and skip the mux check, for example.

OK, I will merge these functions.

> 
> > +
> > +/* called in hdmi_pcm_open when no pin is assigned to the PCM
> > + * in dyn_pcm_assign mode.
> > + */
> > +static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
> > +			 struct hda_codec *codec,
> > +			 struct snd_pcm_substream *substream)
> > +{
> > +	struct hdmi_spec *spec = codec->spec;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	int cvt_idx, mux_idx;
> > +	struct hdmi_spec_per_cvt *per_cvt = NULL;
> > +	int err;
> > +
> > +	err = hdmi_find_available_cvt(codec, &cvt_idx);
> > +	if (err)
> > +		return err;
> > +
> > +	per_cvt = get_cvt(spec, cvt_idx);
> > +	per_cvt->assigned = 1;
> > +	hinfo->nid = per_cvt->cvt_nid;
> > +
> > +	mux_idx = intel_cvt_id_to_mux_idx(spec, per_cvt->cvt_nid);
> > +	/* unshare converter from all pins */
> > +	intel_not_share_assigned_cvt(codec, 0, mux_idx);
> 
> Don't forget the hsw+/vlv+ condition check like in other places.
> Or maybe better put the check into the callee, the new helper
> function.

I forget it. It seems a new helper is better. I will do it.

Regards,
Libin

> 
> 
> Takashi
> 
> 
> > +
> > +	/* todo: setup spdif ctls assign */
> > +
> > +	/* Initially set the converter's capabilities */
> > +	hinfo->channels_min = per_cvt->channels_min;
> > +	hinfo->channels_max = per_cvt->channels_max;
> > +	hinfo->rates = per_cvt->rates;
> > +	hinfo->formats = per_cvt->formats;
> > +	hinfo->maxbps = per_cvt->maxbps;
> > +
> > +	/* Store the updated parameters */
> > +	runtime->hw.channels_min = hinfo->channels_min;
> > +	runtime->hw.channels_max = hinfo->channels_max;
> > +	runtime->hw.formats = hinfo->formats;
> > +	runtime->hw.rates = hinfo->rates;
> > +
> > +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +
> SNDRV_PCM_HW_PARAM_CHANNELS, 2);
> > +	return 0;
> > +}
> > +
> >  /*
> >   * HDA PCM callbacks
> >   */
> > @@ -1455,19 +1538,36 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  	int err;
> >
> >  	/* Validate hinfo */
> > +	mutex_lock(&spec->pcm_lock);
> >  	pin_idx = hinfo_to_pin_index(codec, hinfo);
> > -	if (snd_BUG_ON(pin_idx < 0))
> > -		return -EINVAL;
> > -	per_pin = get_pin(spec, pin_idx);
> > -	eld = &per_pin->sink_eld;
> > +	if (!spec->dyn_pcm_assign) {
> > +		if (snd_BUG_ON(pin_idx < 0)) {
> > +			mutex_unlock(&spec->pcm_lock);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		/* no pin is assigned to the PCM
> > +		 * PA need pcm open successfully when probe
> > +		 */
> > +		if (pin_idx < 0) {
> > +			err = hdmi_pcm_open_no_pin(hinfo, codec,
> substream);
> > +			mutex_unlock(&spec->pcm_lock);
> > +			return err;
> > +		}
> > +	}
> >
> >  	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx, &mux_idx);
> > -	if (err < 0)
> > +	if (err < 0) {
> > +		mutex_unlock(&spec->pcm_lock);
> >  		return err;
> > +	}
> >
> >  	per_cvt = get_cvt(spec, cvt_idx);
> >  	/* Claim converter */
> >  	per_cvt->assigned = 1;
> > +
> > +
> > +	per_pin = get_pin(spec, pin_idx);
> >  	per_pin->cvt_nid = per_cvt->cvt_nid;
> >  	hinfo->nid = per_cvt->cvt_nid;
> >
> > @@ -1488,6 +1588,7 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  	hinfo->formats = per_cvt->formats;
> >  	hinfo->maxbps = per_cvt->maxbps;
> >
> > +	eld = &per_pin->sink_eld;
> >  	/* Restrict capabilities by ELD if this isn't disabled */
> >  	if (!static_hdmi_pcm && eld->eld_valid) {
> >  		snd_hdmi_eld_update_pcm_info(&eld->info, hinfo);
> > @@ -1496,10 +1597,12 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  			per_cvt->assigned = 0;
> >  			hinfo->nid = 0;
> >  			snd_hda_spdif_ctls_unassign(codec, pin_idx);
> > +			mutex_unlock(&spec->pcm_lock);
> >  			return -ENODEV;
> >  		}
> >  	}
> >
> > +	mutex_unlock(&spec->pcm_lock);
> >  	/* Store the updated parameters */
> >  	runtime->hw.channels_min = hinfo->channels_min;
> >  	runtime->hw.channels_max = hinfo->channels_max;
> > @@ -1803,13 +1906,38 @@ static int
> generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> >  {
> >  	hda_nid_t cvt_nid = hinfo->nid;
> >  	struct hdmi_spec *spec = codec->spec;
> > -	int pin_idx = hinfo_to_pin_index(codec, hinfo);
> > -	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
> > -	hda_nid_t pin_nid = per_pin->pin_nid;
> > +	int pin_idx;
> > +	struct hdmi_spec_per_pin *per_pin;
> > +	hda_nid_t pin_nid;
> >  	struct snd_pcm_runtime *runtime = substream->runtime;
> >  	struct i915_audio_component *acomp = codec->bus-
> >core.audio_component;
> >  	bool non_pcm;
> > +	int mux_idx;
> >  	int pinctl;
> > +	int err;
> > +
> > +	mutex_lock(&spec->pcm_lock);
> > +	pin_idx = hinfo_to_pin_index(codec, hinfo);
> > +	if (spec->dyn_pcm_assign && pin_idx < 0) {
> > +		/* when dyn_pcm_assign and pcm is not bound to a pin
> > +		 * skip pin setup and return 0 to make audio playback
> > +		 * be ongoing
> > +		 */
> > +		if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
> > +			mux_idx = intel_cvt_id_to_mux_idx(spec,
> cvt_nid);
> > +			if (mux_idx > 0)
> > +				intel_not_share_assigned_cvt(codec, 0,
> mux_idx);
> > +		}
> > +		snd_hda_codec_setup_stream(codec, cvt_nid,
> > +					stream_tag, 0, format);
> > +		mutex_unlock(&spec->pcm_lock);
> > +		return 0;
> > +	}
> > +
> > +	if (snd_BUG_ON(pin_idx < 0))
> > +		return -EINVAL;
> > +	per_pin = get_pin(spec, pin_idx);
> > +	pin_nid = per_pin->pin_nid;
> >
> >  	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
> >  		/* Verify pin:cvt selections to avoid silent audio after S3.
> > @@ -1838,7 +1966,7 @@ static int
> generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> >
> >  	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
> >  	mutex_unlock(&per_pin->lock);
> > -
> > +	mutex_unlock(&spec->pcm_lock);
> >  	if (spec->dyn_pin_out) {
> >  		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
> >
> AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
> > @@ -1847,7 +1975,10 @@ static int
> generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
> >  				    pinctl | PIN_OUT);
> >  	}
> >
> > -	return spec->ops.setup_stream(codec, cvt_nid, pin_nid,
> stream_tag, format);
> > +	err = spec->ops.setup_stream(codec, cvt_nid, pin_nid,
> > +				 stream_tag, format);
> > +	mutex_unlock(&spec->pcm_lock);
> > +	return err;
> >  }
> >
> >  static int generic_hdmi_playback_pcm_cleanup(struct
> hda_pcm_stream *hinfo,
> > @@ -1878,9 +2009,17 @@ static int hdmi_pcm_close(struct
> hda_pcm_stream *hinfo,
> >  		per_cvt->assigned = 0;
> >  		hinfo->nid = 0;
> >
> > +		mutex_lock(&spec->pcm_lock);
> >  		pin_idx = hinfo_to_pin_index(codec, hinfo);
> > -		if (snd_BUG_ON(pin_idx < 0))
> > +		if (spec->dyn_pcm_assign && pin_idx < 0) {
> > +			mutex_unlock(&spec->pcm_lock);
> > +			return 0;
> > +		}
> > +
> > +		if (snd_BUG_ON(pin_idx < 0)) {
> > +			mutex_unlock(&spec->pcm_lock);
> >  			return -EINVAL;
> > +		}
> >  		per_pin = get_pin(spec, pin_idx);
> >
> >  		if (spec->dyn_pin_out) {
> > @@ -1900,6 +2039,7 @@ static int hdmi_pcm_close(struct
> hda_pcm_stream *hinfo,
> >  		per_pin->setup = false;
> >  		per_pin->channels = 0;
> >  		mutex_unlock(&per_pin->lock);
> > +		mutex_unlock(&spec->pcm_lock);
> >  	}
> >
> >  	return 0;
> > @@ -2370,6 +2510,7 @@ static int patch_generic_hdmi(struct
> hda_codec *codec)
> >  		return -ENOMEM;
> >
> >  	spec->ops = generic_standard_hdmi_ops;
> > +	mutex_init(&spec->pcm_lock);
> >  	codec->spec = spec;
> >  	hdmi_array_init(spec, 4);
> >
> > --
> > 1.9.1
> >
