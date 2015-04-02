From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda_intel: add
 AZX_DCAPS_I915_POWERWELL for skl
Date: Thu, 02 Apr 2015 08:52:21 +0200
Message-ID: <551CE725.8080209@canonical.com>
References: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
 <s5hfv8q98lm.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F1C@SHSMSX103.ccr.corp.intel.com>
 <s5hegoa97jj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F67@SHSMSX103.ccr.corp.intel.com>
 <s5ha8yy971s.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F84@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D1962E18F@SHSMSX103.ccr.corp.intel.com>
 <551B9EC0.2060308@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19633E41@SHSMSX103.ccr.corp.intel.com>
 <551BA856.8060402@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19634094@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E4292604BA
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 08:52:22 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19634094@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2015-04-01 23:55, Yang, Libin wrote:
> Hi David,
>
>
>
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Wednesday, April 01, 2015 4:12 PM
>> To: Yang, Libin; 'Takashi Iwai'
>> Cc: 'alsa-devel@alsa-project.org'
>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda_intel: add
>> AZX_DCAPS_I915_POWERWELL for skl
>>
>>
>>
>> On 2015-04-01 10:00, Yang, Libin wrote:
>>> Hi David,
>>>
>>>> -----Original Message-----
>>>> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
>>>> bounces@alsa-project.org] On Behalf Of David Henningsson
>>>> Sent: Wednesday, April 01, 2015 3:31 PM
>>>> To: Yang, Libin; 'Takashi Iwai'
>>>> Cc: 'alsa-devel@alsa-project.org'
>>>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda_intel: add
>>>> AZX_DCAPS_I915_POWERWELL for skl
>>>>
>>>>
>>>>
>>>> On 2015-03-30 04:47, Yang, Libin wrote:
>>>>>    From our silicon team's comment, it seems we need power on
>>>>> the powerwell when detecting and probing the HDMI codec.
>>>>>
>>>>> For the skl case (HDMI codec is in powerwell, while controller not),
>>>>> my thinking is:
>>>>>
>>>>> 1. power on the power well
>>>>> 2. read STATESTS to determine the codec_mask
>>>>> 3. if codec is not present, power off the power well
>>>>>        and remove the flag. (seems we need a new flag)
>>>>> 4. if codec is present, we will power on the power well
>>>>>        when dealing with HDMI codec.
>>>>>
>>>>> What do you think?
>>>>
>>>> Side question - do you know if it's the same for braswell? I e, the
>> HDMI
>>>> codec is in the powerwell but the controller is not?
>>>
>>> Yes, BSW has the same issue.
>>>
>>> At first, my thinking is:
>>> 1. define a new flag, power on the power well if flag is set
>>> 2. read STATESTS to determine the codec_mask
>>> 3. if codec is not present, power off the power well
>>>       and remove the flag.
>>> 4. after initialization, power off the power well if new flag
>>>       is set and AZX_DCAPS_I915_POWERWELL is not set
>>> 5. power on power well when pcm open
>>> 6. power off the power well when pcm close
>>
>> ...and we're opening the right codec - in case of analog playback, the
>> powerwell can still be off, right?
>>
>>> After a second thought, the method may have limitation:
>>> the codec may send the unsolicited responses.
>>>
>>> So my currently thinking is:
>>> If the codec is in powerwell, the behavior is like the flag
>>> AZX_DCAPS_I915_POWERWELL: always power on unless
>>> suspend.
>>> This method may cause power consumption. But consider
>>> normally audio will be in suspend state in most case.
>>
>> Ok, thanks for the clarification. I was wondering - the reason the codec
>> might send unsol events is just due to hotplug events, right?
>>
>> And these unsol events are triggered by the i915 side by setting some
>> registers, right?
>>
>> Is it then possible that i915, when it detects a video hotplug event,
>> can increment the powerwell counter (so that the powerwell is turned
>> on), trigger the hotplug event to the audio side, and then decrement
>> the
>> powerwell again (possibly with a few seconds delay if needed)?
>>
>> The idea is that once the audio side has got the hotplug event, it can
>> turn on and off the powerwell itself. We just need the i915 driver to
>> turn it on for us to get the hotplug event through.
>
> Normally, it's the hotplug unsol event. But sometimes, I found on
> SKL, when suspending, there is some strange event sending
> from hdmi codec. And the controller will fallback to single cmd
> mode. Then the analog audio will be impacted after resume.
>
> BSW may also have this issue. But I didn't find it on our RVP board.
>
> I will test power on power well during unsol events.

Ok. I wonder if it is possible to stop this "strange event", either 
because it's a hardware/firmware bug that could be fixed in later 
revisions of the hardware/firmware, or if there is some register we 
could write to (or even stop writing to!) on the i915 side that stops 
the unsol events.

Or as a last resort, if we can't stop the "strange event", maybe there's 
some way the audio side could handle the "strange event" more gracefully 
so we don't fall back to single cmd mode when this happens.

(I don't know much about this "strange event" so I'm just guessing here)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
