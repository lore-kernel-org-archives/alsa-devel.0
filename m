From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2] ALSA : hda - not use assigned
 converters for all unused pins
Date: Wed, 25 Sep 2013 12:45:04 +0200
Message-ID: <5242BEB0.3020901@canonical.com>
References: <1379810085-25931-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 733CF261AFE
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 12:45:06 +0200 (CEST)
In-Reply-To: <1379810085-25931-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 09/22/2013 02:34 AM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> BIOS can mark a pin as "no physical connection" if the port is used by an
> integrated display which is not audio capable. And audio driver will overlook
> such pins.
> 
> On Haswell, such a disconneted pin will keep muted and connected to the 1st
> converter by default. But if the 1st convertor is assigned to a connected pin
> for audio streaming. The muted disconnected pin can make the connected pin
> no sound output.
> 
> So this patch avoids using assigned converters for all unused pins for Haswell,
> including the disconected pins.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

For the record, we have tested the previous version of this patch and
confirmed it was working, and the changes here look good, so I'm all for
applying it.

Reviewed-by: David Henningsson <david.henningsson@canonical.com>

> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 3d8cd044..7ea0245 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1149,32 +1149,43 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
>  }
>  
>  static void haswell_config_cvts(struct hda_codec *codec,
> -			int pin_id, int mux_id)
> +			hda_nid_t pin_nid, int mux_idx)
>  {
>  	struct hdmi_spec *spec = codec->spec;
> -	struct hdmi_spec_per_pin *per_pin;
> -	int pin_idx, mux_idx;
> -	int curr;
> -	int err;
> +	hda_nid_t nid, end_nid;
> +	int cvt_idx, curr;
> +	struct hdmi_spec_per_cvt *per_cvt;
>  
> -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> -		per_pin = get_pin(spec, pin_idx);
> +	/* configure all pins, including "no physical connection" ones */
> +	end_nid = codec->start_nid + codec->num_nodes;
> +	for (nid = codec->start_nid; nid < end_nid; nid++) {
> +		unsigned int wid_caps = get_wcaps(codec, nid);
> +		unsigned int wid_type = get_wcaps_type(wid_caps);
>  
> -		if (pin_idx == pin_id)
> +		if (wid_type != AC_WID_PIN)
>  			continue;
>  
> -		curr = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
> +		if (nid == pin_nid)
> +			continue;
> +
> +		curr = snd_hda_codec_read(codec, nid, 0,
>  					  AC_VERB_GET_CONNECT_SEL, 0);
> +		if (curr != mux_idx)
> +			continue;
>  
> -		/* Choose another unused converter */
> -		if (curr == mux_id) {
> -			err = hdmi_choose_cvt(codec, pin_idx, NULL, &mux_idx);
> -			if (err < 0)
> -				return;
> -			snd_printdd("HDMI: choose converter %d for pin %d\n", mux_idx, pin_idx);
> -			snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
> +		/* choose an unassigned converter. The conveters in the
> +		 * connection list are in the same order as in the codec.
> +		 */
> +		for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> +			per_cvt = get_cvt(spec, cvt_idx);
> +			if (!per_cvt->assigned) {
> +				snd_printdd("choose cvt %d for pin nid %d\n",
> +					cvt_idx, nid);
> +				snd_hda_codec_write_cache(codec, nid, 0,
>  					    AC_VERB_SET_CONNECT_SEL,
> -					    mux_idx);
> +					    cvt_idx);
> +				break;
> +			}
>  		}
>  	}
>  }
> @@ -1216,7 +1227,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>  
>  	/* configure unused pins to choose other converters */
>  	if (is_haswell(codec))
> -		haswell_config_cvts(codec, pin_idx, mux_idx);
> +		haswell_config_cvts(codec, per_pin->pin_nid, mux_idx);
>  
>  	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
>  
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
