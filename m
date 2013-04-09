From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Tue, 09 Apr 2013 09:10:27 +0200
Message-ID: <5163BEE3.1050907@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
 <515AC6AC.8040504@canonical.com> <s5hr4it6s7n.wl%tiwai@suse.de>
 <515AD3E4.2000208@canonical.com> <s5hmwtd2ksk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837402E@SHSMSX101.ccr.corp.intel.com>
 <s5hk3og3o47.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
 <51629295.1000701@canonical.com> <s5h4nfh1fsh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
 <5162AB7D.40103@canonical.com> <s5hzjx9z10c.wl%tiwai@suse.de>
 <5162B60C.6000509@canonical.com> <s5htxnhyzvu.wl%tiwai@suse.de>
 <5162C671.90405@canonical.com> <s5hhajhyvww.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com> <s5hli8s19g6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E25C2265D7B
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 09:10:30 +0200 (CEST)
In-Reply-To: <s5hli8s19g6.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 04/09/2013 08:53 AM, Takashi Iwai wrote:
> At Tue, 09 Apr 2013 08:45:32 +0200,
> David Henningsson wrote:
>>
>> On 04/08/2013 05:47 PM, Lin, Mengdong wrote:
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Monday, April 08, 2013 9:50 PM
>>>> To: David Henningsson
>>>> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; Girdwood, Liam R
>>>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
>>>> in system resume
>>>>
>>>> At Mon, 08 Apr 2013 15:30:25 +0200,
>>>> David Henningsson wrote:
>>>>>
>>>>> On 04/08/2013 02:23 PM, Takashi Iwai wrote:
>>>>>> At Mon, 08 Apr 2013 14:20:28 +0200,
>>>>>> David Henningsson wrote:
>>>>>>>
>>>>>>> On 04/08/2013 01:59 PM, Takashi Iwai wrote:
>>>>>>>> At Mon, 08 Apr 2013 13:35:25 +0200, David Henningsson wrote:
>>>>>>>>>
>>>>>>>>> On 04/08/2013 01:06 PM, Lin, Mengdong wrote:
>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>>>>>>>>> Sent: Monday, April 08, 2013 6:24 PM
>>>>>>>>>>> To: David Henningsson
>>>>>>>>>>> Cc: Lin, Mengdong; alsa-devel@alsa-project.org
>>>>>>>>>>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume
>>>>>>>>>>> haswell hdmi codec in system resume
>>>>>>>>>>>
>>>>>>>>>>> At Mon, 08 Apr 2013 11:49:09 +0200, David Henningsson wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> I'm still not understanding this patch.
>>>>>>>>>>>>
>>>>>>>>>>>> We of course cannot have a situation where HDMI jack detection
>>>>>>>>>>>> is not correctly working after S3, which looks like would be the case
>>>> here?
>>>>>>>>>>>
>>>>>>>>>>> No.  The patch itself has nothing to do with the HDMI jack detection
>>>> at all.
>>>>>>>>>>> This intrinsic unsol event is (according to Intel) guaranteed
>>>>>>>>>>> to be issued once at the audio codec initialization, at least for
>>>> Haswell.
>>>>>>>>>
>>>>>>>>> Well, if no process is using the HDMI codec actively, nothing
>>>>>>>>> will initialize the resume, and the HDMI codec will not
>>>>>>>>> initialized at all, i e, no unsol events enabled in the first place?
>>>>>>>>
>>>>>>>> No, the intrinsic unsol event that is issued for this seems
>>>>>>>> irrelevant from the jack state (i.e. active usage).
>>>>>>>>
>>>>>>>>> (The counter argument would be; if nobody uses HDMI codec, does
>>>>>>>>> it matter that it is not initialized, but I'm unsure if e g
>>>>>>>>> "amixer contents" or listeners on legacy /dev/input actually
>>>>>>>>> powers up the chip.)
>>>>>>>>
>>>>>>>> The problem is that the codec resume is always performed no matter
>>>>>>>> whether the device is used or not.  This was different in the past
>>>>>>>> but it's been changed in that way because there are cases where
>>>>>>>> you need to initialize the hardware properly once (e.g. mute-LED
>>>> toggling).
>>>>>>>>
>>>>>>>>
>>>>>>>>>>>> Second, I just saw on a machine we're working on, the
>>>>>>>>>>>> symptoms: one of the pins in D3 and the right channel muted.
>>>>>>>>>>>> And this was on a clean boot, not after S3 suspend/resume cycle.
>>>>>>>>>>>
>>>>>>>>>>> Maybe another problem.  Maybe not.  Does the problem persist if
>>>>>>>>>>> you reload the driver (without invocation of alsactl via udev)?
>>>>>>>>>>
>>>>>>>>>> Hi Takashi and David,
>>>>>>>>>>
>>>>>>>>>> This is the same dependency issue as after system suspend/resume
>>>> cycles, with same phenomenon.
>>>>>>>>>> I duplicated this error if I boot without an HDMI/DP cable connected
>>>> and connect the cable later.
>>>>>>>>>> Maybe we need to delay codec operations on initialization like in
>>>> resume case.
>>>>>>>>>
>>>>>>>>> So it's a problem both on hotplug and S3...
>>>>>>>>
>>>>>>>> In the case of hotplug, you don't hit the inconsistent power sate
>>>>>>>> we're trying to solve.  The graphics has been already powered up.
>>>>>>>>
>>>>>>>>
>>>>>>>>>>>> To look at the problem again: If the problem is that something
>>>>>>>>>>>> must be done on the graphics driver side first and then on the
>>>>>>>>>>>> audio side, wouldn't the solution be for the video driver and
>>>>>>>>>>>> audio driver to communicate somehow?
>>>>>>>>>>>
>>>>>>>>>>> Yes, the pm domain support is necessary sooner or later, as I
>>>>>>>>>>> already discussed shortly with Dave Airlie.  However...
>>>>>>>>>>
>>>>>>>>>> Liam will propose Gfx driver team to implement a pm domain.
>>>>>>>>>>
>>>>>>>>>>>> And resume (and possibly init?) would not complete until first
>>>>>>>>>>>> the graphics driver has done its resume, and after that, the audio
>>>> driver.
>>>>>>>>>>>> I e, userspace will remain frozen until both drivers have
>>>>>>>>>>>> completed a correct resume.
>>>>>>>>>>>
>>>>>>>>>>> ... the resume problem can't be fixed only by the usual pm domain
>>>> serialization.
>>>>>>>>>>> The graphics initialization for the audio bit is done
>>>>>>>>>>> asynchronously, thus we can't guarantee the audio codec is
>>>>>>>>>>> really ready after the graphics driver returns from the resume
>>>> callback.
>>>>>>>>>>> It shows as if it's ready (you can turn it to D0) but actually
>>>>>>>>>>> it doesn't change on the hardware.  Thus, the serialization
>>>>>>>>>>> with an unsol event wait seems mandatory for the time being.
>>>>>>>>>>>
>>>>>>>>>> It seems so. We have not found better solution now :-( I've
>>>>>>>>>> revised the patch for system suspend/resume case. Please review.
>>>>>>>>>
>>>>>>>>> If this problem can be detected by looking at the pin and finding
>>>>>>>>> that it is in D3,
>>>>>>>>
>>>>>>>> No, you can't see that it's D3.  The controller chip _shows_ it's
>>>>>>>> in
>>>>>>>> D0 while it's actually in D3.  That's the problem.
>>>>>>>>
>>>>>>>> So, this is actually a hardware design bug.  But we need to live
>>>>>>>> with that.
>>>>>>>
>>>>>>> Then I'm not sure it's the same problem; because for me I can see
>>>>>>> the D3 in the codec proc output.
>>>>>>
>>>>>> I suppose you didn't set the powersave for it, right?
>>>>>
>>>>> AFAIK, powersave remains at upstream default.
>>>>
>>>> The option is overridden by user-space, so checking only the default value
>>>> doesn't make any sense :)
>>>>
>>>>>> BTW, the main problem was about the FG node, which you can't judge
>>>>>> from the proc output, unfortunately.
>>>>>
>>>>> Here's what it looks like for me. Right channel muted and pin in D3.
>>>>>
>>>>> Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>>>>>      Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
>>>>>      Control: name="IEC958 Playback Con Mask", index=0, device=0
>>>>>      Control: name="IEC958 Playback Pro Mask", index=0, device=0
>>>>>      Control: name="IEC958 Playback Default", index=0, device=0
>>>>>      Control: name="IEC958 Playback Switch", index=0, device=0
>>>>>      Control: name="ELD", index=0, device=3
>>>>>      Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>>>>      Amp-Out vals:  [0x00 0x80]
>>>>>      Pincap 0x0b000094: OUT Detect HBR HDMI DP
>>>>>      Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>>>>        Conn = Digital, Color = Unknown
>>>>>        DefAssociation = 0x1, Sequence = 0x0
>>>>>      Pin-ctls: 0x40: OUT
>>>>>      Unsolicited: tag=01, enabled=1
>>>>>      Power states:  D0 D3 EPSS
>>>>>      Power: setting=D3, actual=D3
>>>>>      Connection: 3
>>>>>         0x02* 0x03 0x04
>>>>
>>>> Then this might be the different issue.
>>>
>>> This is same as what I observed after S3 or connect HDMI/DP cable after boot, on machines with power_save is '0'.
>>> Amp-Out vals:  [0x00 0x80]
>>> Power: setting=D3, actual=D3
>>>
>>> If we set the pin state to D0 and unmute the pin again, HDMI can work. So I still think this is also caused by dependency on Gfx.
>>>
>>> But the controller cannot find the error when it programs the codec to D0
>>> -  when audio driver programs the codec and pins to D0, HW does not return error
>>> -  I also added code to check their power state immediately after setting state to D0, HW reports their state did change to D0.
>>> However, after Gfx driver finishes setting up the display pipeline and enabling audio, the pin's state changed to D3 and get muted, as shown by /proc.
>>> It seems to me that Gfx HW initialization can override some audio driver settings. So we choose to delay resuming the codec until the unsol event which indicates Gfx is ready.
>>
>> I've been answering the power_save questions a little bit uncertain so
>> far, and that's because I don't really know. I've not investigated power
>> management much.
>>
>> But the person with the hardware reports that this problem happens when
>> on AC power only. And that makes sense with your observations about
>> power_save - there could very well be something that turns power_save
>> off when on AC power and on when on battery power.
>>
>> So, if it's just a matter of re-initializing the pin, what do you think
>> about this solution:
>>
>>    - Resume as normal (this will enable unsol events)
>>    - Any time an unsol event comes in, have a haswell specific function
>> that checks relevant pins to see that is still in D0 and mute state
>> correct. If not, correct it.
>>    - This check could possibly also be done in the prepare hook for extra
>> safety.
>
> It won't work reliably.  The problem is that the codec might be set up
> wrongly if it's used before the unsol event comes up.  For example, a
> PCM resume may be performed immediately after the normal resume is
> finished.  Meanwhile the first unsol may arrive much later than that.

Right, but if this will only mean a few samples (max 300 ms?) will never 
reach the HDMI cable, it might be the least bad workaround.

> Thus we need to delay the resume operation in anyway.  And if so,
> there is no merit to perform the normal resume operation at the first
> step.

The normal resume operation enables unsol events, which is important, 
otherwise we don't get the unsol notification from when the gfx pipeline 
has finished.

I guess the question here is how much of the codec setup is really 
destroyed by the gfx driver? Is it just a pin in D3 and a right channel 
mute, or is it much more that needs to be re-done after the gfx driver 
has finished?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
