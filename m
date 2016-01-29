From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - hdmi create spdif ctl based on
	pcm
Date: Fri, 29 Jan 2016 05:59:47 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190465BF87@SHSMSX103.ccr.corp.intel.com>
References: <1454046807-138480-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8120E26066D
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 06:59:51 +0100 (CET)
In-Reply-To: <1454046807-138480-1-git-send-email-libin.yang@linux.intel.com>
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
To: "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This patch is for DP MST audio, and for hda-mst branch.

Regards,
Libin


> -----Original Message-----
> From: libin.yang@linux.intel.com [mailto:libin.yang@linux.intel.com]
> Sent: Friday, January 29, 2016 1:53 PM
> To: alsa-devel@alsa-project.org; tiwai@suse.de
> Cc: Lin, Mengdong; Yang, Libin; Libin Yang
> Subject: [PATCH] ALSA: hda - hdmi create spdif ctl based on pcm
> 
> From: Libin Yang <libin.yang@linux.intel.com>
> 
> SPDIF ctl should be based on pcm. Each spdif ctl controls
> one pcm state.
> 
> This patch creates spdif based on pcm and no longer
> based on pin.
> 
> Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index dfb7c26..2f949fb 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2255,6 +2255,7 @@ static int hdmi_pcm_close(struct
> hda_pcm_stream *hinfo,
>  		hinfo->nid = 0;
> 
>  		mutex_lock(&spec->pcm_lock);
> +		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
>  		clear_bit(pcm_idx, &spec->pcm_in_use);
>  		pin_idx = hinfo_to_pin_index(codec, hinfo);
>  		if (spec->dyn_pcm_assign && pin_idx < 0) {
> @@ -2276,8 +2277,6 @@ static int hdmi_pcm_close(struct
> hda_pcm_stream *hinfo,
>  					    pinctl & ~PIN_OUT);
>  		}
> 
> -		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
> -
>  		mutex_lock(&per_pin->lock);
>  		per_pin->chmap_set = false;
>  		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
> @@ -2560,19 +2559,29 @@ static int
> generic_hdmi_build_controls(struct hda_codec *codec)
>  		err = generic_hdmi_build_jack(codec, pcm_idx);
>  		if (err < 0)
>  			return err;
> -	}
> 
> -	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> -		struct hdmi_spec_per_pin *per_pin = get_pin(spec,
> pin_idx);
> -
> -		err = snd_hda_create_dig_out_ctls(codec,
> +		/* create the spdif for each pcm
> +		 * pin will be bound when monitor is connected
> +		 */
> +		if (spec->dyn_pcm_assign)
> +			err = snd_hda_create_dig_out_ctls(codec,
> +					  0, spec->cvt_nids[0],
> +					  HDA_PCM_TYPE_HDMI);
> +		else {
> +			struct hdmi_spec_per_pin *per_pin =
> +				get_pin(spec, pcm_idx);
> +			err = snd_hda_create_dig_out_ctls(codec,
>  						  per_pin->pin_nid,
>  						  per_pin->mux_nids[0],
> 
> HDA_PCM_TYPE_HDMI);
> +		}
>  		if (err < 0)
>  			return err;
> -		/* pin number is the same with pcm number so far */
> -		snd_hda_spdif_ctls_unassign(codec, pin_idx);
> +		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
> +	}
> +
> +	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
> +		struct hdmi_spec_per_pin *per_pin = get_pin(spec,
> pin_idx);
> 
>  		/* add control for ELD Bytes */
>  		err = hdmi_create_eld_ctl(codec, pin_idx,
> --
> 1.9.1
