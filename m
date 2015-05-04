From: Hui Wang <hui.wang@canonical.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Mon, 04 May 2015 09:11:41 +0800
Message-ID: <5546C74D.70607@canonical.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
 <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
 <CAP1KSYcYSn53Q1ivK9Kxi7G03P71vNWSzdPA6Nagscd=x=iuTw@mail.gmail.com>
 <s5hbni4kbxb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 47874260590
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 03:11:54 +0200 (CEST)
In-Reply-To: <s5hbni4kbxb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Simon Derr <ddrsimon@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 05/01/2015 03:13 PM, Takashi Iwai wrote:
> At Fri, 1 May 2015 09:05:44 +0200,
> Simon Derr wrote:
>> On Thu, Apr 30, 2015 at 10:39 PM, Simon Derr <ddrsimon@gmail.com> wrote:
>>
>>> Good news : setting model=,headset-mic seems to solve all my issues.
>>> The jack mic works, the internal mic works, and the boost works.
>> Ach !
>>
>> Things are actually a bit more complicated. After suspend/resume my
>> mic stopped working.
> OK, this must be a bug in the quirk.
> Could you give alsa-info.sh outputs before and after suspend (with
> this model option)?
>
> David, Hui, do you see any similar problem with Dell machines?
>
I didn't see the similar problem with Dell machines recently.

Regards,
Hui.
> thanks,
>
> Takashi
>
>> After a lengthy testing the minimum sequence that seems to reliably work is:
>>
>> 1/ modprobe snd-hda-intel model=,dell-headset-multi
>> But **with a headset plugged in in the combo jack**. Else it does not work.
>>
>> 2/ using alsamixer set the second capture knob (that was at 0) to 100
>>
>> 3/ rmmod snd-hda-intel. The headset can be removed now, or not.
>>
>> 4/ modprobe snd-hda-intel model=,headset-mic
>>
>> 5/ Now the proper boost and recording levels can be set in alsamixer,
>> and the mic works properly.
>>
>>      Simon
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
