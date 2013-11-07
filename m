From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/3] ALSA: hda - Delay HDMI presence
 reports while waiting for ELD information
Date: Thu, 07 Nov 2013 17:25:35 +0200
Message-ID: <527BB0EF.3010202@iki.fi>
References: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
 <1383827905-2618-2-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D0E260323
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 16:25:41 +0100 (CET)
In-Reply-To: <1383827905-2618-2-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

07.11.2013 14:38, David Henningsson kirjoitti:
> From: Takashi Iwai <tiwai@suse.de>
> 
> ---
>  sound/pci/hda/patch_hdmi.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index e22323f..497e84d 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1140,7 +1140,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
>   * Unsolicited events
>   */
>  
> -static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
> +static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
>  
>  static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
>  {
> @@ -1166,8 +1166,8 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
>  	if (pin_idx < 0)
>  		return;
>  
> -	hdmi_present_sense(get_pin(spec, pin_idx), 1);
> -	snd_hda_jack_report_sync(codec);
> +	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
> +		snd_hda_jack_report_sync(codec);
>  }
>  
>  static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
> @@ -1475,7 +1475,7 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
>  	return 0;
>  }
>  
> -static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
> +static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>  {
>  	struct hda_codec *codec = per_pin->codec;
>  	struct hdmi_spec *spec = codec->spec;
> @@ -1493,6 +1493,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>  	int present = snd_hda_pin_sense(codec, pin_nid);
>  	bool update_eld = false;
>  	bool eld_changed = false;
> +	bool ret;
>  
>  	mutex_lock(&per_pin->lock);
>  	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
> @@ -1559,7 +1560,12 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>  			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
>  			       &per_pin->eld_ctl->id);
>   unlock:
> +	if ((codec->vendor_id & 0xffff0000) == 0x10020000)
> +		ret = true; /* FIXME: implement fake ELD for AMD */
> +	else
> +		ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;

Hmm, what is the reason for this special AMD handling?

AFAICS the AMD behavior should be the same as generic codecs from the
perspective of this code, i.e. the repolling mechanism, monitor_present
and eld_valid work the same.


>  	mutex_unlock(&per_pin->lock);
> +	return ret;
>  }
>  
>  static void hdmi_repoll_eld(struct work_struct *work)
> @@ -1570,7 +1576,8 @@ static void hdmi_repoll_eld(struct work_struct *work)
>  	if (per_pin->repoll_count++ > 6)
>  		per_pin->repoll_count = 0;
>  
> -	hdmi_present_sense(per_pin, per_pin->repoll_count);
> +	if (hdmi_present_sense(per_pin, per_pin->repoll_count))
> +		snd_hda_jack_report_sync(per_pin->codec);
>  }
>  
>  static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
> 


-- 
Anssi Hannula
