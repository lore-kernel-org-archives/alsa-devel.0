From: Cefn Hoile <alsa-project.org@cefn.com>
Subject: Dell N5110 HDA External Speaker is mute
Date: Wed, 11 Jan 2012 00:56:18 +0000
Message-ID: <CA+P0tC_jvOyEsbmZoF5oJZ9k6DA3FRaHCbq+xP3axw+jgLaQ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EF8C246BE
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2012 01:56:20 +0100 (CET)
Received: by obcwm4 with SMTP id wm4so262973obc.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 16:56:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I'd like to report an issue experienced with the latest Oneiric, Dell
N5110, and IDT STAC92HD87 which has been explored through quite a few
steps already, and seems to have bottomed out to a set of
pins/controls/flags which are not being properly managed in order to
toggle speaker activation when a headphone is inserted.

So far, I haven't heard sound from my speakers at all, although within
Alsamixer, the Speaker volume is visibly toggled from 100% to MM
(mute) on headphone insertion.

I've tried every model against snd-hda-intel, many different other
options, and started to explore the HDA Analyzer, which includes
controls named like this...

Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Device: name="STAC92xx Analog", type="Audio", device=0
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=1, idx=0, ofs=63
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=1, idx=0, ofs=0
  Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
  Amp-Out vals: [0x7f 0x7f]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples

...but toggling these checkboxes within the HDA Analyzer gui doesn't
trigger any sound from the speakers either. It could be a rich
combination of the very many checkboxes and sliders which are revealed
by the Analyzer, but I don't really know where to start. The bug
information downstream is here...

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/914290

I'd really welcome suggestions for what else to try and happy to
invest time exploring options to try and make ALSA better still.

Cefn
http://cefn.com
