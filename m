From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Laptop internal speaker volume is apparently
 controlled by the headphone control (Intel HDA Panther Point)
Date: Sat, 1 Aug 2015 08:39:21 +0800
Message-ID: <CAN8cciYJShqFCOWZETUecvL-9wguL4dFSDMevhtL2d=E2b2PbQ@mail.gmail.com>
References: <loom.20150731T230048-584@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C531F2619D0
 for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2015 02:39:21 +0200 (CEST)
Received: by obnw1 with SMTP id w1so65129820obn.3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 17:39:21 -0700 (PDT)
In-Reply-To: <loom.20150731T230048-584@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dang Sananikone <dang.sananikone@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I
>
> Hi,
>
> I've just noticed that the internal speaker volume on my laptop is now
> controlled by the headphone control in alsamixer. I think this may be a
> recent change although I can't be sure. I'm using Arch Linux with kernel
> 4.1.3-1.
>
> I've uploaded the alsa info here:
> http://www.alsa-project.org/db/?f=f04e506dad863823b18f8f9e9d0261fdacd72695

Simple mixer control 'Loopback Mixing',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'

When loopback mixing is enabled, both heaephone and speaker are connected
to audio mixer node 0x1b through node 0x1c,  audio mixer node 0x1b is only
connected to audio output node 0x13 which is controlled by headphone
playback volume

Node 0x1b [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Power states:
  Power: setting=D0, actual=D0
  Connection: 5
     0x13 0x14 0x0a 0x0c 0x0f

You have to disable loopback mixing
