From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [PATCH RFC 4/4] ALSA: hda - Use component ops for
 i915 HDMI/DP audio jack handling
Date: Fri, 13 Nov 2015 09:55:25 +0800
Message-ID: <5645430D.8060903@linux.intel.com>
References: <1447345214-7212-1-git-send-email-tiwai@suse.de>
 <1447345214-7212-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4074226078A
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 02:57:03 +0100 (CET)
In-Reply-To: <1447345214-7212-5-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: mengdong.lin@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


On 11/13/2015 12:20 AM, Takashi Iwai wrote:
> Since we have a new audio component ops to fetch the current ELD and
> state now, we can reduce the usage of unsol event of HDMI/DP pins.
> The unsol event isn't only unreliable, but it also needs the power
> up/down of the codec and link at each time, which is a significant
> power and time loss.
>
> In this patch, the jack creation and unsol/jack event handling are
> modified to use the audio component for the dedicated Intel chips.
>
> The jack handling got slightly more codes than a simple usage of
> hda_jack layer since we need to deal directly with snd_jack object;
> the hda_jack layer is basically designed for the pin sense read and
> unsol events, both of which aren't used any longer in our case.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/patch_hdmi.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 60cd9e700909..ca1d2d4a295e 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -83,6 +83,7 @@ struct hdmi_spec_per_pin {
>   	struct mutex lock;
>   	struct delayed_work work;
>   	struct snd_kcontrol *eld_ctl;
> +	struct snd_jack *acomp_jack; /* jack via audio component */
>   	int repoll_count;
>   	bool setup; /* the stream has been set up by prepare callback */
>   	int channels; /* current number of channels */
> @@ -141,6 +142,7 @@ struct hdmi_spec {
>   	struct hdmi_ops ops;
>
>   	bool dyn_pin_out;
> +	bool use_acomp; /* use audio component for ELD notify/update */
>
>   	/*
>   	 * Non-generic VIA/NVIDIA specific
> @@ -1530,6 +1532,9 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
>   	return 0;
>   }
>
> +static void sync_eld_via_acomp(struct hda_codec *codec,
> +			       struct hdmi_spec_per_pin *per_pin);
> +
>   static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>   {
>   	struct hda_jack_tbl *jack;
> @@ -1551,6 +1556,11 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>   	bool eld_changed = false;
>   	bool ret;
>
> +	if (spec->use_acomp) {
> +		sync_eld_via_acomp(codec, per_pin);
> +		return false; /* don't call snd_hda_jack_report_sync() */

I think we still need call intel_verify_pin_cvt_connect(), 
intel_not_share_assigned_cvt() and hdmi_setup_audio_infoframe() as 
before if eld_valid is true.


> +	}
> +
>   	snd_hda_power_up_pm(codec);
>   	present = snd_hda_pin_sense(codec, pin_nid);
>
> @@ -2091,6 +2101,67 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
>   	return 0;
>   }
>
> +/* update ELD and jack state via audio component */
> +static void sync_eld_via_acomp(struct hda_codec *codec,
> +			       struct hdmi_spec_per_pin *per_pin)
> +{
> +	struct i915_audio_component *acomp = codec->bus->core.audio_component;
> +	struct hdmi_eld *eld = &per_pin->sink_eld;
> +	int size;
> +
> +	if (acomp && acomp->ops && acomp->ops->get_eld) {
> +		size = acomp->ops->get_eld(acomp->dev,
> +					   intel_pin2port(per_pin->pin_nid),
> +					   eld->eld_buffer,
> +					   ELD_MAX_SIZE);
> +		if (size < 0)
> +			return;
> +		if (size) {
> +			memset(&eld->info, 0, sizeof(eld->info));
> +			if (snd_hdmi_parse_eld(codec, &eld->info,
> +					       eld->eld_buffer,
> +					       size) < 0)
> +				size = 0;
> +		}
> +		if (size) {
> +			eld->monitor_present = true;
> +			eld->eld_valid = true;
> +			eld->eld_size = size;
> +
> +		} else {
> +			eld->monitor_present = false;
> +			eld->eld_valid = false;
> +			eld->eld_size = 0;
> +		}
> +		snd_jack_report(per_pin->acomp_jack,
> +				size ? SND_JACK_AVOUT : 0);


Is Jack report enough? Do we need call snd_ctl_notify() to notify eld 
change event as before?

Best Regards,
Libin

> +	}
> +}
> +
> +static void free_acomp_jack_priv(struct snd_jack *jack)
> +{
> +	struct hdmi_spec_per_pin *per_pin = jack->private_data;
> +
> +	per_pin->acomp_jack = NULL;
> +}
> +
> +static int add_acomp_jack_kctl(struct hda_codec *codec,
> +			       struct hdmi_spec_per_pin *per_pin,
> +			       const char *name)
> +{
> +	struct snd_jack *jack;
> +	int err;
> +
> +	err = snd_jack_new(codec->card, name, SND_JACK_AVOUT, &jack,
> +			   true, false);
> +	if (err < 0)
> +		return err;
> +	per_pin->acomp_jack = jack;
> +	jack->private_data = per_pin;
> +	jack->private_free = free_acomp_jack_priv;
> +	return 0;
> +}
> +
>   static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
>   {
>   	char hdmi_str[32] = "HDMI/DP";
> @@ -2101,6 +2172,8 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
>
>   	if (pcmdev > 0)
>   		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d", pcmdev);
> +	if (spec->use_acomp)
> +		return add_acomp_jack_kctl(codec, per_pin, hdmi_str);
>   	phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
>   	if (phantom_jack)
>   		strncat(hdmi_str, " Phantom",
> @@ -2196,6 +2269,8 @@ static int generic_hdmi_init(struct hda_codec *codec)
>   		hda_nid_t pin_nid = per_pin->pin_nid;
>
>   		hdmi_init_pin(codec, pin_nid);
> +		if (spec->use_acomp)
> +			continue;
>   		snd_hda_jack_detect_enable_callback(codec, pin_nid,
>   			codec->jackpoll_interval > 0 ? jack_callback : NULL);
>   	}
> @@ -2219,7 +2294,7 @@ static void generic_hdmi_free(struct hda_codec *codec)
>   	struct hdmi_spec *spec = codec->spec;
>   	int pin_idx;
>
> -	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
> +	if (spec->use_acomp)
>   		snd_hdac_i915_register_notifier(NULL);
>
>   	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> @@ -2227,6 +2302,8 @@ static void generic_hdmi_free(struct hda_codec *codec)
>
>   		cancel_delayed_work_sync(&per_pin->work);
>   		eld_proc_free(per_pin);
> +		if (per_pin->acomp_jack)
> +			snd_device_free(codec->card, per_pin->acomp_jack);
>   	}
>
>   	hdmi_array_free(spec);
> @@ -2381,7 +2458,9 @@ static int patch_generic_hdmi(struct hda_codec *codec)
>   	if (is_valleyview_plus(codec) || is_skylake(codec))
>   		codec->core.link_power_control = 1;
>
> -	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
> +	spec->use_acomp =
> +		is_haswell_plus(codec) || is_valleyview_plus(codec);
> +	if (spec->use_acomp) {
>   		codec->depop_delay = 0;
>   		spec->i915_audio_ops.audio_ptr = codec;
>   		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
>
