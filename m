From: "Christophe Osuna" <christophe.osuna@gmail.com>
Subject: Problems with ALC882
Date: Wed, 16 Jan 2008 18:20:20 +0100
Message-ID: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 260B5244F5
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 18:20:23 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so529923wag.8
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 09:20:21 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am having a bad time trying to get an ALC882 [1] to work. I hope
that you can help me. Currently I am using alsa-driver-1.0.14 but it
would probably be the same with 1.0.15 since there has been no change
in /pci/hda/.

The ALC882 has got three ADC, and for every one of them it is possible
to select one input source. amixer shows my current settings:

  ~# amixer get 'Input Source',0
  Simple mixer control 'Input Source',0
    Capabilities: enum
    Items: 'Mic' 'Front Mic' 'Line' 'CD'
    Item0: 'Mic'
  ~# amixer get 'Input Source',1
  Simple mixer control 'Input Source',1
    Capabilities: enum
    Items: 'Mic' 'Front Mic' 'Line' 'CD'
    Item0: 'Front Mic'
  ~# amixer get 'Input Source',2
  Simple mixer control 'Input Source',2
    Capabilities: enum
    Items: 'Mic' 'Front Mic' 'Line' 'CD'
    Item0: 'Line'

Put more simply:

  Mic -> Input 0 (1st ADC)
  Front Mic -> Input 1 (2nd ADC)
  Line In -> Input 2 (3rd ADC)

A grep in the proc filesystem shows that there are three ADC and one
digital input.

  ~# cat /proc/asound/card0/codec\#2 | grep Input
  Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital

So far, so good. But then I try to use the PCM system and things start
to go worse.

  ~# cat /proc/asound/pcm
  00-02: ALC882 Analog : ALC882 Analog : capture 2
  00-01: ALC882 Digital : ALC882 Digital : playback 1 : capture 1
  00-00: ALC882 Analog : ALC882 Analog : playback 1 : capture 2

If my ALSA understanding is right, that means I have two analog input
devices (hw:0,0 and hw:0,2). One is missing!

If I ask arecord to list the capture devices, it shows the following:

  ~# ./arecord -l
  **** List of CAPTURE Hardware Devices ****
  card 0: Intel [HDA Intel], device 0: ALC882 Analog [ALC882 Analog]
    Subdevices: 2/2
    Subdevice #0: subdevice #0
    Subdevice #1: subdevice #1
  card 0: Intel [HDA Intel], device 1: ALC882 Digital [ALC882 Digital]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
  card 0: Intel [HDA Intel], device 2: ALC882 Analog [ALC882 Analog]
    Subdevices: 2/2
    Subdevice #0: subdevice #0
    Subdevice #1: subdevice #1

I have tried to pipe arecord into aplay several times:

  1) arecord -f dat -D hw:0,0,0 | aplay -f dat -D hw:0,0,0
  2) arecord -f dat -D hw:0,0,1 | aplay -f dat -D hw:0,0,0
  3) arecord -f dat -D hw:0,1,0 | aplay -f dat -D hw:0,0,0 (fails)
  4) arecord -f dat -D hw:0,2,0 | aplay -f dat -D hw:0,0,0
  5) arecord -f dat -D hw:0,2,1 | aplay -f dat -D hw:0,0,0
  6) arecord -f dat -D hw:0,0,0 > /dev/null (fails)
      and arecord -f dat -D hw:0,2,0 > /dev/null (fails)

and it shows that:

  1) hw:0,0,0 maps to 1st ADC: OK
  2) hw:0,0,1 maps to 2nd ADC: OK
  3) fails probably because digital input is not activated
  4) hw:0,2,0 maps to 1st ADC (same as hw:0,0,0)
  5) hw:0,2,1 maps to 2nd ADC (same as hw:0,0,1)
  6) when I start the second arecord the first stops (I/O error) and
then the second one stops (error), probably because they are working
on the same ADC.

So it appears that while the "control" ALSA layer detects the 3 ADC
the "PCM" layer does not. Do you have any idea of what could be wrong?

Besides that I have another smaller problem. According to the ALC882
documentation, the codec can handle 8 kHz signals (by sending setting
only one packet on every six packets  of the HDA bus which operates at
48 kHz). However the driver will not let me use that sample rate.
Example from /proc:

  Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
    Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
    Amp-In vals:  [0x14 0x14]
    PCM:
      rates [0x160]: 44100 48000 96000
      bits [0x6]: 16 20
      formats [0x1]: PCM
    Connection: 1
       0x24

Is this a limit of the HDA implementation?

Thanks for your help.

[1] http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PFid=28&Level=5&Conn=4&ProdID=43
