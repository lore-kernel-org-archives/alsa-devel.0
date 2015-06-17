From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Wed, 17 Jun 2015 22:43:15 +0300
Message-ID: <CAH=tA9H+SD81PtK_5XYUoJ62M4nC0dEhrz1RsLLKXfcv61_TUQ@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
 <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
 <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
 <CAN8cciaQhhP3P-LU2KFJ8mCSTk5tcroEKpDMh4g_dtMkxV_q0A@mail.gmail.com>
 <CAN8ccib13ygePJWmQiQvmt-4wt49GnJ2BYVLAUKFckNNk0mf5A@mail.gmail.com>
 <CAH=tA9ECWF9WaeJvJcT3D-uXqr-r4Zp+TmBD88GJ6YhxQztJxA@mail.gmail.com>
 <CAN8ccibLHuYuqgypm8O7gZMwZoGUNs8-cg-1rHcPaErNGVs2Fw@mail.gmail.com>
 <CAH=tA9H78dWaRk92Aojh2Z4Gw9MZyhQSb3BAqsJ6EhFB7cDVWw@mail.gmail.com>
 <CAN8cciY5NYuRGph7GBxWVR4LKAzKOJMPXpdH35hXwwyQwVUs-Q@mail.gmail.com>
 <CAN8cciYB26go1g9SqGcu2hjPUQRNSy0=8ts9KUkxDGgU6AqsXA@mail.gmail.com>
 <CAH=tA9Hm5Do+uGOJPnUGFMMUyj+UFpA_PitezXsYQgmurvgPvw@mail.gmail.com>
 <CAN8cciaFiFhZ9e14mNoAAm7G4fJZV5A9ONiBxos1EgZx2UaC9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 246B5265FCF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 21:43:16 +0200 (CEST)
Received: by laka10 with SMTP id a10so40470390lak.0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 12:43:15 -0700 (PDT)
In-Reply-To: <CAN8cciaFiFhZ9e14mNoAAm7G4fJZV5A9ONiBxos1EgZx2UaC9w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jack functions numbered as seen in Asus PDF, copied from Realtek HDA:
Jack 1:
Headphone
Front Speaker Out

Jack 2:
Mic In
Center/Subwoofer Speaker Out

Jack 3:
Headphone
Rear Speaker Out

On Windows I don't need any reboot. hdajackretask was giving a warning
and it didn't work only after rebooting.

On Wed, Jun 17, 2015 at 6:20 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
>> >
>> >> >
>> >> > How do the other user know the mapping even if you implemented 5.1 ?
>> >> I don't know (?)
>> >
>> >
>> > https://rog.asus.com/forum/showthread.php?54685-Asus-G751JT-supports-5-1-analog-output
>> >
>> > Is the support of 5.1 done by realtek hda manager or asus audio wizard ?
>> I have only used Realtek HDA Manager. There's no "wizard", you just
>> have to select 5.1 Speaker in Speaker Configuration drop down menu.
>
> Do your 2.1  work as expected after enable pulseaudio 2.1 lfe filter ?
>
> Do your dual headphone jacks work as expected after you add back the missing
> pin?
>
> Do your dual headphone jack coexist with 2.1 speakers since you only have
> three volume controls ?
>
> After you change to 5.1 by realtek hda manger , do you need a reboot ?
> If yes, Do this mean that you also need another reboot to use back 2.1
> intenal speakers ?
>
> Do HDA realtek manager  allow you to
>
> a) change mic jack as Line in jack ?
> b) disable the subwoofer ?
> c) change any jack to line in, line out, headphone or mic ?
>
> Since bios did not setup pin default for some jacks,
>
> Do users expect the jacks are initialised by the driver
>
> 1) as the icon near the jack
> 2) as specified in user manual
> 3) as notebook specifcation
>
> You need a simplified verion of hdajackretask which  allow you to change
> from 2.1 to 5.1
