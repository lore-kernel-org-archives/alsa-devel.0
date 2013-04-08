From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Mon, 08 Apr 2013 13:35:25 +0200
Message-ID: <5162AB7D.40103@canonical.com>
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
 <51629295.1000701@canonical.com> <s5h4nfh1fsh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E3F39265120
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 13:35:29 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On 04/08/2013 01:06 PM, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Monday, April 08, 2013 6:24 PM
>> To: David Henningsson
>> Cc: Lin, Mengdong; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
>> in system resume
>>
>> At Mon, 08 Apr 2013 11:49:09 +0200,
>> David Henningsson wrote:
>>>
>>> I'm still not understanding this patch.
>>>
>>> We of course cannot have a situation where HDMI jack detection is not
>>> correctly working after S3, which looks like would be the case here?
>>
>> No.  The patch itself has nothing to do with the HDMI jack detection at all.
>> This intrinsic unsol event is (according to Intel) guaranteed to be issued once at
>> the audio codec initialization, at least for Haswell.

Well, if no process is using the HDMI codec actively, nothing will 
initialize the resume, and the HDMI codec will not initialized at all, i 
e, no unsol events enabled in the first place?

(The counter argument would be; if nobody uses HDMI codec, does it 
matter that it is not initialized, but I'm unsure if e g "amixer 
contents" or listeners on legacy /dev/input actually powers up the chip.)

>>> Second, I just saw on a machine we're working on, the symptoms: one of
>>> the pins in D3 and the right channel muted. And this was on a clean
>>> boot, not after S3 suspend/resume cycle.
>>
>> Maybe another problem.  Maybe not.  Does the problem persist if you reload
>> the driver (without invocation of alsactl via udev)?
>
> Hi Takashi and David,
>
> This is the same dependency issue as after system suspend/resume cycles, with same phenomenon.
> I duplicated this error if I boot without an HDMI/DP cable connected and connect the cable later.
> Maybe we need to delay codec operations on initialization like in resume case.

So it's a problem both on hotplug and S3...

>>> To look at the problem again: If the problem is that something must be
>>> done on the graphics driver side first and then on the audio side,
>>> wouldn't the solution be for the video driver and audio driver to
>>> communicate somehow?
>>
>> Yes, the pm domain support is necessary sooner or later, as I already discussed
>> shortly with Dave Airlie.  However...
>
> Liam will propose Gfx driver team to implement a pm domain.
>
>>> And resume (and possibly init?) would not complete until first the
>>> graphics driver has done its resume, and after that, the audio driver.
>>> I e, userspace will remain frozen until both drivers have completed a
>>> correct resume.
>>
>> ... the resume problem can't be fixed only by the usual pm domain serialization.
>> The graphics initialization for the audio bit is done asynchronously, thus we
>> can't guarantee the audio codec is really ready after the graphics driver returns
>> from the resume callback.
>> It shows as if it's ready (you can turn it to D0) but actually it doesn't change on
>> the hardware.  Thus, the serialization with an unsol event wait seems
>> mandatory for the time being.
>>
> It seems so. We have not found better solution now :-(
> I've revised the patch for system suspend/resume case. Please review.

If this problem can be detected by looking at the pin and finding that 
it is in D3, can we extend the "try to set the pin 10 times" algorithm 
in hda_set_power_state to check all the pins for haswell HDMI?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
