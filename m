From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC V2 PATCH 1/5] ALSA: hda - hdmi playback
 without monitor in dynamic pcm bind mode
Date: Wed, 25 Nov 2015 06:50:10 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1977F3A1@SHSMSX103.ccr.corp.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
 <1448287774-146673-3-git-send-email-libin.yang@linux.intel.com>
 <s5hvb8szovf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 60392261691
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 07:50:16 +0100 (CET)
In-Reply-To: <s5hvb8szovf.wl-tiwai@suse.de>
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
> Sent: Tuesday, November 24, 2015 12:01 AM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC V2 PATCH 1/5] ALSA: hda - hdmi playback
> without monitor in dynamic pcm bind mode
> 
> On Mon, 23 Nov 2015 15:09:30 +0100,
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
> 
> The explanation why you added pcm_lock is missing.

Get it. I will add the explanation for pcm_lock.

Regards,
Libin

> 
> 
> Takashi
> 
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 171
> +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 157 insertions(+), 14 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 92e05fb..d0294bf 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -135,6 +135,7 @@ struct hdmi_spec {
> >  	int num_pins;
> >  	struct snd_array pins; /* struct hdmi_spec_per_pin */
> >  	struct hda_pcm *pcm_rec[16];
> > +	struct mutex pcm_lock;
> >  	unsigned int channels_max; /* max over all cvts */
> >
> >  	struct hdmi_eld temp_eld;
> > @@ -1331,6 +1332,11 @@ static int hdmi_setup_stream(struct
> hda_codec *codec, hda_nid_t cvt_nid,
> >  	return 0;
> >  }
> >
> > +/* Try to find an available converter
> > + * If pin_idx is less then zero, just try to find an available converter.
> > + * Otherwise, try to find an available converter and get the cvt mux
> index
> > + * of the pin.
> > + */
> >  static int hdmi_choose_cvt(struct hda_codec *codec,
> >  			int pin_idx, int *cvt_id, int *mux_id)
> >  {
> > @@ -1339,7 +1345,11 @@ static int hdmi_choose_cvt(struct
> hda_codec *codec,
> >  	struct hdmi_spec_per_cvt *per_cvt = NULL;
> >  	int cvt_idx, mux_idx = 0;
> >
> > -	per_pin = get_pin(spec, pin_idx);
> > +	/* pin_idx < 0 means no pin will be bound to the converter */
> > +	if (pin_idx < 0)
> > +		per_pin = NULL;
> > +	else
> > +		per_pin = get_pin(spec, pin_idx);
> >
> >  	/* Dynamically assign converter to stream */
> >  	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> > @@ -1348,6 +1358,8 @@ static int hdmi_choose_cvt(struct
> hda_codec *codec,
> >  		/* Must not already be assigned */
> >  		if (per_cvt->assigned)
> >  			continue;
> > +		if (per_pin == NULL)
> > +			break;
> >  		/* Must be in pin's mux's list of converters */
> >  		for (mux_idx = 0; mux_idx < per_pin->num_mux_nids;
> mux_idx++)
> >  			if (per_pin->mux_nids[mux_idx] == per_cvt-
> >cvt_nid)
> > @@ -1360,9 +1372,10 @@ static int hdmi_choose_cvt(struct
> hda_codec *codec,
> >
> >  	/* No free converters */
> >  	if (cvt_idx == spec->num_cvts)
> > -		return -ENODEV;
> > +		return -EBUSY;
> >
> > -	per_pin->mux_idx = mux_idx;
> > +	if (per_pin != NULL)
> > +		per_pin->mux_idx = mux_idx;
> >
> >  	if (cvt_id)
> >  		*cvt_id = cvt_idx;
> > @@ -1388,6 +1401,20 @@ static void
> intel_verify_pin_cvt_connect(struct hda_codec *codec,
> >  					    mux_idx);
> >  }
> >
> > +/* get the mux index for the converter of the pins
> > + * converter's mux index is the same for all pins on Intel platform
> > + */
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
> > +
> >  /* Intel HDMI workaround to fix audio routing issue:
> >   * For some Intel display codecs, pins share the same connection list.
> >   * So a conveter can be selected by multiple pins and playback on any
> of these
> > @@ -1439,6 +1466,69 @@ static void
> intel_not_share_assigned_cvt(struct hda_codec *codec,
> >  	}
> >  }
> >
> > +/* A wrapper of intel_not_share_asigned_cvt() */
> > +static void intel_not_share_assigned_cvt_nid(struct hda_codec
> *codec,
> > +			hda_nid_t pin_nid, hda_nid_t cvt_nid)
> > +{
> > +	int mux_idx;
> > +	struct hdmi_spec *spec = codec->spec;
> > +
> > +	if (!is_haswell_plus(codec) && !is_valleyview_plus(codec))
> > +		return;
> > +
> > +	/* On Intel platform, the mapping of converter nid to
> > +	 * mux index of the pins are always the same.
> > +	 * The pin nid may be 0, this means all pins will not
> > +	 * share the converter.
> > +	 */
> > +	mux_idx = intel_cvt_id_to_mux_idx(spec, cvt_nid);
> > +	if (mux_idx > 0)
> > +		intel_not_share_assigned_cvt(codec, pin_nid, mux_idx);
> > +}
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
> > +	int cvt_idx;
> > +	struct hdmi_spec_per_cvt *per_cvt = NULL;
> > +	int err;
> > +
> > +	err = hdmi_choose_cvt(codec, -1, &cvt_idx, NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	per_cvt = get_cvt(spec, cvt_idx);
> > +	per_cvt->assigned = 1;
> > +	hinfo->nid = per_cvt->cvt_nid;
> > +
> > +	intel_not_share_assigned_cvt_nid(codec, 0, per_cvt->cvt_nid);
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
> > @@ -1455,19 +1545,36 @@ static int hdmi_pcm_open(struct
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
> > @@ -1488,6 +1595,7 @@ static int hdmi_pcm_open(struct
> hda_pcm_stream *hinfo,
> >  	hinfo->formats = per_cvt->formats;
> >  	hinfo->maxbps = per_cvt->maxbps;
> >
> > +	eld = &per_pin->sink_eld;
> >  	/* Restrict capabilities by ELD if this isn't disabled */
> >  	if (!static_hdmi_pcm && eld->eld_valid) {
> >  		snd_hdmi_eld_update_pcm_info(&eld->info, hinfo);
> > @@ -1496,10 +1604,12 @@ static int hdmi_pcm_open(struct
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
> > @@ -1803,13 +1913,33 @@ static int
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
> > +		intel_not_share_assigned_cvt_nid(codec, 0, cvt_nid);
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
> > @@ -1838,7 +1968,7 @@ static int
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
> > @@ -1847,7 +1977,10 @@ static int
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
> > @@ -1878,9 +2011,17 @@ static int hdmi_pcm_close(struct
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
> > @@ -1900,6 +2041,7 @@ static int hdmi_pcm_close(struct
> hda_pcm_stream *hinfo,
> >  		per_pin->setup = false;
> >  		per_pin->channels = 0;
> >  		mutex_unlock(&per_pin->lock);
> > +		mutex_unlock(&spec->pcm_lock);
> >  	}
> >
> >  	return 0;
> > @@ -2370,6 +2512,7 @@ static int patch_generic_hdmi(struct
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
