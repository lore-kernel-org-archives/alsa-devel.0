From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - Ignore default pin config
 on Haswell HDMI codecs
Date: Tue, 4 Jun 2013 15:26:59 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011821B84@SHSMSX104.ccr.corp.intel.com>
References: <1370332965-3489-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC792615A6
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 17:27:03 +0200 (CEST)
In-Reply-To: <1370332965-3489-1-git-send-email-david.henningsson@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Li, Jocelyn" <jocelyn.li@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi David,

Did you test the patch and what exactly the issue it could fix?
We do have issue when play audio on the pin without physical device connected.i.e. you can hear sound on that pin.
I'm working on some patches to fix similar issues, also trying to fix issue like dual monitor audio routing.
So please let me know what's the scenario of this patch trying to fix.

thanks
--xingchao


> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, June 04, 2013 4:03 PM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; Wang, Xingchao; daniel@ffwll.ch; Lin, Mengdong;
> Girdwood, Liam R; Li, Jocelyn; David Henningsson
> Subject: [RFC PATCH] ALSA: hda - Ignore default pin config on Haswell HDMI
> codecs
> 
> According to Daniel Vetter, these pin configs should be ignored, because the
> graphics driver/userspace could route audio to these pins even if they are
> disabled by BIOS.
> 
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  sound/pci/hda/patch_hdmi.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> It would be good to have this acked by someone at Intel before committing.
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c index
> e12f7a0..8c1bede 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1307,12 +1307,14 @@ static int hdmi_add_pin(struct hda_codec *codec,
> hda_nid_t pin_nid)
>  	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
>  		return 0;
> 
> -	config = snd_hda_codec_get_pincfg(codec, pin_nid);
> -	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
> -		return 0;
> -
>  	if (codec->vendor_id == 0x80862807)
>  		intel_haswell_fixup_connect_list(codec, pin_nid);
> +	else {
> +		/* On Haswell, default pin config should be ignored */
> +		config = snd_hda_codec_get_pincfg(codec, pin_nid);
> +		if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
> +			return 0;
> +	}
> 
>  	pin_idx = spec->num_pins;
>  	per_pin = snd_array_new(&spec->pins);
> --
> 1.7.9.5
