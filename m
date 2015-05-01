From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Fri, 1 May 2015 09:32:24 +0200
Message-ID: <CAP1KSYfwo+O0vo3raRFn8VzB1szWT+CQjYictkwkUuv_ZxLLnQ@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
 <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
 <CAP1KSYcYSn53Q1ivK9Kxi7G03P71vNWSzdPA6Nagscd=x=iuTw@mail.gmail.com>
 <s5hbni4kbxb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AB8BF260666
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 09:32:44 +0200 (CEST)
Received: by wgyo15 with SMTP id o15so84509857wgy.2
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2015 00:32:44 -0700 (PDT)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 1, 2015 at 9:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 1 May 2015 09:05:44 +0200,
> Simon Derr wrote:
>>
>> On Thu, Apr 30, 2015 at 10:39 PM, Simon Derr <ddrsimon@gmail.com> wrote:
>>
>> > Good news : setting model=,headset-mic seems to solve all my issues.
>> > The jack mic works, the internal mic works, and the boost works.
>>
>> Ach !
>>
>> Things are actually a bit more complicated. After suspend/resume my
>> mic stopped working.
>
> OK, this must be a bug in the quirk.

I wouldn't call it a bug, since the quirk that is "live" during
suspend/resume is not the only quirk needed to make the mic work.
Anyway, more testing shows that one step in my sequence was not needed.

The whole story is:

1/ modprobe snd-hda-intel model=,dell-headset-multi
But **with a headset plugged in in the combo jack**. Else it does not work.
At this point the headset mic works but not the internal one.

2/ rmmod snd-hda-intel. The headset can be removed now, or not.

3/ modprobe snd-hda-intel model=,headset-mic

4/ Now the proper boost and recording levels can be set in alsamixer,
the mic works.
alsa-info here:
http://www.alsa-project.org/db/?f=17352a127029ec18376b71f960965c9d29646c8b

5/suspend-resume. Mic stops working.
alsa-info here:
http://www.alsa-project.org/db/?f=de32acc42d0c3be14ffeca2715881eb436eb57b1

Regards,


    Simon
