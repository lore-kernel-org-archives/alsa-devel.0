From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Sat, 13 Jun 2015 06:09:28 +0800
Message-ID: <CAN8cciaKtnQixs0+pa5=xCG8ZPpz+=ZaYjwnBmLoVsOJYY-7vg@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
 <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
 <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f196.google.com (mail-ob0-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 46359260557
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 00:09:29 +0200 (CEST)
Received: by obcwm4 with SMTP id wm4so7381400obc.3
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:09:28 -0700 (PDT)
In-Reply-To: <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
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

> > Do you mean hdajackretask cannot shutdown pulseaudio or you still have
other
> > applicaion using the sound card which prevent dynamic reconfiguration of
> > snd-hda-intel ?
> >
> I was testing using a browser on a youtube video. When I apply the
> changes, I lose the sound (pulseaudio gets killed), that message
> appears and I have to refresh the page to get sound again - but
> nothing changes.
>
> >
> > Can you post the output of alsa-info.sh after you patched the line out
jacks
> > ?
> http://www.alsa-project.org/db/?f=82a057b76a781edb53217b2cc096bce35459ab0a
>
> > Which node is the headphone spdif combo jack ?
> >
> Using hdajacksensetest I found out the mapping:
> SPDIF port (jack 1): Pin 0x16 (Green Line Out, Rear side)
> jack 2: Pin 0x18 (Green Line Out, Rear side)
> jack 3: Pin 0x15 (Green Line Out, Rear side)
>
> > Do both headphone jacks have headphone , headset  or line out icon ?
> You can see the icons here [0] at page 20

Are you sure that those icons and jacks order matched with your notebook ?

The user guide seem not specific to g751jm

3) the icon is a line out symbol, arrow point out of the circles but the
description is audio input jack (i.e. line in) which does not match with
the specification

Neither specification nor user manual mention the support of surround 5.1

>
> > Do you mean switch to 5.1 profile in sound preference is not enough ?
> By listening on Youtube I can't hear the center and subwoofer without
> modifying the pulseaudio conf
>
> [0]
http://dlcdnet.asus.com/pub/ASUS/nb/G751JM/0409_E9481.pdf?_ga=1.206896403.1230956712.1434110719
