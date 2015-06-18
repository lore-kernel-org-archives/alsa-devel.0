From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Thu, 18 Jun 2015 10:44:30 +0800
Message-ID: <CAN8cciZgNgY-U2Wi2+vbp6nqNBfeTw=m_K8WJTptChJZy3gVAw@mail.gmail.com>
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
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E3CB2660BD
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 04:44:32 +0200 (CEST)
Received: by oigx81 with SMTP id x81so48154514oig.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 19:44:31 -0700 (PDT)
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
To: Nicolae Rosia <nicolae.rosia@gmail.com>, sodmgerk@gmail.com
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

For Toshiba QOSMIO G40, there are also two headphone jacks , mic jack, line
in jacks  and one speaker but only  alc262 4 channel codecs

https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1465167/+attachment/4414982/+files/AlsaInfo.txt

Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=1, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x0421101f: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Connection: 2
     0x0c 0x0d*
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Line Out Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x042110f0: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Connection: 2
     0x0c* 0x0d

Do user prefer to support 4 channel by dual headphone jacks or two
headphone jacks share volume control ?

Do user prefer different name for two headphone jack kctl as playback
switches instead of index=0 and index=1 as pulseaudio seem unable to use
index=1 javk kctl in the pulseaudio verbose log

https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1465167
