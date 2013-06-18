From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] ALSA: hda - Avoid choose same converter
	for unused pins
Date: Tue, 18 Jun 2013 09:03:05 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011830FBC@SHSMSX104.ccr.corp.intel.com>
References: <1371544321-27812-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 27504261600
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 11:03:11 +0200 (CEST)
In-Reply-To: <1371544321-27812-1-git-send-email-xingchao.wang@linux.intel.com>
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
To: "tiwai@suse.de" <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi/Daniel,

This patch could be used to replace below two:
http://lists.freedesktop.org/archives/intel-gfx/2013-June/029076.html
http://lists.freedesktop.org/archives/intel-gfx/2013-June/029077.html

It could avoid lots of changes in gfx side.
I test the patch and it could fix the same routing issues.

thanks
--xingchao


> -----Original Message-----
> From: Wang Xingchao [mailto:xingchao.wang@linux.intel.com]
> Sent: Tuesday, June 18, 2013 4:32 PM
> To: tiwai@suse.de
> Cc: daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> intel-gfx@lists.freedesktop.org; Wang, Xingchao; Wang Xingchao
> Subject: [PATCH] ALSA: hda - Avoid choose same converter for unused pins
> 
> For Intel Haswell HDMI codecs, the pins choose converter 0 by default.
> This would cause conflict when playing audio on unused pins,the pin with
> physical device connected would get audio data too.
> i.e. Pin 0/1/2 default choose converter 0, pin 1 has HDMI monitor connected.
> when play audio on Pin 0 or pin 2, pin 1 could get audio data too.
> 
> This patch configure unused pins to choose different converter.
> 
> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c |   89
> +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c index
> 8983747..e887584 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1110,26 +1110,15 @@ static int hdmi_setup_stream(struct hda_codec
> *codec, hda_nid_t cvt_nid,
>  	return 0;
>  }
> 
> -/*
> - * HDA PCM callbacks
> - */
> -static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> -			 struct hda_codec *codec,
> -			 struct snd_pcm_substream *substream)
> +static int hdmi_choose_cvt(struct hda_codec *codec,
> +			int pin_idx, int *cvt_id, int *mux_id)
>  {
>  	struct hdmi_spec *spec = codec->spec;
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> -	int pin_idx, cvt_idx, mux_idx = 0;
>  	struct hdmi_spec_per_pin *per_pin;
> -	struct hdmi_eld *eld;
>  	struct hdmi_spec_per_cvt *per_cvt = NULL;
> +	int cvt_idx, mux_idx = 0;
> 
> -	/* Validate hinfo */
> -	pin_idx = hinfo_to_pin_index(spec, hinfo);
> -	if (snd_BUG_ON(pin_idx < 0))
> -		return -EINVAL;
>  	per_pin = get_pin(spec, pin_idx);
> -	eld = &per_pin->sink_eld;
> 
>  	/* Dynamically assign converter to stream */
>  	for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) { @@ -1147,10
> +1136,77 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>  			continue;
>  		break;
>  	}
> +
>  	/* No free converters */
>  	if (cvt_idx == spec->num_cvts)
>  		return -ENODEV;
> 
> +	if (cvt_id)
> +		*cvt_id = cvt_idx;
> +	if (mux_id)
> +		*mux_id = mux_idx;
> +
> +	return 0;
> +}
> +
> +static void haswell_config_cvts(struct hda_codec *codec,
> +			int pin_id, int mux_id)
> +{
> +	struct hdmi_spec *spec = codec->spec;
> +	struct hdmi_spec_per_pin *per_pin;
> +	int pin_idx, mux_idx;
> +	int curr = -1;
> +	int err;
> +
> +	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> +		per_pin = get_pin(spec, pin_idx);
> +
> +		if (pin_idx == pin_id)
> +			continue;
> +
> +		curr = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
> +					  AC_VERB_GET_CONNECT_SEL, 0);
> +
> +		/* Choose another unused converter */
> +		if (curr == mux_id) {
> +			err = hdmi_choose_cvt(codec, pin_idx, NULL, &mux_idx);
> +			if (err < 0)
> +				return;
> +			snd_printk("HDMI: choose converter %d for pin %d\n", mux_idx,
> pin_idx);
> +			snd_hda_codec_write(codec, per_pin->pin_nid, 0,
> +					    AC_VERB_SET_CONNECT_SEL,
> +					    mux_idx);
> +		}
> +	}
> +}
> +
> +/*
> + * HDA PCM callbacks
> + */
> +static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> +			 struct hda_codec *codec,
> +			 struct snd_pcm_substream *substream) {
> +	struct hdmi_spec *spec = codec->spec;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int pin_idx, cvt_idx, mux_idx = 0;
> +	struct hdmi_spec_per_pin *per_pin;
> +	struct hdmi_eld *eld;
> +	struct hdmi_spec_per_cvt *per_cvt = NULL;
> +	int err;
> +
> +	/* Validate hinfo */
> +	pin_idx = hinfo_to_pin_index(spec, hinfo);
> +	if (snd_BUG_ON(pin_idx < 0))
> +		return -EINVAL;
> +	per_pin = get_pin(spec, pin_idx);
> +	eld = &per_pin->sink_eld;
> +
> +	err = hdmi_choose_cvt(codec, pin_idx, &cvt_idx, &mux_idx);
> +	if (err < 0)
> +		return err;
> +
> +	per_cvt = get_cvt(spec, cvt_idx);
>  	/* Claim converter */
>  	per_cvt->assigned = 1;
>  	hinfo->nid = per_cvt->cvt_nid;
> @@ -1158,6 +1214,11 @@ static int hdmi_pcm_open(struct hda_pcm_stream
> *hinfo,
>  	snd_hda_codec_write(codec, per_pin->pin_nid, 0,
>  			    AC_VERB_SET_CONNECT_SEL,
>  			    mux_idx);
> +
> +	/* configure unused pins to choose other converters */
> +	if (codec->vendor_id == 0x80862807)
> +		haswell_config_cvts(codec, pin_idx, mux_idx);
> +
>  	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
> 
>  	/* Initially set the converter's capabilities */
> --
> 1.7.9.5
