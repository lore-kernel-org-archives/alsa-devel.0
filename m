From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA : hda - not use assigned
 converters for all unused pins
Date: Tue, 17 Sep 2013 00:40:15 +0200
Message-ID: <523788CF.3060001@canonical.com>
References: <1379299244-18559-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F9C265043
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 00:40:17 +0200 (CEST)
In-Reply-To: <1379299244-18559-1-git-send-email-mengdong.lin@intel.com>
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

On 09/16/2013 04:40 AM, mengdong.lin@intel.com wrote:
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

Thanks for the patch!

> 
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 3d8cd044..4960695 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1152,29 +1152,34 @@ static void haswell_config_cvts(struct hda_codec *codec,
>  			int pin_id, int mux_id)
>  {
>  	struct hdmi_spec *spec = codec->spec;
> -	struct hdmi_spec_per_pin *per_pin;
> -	int pin_idx, mux_idx;
> +	hda_nid_t  pin_nid;
> +	int pin_idx, cvt_idx;
>  	int curr;
> -	int err;
> -
> -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> -		per_pin = get_pin(spec, pin_idx);
> +	struct hdmi_spec_per_cvt *per_cvt;
>  
> +	/* configure all 3 pins, including "no physical connection" ones */
> +	for (pin_nid = 5; pin_nid < 8; pin_nid++) {

It might not be so future proof to hard code nid IDs here (even if it
should be safe right now?). Perhaps more elegant to go through the
entire codec->nids array like being done here:

http://lxr.linux.no/linux+*/sound/pci/hda/hda_auto_parser.c#L188

The nid's wcaps is cached so it does not mean additional reads from the
codec.

> +		pin_idx = pin_nid_to_pin_index(spec, pin_nid);
>  		if (pin_idx == pin_id)
>  			continue;
>  
> -		curr = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
> +		curr = snd_hda_codec_read(codec, pin_nid, 0,
>  					  AC_VERB_GET_CONNECT_SEL, 0);
> +		if (curr != mux_id)
> +			continue;
> +
> +		for (cvt_idx = 0; cvt_idx < spec->num_cvts; cvt_idx++) {
> +			per_cvt = get_cvt(spec, cvt_idx);
>  
> -		/* Choose another unused converter */
> -		if (curr == mux_id) {
> -			err = hdmi_choose_cvt(codec, pin_idx, NULL, &mux_idx);
> -			if (err < 0)
> -				return;
> -			snd_printdd("HDMI: choose converter %d for pin %d\n", mux_idx, pin_idx);
> -			snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
> +			/* Must not already be assigned */
> +			if (!per_cvt->assigned) {
> +				snd_printdd("choose converter %d for pin %d\n",
> +					cvt_idx, pin_idx);
> +				snd_hda_codec_write_cache(codec, pin_nid, 0,
>  					    AC_VERB_SET_CONNECT_SEL,
> -					    mux_idx);
> +					    cvt_idx);
> +				break;
> +			}
>  		}
>  	}
>  }
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
