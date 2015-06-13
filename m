From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Sat, 13 Jun 2015 20:26:32 +0800
Message-ID: <CAN8ccibLHuYuqgypm8O7gZMwZoGUNs8-cg-1rHcPaErNGVs2Fw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2728826057F
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:26:34 +0200 (CEST)
Received: by obpc2 with SMTP id c2so9287496obp.3
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:26:33 -0700 (PDT)
In-Reply-To: <CAH=tA9ECWF9WaeJvJcT3D-uXqr-r4Zp+TmBD88GJ6YhxQztJxA@mail.gmail.com>
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

> > If your specifcaion and user guide does not mention the support of
surround
> > 5.1
> >
> > You need to find out the internal subwoofer use both channel or just
left or
> > right
> >
> > speaker-test -c4 -t wav -D hw:0,0
> >
> > If you hear high frequency from subwoofer, this mean you need software
low
> > pass filtter
> >
> After removing all jacks and testing with speaker-test -c 4 -t wav -D
hw:1,0
>
> speaker-test 1.0.29
>
> Playback device is hw:1,0
> Stream parameters are 48000Hz, S16_LE, 4 channels
> WAV file(s)
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 32 to 524288
> Period size range from 16 to 262144
> Using max buffer size 524288
> Periods = 4
> was set period_size = 131072
> was set buffer_size = 524288
>  0 - Front Left
>  1 - Front Right
>  3 - Rear Right
>  2 - Rear Left
> ^CTime per period = 9.384977
>
> I can hear high frequency from internal subwoofer while speaker-test
> printed 3 and 2.

http://colin.guthr.ie/2010/09/compiling-and-running-pulseaudio-from-git/

You can build and run using git but without install pulseaudio to test 2.1
and pulseaudio lfe-filter

>
> > Two headphone jacks, internal speaker and subwoofer
> >
> > There are only three playback volume controls
> >
> >
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093668.html
> >
> > Your case are
> >
> > A. 3 DACs, 2 HP, 2 speakers

> Neither specification nor user manual mention the support of surround 5.1
It is curious because I have selected Analog Surround 5.1 Output in Sound
Settings (GNOME), and I can test each individual speaker (5.1). It also
works in Windows 8.1

do windows 8.1 use mic jack as clfe or surround ?

Since the user manual did not provide the mapping,

http://www.intel.com/support/motherboards/desktop/sb/CS-034198.htm

How do the other user know the mapping even if you implemented 5.1 ?

You have to follow up the above thread about the name of volume control if
you think your case are

D: 3DACs 2 HP 1Mic 2 Speaker
