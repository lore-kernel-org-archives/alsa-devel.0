From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Thu, 18 Jun 2015 07:24:50 +0800
Message-ID: <CAN8cciYaHv-TtgCGkcnxagZp7p2EO4b17c9An6ctka7wkT8AXw@mail.gmail.com>
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
 <CAH=tA9H+SD81PtK_5XYUoJ62M4nC0dEhrz1RsLLKXfcv61_TUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 740792660BB
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 01:24:51 +0200 (CEST)
Received: by obctg8 with SMTP id tg8so43503958obc.3
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 16:24:50 -0700 (PDT)
In-Reply-To: <CAH=tA9H+SD81PtK_5XYUoJ62M4nC0dEhrz1RsLLKXfcv61_TUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolae Rosia <nicolae.rosia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Jack functions numbered as seen in Asus PDF, copied from Realtek HDA:
> Jack 1:
> Headphone
> Front Speaker Out
>
> Jack 2:
> Mic In
> Center/Subwoofer Speaker Out
>
> Jack 3:
> Headphone
> Rear Speaker Out
>
> On Windows I don't need any reboot. hdajackretask was giving a warning
> and it didn't work only after rebooting.

Have you tested whether your dual headphone jacks work as expected ?

When auto parser find two headphone jacks and no line out  jacks,  it use
sequence number to check those headphone and dock headphone and put one
headphone jack in spec->line_out_pins

But your dual headphone jacks need sequence number to determine whether it
is use as headphone for front and headphone for surround

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-headphones-2.conf

AFAIK, no alsa  driver create Headphone2 playback volume nor Headphone2
playback switch controls
