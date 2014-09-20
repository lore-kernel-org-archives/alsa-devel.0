From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Radeon unconnected HDMI eats samples at 280 kHz
Date: Sat, 20 Sep 2014 02:06:30 +0200
Message-ID: <541CC506.601@canonical.com>
References: <54198F38.30002@canonical.com>	<5419FC9E.9010302@iki.fi>	<541A5BCD.2040105@canonical.com>
 <s5hlhph8jt5.wl-tiwai@suse.de> <541A8FA2.7090406@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D059929D9D@satlexdag05.amd.com>
 <541C31EE.4020101@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992A81C@satlexdag05.amd.com>
 <541C6C23.1040403@canonical.com>
 <A3397C8B8B789E45844E7EC5DEAD89D05992AB48@satlexdag05.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5B626535F
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 02:06:30 +0200 (CEST)
In-Reply-To: <A3397C8B8B789E45844E7EC5DEAD89D05992AB48@satlexdag05.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2014-09-20 01:32, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Friday, September 19, 2014 1:47 PM
>> To: Deucher, Alexander; Takashi Iwai
>> Cc: Anssi Hannula; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280 kHz
>> On 2014-09-19 16:14, Deucher, Alexander wrote:
>>>> -----Original Message-----
>>>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>>>> Sent: Friday, September 19, 2014 9:39 AM
>>>> To: Deucher, Alexander; Takashi Iwai
>>>> Cc: Anssi Hannula; alsa-devel@alsa-project.org
>>>> Subject: Re: [alsa-devel] Radeon unconnected HDMI eats samples at 280
>> kHz
>>>>
>>>> On 2014-09-19 00:29, Deucher, Alexander wrote:
>>> PIN*_JACK_DETECTION_ENABLE
>>> If PIN0_JACK_DETECTION_ENABLE is 1, changing PIN0_AUDIO_ENABLED
>> will produce jack connection and disconnection status changes in pin0
>> accordingly.
>>>
>>>    POSSIBLE VALUES:
>>>         00 - setting PIN0_AUDIO_ENABLED does not set pin0
>> PRESENCE_DETECT
>>>         01 - setting PIN0_AUDIO_ENABLED sets pin0 PRESENCE_DETECT
>>
>> Ok, we definitely need this enabled.
>>
>>> PIN*_UNSOLICITED_RESPONSE_ENABLE
>>>
>>> For PIN0, If 1, when AUDIO_ENABLED changes, an unsolicited response
>> with payload UNSOLICITED_RESPONSE_PAYLOAD will be sent.
>>>    POSSIBLE VALUES:
>>>         00 - changing AUDIO_ENABLED does not produce an unsolicited
>> response
>>>         01 - changing AUDIO_ENABLED produces an unsolicited response
>>
>> Ok, we need this enabled too.
>>
>> Note: to make sure both plug and unplug events are delivered, these two
>> should probably remain enabled even when the monitor is disconnected.
>> There is a risk that setting these to zero when also setting
>> AUDIO_ENABLED to zero could cause either event not to trigger on the
>> audio side.
>
> The driver would need to be restructured a bit to actually reflect the connected/disconnected state of the monitor on the audio side.  Right now we set up audio when the display is enabled, not when it's probed.

I think the current behaviour is okay. If there's no video enabled, then 
it's okay to report audio as disconnected too.

So my sentence above should be rephrased as "these two should probably 
remain enabled even when the display is disabled or disconnected".

Btw, is there a register dump utility I could use to get the current 
register value, e g by reading sysfs or procfs? It could be interesting 
to see if anything we do on the audio side would affect this register.

>>> CODEC_HOT_PLUG_ENABLE
>>> If 1, changing AUDIO_ENABLED sets STATE_CHANGE_STATUS.
>>>
>>>    POSSIBLE VALUES:
>>>         00 - changing AUDIO_ENABLED does not set STATE_CHANGE_STATUS
>>>         01 - changing AUDIO_ENABLED sets STATE_CHANGE_STATUS
>>
>> This probably refer to audio controller register STATESTS, because
>> that's the only thing labelled "State change status" in the HDA spec. I
>> think this should be enabled too, but it's possible that it's only
>> relevant if the audio device is in a power down state.
>
> Yes, STATE_CHANGE_STATUS is an audio register.
>
>>
>>> PIN*_AUDIO_ENABLED
>>> Set to 1 by the driver if an HDMI TV able to take channel pair 0,1 for PIN0
>> (or 2,3 for PIN1, etc.) is connected, set to 0 if not.
>>>
>>>    POSSIBLE VALUES:
>>>         00 - disabled
>>>         01 - enabled
>>>
>>> AUDIO_ENABLED
>>> Set to 1 by the driver when an Audio Enabled HDMI TV is connected, set to
>> 0 when it is disconnected. Zeroed by the driver during mode change to
>> disable audio temporarily in order to avoid noise. The software changes on
>> this bit are used by the CODEC hardware to emulate hot plugging-unplugging
>> of the audio-enabled HDMI TV.
>>>
>>>    POSSIBLE VALUES:
>>>         00 - disabled
>>>         01 - enabled
>>
>> If audio_enabled quickly changes to off and then on when there is a mode
>> change, it might make sense to *not* wake up the audio driver in this
>> case, as I assume that the audio capabilities on the HDMI TV will not
>> change just because the video mode changes.
>>
>> To sum up, what the audio driver needs is PRESENCE_DETECT to correctly
>> correspond to whether something is plugged in or not. And we need an
>> unsolicited event when PRESENCE_DETECT changes.
>
> The tricky part is that you may only have 1 audio pin.  What do you do if you have multiple displays that support audio connected?  I guess we could report connected if any displays that support audio are connected, but pass the sink information to the audio driver when the display was actually enabled since the sinks may have different audio capabilities.

 From the audio driver's point of view, if you have 1 audio pin, then 
that's one display. Presence detect, as well as ELD information, should 
reflect the status of that one display.

How to multiplex that against several audio capable monitors is tricky, 
but it's something you have to solve on the video driver side.
I'm not sure how other video drivers have solved that, or if AMD/ATI is 
the only manufacturer who has cards with this hw design (i e fewer audio 
pins than audio capable outputs).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
