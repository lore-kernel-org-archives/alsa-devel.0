From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Bug in setting channels,
 related to recent ELD/EDID changes?
Date: Tue, 11 Jan 2011 18:58:51 +0200
Message-ID: <4D2C8C4B.1030202@iki.fi>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>	<4D12E292.9050204@iki.fi>	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>	<4D20508C.7070609@iki.fi>	<s5hoc7ok05l.wl%tiwai@suse.de>	<3a46493bd2a1ec3b74c89cb6970c9ab0.squirrel@mail.onse.fi>	<s5hk4icjy2t.wl%tiwai@suse.de>
	<s5hbp3nkj1z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id B675F1038AE
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:58:55 +0100 (CET)
In-Reply-To: <s5hbp3nkj1z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: VDR User <user.vdr@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(restored CC I removed, sorry about that)

On 11.01.2011 09:15, Takashi Iwai wrote:
> At Mon, 10 Jan 2011 21:36:10 +0100,
> Takashi Iwai wrote:
>>
>> At Mon, 10 Jan 2011 21:58:26 +0200,
>> Anssi Hannula wrote:
>>>
>>>
>>> Takashi Iwai kirjoitti:
>>>> At Sun, 02 Jan 2011 12:16:44 +0200,
>>>> Anssi Hannula wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>> Takashi, it seems the "allow all when not plugged in" behaviour you
>>>>> implemented in bbbe3390 is not enough to allow applications to open the
>>>>> device before the output device is ready. Switched-off A/V receivers may
>>>>> provide the information of the plugged-in television which usually
>>>>> restricts the max_channels to 2, causing applications to fail opening
>>>>> the device with more channels when a the A/V receiver is switched off.
>>>>>
>>>>> Also, even if the application can gracefully fallback to stereo, AFAIK
>>>>> there is no method for an application to get informed when the
>>>>> limitation is lifted, so it can't automatically resume multichannel
>>>>> output when the A/V receiver is switched on again.
>>>>>
>>>>> Based on this info, I guess the restrictions based on ELD should be
>>>>> removed :/
>>>>> Unless you have some other ideas to fix the issue, of course.
>>>>
>>>> What about the patch below?  If it's unplugged, the valid flag should
>>>> be cleared, so the next open fall backs to the default state (i.e.
>>>> allows all).
>>>
>>> But it is not unplugged. The multichannel-capable receiver forwards EDID
>>> of TV which doesn't allow more than 2 channels, when the receiver is
>>> swtiched off.
>>
>> Well, in that case, this is the correct behavior, IMO.  At this
>> moment, setting channels to 2 is the right thing.  Then, how can you
>> know that more channels will be available in future at all?
>>
>> What you want to have a static configuration way by ignoring the ELD
>> information.  But, the interface isn't pretty easy if it's implemented
>> in control API, I suppose.
> 
> ... or, maybe an easier option is to use the module parameter like
> the patch below.  It can be changed dynamically via sysfs as well.

Better than nothing I guess.

Note that the condition is backwards in the below patch :)

> ---
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index d1b1b57..4115a39 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -31,10 +31,14 @@
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/moduleparam.h>
>  #include <sound/core.h>
>  #include "hda_codec.h"
>  #include "hda_local.h"
>  
> +static bool static_hdmi_pcm;
> +module_param(static_hdmi_pcm, bool, 0644);
> +
>  /*
>   * The HDMI/DisplayPort configuration can be highly dynamic. A graphics device
>   * could support two independent pipes, each of them can be connected to one or
> @@ -827,7 +831,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>  		*codec_pars = *hinfo;
>  
>  	eld = &spec->sink_eld[idx];
> -	if (eld->sad_count > 0) {
> +	if (static_hdmi_pcm && eld->sad_count > 0) {
>  		hdmi_eld_update_pcm_info(eld, hinfo, codec_pars);
>  		if (hinfo->channels_min > hinfo->channels_max ||
>  		    !hinfo->rates || !hinfo->formats)


-- 
Anssi Hannula
