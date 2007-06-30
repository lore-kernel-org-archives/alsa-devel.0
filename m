From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: [HDA Intel/STAC92xx] mic not working
	(retasking?)...
Date: Sat, 30 Jun 2007 22:07:13 +0100
Message-ID: <6278d2220706301407p739ebfb5i52d4a2af3a17ecd8@mail.gmail.com>
References: <6278d2220706271328u79afd988r44cc1fbfc41c6014@mail.gmail.com>
	<s5hved6z75l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 47EC810380D
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2007 23:07:17 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so1048992ugf
	for <alsa-devel@alsa-project.org>; Sat, 30 Jun 2007 14:07:16 -0700 (PDT)
In-Reply-To: <s5hved6z75l.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi San,

On 30/06/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 27 Jun 2007 21:28:43 +0100,
> Daniel J Blueman wrote:
> >
> > With both 2.6.20 and 2.6.22 kernels on Ubuntu 7.04 on my Sony Vaio
> > SZ240, I'm unable to get my mic connector working at any cost.
> >
> > Well, almost...reading from /dev/dsp, I do see a minute change from
> > 127 for 126 or 128 if I tap my external mic. This would imply the
> > jack-retasking feature of this darn STAC chipset, right?
> >
> > How can I change the jack retasking with the Intel HDA drivers or get
> > further insight into this problem?
>
> First, show the contents of /proc/asound/card0/codec#* files...

Firstly, thank you for replying; the only related cases I've been able
to find on the internet suggest to use the 'model=vaio' option to the
snd-hda-intel module, but this does not help.

The information you requested, and a little more is:

# cat /proc/asound/card0/codec#0
Codec: SigmaTel CXD9872RD/K
Address: 0
Vendor Id: 0x83847661
Subsystem Id: 0x104d0700
Revision Id: 0x104201
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6c 0x6c]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x6c 0x6c]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x07
Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x0e
Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x09
Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0f 0x0f]
  Connection: 1
     0x15
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x03211030: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x40f000fb: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x40f000fc: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x03a1502e: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Red
  Pin-ctls: 0x24: IN
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN Detect
  Pin Default 0x50370060: [N/A] CD at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x90171010: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x05
Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x3e0]: 44100 48000 88200 96000 176400
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40f000fd: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 2
     0x10* 0x09
Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x13
Node 0x13 [Pin Complex] wcaps 0x440381: Stereo Digital
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x40f000fe: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x90a71020: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Black
  Pin-ctls: 0x20: IN
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 4
     0x0a 0x0d 0x14* 0x02
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x17 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x18 [Audio Output] wcaps 0x40201: Stereo Digital

# cat /proc/asound/card0/codec#1
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x104d0200
Revision Id: 0x90000

# cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: STAC92xx Analog
name: STAC92xx Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 2
subdevices_avail: 2

# cat /proc/asound/card0/pcm0c/sub0/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: STAC92xx Analog
name: STAC92xx Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 2
subdevices_avail: 2

# cat /proc/asound/card0/pcm0c/sub1/info
card: 0
device: 0
subdevice: 1
stream: CAPTURE
id: STAC92xx Analog
name: STAC92xx Analog
subname: subdevice #1
class: 0
subclass: 0
subdevices_count: 2
subdevices_avail: 2

Thanks again!
  Daniel
-- 
Daniel J Blueman
