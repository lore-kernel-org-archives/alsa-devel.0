From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Sat, 13 Jun 2015 11:14:40 +0800
Message-ID: <CAN8ccib13ygePJWmQiQvmt-4wt49GnJ2BYVLAUKFckNNk0mf5A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 6618F266A0D
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:14:41 +0200 (CEST)
Received: by obbsn1 with SMTP id sn1so33713827obb.1
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 20:14:40 -0700 (PDT)
In-Reply-To: <CAN8cciaQhhP3P-LU2KFJ8mCSTk5tcroEKpDMh4g_dtMkxV_q0A@mail.gmail.com>
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
>
> > Do you mean switch to 5.1 profile in sound preference is not enough ?
> By listening on Youtube I can't hear the center and subwoofer without
> modifying the pulseaudio conf
>
> [0]
http://dlcdnet.asus.com/pub/ASUS/nb/G751JM/0409_E9481.pdf?_ga=1.206896403.1230956712.1434110719

If your specifcaion and user guide does not mention the support of surround
5.1

You need to find out the internal subwoofer use both channel or just left
or right

speaker-test -c4 -t wav -D hw:0,0

If you hear high frequency from subwoofer, this mean you need software low
pass filtter

Two headphone jacks, internal speaker and subwoofer

There are only three playback volume controls

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093668.html

Your case are

A. 3 DACs, 2 HP, 2 speakers

Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Bass Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Surround Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x90170130: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 3
     0x0c 0x0d* 0x0e
