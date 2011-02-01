From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Questions about Multi-streaming playback with HDA
 codec ad1988b
Date: Tue, 1 Feb 2011 16:55:01 +0800
Message-ID: <AANLkTi=GfTA1eQd38nR85iAOm-yeN6c2N9_-ZhoP8BQn@mail.gmail.com>
References: <AANLkTi=_xGmLUz24UUPvZGdzFJXU0HcpdsxTuU2C=uta@mail.gmail.com>
	<s5h1v4b38hq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 959142443B
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 09:55:02 +0100 (CET)
Received: by eyg24 with SMTP id 24so2833085eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 00:55:02 -0800 (PST)
In-Reply-To: <s5h1v4b38hq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/17 Takashi Iwai <tiwai@suse.de>

>
>
> > c) idenifty ad1988a and ad1988b
>
> Once if we have a PCI quirk entry with any real device ids.
>
>
ad1989b has SPDIF OUT 2 for HDMI

http://www.analog.com/en/audiovideo-products/audio-codecs/ad1989b/products/product.html

https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/711066

http://launchpadlibrarian.net/63268478/Card0.Codecs.codec.0.txt

Node 0x1d [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Control: name="HDMI Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000010: OUT
  Pin Default 0x1856f1b0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Other
    DefAssociation = 0xb, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
