From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA - hda: hdmi flag to stop playback
 when monitor is disconnected
Date: Thu, 12 Nov 2015 08:32:41 +0100
Message-ID: <56444099.2020401@canonical.com>
References: <1447231149-88326-1-git-send-email-libin.yang@linux.intel.com>
 <s5h4mgs6h9l.wl-tiwai@suse.de> <s5hfv0ck4ka.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19779E19@SHSMSX103.ccr.corp.intel.com>
 <56443993.3000104@canonical.com> <56443F28.3000803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EEDF2606E5
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 08:32:45 +0100 (CET)
In-Reply-To: <56443F28.3000803@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Libin Yang <libin.yang@linux.intel.com>, "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-11-12 08:26, Libin Yang wrote:
>
> On 11/12/2015 03:02 PM, David Henningsson wrote:
>>
>>
>> On 2015-11-11 15:23, Yang, Libin wrote:
>>>
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Wednesday, November 11, 2015 10:13 PM
>>>> To: libin.yang@linux.intel.com
>>>> Cc: David Henningsson; alsa-devel@alsa-project.org;
>>>> mengdong.lin@linux.intel.com; Yang, Libin
>>>> Subject: Re: [PATCH] ALSA - hda: hdmi flag to stop playback when
>>>> monitor is disconnected
>>>>
>>>> On Wed, 11 Nov 2015 10:02:14 +0100,
>>>> Takashi Iwai wrote:
>>>>>
>>>>> On Wed, 11 Nov 2015 09:39:09 +0100,
>>>>> libin.yang@linux.intel.com wrote:
>>>>>>
>>>>>> From: Libin Yang <libin.yang@linux.intel.com>
>>>>>>
>>>>>> Add a flag that user can decide to stop HDMI/DP playback when
>>>>>> the corresponding monitor is disconnected and refuse to open PCM
>>>>>> if there is no monitor connected.
>>>>>>
>>>>>> Background:
>>>>>> When a monitor is disconnected and a new monitor is connected,
>>>>>> the parameters of the 2 monitors may be different. Audio driver
>>>>>> need handle this situation.
>>>>>>
>>>>>> Besides, stopping playback when monitor is disconnected will
>>>>>> help to save the power.
>>>>>>
>>>>>> Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
>>>>>
>>>>> Thanks.  Below are just nitpicking, so let's test this patch at
>>>>> first,
>>>>> especially to see whether it has any significant influence on PA,
>>>>> then
>>>>> respin with the fixes.
>>>>>
>>>>> David, care to check in your side, too?
>>>>
>>>> So I tested this with PA 7.1, and it failed, unfortunately.
>>>> In short:
>>>> - PA needs the PCM access at probe.  If it gets an error, the device
>>>>    will be never enumerated again
>>
>> ...and that's the expected behaviour given how PA works today. Which
>> also means that this new parameter should not be enabled by default,
>> unless we want to break PA 7.1 and earlier versions.
>>
>>>
>>> Thanks for test.
>>>
>>> If so, should we re-write the hdmi_pcm_open() and
>>> generic_hdmi_playback_pcm_prepare() function to make
>>> the probe works?  Or not support dynamic pcm assignment?
>>
>> I've already suggested how we can make it work, by assigning converter
>> nodes dynamically regardless of whether or not the PCM has a monitor
>> connected to it.
>
> It means the PCM will hold the converter even no monitor is connected.

As long as the PCM is open, yes.

> When will PA release the converter? If PA can't release converter in
> time, other PCM will not find a proper converter. Especially in probe
> time, will it cause probe failure?

During probe, PA probes one output + one input at a time (at least by 
default). E g, before PA tries to open "hdmi:0,1", it closes "hdmi:0,0". 
And when PA calls snd_pcm_close, that should also make the driver 
release the converter node.

>> Keeping the power well on for up to five seconds (and often much less)
>> during boot should not be a big deal power saving wise, so the power
>> save argument doesn't hold IMO.
>
> That's fine for power saving.
>
>>
>>>> - PA removes the device when it's disconnected.  The PCM stop with
>>>>    DISCONNECT state leads to the device disappearance.
>>>
>>> If we can't use DISCONNECT, what else can we use? Or we can't
>>> stop PCM when monitor is disconnected?
>>
>> The current behavior is to keep the PCM running, which also has the
>> benefit to be able to switch monitors on the fly (i e without stopping
>> the stream), if both support the stream format. At least I think one
>> can do this, I've actually never tried.
>
> Yes, we will keep PCM running even when monitor is disconnected.
>
> Regards,
> Libin
>
>>
>> While reporting -ENODEV for a disconnected monitor seems useful to
>> some scenarios, there are certainly other scenarios where it doesn't
>> work.
>>
>> PA should use the ELD and/or the Jack kctl to figure out when it needs
>> to reprobe the device. This has not been implemented.
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
