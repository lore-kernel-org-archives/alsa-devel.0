From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 5/5] ALSA: hda - hdmi: Disable ramp-up/down
 for non-PCM on AMD codecs
Date: Thu, 24 Oct 2013 22:00:24 +0300
Message-ID: <52696E48.80105@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <1382638238-25055-6-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 5045E261641
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 21:00:30 +0200 (CEST)
In-Reply-To: <1382638238-25055-6-git-send-email-anssi.hannula@iki.fi>
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
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

24.10.2013 21:10, Anssi Hannula kirjoitti:
> Recent AMD HDMI codecs (revision ID 3 and later, 0x100300 as reported by
> procfs codec#0) have a configurable ramp-up/down functionality.
> 
> The documentation ( http://www.x.org/docs/AMD/AMD_HDA_verbs_v2.pdf )
> specifies that 180 ("180/256 =~ 0.7") is recommended for PCM and 0 for
> non-PCM.
> 
> Apply the recommended values according to provided S/PDIF AES0 settings
> since ramp-up/down does not make sense for non-PCM.
> 
> v2: adapted to hdmi_ops infrastructure
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Tested-by: Olivier Langlois <olivier@trillion01.com> # v1

Hmm, actually, re-reading mails reveals that Olivier didn't find the
expected difference with this setting, except for "maybe slightly slower
startup with AES0=6" (i.e. value 0, which is unexpected).

So maybe
a) it makes too unnoticiable a difference, or
b) only affects certain hardware (card and/or sink), or
c) ramp-up/down is only triggered with the MUTE bit of
   ATI_VERB_SET_MULTICHANNEL_xx which is also rev3+ specific,
   but is not presently used by the driver,
or something else.

So there's a significant chance setting ramp rate is useless for us ATM,
but probably does not do actual harm either.

Takashi, I'll leave it to you whether to apply this one (if you apply,
feel free to add to patch description e.g. "No actual playback
difference has been found in testing, so possibly something more is
needed for ramp-up/down.").

I guess I might investigate the ramp-up/down/MUTE-bit stuff more at some
point, but probably not in the next few months...


> ---
>  sound/pci/hda/patch_hdmi.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 2c45591..74bd2e63ce 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2819,6 +2819,10 @@ static int patch_nvhdmi_8ch_7x(struct hda_codec *codec)
>  #define ATI_VERB_GET_MULTICHANNEL_7	0xf88
>  #define ATI_VERB_GET_MULTICHANNEL_MODE	0xf89
>  
> +/* AMD specific HDA cvt verbs */
> +#define ATI_VERB_SET_RAMP_RATE		0x770
> +#define ATI_VERB_GET_RAMP_RATE		0xf70
> +
>  #define ATI_OUT_ENABLE 0x1
>  
>  #define ATI_MULTICHANNEL_MODE_PAIRED	0
> @@ -3050,6 +3054,23 @@ static int atihdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
>  	return 0;
>  }
>  
> +static int atihdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
> +				hda_nid_t pin_nid, u32 stream_tag, int format)
> +{
> +
> +	if (is_amdhdmi_rev3_or_later(codec)) {
> +		int ramp_rate = 180; /* default as per AMD spec */
> +		/* disable ramp-up/down for non-pcm as per AMD spec */
> +		if (format & AC_FMT_TYPE_NON_PCM)
> +			ramp_rate = 0;
> +
> +		snd_hda_codec_write(codec, cvt_nid, 0, ATI_VERB_SET_RAMP_RATE, ramp_rate);
> +	}
> +
> +	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
> +}
> +
> +
>  static int atihdmi_init(struct hda_codec *codec)
>  {
>  	struct hdmi_spec *spec = codec->spec;
> @@ -3096,6 +3117,7 @@ static int patch_atihdmi(struct hda_codec *codec)
>  	spec->ops.pin_set_slot_channel = atihdmi_pin_set_slot_channel;
>  	spec->ops.pin_setup_infoframe = atihdmi_pin_setup_infoframe;
>  	spec->ops.pin_hbr_setup = atihdmi_pin_hbr_setup;
> +	spec->ops.setup_stream = atihdmi_setup_stream;
>  
>  	if (!has_amd_full_remap_support(codec)) {
>  		/* override to ATI/AMD-specific versions with pairwise mapping */
> 
-- 
Anssi Hannula
