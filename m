From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Sun, 14 Jun 2015 14:48:07 +0800
Message-ID: <CAN8cciadrCevB06xOdfsfK0CRv__A8Wtf77v=FZd_6fp5Hk3NQ@mail.gmail.com>
References: <5576B419.5010505@canonical.com>
	<s5h1thlqeus.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6C8260502
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 08:48:08 +0200 (CEST)
Received: by obpc2 with SMTP id c2so17283786obp.3
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 23:48:07 -0700 (PDT)
In-Reply-To: <s5h1thlqeus.wl-tiwai@suse.de>
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
Cc: hwang4 <hui.wang@canonical.com>, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > I am trying to enable the subwoofer speaker on a HP laptop, on this
> > machine, there are two speakers and one headphone, but the BIOS verb
> > only enabled one speaker(nid 0xd) and one headphone(nid 0xb), I need
> > to use quirk in the kernel driver to configure the second speaker
> > (subwoofer speaker, nid 0x10). Under current alsa driver, the
> > headphone will be assigned a dac (nid 0x13) and the 2 speakers will
> > be assigned a dac (nid 0x14), this assignment is not good since 2
> > speakers share the same dac, this means 2 speakers can't work
> > at the same time to support 4.0/2.1 channels.
> >
> > On another Dell machine with realtek codec, there are also 2 speakers,
> > 1 headphone and 2 dacs, on this machine, 1 speaker and 1 headphone are
> > assigned
> > 1 dac, and the other speaker is assigned another dac, so there is no
> > problem for this machine to support 4.0/2.1 channels.
> >
> > Through debugging, I found on Dell machine, the speaker nid only has
> > one connection to dac (hardwired), so when driver assign dac to it, the
> > map_single() can successfully assign the each dac to the 2 speakers
> > respectively.
> > But on that HP machine, the speaker has multiple connections for dac,
the
> > map_single() can't work for this machine.
> >
> >
> > The alsa-info.txt for that HP machine is at
> > http://pastebin.ubuntu.com/11667947/



Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="92HD91BXX Analog", type="Audio", device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=5, channel=0
  Power states:
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x14 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x64 0x64]
  Converter: stream=5, channel=0
  Power states:
  Power: setting=D0, actual=D0
  Delay: 13 samples

Do hda_proc.c or hda_codec use the correct verb to get amp out cap of idt
codecs ?

92hd91 datasheet has default values of amp out caps

Why amp out caps are N/A ?

7.14.2.DAC0 (NID = 13h): OutAmpLeft

7.14.3.DAC0 (NID = 13h): OutAmpRight

7.15.2.DAC1 (NID = 14h): OutAmpLeft

7.15.3.DAC1 (NID = 14h): OutAmpRight
