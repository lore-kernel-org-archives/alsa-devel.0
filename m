From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Mon, 08 Apr 2013 11:49:09 +0200
Message-ID: <51629295.1000701@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51517F53.7070608@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
 <515AC6AC.8040504@canonical.com>	<s5hr4it6s7n.wl%tiwai@suse.de>
 <515AD3E4.2000208@canonical.com>	<s5hmwtd2ksk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837402E@SHSMSX101.ccr.corp.intel.com>
 <s5hk3og3o47.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AA0F0265317
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 11:49:13 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/07/2013 02:10 AM, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Saturday, April 06, 2013 1:05 AM
>
>
>>>>> Immediate playback:
>>>>>    1. System skips hda_call_codec_resume and sets
>> codec->resume_delayed.
>>>>>    2. Process context wants to start playback, which powers up the
>>>>> codec and calls intel_haswell_set_power_state.
>>>>>    3. intel_haswell_wait_ready_to_resume enables unsol events and
>>>>> starts to wait on ready_to_resume
>>>>>    4. Gfx init finishes, and workq context fires the unsol event,
>>>>> which calls hdmi_intrinsic_event, which triggers the resume_wq.
>>>>>    5. Process context and workq context now continues in parallel,
>>>>> potentially (but hopefully not) leading to race conditions?
>>>>
>>>> The current patch has a small race, but it can be avoided by
>>>> clearing
>>>> spec->ready_to_resume early enough, e.g. in suspend callback or in
>>>> init callback, like the patch below.
>>>>
>>>
>>> I think there is no race for Haswell. In my test I observed that the
>>> unsol evnet will not be received until intel_haswell_wait_ready_to_resume()
>> enables the unsol event on the pins.
>>> So I put "spec->ready_to_resume = 0" before enabling the unsol event.
>>
>> Practically your patch would work well, but theoretically the unsol event might
>> be issued and handled by hdmi_intrinsic_event() before you go into
>> intel_haswell_wait_ready_to_resume().  That is, you _clear_
>> spec->ready_to_resume again and wait for the unsol event that had been
>> already processed.  That's the race David pointed.
>>
>> The fix is simply not to clear spec->ready_to_resume in
>> intel_haswell_wait_ready_to_resume() but clear it much earlier already before
>> the resume path as my patch does.  Then wait_event() passes immediately
>> (and the unsol enablement of is anyway harmless).
>>
>
> Hi Takashi,
>
> I see. Thanks for clarifying!
>
> I'll revise the patch and test it again when I'm in office on Monday.
> Also I'll rebase the patch to for-next branch of sound git tree and fix the indentations and spaces errors.

I'm still not understanding this patch.

We of course cannot have a situation where HDMI jack detection is not 
correctly working after S3, which looks like would be the case here?

Second, I just saw on a machine we're working on, the symptoms: one of 
the pins in D3 and the right channel muted. And this was on a clean 
boot, not after S3 suspend/resume cycle.

To look at the problem again: If the problem is that something must be 
done on the graphics driver side first and then on the audio side, 
wouldn't the solution be for the video driver and audio driver to 
communicate somehow? And resume (and possibly init?) would not complete 
until first the graphics driver has done its resume, and after that, the 
audio driver. I e, userspace will remain frozen until both drivers have 
completed a correct resume.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
