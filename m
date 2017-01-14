From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Sat, 14 Jan 2017 10:20:16 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1701141015060.19717@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701031449090.1620@localhost.localdomain>
 <s5hlgujyyop.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701121708560.2607@localhost.localdomain>
 <s5h1sw8w8pi.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701131929420.17357@localhost.localdomain>
 <s5htw92hvz7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B0EC026680A
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 10:20:22 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id c85so17088769wmi.1
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 01:20:22 -0800 (PST)
In-Reply-To: <s5htw92hvz7.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

Hello Takashi,
thank you very much again for your kindness and patience...

I'll enable the tracepoint.
Discrepancies in the single_cmd value are derived from the fact that I am still using the hackish version of the patch, since I didn't reboot... otherwise I should have started from scratch some very-long operations.
But the value has remained to 0, and the fallback didn't happen, as expected.

Ok, reading note.rst now.
I was wondering, but I may well be wrong: in the past that fallback code brought my system to single cmd mode after polling... Now it crashes, and as I said before, the switching from polling to last_cmd is kind-of immediate most of the times these days (e.g.: on this kernel).
May be something goes wrong in the fallback path? Or is this caused by an invalid verb ?
Guessing verb = something like a command...
Thank you again,
Enrico

On Sat, 14 Jan 2017, Takashi Iwai wrote:

> Date: Sat, 14 Jan 2017 09:44:12
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Fri, 13 Jan 2017 20:42:06 +0100,
> Enrico Mioso wrote:
>>
>> Hello guys.
>> I finally can report some interesting news.
>> Now audio stopped working - still, the system didn't panic. So I consider this a good good point.
>> My system is alive and I can keep it alive indefinitely, clearly if hardware doesn't break and/or other events out of my control cause an interruption.
>>
>> In my dmesg, the following messages started to appear:
>> snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching to polling mode: last cmd=0x020c0000
>
> I suppose the last_cmd value isn't always same?
>
>> snd_hda_codec_realtek hdaudioC0D0: Unable to sync register 0x1f0e00. -5
>
> Hm, this might be an invalid verb.
>
>> And they appear apparently when the driver tries to send new commands to the device, but this is only my impression.
>> Let me know what I could do to report on what's happening. My system is acually running with kdump active, so in case I may also invoke the crash sysrq action and send back results.
>
> When a crash no longer happens, kdump isn't needed.  Instead, we need
> to track what triggers the stall.
>
> Try to enable the tracepoint, as mentioned in
> Documentation/sound/hd-audio/notes.rst.
>
>
> thanks,
>
> Takashi
>
