From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Tue, 8 Nov 2016 16:56:19 +0100
Message-ID: <903db9b3-4db0-81d9-32a0-c479eb64925e@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
 <a5b9dbde-f864-34ef-8703-e7d6cd4a8904@ladisch.de>
 <4430ddee-488a-2bda-1ff2-fe911bbdf9fb@st.com> <s5hmvha9h7n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F1223261B03
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 16:56:23 +0100 (CET)
In-Reply-To: <s5hmvha9h7n.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Clemens Ladisch <clemens@ladisch.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org



On 11/08/2016 03:30 PM, Takashi Iwai wrote:
> On Tue, 08 Nov 2016 15:16:29 +0100,
> Arnaud Pouliquen wrote:
>>
>> Hello Clemens,
>>
>> On 11/08/2016 10:52 AM, Clemens Ladisch wrote:
>>> Arnaud Pouliquen wrote:
>>>> 1-1) How to Instantiate generic ALSA control
>>>>
>>>> The  point is the handling of multi instance of generic ALSA controls.
>>>> In this case "prefix" can not be used. Controls have to be identified
>>>> by a combination of device/sub-device/index
>>>
>>> Controls are identified either
>>> - by their numid, or
>>> - by the combination of iface/device/subdevice/name/index.
>>>
>>> The device/subdevice fields are used to link controls with PCM devices;
>>> this is needed for per-stream volume controls or for the S/PDIF "Mask"
>>> controls, which set properties of some PCM stream.
>> Seems that today device/subdevice are also used to differentiate PCM
>> control, using a "virtual" device/subdevice that is not linked to a
>> "real PCM device. This is what i understand when i parse HDA-Intel.conf
>> for instance HDA-Intel.pcm.hdmi.1: "DEVICE=7,"
> 
> The HD-audio shouldn't be taken as the good reference.  It has its own
> mapping there just to keep the backward compatibility with the old
> implementation that was basically broken.
> 
> 
>>>
>>>>     Should we always apply this rules?
>>>>       - MIXER control type: as it is not linked to PCM device but card,
>>>> 	"index" is used to instantiate control.
>>>
>>> "index" is _always_ used.
>>>
>>>>       - PCM control type: as it is linked to PCM device,
>>>>         "device/subdevice" is used to instantiate control.
>>>>     Or could we consider that a control can be instantiated using
>>>>       device/subdevice fields  and/or index fields?
>>>
>>> The amixer tool does not allow controls with the same iface/name/index
>>> values, regardless of the (sub)device values.  This appears to be a bug
>>> in amixer (because the behaviour is different from the kernel's), but
>>> the (sub)device fields were never intended to be used by MIXER controls,
>> In fact only amixer simple controls are not handled using (sub)device
>> fields. if simple control is only MIXER controls, it is not a bug as it
>> respect rules.
>>
>>> and PCM controls typically are inactive when their stream is closed.
>> if we consider that 'IEC958 Playback Default' is a PCM control. This is
>> not compatible with iecset application that sets the control without
>> opening the PCM device.
> 
> Yes, it's a slight inconsistency.  But it's specific to "Default"
> stuff.  All other controls are usually tied with PCM open/close.
> 
Thanks for the clarification.
In this case, "[RFC 4/4 ] iecset: allow to select control with device
and sub-device numbers" seems coherent, to allow access to this PCM
controls with device/subdevice values...
I will propose it in a separate patch-set to not mix kernel and
application patch...

As 'IEC958 Playback Default' is specific, i will also try to
rework and propose a new version of
[PATCH v4 3/6] ALSA: pcm: add IEC958 channel status control helper
(http://www.spinics.net/lists/alsa-devel/msg47615.html)

>>>
>>>>    - Concerning IEC controls, should we consider them as PCM or MIXER
>>>>      type controls? In current implementations both are used...
>>>
>>> MIXER controls are shown in alsamixer.  PCM controls are hidden, and
>>> accessed by software.
>>>
>>> Something like "IEC958 Playback Switch" should be MIXER, and "IEC958
>>> Playback Con Mask", PCM.
>>>
>>>> 2) From driver point of view
>>>>
>>>> 2-1) None SOC drivers:
>>>> Today solution seems to base indexation on both "index" and "device"
>>>> number. Device indexation seems not linked to PCM device number
>>>> Example in  ea9b43addc4d ("ALSA: hda - Fix broken workaround for HDMI/SPDIF conflicts").
>>>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add
>>>>
>>>> => The drawback is that each driver has to implement it. Could be nice
>>>>    to have in generic code....
>>>
>>> In the good old times, the ALSA framework assumed that a driver knows
>>> all its controls, and handles conflicts by assignind index values.
>>>
>>> It would be useful to let snd_ctl_add() assign a new index automatically,
>>> but only if explicitly requested (e.g., something like
>>> "#define SNDRV_CTL_INDEX_AUTO -1").
>> you right, seems more reasonable, I will update this for a V2, if
>> everyone is ok for this solution...
> 
> Right, this behavior must be optional.  For the normal drivers, the
> duplicated controls *are* errors, and we catch it instead.  For
> drivers that are aware of confliction and want the automatic
> workaround (e.g. HD-audio driver does it already), this kind of code
> would be useful to be in the common place.

I will send a V2 that integrates SNDRV_CTL_INDEX_AUTO (and
SNDRV_CTL_DEVICE_AUTO for the ASoC PCM link)

Thanks & Regards
Arnaud
