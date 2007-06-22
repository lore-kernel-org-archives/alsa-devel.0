From: Nathan Allen Stratton <nathan@robotics.net>
Subject: Osprey 440 almost supported!!! Need X9221 i2c support!
Date: Thu, 21 Jun 2007 22:41:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706212241460.15772@barney.robotics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barney.robotics.net (cyber.robotics.net [209.150.98.82])
	by alsa0.perex.cz (Postfix) with ESMTP id AB58C244BD
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 04:41:54 +0200 (CEST)
Received: from barney.robotics.net (barney.robotics.net [209.150.98.82])
	by barney.robotics.net (8.12.10/8.12.10) with ESMTP id l5M2fvFX015811
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 22:41:57 -0400
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


This card does not use analog bt878a inputs, but rather the digital input.
To get audio working I set the mask to 000303, first two bits are for the
audio rate, 00 is 32000, 01 is 41000, 10 is 4800. The first two bits in
the next byte are for balanced or unbalanced audio input. 0x00 for
unbalanced and 0x100 for balanced. So I am using:

modprobe bttv card=140 bttv_gpio=1 bttv_verbose=2 bttv_debug=1 gpiomask=0x020303 audioall=0xFFFDFC

bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:08:04.0, irq: 24, latency: 132, mmio: 0xc8600000
bttv0: detected: Osprey-440 [card=140], PCI subsystem ID is 0070:ff07
bttv0: using: Osprey 440 [card=140,insmod option]
bttv0: gpio config override: mask=0x20303, mux=0xfffdfc,0xfffdfc,0xfffdfc,0xfffdfc
bttv0: gpio: en=00000000, out=00000000 in=00feffff [pre-init]
bttv0: risc main @ 37f25000
bttv0: gpio: en=00000000, out=00000000 in=00feffff [init]
bttv0: BT878A ARESET
bttv0: tveeprom i2c attach [addr=0x50,client=tveeprom]
bttv0: using tuner=-1
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: gpio: en=00020303, out=00000000 in=00fcfcfc [audio: mute]
bttv0: video mux: input=0 mux=2
bttv0: gpio: en=00020303, out=00000000 in=00fcfcfc [audio: mute]
bttv0: PLL: 28636363 => 35468950 .<7>bttv0: gpio: en=00020303, out=00000000 in=00fcfcfc [audio: mute]
 ok

So the issue now is that the audio is WAY to high so it is very distorted.
The audio is controlled via X9221A chips on the i2c bus at 0x50, there are
not drivers for X9221 so I can't lower the audio levels. Anyone able to
help me with this last part???


><>
Nathan Stratton                         CTO, Voila IP Communications
nathan at robotics.net                  nathan at voilaip.com
http://www.robotics.net                 http://www.voilaip.com
