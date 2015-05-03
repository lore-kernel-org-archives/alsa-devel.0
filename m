From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Sun, 3 May 2015 23:27:46 +0200
Message-ID: <CAP1KSYfpP+Q8=xEteLXh6fia2=tSUe2+WYb_pgDkoead_hD3uQ@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
 <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
 <CAP1KSYcYSn53Q1ivK9Kxi7G03P71vNWSzdPA6Nagscd=x=iuTw@mail.gmail.com>
 <s5hbni4kbxb.wl-tiwai@suse.de>
 <CAP1KSYfwo+O0vo3raRFn8VzB1szWT+CQjYictkwkUuv_ZxLLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BFA26042B
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2015 23:28:07 +0200 (CEST)
Received: by wgen6 with SMTP id n6so133729953wge.3
 for <alsa-devel@alsa-project.org>; Sun, 03 May 2015 14:28:07 -0700 (PDT)
In-Reply-To: <CAP1KSYfwo+O0vo3raRFn8VzB1szWT+CQjYictkwkUuv_ZxLLnQ@mail.gmail.com>
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

Hello,

I have made some progress.

First I may have been mistaken when I thought that the external mic
was working. Further testing makes me think that it was actually the
internal mic picking up sound while the headset was connected. But
that's not really an issue for me, since I am mostly interested in the
internal mic.

Now, I have used ftrace to trace what was going on when I plugged the
headset while using dell-headset-multi. This allowed me to write a
patchfile that I can load using

   modprobe snd-hda-intel patch=,my-hda-patch.fw

With the contents of /lib/firmware/my-hda-patch.fw being as follows:

[codec]
0x10ec0233 0x1043124f 0

[verb]
0x20 0x500 0x45
0x20 0x4c4 0x29
0x20 0x500 0x35
0x20 0xc00 0x00
0x20 0x500 0x35
0x20 0x46f 0x3e
0x20 0x500 0x06
0x20 0x421 0x00
0x20 0x500 0x1a
0x20 0x400 0x21
0x20 0x500 0x26
0x20 0x400 0x8c


Using this, my internal mic works, and keeps working after suspend/resume.

Regards,


    Simon
