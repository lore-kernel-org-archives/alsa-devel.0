From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [PATCH v4 0/5] ALSA: hda - hdmi support dynamic
 pcm assignment
Date: Mon, 21 Dec 2015 08:51:02 +0800
Message-ID: <56774CF6.60005@linux.intel.com>
References: <1450244565-77041-1-git-send-email-libin.yang@linux.intel.com>
 <s5hbn9qhm2v.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D197B2CAF@SHSMSX103.ccr.corp.intel.com>
 <s5hh9jgt4ku.wl-tiwai@suse.de> <s5hvb7wrmgv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 115702608B1
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 01:53:40 +0100 (CET)
In-Reply-To: <s5hvb7wrmgv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Yang, Libin" <libin.yang@intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 12/18/2015 08:05 PM, Takashi Iwai wrote:
> On Fri, 18 Dec 2015 11:48:49 +0100,
> Takashi Iwai wrote:
>>
>> On Fri, 18 Dec 2015 03:53:32 +0100,
>> Yang, Libin wrote:
>>>
>>> Hi Takashi,
>>>
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Wednesday, December 16, 2015 3:47 PM
>>>> To: libin.yang@linux.intel.com
>>>> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
>>>> Subject: Re: [alsa-devel] [PATCH v4 0/5] ALSA: hda - hdmi support
>>>> dynamic pcm assignment
>>>>
>>>> On Wed, 16 Dec 2015 06:42:40 +0100,
>>>> libin.yang@linux.intel.com wrote:
>>>>>
>>>>> From: Libin Yang <libin.yang@linux.intel.com>
>>>>>
>>>>> The patches are trying to support dynamically binding PCM to pin
>>>>> in HDMI/DP audio.
>>>>>
>>>>> The pin will not bind to any PCM if there is not monitor connected.
>>>>> When there is a monitor connected to the port (pin), driver will
>>>>> try to find a proper PCM to assign to the port and setup the pin
>>>>> if necessary.
>>>>>
>>>>> Libin Yang (5):
>>>>>    ALSA: hda - hdmi begin to support dynamic PCM assignment
>>>>>    ALSA: hda - hdmi playback without monitor in dynamic pcm bind
>>>> mode
>>>>>    ALSA: hda - hdmi operate spdif based on pcm
>>>>>    ALSA: hda - hdmi dynamically bind PCM to pin when monitor hotplug
>>>>>    ALSA: hda - hdmi setup pin when monitor hotplug in pcm dynamic
>>>>>      assignment mode
>>>>
>>>> I updated topic/hda-mst branch with these patches.  But the patch 4
>>>> needs more fixes, as suggested in another mail.
>>>>
>>>> Overall, I'd like to know whether MST audio really works in the
>>>> current state, or not.  Do you have *any* git branch where MST audio
>>>> is supposed to work at all?
>>>
>>> I have uploaded the patches to: https://github.com/libinyang/linux.git
>>> Branch is mst_virtual_pin_github.
>>>
>>> There is still an issue when doing the mst audio playback:
>>> The later converter selection for pin will overwrite the previous setting.
>>> This is the driver bug, I'm debugging it.
>>
>> Thanks.  I tried this branch, but the DP MST audio on my HP laptop
>> dock doesn't seem working.  It gets no notification (maybe expected),
>> but the accesses to any HDMI devices result in the error.  I tested
>> via aplay -Dhdmi:0,0 to 0,2.
>>
>> With the latest patchset (e.g. my test/hdmi-jack branch) I get the
>> notification and ELD, but the audio still doesn't come out.  So,
>> something seems missing.
>
> Actually I'm thinking how the MST things are supposed to work here.
> The machine here has a docking station connected to port D, and it has
> to DP connectors.  Meanwhile it has a built-in DP port on port C.
> The latter works fine while dock ports don't.

I have updated the code last Friday, which fixed a converter setting 
issue in MST mode. Without the latest code, there is no sound for DP 
MST audio.

The port D should be the same with port C for the HW connection.

>
> Suppose if I plug two monitors on the docking station.  How would the
> audio in HD-audio side be set up?

Not sure how the docking station works. If the docking works as it is 
a MST hub, there should be sound independently from both ports. But 
I'm not sure whether the docking is a MST hub or just duplicates 
context to the other port.

I think we can try to get the device entry number on the pin by 
calling snd_hda_get_num_devices().

The steps should be:
1. connect 2 monitors to the docking station and boot up the machine.
2. If xxx_get_num_devices() returns 0, this means it is not MST mode.
    If xxx_get_num_devices() returns 1, this means it works as MST hub.


Best Regards,
Libin
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
