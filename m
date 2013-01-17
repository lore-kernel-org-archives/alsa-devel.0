From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Thu, 17 Jan 2013 14:51:42 -0500
Message-ID: <CA+S_cwpM1Z0sPOS+TcdDni14vY7DU14F1ez4CyOkLS1LHyM1oQ@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5h1udlp5to.wl%tiwai@suse.de>
 <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f174.google.com (mail-ia0-f174.google.com
 [209.85.210.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D50272650AC
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 20:51:43 +0100 (CET)
Received: by mail-ia0-f174.google.com with SMTP id o25so722461iad.19
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 11:51:42 -0800 (PST)
In-Reply-To: <20130117191224.44794728@gmail.com>
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

> El jue, 17 ene 2013 a las 16:32 horas
> Takashi Iwai escribi=F3:
> >
> >In anyway, only for checking the presence unsolicited events, you can
> >do without extra program.  Suppose you built your kernel with the
> >tracing support.  See "Tracepoints" option in
> >Documentation/sound/alsa/HD-Audio.txt.
> >
> >  # echo 1 > /sys/kernel/debug/tracing/events/hda/hda_unsol_event/enable
> >
> >  (plug and unplug your headphone jacks)
> >
> >  # cat /sys/kernel/debug/tracing/trace
> >
> >If you see some hda_unsol_event lines there, it implies that the jack
> >detection basically works in hardware level.
> >
> >
> >Takashi
>
>
> My test:

HP Independent disabled, Auto-Mute enabled. When plugging front headphones,
sound is in both devices. Yet tracing shows that  jack detection is being
picked up (one plug and unplug event):

miro2 miro # cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:8
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h.   339.442694: hda_unsol_event: [0]
res=3D4000000, res_ex=3D10
          <idle>-0     [000] d.h.   345.727502: hda_unsol_event: [0]
res=3D4000000, res_ex=3D10


So, somehow auto-muting appears non-functional ...
