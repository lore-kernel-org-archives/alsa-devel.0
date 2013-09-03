From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Re-setup HDMI pin and audio
 infoframe on stream switches
Date: Tue, 03 Sep 2013 15:09:48 +0200
Message-ID: <5225DF9C.7090807@canonical.com>
References: <1378202279-14990-1-git-send-email-tiwai@suse.de>
 <5225C3B3.8030108@canonical.com> <s5hvc2i9kj1.wl%tiwai@suse.de>
 <5225D7BD.1060005@canonical.com> <s5hr4d69imz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D082652F5
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 15:09:49 +0200 (CEST)
In-Reply-To: <s5hr4d69imz.wl%tiwai@suse.de>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2013 02:47 PM, Takashi Iwai wrote:
> At Tue, 03 Sep 2013 14:36:13 +0200,
> David Henningsson wrote:
>>
>> On 09/03/2013 02:06 PM, Takashi Iwai wrote:
>>> At Tue, 03 Sep 2013 13:10:43 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 09/03/2013 11:57 AM, Takashi Iwai wrote:
>>>>> When the transcoder:port mapping on Haswell HDMI/DP audio is changed
>>>>> during the stream playback, the sound gets lost.  Typically this
>>>>> problem is seen when the user switches the graphics mode from eDP+DP
>>>>> to DP-only configuration, where CRTC 1 is used for DP in the former
>>>>> while CRTC 0 is used for the latter.
>>>>>
>>>>> The graphics controller notifies the change via the normal ELD update
>>>>> procedure, so we get the intrinsic event.  For enabling the sound
>>>>> again, the HDMI audio driver needs to reset the pin and set up the
>>>>> audio infoframe again.
>>>>
>>>> Thanks for working on this!
>>>>
>>>> See a review comment below.
>>>>
>>>>>
>>>>> This patch achieves it by:
>>>>> - keep the current status of channels and info frame setup in per_pin
>>>>>   struct,
>>>>> - check the reconnection in the intrinsic event handler,
>>>>> - reset the pin and the re-invoke hdmi_setup_audio_infoframe()
>>>>>   accordingly.
>>>>>
>>>>> The hdmi_setup_audio_infoframe() function has been changed, too, so
>>>>> that it can be invoked without passing the substream instance.
>>>>>
>>>>> The patch is mostly based on the work by Mengdong Lin.
>>>>>
>>>>> Cc: Mengdong Lin <mengdong.lin@intel.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>>> ---
>>>>>  sound/pci/hda/patch_hdmi.c | 41 +++++++++++++++++++++++++++++++----------
>>>>>  1 file changed, 31 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>>> index b83b14f..22b5089 100644
>>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>>> @@ -67,6 +67,8 @@ struct hdmi_spec_per_pin {
>>>>>  	struct delayed_work work;
>>>>>  	struct snd_kcontrol *eld_ctl;
>>>>>  	int repoll_count;
>>>>> +	bool setup; /* the stream has been set up by prepare callback */
>>>>> +	int channels; /* current number of channels */
>>>>>  	bool non_pcm;
>>>>>  	bool chmap_set;		/* channel-map override by ALSA API? */
>>>>>  	unsigned char chmap[8]; /* ALSA API channel-map */
>>>>> @@ -879,18 +881,19 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
>>>>>  	return true;
>>>>>  }
>>>>>  
>>>>> -static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
>>>>> -				       bool non_pcm,
>>>>> -				       struct snd_pcm_substream *substream)
>>>>> +static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
>>>>> +				       struct hdmi_spec_per_pin *per_pin,
>>>>> +				       bool non_pcm)
>>>>>  {
>>>>> -	struct hdmi_spec *spec = codec->spec;
>>>>> -	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
>>>>>  	hda_nid_t pin_nid = per_pin->pin_nid;
>>>>> -	int channels = substream->runtime->channels;
>>>>> +	int channels = per_pin->channels;
>>>>>  	struct hdmi_eld *eld;
>>>>>  	int ca;
>>>>>  	union audio_infoframe ai;
>>>>>  
>>>>> +	if (!channels)
>>>>> +		return;
>>>>> +
>>>>>  	eld = &per_pin->sink_eld;
>>>>>  	if (!eld->monitor_present)
>>>>>  		return;
>>>>> @@ -1341,6 +1344,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>>>>>  		eld_changed = true;
>>>>>  	}
>>>>>  	if (update_eld) {
>>>>> +		bool old_eld_valid = pin_eld->eld_valid;
>>>>>  		pin_eld->eld_valid = eld->eld_valid;
>>>>>  		eld_changed = pin_eld->eld_size != eld->eld_size ||
>>>>>  			      memcmp(pin_eld->eld_buffer, eld->eld_buffer,
>>>>> @@ -1350,6 +1354,18 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>>>>>  			       eld->eld_size);
>>>>>  		pin_eld->eld_size = eld->eld_size;
>>>>>  		pin_eld->info = eld->info;
>>>>> +
>>>>> +		/* Haswell-specific workaround: re-setup when the transcoder is
>>>>> +		 * changed during the stream playback
>>>>> +		 */
>>>>> +		if (codec->vendor_id == 0x80862807 &&
>>>>> +		    eld->eld_valid && !old_eld_valid && per_pin->setup) {
>>>>> +			snd_hda_codec_write(codec, pin_nid, 0,
>>>>> +					    AC_VERB_SET_AMP_GAIN_MUTE,
>>>>> +					    AMP_OUT_UNMUTE);
>>>>
>>>> If the system is deliberately muted by turning off "IEC958 Playback
>>>> Switch", are we now ignoring that and turning it back on?
>>>
>>> The pin amp is always unmuted.  The IEC958 Playback Switch is
>>> controlled via IEC958 status bits instead.
>>
>> Ok.
>>
>>>
>>>> Also, this looks a bit like the workaround I added a while back
>>>> (83f26ad2c909083fa6 - ALSA: hda - fixup D3 pin and right channel mute on
>>>> Haswell HDMI audio) is there a possibility we need to fix up D3 as well
>>>> here? I e, call haswell_verify_pin_D0 rather than just setting the mute?
>>>> Or perhaps move the call to haswell_verify_pin_D0 from hdmi_setup_stream
>>>> to hdme_setup_audio_infoframe ?
>>>
>>> The power state is fine in this case, but just to reset the amp state
>>> by some reason.  It's not enough to update the info frame, as far as I
>>> tested.
>>
>> Ok - maybe Mengdong can comment more on this, if it's the same scenario
>> as I was working around earlier (right channel muted and pin in D3), or
>> if this is something different.
>>
>> If it's the same issue, I was thinking that we could
>>  1) skip the extra snd_hda_codec_write here, and
>>  2) move the call to haswell_verify_pin_D0 from hdmi_setup_stream to
>> hdmi_setup_audio_infoframe?
> 
> That makes sense.  Though, I'd like to merge the working patch now and
> improve later on, as it's already in 3.12 merge window now.

Sure, no problem.

> 
>> Also, if the pin amp is always unmuted, we could speed up
>> haswell_verify_pin_D0 to always unmute instead of read-then-write.
> 
> Yes.
> 
> 
> Takashi
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
