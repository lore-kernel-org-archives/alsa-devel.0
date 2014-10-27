From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] pcm: Fix snd_pcm_avail_update description
Date: Mon, 27 Oct 2014 13:21:56 +0100
Message-ID: <544E38E4.1010704@canonical.com>
References: <1414411902-5335-1-git-send-email-david.henningsson@canonical.com>
 <s5hmw8h4sgi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8CE2608D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 13:21:56 +0100 (CET)
In-Reply-To: <s5hmw8h4sgi.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-10-27 13:17, Takashi Iwai wrote:
> At Mon, 27 Oct 2014 13:11:42 +0100,
> David Henningsson wrote:
>>
>> While reading alsa-lib code, I discovered that snd_pcm_avail_update
>> does require a user-kernel context switch:
>
> Not "does" but "may"...
>
>> snd_pcm_avail_update() -> snd_pcm_hw_avail_update() -> sync_ptr()
>> -> sync_ptr1() -> ioctl()
>
> ... since this depends on the setup.  sync_ptr() calls sync_ptr1()
> only when the status mmap isn't done.

Ah, that's what I was missing. Thanks.

>
>
> Takashi
>
>> The documentation says it does not, so let's fix the documentation.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   src/pcm/pcm.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
>> index 4a7be6c..e57e362 100644
>> --- a/src/pcm/pcm.c
>> +++ b/src/pcm/pcm.c
>> @@ -403,10 +403,12 @@ The function #snd_pcm_avail_update() updates the current
>>   available count of samples for writing (playback) or filled samples for
>>   reading (capture). This call is mandatory for updating actual r/w pointer.
>>   Using standalone, it is a light method to obtain current stream position,
>> -because it does not require the user <-> kernel context switch, but the value
>> -is less accurate, because ring buffer pointers are updated in kernel drivers
>> +because while it does require a user <-> kernel context switch, the value is
>> +just copied from the kernel, and not updated by synchronously asking the hardware
>> +about its current position. The ring buffer pointers are updated in kernel drivers
>>   only when an interrupt occurs. If you want to get accurate stream state,
>> -use functions #snd_pcm_avail(), #snd_pcm_delay() or #snd_pcm_avail_delay().
>> +use functions #snd_pcm_avail(), #snd_pcm_delay(), #snd_pcm_avail_delay() or
>> +#snd_pcm_status().
>>   </p>
>>   <p>
>>   The function #snd_pcm_avail() reads the current hardware pointer
>> --
>> 1.9.1
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
