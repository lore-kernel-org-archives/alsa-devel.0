From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Bug in setting channels,
 related to recent ELD/EDID changes?
Date: Tue, 11 Jan 2011 18:54:50 +0200
Message-ID: <4D2C8B5A.1090404@iki.fi>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>	<4D12E292.9050204@iki.fi>	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>	<4D20508C.7070609@iki.fi>	<s5hoc7ok05l.wl%tiwai@suse.de>	<3a46493bd2a1ec3b74c89cb6970c9ab0.squirrel@mail.onse.fi>	<s5hk4icjy2t.wl%tiwai@suse.de>	<4D2C8671.5030406@iki.fi>
	<s5hy66r9ytb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B90B103827
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:55:01 +0100 (CET)
In-Reply-To: <s5hy66r9ytb.wl%tiwai@suse.de>
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

On 11.01.2011 18:42, Takashi Iwai wrote:
> At Tue, 11 Jan 2011 18:33:53 +0200,
> Anssi Hannula wrote:
>>
>> (restored CC I removed, sorry about that)
>>
>> On 10.01.2011 22:36, Takashi Iwai wrote:
>>> At Mon, 10 Jan 2011 21:58:26 +0200,
>>> Anssi Hannula wrote:
>>>>
>>>>
>>>> Takashi Iwai kirjoitti:
>>>>> At Sun, 02 Jan 2011 12:16:44 +0200,
>>>>> Anssi Hannula wrote:
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> Takashi, it seems the "allow all when not plugged in" behaviour you
>>>>>> implemented in bbbe3390 is not enough to allow applications to open the
>>>>>> device before the output device is ready. Switched-off A/V receivers may
>>>>>> provide the information of the plugged-in television which usually
>>>>>> restricts the max_channels to 2, causing applications to fail opening
>>>>>> the device with more channels when a the A/V receiver is switched off.
>>>>>>
>>>>>> Also, even if the application can gracefully fallback to stereo, AFAIK
>>>>>> there is no method for an application to get informed when the
>>>>>> limitation is lifted, so it can't automatically resume multichannel
>>>>>> output when the A/V receiver is switched on again.
>>>>>>
>>>>>> Based on this info, I guess the restrictions based on ELD should be
>>>>>> removed :/
>>>>>> Unless you have some other ideas to fix the issue, of course.
>>>>>
>>>>> What about the patch below?  If it's unplugged, the valid flag should
>>>>> be cleared, so the next open fall backs to the default state (i.e.
>>>>> allows all).
>>>>
>>>> But it is not unplugged. The multichannel-capable receiver forwards EDID
>>>> of TV which doesn't allow more than 2 channels, when the receiver is
>>>> swtiched off.
>>>
>>> Well, in that case, this is the correct behavior, IMO.  At this
>>> moment, setting channels to 2 is the right thing.
>>
>> Well, I don't like this at all for two reasons:
>>
>> 1) This common use case worked with earlier kernel revisions: You could
>> start playback of a video / TV channel, then go sit on a couch and start
>> up the A/V receiver to get surround sound. Now it is broken.
> 
> Yeah, this is a drawback of the "fix", though.  In the earlier driver
> version, if you send incompatible setups that don't match with the
> actual device, it simply doesn't work.  Now it makes working.
> 
>> 2) There is no way this can be fixed in the libalsa-using application
>> either, as it doesn't receive a notification when more channels become
>> available after it has already fallbacked to stereo.
>>
>> So we got something reasonable that worked before but not with 2.6.36+.
> 
> It depends on the definition "reasonable" :)
> 
>>> Then, how can you
>>> know that more channels will be available in future at all?
>>
>> We don't. However, we don't know that about any analog line-outs either,
>> yet we always allow all channels no matter what amount of speakers are
>> plugged in (AFAIK)  (assuming jack detection support).
> 
> But there have been already systems which PCM configuration changes
> dynamically.  So, sane apps are supposed to re-open if needed
> (e.g. multi-channel open failed).

Yep. It really should get a notification to allow switching to
multichannel later (dunno what that would look like, I don't know the
ALSA api well).

I guess something simpler (looking from the application side) would be
something to allow forcing open if the sink doesn't support the mode but
the card does.

> Anyway, reverting the whole idea seems like nonsense as well, since
> the current behavior works more or less for many other cases.
> An easy solution would be to add a module option as I posted.  In that
> way, you can switch the behavior dynamically.  For ones who require
> the static configuration, set the option to true.  For others, set the
> option false.

Yes, it would indeed be the easiest solution.

> 
> Takashi
> 
>>> What you want to have a static configuration way by ignoring the ELD
>>> information.  But, the interface isn't pretty easy if it's implemented
>>> in control API, I suppose.
>>>
>>>
>>> Takashi
>>>
>>>>
>>>>> Takashi
>>>>>
>>>>> ---
>>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>>> index d1b1b57..27e8597 100644
>>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>>> @@ -827,7 +827,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>>>>>  		*codec_pars = *hinfo;
>>>>>
>>>>>  	eld = &spec->sink_eld[idx];
>>>>> -	if (eld->sad_count > 0) {
>>>>> +	if (eld->eld_valid && eld->sad_count > 0) {
>>>>>  		hdmi_eld_update_pcm_info(eld, hinfo, codec_pars);
>>>>>  		if (hinfo->channels_min > hinfo->channels_max ||
>>>>>  		    !hinfo->rates || !hinfo->formats)
>>>>>
>>>>
>>>>
>>>> -- 
>>>> Anssi Hannula
>>>>
>>
>>
>> -- 
>> Anssi Hannula
>>


-- 
Anssi Hannula
