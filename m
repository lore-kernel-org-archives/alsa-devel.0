From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: Re: Fwd:  ALSA queries
Date: Tue, 7 Aug 2018 19:06:22 +0530
Message-ID: <CALW20Z0x0a3A9S4DMq314jgSDa5LODJDiJi9HpcJ3WQv2pWz2A@mail.gmail.com>
References: <CALW20Z3Bhp6Bhx8qWWcfcF9wcOSGV_V+KC5ct+ovFQ=o2HeoAw@mail.gmail.com>
 <s5h8t5nx5qs.wl-tiwai@suse.de>
 <CALW20Z1YFqnbUE51Wbm38VaNL2Yr4osyMeGJmHrabfQvAY_1VQ@mail.gmail.com>
 <CALW20Z27m4gjzJzL-Jc11SzE70u05oV1uoKdj5T2Gk+ABVD1ig@mail.gmail.com>
 <s5htvo8smce.wl-tiwai@suse.de>
 <CALW20Z08N9pOG6W_FCBSz8DO92ZNTHnRYSY=ausL1tgij9-tOQ@mail.gmail.com>
 <s5hbmafhd3t.wl-tiwai@suse.de>
 <CALW20Z3PrdQwB2orP3aXx9TqEeh_AKizEC+oPQ8B66FbBSOYEg@mail.gmail.com>
 <s5hk1p37h8t.wl-tiwai@suse.de>
 <CALW20Z2_vxVxjT_bCf2fZDPuuAt1hZyOVF+jusm+9YCLc=ppfQ@mail.gmail.com>
 <s5h36vr7bsk.wl-tiwai@suse.de>
 <CALW20Z2OzysCHqtpbJCnDvQ3hho5kk=fwJF_q-fRVGMVDTGOTQ@mail.gmail.com>
 <s5hzhxy4c4y.wl-tiwai@suse.de>
 <CALW20Z30cz6HUKCqStsyvtfp=2UYKm8SBVvwvsuOA+zrgGJWjA@mail.gmail.com>
 <s5hwot24brq.wl-tiwai@suse.de>
 <CALW20Z04fL4xeFwwHBVRKhJVndL66muLXdCDhoEmAW+YGHh+tA@mail.gmail.com>
 <s5htvo64bfi.wl-tiwai@suse.de>
 <CALW20Z2Gdk3aT1-7X6qU1r7Fq01fnkBY1eo97EawCdduQB2UEw@mail.gmail.com>
 <s5hmuty48sn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E83C7267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 15:36:38 +0200 (CEST)
Received: by mail-qt0-f174.google.com with SMTP id w26-v6so5177673qto.5
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2018 06:36:38 -0700 (PDT)
In-Reply-To: <s5hmuty48sn.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>In the case above it's in frames.  But it can be defined in bytes
>depending on the hardware spec.  Some hardware defines in the time
>unit (like msec), too.

Can you please tell me how to define in bytes ?

>Now you know it.  And remember that PA is often die-hard.
So it means that I can not do rmmod until pulseaudio is removed , is
it correct ?

Regards,
Chakravarthi
On Tue, Aug 7, 2018 at 6:45 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 07 Aug 2018 15:12:08 +0200,
> Chakravarthi Pradeep wrote:
> >
> > Dear Takashi,
> >
> > Thanks for your reply.
> >
> > > The "period" in ALSA PCM definition represents the interval time (or
> > > frames) of the periodical interrupts on the ring buffer.  If the irq
> > > is issued for each 256 frames while the ring buffer size is 1024
> > > frames, periods = 1024/256 = 4.  The periods_min defines the minimal
> > > number of periods the hardware may accept.
> >
> > Is it  256 frames or  256 bytes ?
>
> In the case above it's in frames.  But it can be defined in bytes
> depending on the hardware spec.  Some hardware defines in the time
> unit (like msec), too.
>
> > fuser -v /dev/snd/* output is
> >                                          USER
> >   PID   ACCESS    COMMAND
> > /dev/snd/controlC0         Dell                                   1815
> > F.....           pulseaudio
>
> Now you know it.  And remember that PA is often die-hard.
>
>
> Takashi



-- 
Thanks and Regards
Chakravarthi Pradeep.K
Ph: 91 9980434900
