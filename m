From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Tue, 02 Apr 2013 14:49:40 +0200
Message-ID: <515AD3E4.2000208@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51517F53.7070608@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
 <515AC6AC.8040504@canonical.com> <s5hr4it6s7n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 972F02651C8
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 14:49:42 +0200 (CEST)
In-Reply-To: <s5hr4it6s7n.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/02/2013 02:18 PM, Takashi Iwai wrote:
> At Tue, 02 Apr 2013 13:53:16 +0200,
> David Henningsson wrote:
>>
>> On 03/27/2013 11:01 AM, Lin, Mengdong wrote:
>>>> -----Original Message-----
>>>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>>>> Sent: Wednesday, March 27, 2013 4:19 PM
>>>
>>>>> The Haswell codec set_power_state ops (intel_haswell_set_power_state) will
>>>> only wait if this is a delayed resume and clear this flag after waiting. And
>>>> actually, there is no waiting even in this case. Because when 1st user operation
>>>> after system resume happens, Gfx already finishes resuming and audio
>>>> initialization, so as long as intel_haswell_wait_ready_to_resume() enable the
>>>> unsol event, the unsol event comes and so so waiting finishes. The 300ms time
>>>> out is set for safety consideration in case unsol event is lost. I've not observed
>>>> any unsol event lost till now.
>>>>
>>>> As for the timeout, I suggest you use the codec->bus->workq instead of
>>>> creating a new workq. I think that will also give us some serialisation, i e,
>>>> protection against race conditions if the timeout happen at the same time as
>>>> the unsol event.
>>>
>>> Hi David,
>>>
>>> The new added "resume_wq" for hdmi codec is a wait queue, not a work queue like codec->bus->workq.
>>> It's expected to wake up as soon as the unsol event is got.
>>
>> Sure; but I don't see why you need a wait queue for that? Why don't you
>> just call the resume path from the unsol event handler
>> (hdmi_present_sense, or its caller), and then also cancel the timeout
>> handler (which can then be in the normal workq)?
>
> Because the delayed resume actually fakes as if the resume is done.
> This is necessary not to block other device's resume operation.
>
> Since it looks as if ready, user-space might restart things soon again
> before the delayed resume is really finished.  So, some serialization
> is required there.

Lin, would it be possible to add some chain of events description to the 
bug commit? The different contexts are just boggling my mind :-)

Assume we have two cases, system idle after S3 and immediate playback 
after S3.

Is this correct:

System idle:
  1. System skips hda_call_codec_resume and sets codec->resume_delayed.
  2. Since the codec is not reinitialized, nothing powers up the codec, 
so this is all that happens.
  3. Since unsol events are not enabled (?), we have a bug that jack 
detection does not work and cannot be detected from userspace...?

Immediate playback:
  1. System skips hda_call_codec_resume and sets codec->resume_delayed.
  2. Process context wants to start playback, which powers up the codec 
and calls intel_haswell_set_power_state.
  3. intel_haswell_wait_ready_to_resume enables unsol events and starts 
to wait on ready_to_resume
  4. Gfx init finishes, and workq context fires the unsol event, which 
calls hdmi_intrinsic_event, which triggers the resume_wq.
  5. Process context and workq context now continues in parallel, 
potentially (but hopefully not) leading to race conditions?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
