From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: no 5.1 surround sound on 3stack-6ch motherboard
Date: Sat, 1 Sep 2012 10:37:06 +0800
Message-ID: <CAN8cciZ=YARPzaOfcBg5kJBy+Uo8S+WhLT-2-vuQQN81VfiCSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E2E265E16
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2012 04:37:07 +0200 (CEST)
Received: by qcse14 with SMTP id e14so2387900qcs.38
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 19:37:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shane <sloath666@gmail.com>
Cc: pulseaudio-discuss.org@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1044150
>
>  you need to switch channel mode from 2ch to 6ch and restore this
> setting by alsactl before pulseaudio start
>
> Simple mixer control 'Channel Mode',0
>   Capabilities: enum
>   Items: '2ch' '4ch' '6ch'
>   Item0: '2ch
>
> but how can i do this??

amixer -c0 set "Channel  Mode" "6ch"

alsactl store

restart pulseaudio server

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio-Controls.txt;hb=HEAD

Realtek codecs
--------------

* Channel Mode
  This is an enum control to change the surround-channel setup,
  appears only when the surround channels are available.
  It gives the number of channels to be used, "2ch", "4ch", "6ch",
  and "8ch".  According to the configuration, this also controls the
  jack-retasking of multi-I/O jacks.

can you post the pulseaudio log ?

I don't understand how can pulseaudio server switch to active profile
surround51 when blue and pink jacks had not been retasked as output (
Pin-ctls are still IN ) and channel mode is still 2ch.

analog-input rear mic and line-in ports should not be available too.

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#6ch

Jack retasking is a feature that allows an audio jack to support more than
one function. For example, the pink audio jack can support microphone input
when the system configuration is set to Stereo Mode, and as Center/LFE or
Rear Surround (depending on the audio solution used) when set as 6 channel.

Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Rear Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals: [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19c50: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=03, enabled=1
  Power states: D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26

Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals: [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181345f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Power states: D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26



    index: 1
name: <alsa_card.pci-0000_00_1b.0>
driver: <module-alsa-card.c>
owner module: 5
properties:
alsa.card = "0"
alsa.card_name = "HDA Intel PCH"
alsa.long_card_name = "HDA Intel PCH at 0xf7d00000 irq 44"
alsa.driver_name = "snd_hda_intel"
device.bus_path = "pci-0000:00:1b.0"
sysfs.path = "/devices/pci0000:00/0000:00:1b.0/sound/card0"
device.bus = "pci"
device.vendor.id = "8086"
device.vendor.name = "Intel Corporation"
device.product.name = "6 Series/C200 Series Chipset Family High Definition
Audio Controller"
device.form_factor = "internal"
device.string = "0"
device.description = "Built-in Audio"
module-udev-detect.discovered = "1"
device.icon_name = "audio-card-pci"
profiles:
output:analog-stereo: Analogue Stereo Output (priority 1000)
output:analog-stereo+input:analog-stereo: Analogue Stereo Duplex (priority
1010)
output:analog-surround-40: Analogue Surround 4.0 Output (priority 700)
output:analog-surround-40+input:analog-stereo: Analogue Surround 4.0 Output
+ Analogue Stereo Input (priority 710)
output:analog-surround-41: Analogue Surround 4.1 Output (priority 800)
output:analog-surround-41+input:analog-stereo: Analogue Surround 4.1 Output
+ Analogue Stereo Input (priority 810)
output:analog-surround-50: Analogue Surround 5.0 Output (priority 700)
output:analog-surround-50+input:analog-stereo: Analogue Surround 5.0 Output
+ Analogue Stereo Input (priority 710)
output:analog-surround-51: Analogue Surround 5.1 Output (priority 3800)
output:analog-surround-51+input:analog-stereo: Analogue Surround 5.1 Output
+ Analogue Stereo Input (priority 3810)
input:analog-stereo: Analogue Stereo Input (priority 10)
off: Off (priority 0)
active profile: <output:analog-surround-51+input:analog-stereo>
sinks:
alsa_output.pci-0000_00_1b.0.analog-surround-51/#0: Built-in Audio Analogue
Surround 5.1
sources:
alsa_output.pci-0000_00_1b.0.analog-surround-51.monitor/#1: Monitor of
Built-in Audio Analogue Surround 5.1
alsa_input.pci-0000_00_1b.0.analog-stereo/#2: Built-in Audio Analogue Stereo
ports:
analog-output: Analogue Output (priority 9900, available: unknown)
properties:

analog-output-headphones: Headphones (priority 9000, available: unknown)
properties:

analog-input-microphone-front: Front Microphone (priority 8500, available:
no)
properties:

analog-input-microphone-rear: Rear Microphone (priority 8200, available:
yes)
properties:

analog-input-linein: Line In (priority 8100, available: yes)
properties:
