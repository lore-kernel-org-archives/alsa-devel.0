From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Fri, 1 May 2015 09:05:44 +0200
Message-ID: <CAP1KSYcYSn53Q1ivK9Kxi7G03P71vNWSzdPA6Nagscd=x=iuTw@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
 <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E1EB8260647
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 09:06:04 +0200 (CEST)
Received: by wgso17 with SMTP id o17so84192697wgs.1
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2015 00:06:04 -0700 (PDT)
In-Reply-To: <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 10:39 PM, Simon Derr <ddrsimon@gmail.com> wrote:

> Good news : setting model=,headset-mic seems to solve all my issues.
> The jack mic works, the internal mic works, and the boost works.

Ach !

Things are actually a bit more complicated. After suspend/resume my
mic stopped working.
After a lengthy testing the minimum sequence that seems to reliably work is:

1/ modprobe snd-hda-intel model=,dell-headset-multi
But **with a headset plugged in in the combo jack**. Else it does not work.

2/ using alsamixer set the second capture knob (that was at 0) to 100

3/ rmmod snd-hda-intel. The headset can be removed now, or not.

4/ modprobe snd-hda-intel model=,headset-mic

5/ Now the proper boost and recording levels can be set in alsamixer,
and the mic works properly.

    Simon
