From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Thu, 17 Jan 2013 23:20:53 -0500
Message-ID: <CA+S_cwokG9OfvNP+7ji4PLgvN4ABw2fP9ErmwRPA_+rjP9qsnw@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <s5hfw1z1s6a.wl%tiwai@suse.de> <20130117214043.5a1574ee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 92BA42616FA
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 05:20:54 +0100 (CET)
Received: by mail-ie0-f178.google.com with SMTP id c12so5966209ieb.9
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 20:20:53 -0800 (PST)
In-Reply-To: <20130117214043.5a1574ee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Manolo_D=EDaz?= <diaz.manolo@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, basinilya@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2013 at 3:40 PM, Manolo D=EDaz <diaz.manolo@gmail.com> wrot=
e:

>
> branch tested: master
>
> commit d89012bef4ad6d33c1050dd2924f010f5072ff52
> Merge: ad92fbe 36c9db7
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Thu Jan 17 17:47:19 2013 +0100
>
> Just the same: auto-mute doesn't work.
>
> alsa-info output show no differences (attached).
>
> Jack inserting event correctly detected again.
>
> #~ cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:2
> #
> #                              _-----=3D> irqs-off
> #                             / _----=3D> need-resched
> #                            | / _---=3D> hardirq/softirq
> #                            || / _--=3D> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>           <idle>-0     [001] d.h.   198.843063: hda_unsol_event: [0]
> res=3D4000000, res_ex=3D10
>
>
> Regards,
> --
> Manolo D=EDaz
>

Testing master branch, I got the similar results as Manolo

commit 920544e4bc95d5fb4465eb58e419a2c61074cd7e
Merge: 910fb91 ae12700
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Jan 16 16:26:03 2013 +0100

# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:8
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h.   341.307150: hda_unsol_event: [0]
res=3D4000000, res_ex=3D10

No difference in alsa-info before and after headphones are plugged in
(other than timestamp):
http://pastebin.com/J1PiRia8


Should I test with the test/hda-gen-parser branch?
