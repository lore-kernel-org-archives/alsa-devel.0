From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - unmute pin amplifier in
 infoframe setup for Haswell
Date: Wed, 04 Sep 2013 11:55:27 +0200
Message-ID: <5227038F.1070500@canonical.com>
References: <1378240705-27681-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 635482654D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 11:55:29 +0200 (CEST)
In-Reply-To: <1378240705-27681-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2013 10:38 PM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> When Gfx driver reconnects a port and transcoder, the pin amplifier will be
> muted. To enable sound, the pin amp need to be unmuted.
> 
> This patch
> - moves pin amp unmuting from stream preparing to hdmi_setup_audio_infoframe().
>   So if port:transcoder reconnection happens during stream playback, the ELDV
>   unsol event can stil trigger pin's amp unmuting when re-setting up audio
>   info frame.
> 
> - remove reading pin amp status before unmuting for speed-up, since pin amp
>   should always be unmuted.
> 
> - rename haswell_verify_pin_D0() to haswell_verify_pin_cvt_D0(), since the
>   convertor power state is also fixed here.

Or just haswell_verify_D0. Anyway, looks good to me.

> - define is_haswell() to replace checking Haswell vendor ID everywhere.

I agree with this, but Takashi might want refactoring and behavioural
changes in different patches.

Side note: One can also wonder what happens in future generations of
Intel hardware (Broadwell etc), if we end up with a
is_haswell_or_broadwell_or_somethingwell_or_verywell() after a while :-)

> 
> This patch is mostly based on suggestion of David Henningsson.
> 
> Cc: David Henningsson <david.henningsson@canonical.com>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 9a58893..471c158 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -44,6 +44,8 @@ static bool static_hdmi_pcm;
>  module_param(static_hdmi_pcm, bool, 0644);
>  MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
>  
> +#define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
> +
>  struct hdmi_spec_per_cvt {
>  	hda_nid_t cvt_nid;
>  	int assigned;
> @@ -894,6 +896,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
>  	if (!channels)
>  		return;
>  
> +	if (is_haswell(codec))
> +		snd_hda_codec_write(codec, pin_nid, 0,
> +					    AC_VERB_SET_AMP_GAIN_MUTE,
> +					    AMP_OUT_UNMUTE);
> +
>  	eld = &per_pin->sink_eld;
>  	if (!eld->monitor_present)
>  		return;
> @@ -1033,10 +1040,10 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
>  		hdmi_non_intrinsic_event(codec, res);
>  }
>  
> -static void haswell_verify_pin_D0(struct hda_codec *codec,
> +static void haswell_verify_pin_cvt_D0(struct hda_codec *codec,
>  		hda_nid_t cvt_nid, hda_nid_t nid)
>  {
> -	int pwr, lamp, ramp;
> +	int pwr;
>  
>  	/* For Haswell, the converter 1/2 may keep in D3 state after bootup,
>  	 * thus pins could only choose converter 0 for use. Make sure the
> @@ -1052,25 +1059,6 @@ static void haswell_verify_pin_D0(struct hda_codec *codec,
>  		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
>  		snd_printd("Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
>  	}
> -
> -	lamp = snd_hda_codec_read(codec, nid, 0,
> -				  AC_VERB_GET_AMP_GAIN_MUTE,
> -				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
> -	ramp = snd_hda_codec_read(codec, nid, 0,
> -				  AC_VERB_GET_AMP_GAIN_MUTE,
> -				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
> -	if (lamp != ramp) {
> -		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
> -				    AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT | lamp);
> -
> -		lamp = snd_hda_codec_read(codec, nid, 0,
> -				  AC_VERB_GET_AMP_GAIN_MUTE,
> -				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
> -		ramp = snd_hda_codec_read(codec, nid, 0,
> -				  AC_VERB_GET_AMP_GAIN_MUTE,
> -				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
> -		snd_printd("Haswell HDMI audio: Mute after set on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
> -	}
>  }
>  
>  /*
> @@ -1087,8 +1075,8 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>  	int pinctl;
>  	int new_pinctl = 0;
>  
> -	if (codec->vendor_id == 0x80862807)
> -		haswell_verify_pin_D0(codec, cvt_nid, pin_nid);
> +	if (is_haswell(codec))
> +		haswell_verify_pin_cvt_D0(codec, cvt_nid, pin_nid);
>  
>  	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
>  		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
> @@ -1227,7 +1215,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>  			    mux_idx);
>  
>  	/* configure unused pins to choose other converters */
> -	if (codec->vendor_id == 0x80862807)
> +	if (is_haswell(codec))
>  		haswell_config_cvts(codec, pin_idx, mux_idx);
>  
>  	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
> @@ -1358,14 +1346,10 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>  		/* Haswell-specific workaround: re-setup when the transcoder is
>  		 * changed during the stream playback
>  		 */
> -		if (codec->vendor_id == 0x80862807 &&
> -		    eld->eld_valid && !old_eld_valid && per_pin->setup) {
> -			snd_hda_codec_write(codec, pin_nid, 0,
> -					    AC_VERB_SET_AMP_GAIN_MUTE,
> -					    AMP_OUT_UNMUTE);
> +		if (is_haswell(codec) &&
> +		    eld->eld_valid && !old_eld_valid && per_pin->setup)
>  			hdmi_setup_audio_infoframe(codec, per_pin,
>  						   per_pin->non_pcm);
> -		}
>  	}
>  	mutex_unlock(&pin_eld->lock);
>  
> @@ -1405,7 +1389,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>  	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
>  		return 0;
>  
> -	if (codec->vendor_id == 0x80862807)
> +	if (is_haswell(codec))
>  		intel_haswell_fixup_connect_list(codec, pin_nid);
>  
>  	pin_idx = spec->num_pins;
> @@ -2014,7 +1998,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
>  	codec->spec = spec;
>  	hdmi_array_init(spec, 4);
>  
> -	if (codec->vendor_id == 0x80862807) {
> +	if (is_haswell(codec)) {
>  		intel_haswell_enable_all_pins(codec, true);
>  		intel_haswell_fixup_enable_dp12(codec);
>  	}
> @@ -2025,7 +2009,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
>  		return -EINVAL;
>  	}
>  	codec->patch_ops = generic_hdmi_patch_ops;
> -	if (codec->vendor_id == 0x80862807) {
> +	if (is_haswell(codec)) {
>  		codec->patch_ops.set_power_state = haswell_set_power_state;
>  		codec->dp_mst = true;
>  	}
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
