From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Fri, 2 Dec 2016 10:20:45 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1612021018500.11018@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 429DF26774C
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 10:20:47 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id g23so1729652wme.1
 for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2016 01:20:46 -0800 (PST)
In-Reply-To: <s5h4m2n21ll.wl-tiwai@suse.de>
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

thank you very much.
Unfortunately crashes on that machine are a little bit problematic now.
In case I get to render them less problematic, I'll let you know, even if I really don't know how things may go.

In case, I may try to set up a kdump or photograph the screen.
Thank you again, and sorry for the "inconcludence"....
Enrico


Enrico Mioso
Mobile Phone Number: +393807096934 ( +Telegram :) )
My Tox ID is: 7C593F402A3C8632D87AB4B948D492294C39A6A614464ECF843CA3429FB023284180472C7475

I like / recommend usage of open messaging standards when possible.

On Thu, 1 Dec 2016, Takashi Iwai wrote:

> Date: Thu, 1 Dec 2016 14:57:58
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Thu, 01 Dec 2016 14:50:30 +0100,
> Enrico Mioso wrote:
>>
>> On Thu, 1 Dec 2016, Takashi Iwai wrote:
>>
>>> Date: Thu, 1 Dec 2016 11:12:25
>>> From: Takashi Iwai <tiwai@suse.de>
>>> To: Enrico Mioso <mrkiko.rs@gmail.com>
>>> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
>>> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
>>>
>>> On Wed, 23 Nov 2016 09:19:07 +0100,
>>> Enrico Mioso wrote:
>>>>
>>>> Hello guys.
>>>> With the these last settings the system seems able to survive. However, I think I am a little bit drastic with these settings.
>>>>
>>>> here my hardware infos: I remember of being asked to send them as an attachment, so I'll do so.
>>>> No upload has been made: when the script aked me, I choosen "Save locally". But there is an "upload=true" or something like that at the beginning.
>>>
>>> The single_cmd is really the last resort, and it already means that
>>> something wrong in the codec/controller communication.
>>>
>>> What does actually crash and how is the exact symptom?  You seem to
>>> always cut the citation, so I cannot remember the exact issue.
>>> Please keep the normal ML style, no top-posting.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>> Sorry for the inconvenience. I usually did that because, when reading
>> e-mails with a screen reader (e.g.: from my phone), having all the
>> text preceeded by things like ">>" is a little bit unconfortable. But
>> I understand this can be a problem, and ML worked this way since a
>> long time I guess.
>>
>> So I recap: my computyer identifies itself as:
>> ASUSTeK Computer INC. 1101HAG/1101HAG, BIOS 0102    08/17/2009
>> (it's an EEE PC and this message has been extracted from the dmesg, DMI data).
>>
>> Once back, the HDA audio controller exhibited some strange behaviours,
>> and in particular, audio wasn't routed the normal way when I plugged
>> my headphones or unplugged them (so, if I din't wait for the
>> controller to go in low-power mode, I could hear audio both form
>> headphones and laptop speakers). Waiting instead, resulted in the
>> controller working properly.
>> You suggested me a method to report back some useful infos, but I
>> didn't do that, sorry. (I posted a mail with those infos some day ago
>> if I am not wrong.)
>>
>> Then time passed,and I upgraded my kernel to the git version I
>> reported in my previous mail, and now btw I am following current -git
>> kernel with this system.
>> I haven't noticed strange behaviours regarding audio routing, but it
>> may well be due to lack of testing in this. But another strange thing
>> started happening: in particular, kernel panics when an application
>> tries to open the audio device (in my case it was Music Player Daemon,
>> but also mplayer triggered it once).
>
> The kernel panic is bad.  If you can get Oops message reliably, it'd
> be helpful to catch the stack trace.  You can also set up kdump to
> capture the crash.
>
>> So I tried setting power_save_controller and power_save both to 0
>> (yes, I know power_save_controller is a boolean)... I tried this
>> without much reasoning if reasoning at all.
>
> Note that many desktop environments adjust already the power-saving
> stuff by themselves, so your setup would be overridden.
>
>> No matter, I could still observe a panic (a single one I think).
>
> Again, if you can get an Oops, try to catch the oops message.  This
> would help analysis.
>
>> So I tried with single mode: and I did so because I think the driver
>> reverted to single cmd mode at some point on this device, in the past.
>> Now the system doesn't panic anymore, still in my dmesg there are lots of messages like:
>> snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
>
> Well, I'm not going to debug it any longer, as this is about
> single_cmd mode, and using single_cmd is only for the last-resort
> debugging.  Any inconvenience is expected.
>
> So, at best, let's try to catch the kernel oops at first.
>
>
> thanks,
>
> Takashi
>
