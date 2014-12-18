From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Create capture source ctls
 when stereo mix input is added
Date: Thu, 18 Dec 2014 15:13:13 +0800
Message-ID: <CAN8cciat+TW_qxEHPngXkAWzQZ4GSUWrmww3WDt2qA2R0Mnvsw@mail.gmail.com>
References: <1418648202-2509-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 622F126049A
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 08:13:14 +0100 (CET)
Received: by mail-qg0-f47.google.com with SMTP id q108so441835qgd.6
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 23:13:13 -0800 (PST)
In-Reply-To: <1418648202-2509-1-git-send-email-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> When the stereo mix input is explicitly enabled via a user hint, the
> driver should create always a capture source enum ctl and disable the
> auto-mic switch.  Otherwise the behavior gets confused.  For doing it,
> this patch just sets spec->suppress_auto_mic flag appropriately.
>

As your patch allow notebook to use stereo mix by hint , does it mean that
those audio mixer which only have input from audio output but no mic or
line input can be also enabled on notebook by hint ?

https://bugzilla.kernel.org/attachment.cgi?id=144111

Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="CX20590 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
  Amp-In vals:  [0x50 0x50] [0x80 0x80] [0x50 0x50] [0x80 0x80]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
  Connection: 4
     0x17 0x18 0x23* 0x24

Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x10 0x11
