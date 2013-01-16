From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Fujitsu Lifebook s7110 (ALC262) no sound
Date: Wed, 16 Jan 2013 09:04:53 +0800
Message-ID: <CAN8cciYGgg4ShyEFko9KUVSG3SJiumqZyobNm3SKs-M5SZ+abg@mail.gmail.com>
References: <CAN8ccibtCqRSeDHwNOq-xuVZKiCuPju9QNtGnT_N4tcNEUuUGw@mail.gmail.com>
 <CAN8ccibFCGAyFd7WGLvfQFieXYo-Jk7ZUsfTMgfyV+aKFc1WCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 37C752616B2
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 02:04:55 +0100 (CET)
Received: by mail-ie0-f175.google.com with SMTP id qd14so1449443ieb.20
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 17:04:54 -0800 (PST)
In-Reply-To: <CAN8ccibFCGAyFd7WGLvfQFieXYo-Jk7ZUsfTMgfyV+aKFc1WCw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: stormyweather <davconwaypub-resa3@yahoo.fr>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, pulseaudio-discuss@freedesktop.org
List-Id: alsa-devel@alsa-project.org

> after patching the clean 12.04 install with teh last alsa version (see
comment #13)
and with external speakers plugged (3.5 mm jack), I have got the follwoing
Alsa log:

http://www.alsa-project.org/db/?f=778415ad65d437d9ff5e5dd341e0e556ff848bc1

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=3dcd3be33046c9828a6057ee0f14de6e5d3b48a2;hp=b42590b865cb4358a0c37b2128e303a18d897bf6


-/*
- * fujitsu model
- *  0x14 = headphone/spdif-out, 0x15 = internal speaker,
- *  0x1b = port replicator headphone out
- */

Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Surround Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Headphone Surround Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals: [0x00 0x00]
   Pincap 0x0000003e: IN OUT HP Detect Trigger
   Pin Default 0x032110f0: [Jack] HP Out at Ext Left
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=03, enabled=1
   Connection: 2
      0x0c 0x0d*

Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Front Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Headphone Front Phantom Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals: [0x00 0x00]
   Pincap 0x0000003e: IN OUT HP Detect Trigger
   Pin Default 0xb7231110: [Fixed] HP Out at Oth Mobile-In
     Conn = ATAPI, Color = Black
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 2
      0x0c* 0x0d

Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Dock Headphone Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals: [0x00 0x00]
   Pincap 0x0000173e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x2321101f: [Jack] HP Out at Sep Left
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=01, enabled=1
   Connection: 2
      0x0c* 0x0d

If seem that BIOS did not setup the internal speaker node and need pin fixup

Pulseaudio expect headphone Jack and speaker phantom port

https://launchpadlibrarian.net/128561206/pulseverbose2.log
