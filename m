From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda: Disable odd numbered channels
 on	HDMI controllers.
Date: Fri, 14 Jan 2011 11:14:16 +0200
Message-ID: <4D3013E8.9050500@iki.fi>
References: <1294949987-11389-1-git-send-email-ndaga@nvidia.com>	<4D2F63BF.8000308@iki.fi>
	<s5hy66neupv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id ED4B4103B89
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 10:14:21 +0100 (CET)
In-Reply-To: <s5hy66neupv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 14.01.2011 10:49, Takashi Iwai wrote:
> At Thu, 13 Jan 2011 22:42:39 +0200,
> Anssi Hannula wrote:
>>
>> On 13.01.2011 22:19, Nitin Daga wrote:
>>> Added code in hda_intel.c to disable odd numbered channels
>>> not supported by HDMI controllers.
>>>
>>> Signed-off-by: Nitin Daga <ndaga@nvidia.com>
>>> Acked-By: Stephen Warren <swarren@nvidia.com>
>>> ---
>>>  pci/hda/hda_intel.c |   13 +++++++++++++
>>>  1 files changed, 13 insertions(+), 0 deletions(-)
[...]
>> This would seem simpler and more generic (there are codecs that have
>> over 8 channels):
>> snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>>
>> However, either of those would AFAICS break Si3054 Modem codec which is
>> mono-only.
>>
>> Maybe just add the constraint to patch_hdmi.c?
> 
> Yes, looks so.  I applied the following patch instead.

It is ineffective, the generic hdmi devices use hdmi_pcm_open() instead
of simple_playback_pcm_open().

> Alternatively, we can check channels_min and channels_max that are
> already set in hda_intel.c::azx_pcm_open(), and apply the hw_constraint
> only when channels_min%2==0 or such.
> 
> But, as we aren't 100% sure whether the odd number of channels work
> with other (analog) codecs, it's safer to limit only for HDMI for the
> time being.

Well, snd_hda_multi_out_analog_open() already sets such a constraint,
but I didn't check if all the analog multichannel codecs use that.

> thanks,
> 
> Takashi
> 
> ---
> From ad09fc9d2156f3d37537b34418a6b79309013d33 Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Fri, 14 Jan 2011 09:42:27 +0100
> Subject: [PATCH] ALSA: hda - Suppress the odd number of channels for HDMI
> 
> It looks like that HDMI codecs don't support the odd number of channels
> although HD-audio spec doesn't have the restriction.  Add the
> hw_constraint to limit to only the even number of channels.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_hdmi.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index f29b97b..2d28879 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1238,6 +1238,9 @@ static int simple_playback_pcm_open(struct hda_pcm_stream *hinfo,
>  		snd_pcm_hw_constraint_list(substream->runtime, 0,
>  				SNDRV_PCM_HW_PARAM_CHANNELS,
>  				hw_constraints_channels);
> +	} else {
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>  	}
>  
>  	return snd_hda_multi_out_dig_open(codec, &spec->multiout);


-- 
Anssi Hannula
