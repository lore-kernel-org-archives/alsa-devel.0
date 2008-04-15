From: "John R." <johnr@wowway.com>
Subject: Another unknown bt878
Date: Mon, 14 Apr 2008 23:17:47 -0500
Message-ID: <48042C6B.9090306@wowway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pop-7.dnv.wideopenwest.com (pop-7.dnv.wideopenwest.com
	[64.233.207.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9CC9624677
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 06:16:03 +0200 (CEST)
Received: from sordid.slotcar.chicago.il.us
	(d53-64-153-162.nap.wideopenwest.com [64.53.162.153])
	by pop-7.dnv.wideopenwest.com (8.12.8/8.12.8) with ESMTP id
	m3F4G1Jr008739
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 23:16:01 -0500
Received: from aqui.slotcar.prv ([172.16.1.3])
	by sordid.slotcar.chicago.il.us with esmtp (Exim 4.67)
	(envelope-from <johnr@wowway.com>) id 1JlcaP-00007r-Sc
	for alsa-devel@alsa-project.org; Mon, 14 Apr 2008 23:16:01 -0500
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

Sound doesn't work on my bt878 based card.  Let me know what other 
information is needed...

kernel 2.6.24.2:

Apr 14 20:28:38 server kernel: unknown card 0x878-0xaa00:0x1460
Apr 14 20:28:38 server kernel: please mail id, board name, and, if it 
works, the correct digital_rate option to <alsa-devel@alsa-project.org>
Apr 14 20:28:38 server kernel: ACPI: PCI Interrupt 0000:05:00.1[A] -> 
GSI 18 (level, low) -> IRQ 18
Apr 14 20:28:38 server kernel: bt87x0: Using board 0, analog, digital 
(rate 32000 Hz)
Apr 14 20:28:38 server kernel: unknown card 0x878-0xaa01:0x1461
Apr 14 20:28:38 server kernel: please mail id, board name, and, if it 
works, the correct digital_rate option to <alsa-devel@alsa-project.org>
Apr 14 20:28:38 server kernel: ACPI: PCI Interrupt 0000:05:01.1[A] -> 
GSI 19 (level, low) -> IRQ 19
Apr 14 20:28:38 server kernel: bt87x1: Using board 0, analog, digital 
(rate 32000 Hz)
Apr 14 20:28:38 server kernel: unknown card 0x878-0xaa02:0x1462
Apr 14 20:28:38 server kernel: please mail id, board name, and, if it 
works, the correct digital_rate option to <alsa-devel@alsa-project.org>
Apr 14 20:28:38 server kernel: ACPI: PCI Interrupt 0000:05:02.1[A] -> 
GSI 16 (level, low) -> IRQ 16
Apr 14 20:28:38 server kernel: bt87x2: Using board 0, analog, digital 
(rate 3200
0 Hz)
Apr 14 20:28:38 server kernel: unknown card 0x878-0xaa03:0x1463
Apr 14 20:28:38 server kernel: please mail id, board name, and, if it 
works, the correct digital_rate option to <alsa-devel@alsa-project.org>
Apr 14 20:28:38 server kernel: ACPI: PCI Interrupt 0000:05:03.1[A] -> 
GSI 17 (level, low) -> IRQ 17
Apr 14 20:28:38 server kernel: bt87x3: Using board 0, analog, digital 
(rate 32000 Hz)

lspci:

05:00.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
05:00.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
05:01.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
05:01.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
05:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
05:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
05:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
05:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)

at boot:

bttv: driver version 0.9.17 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:05:00.0, irq: 18, latency: 64, mmio: 
0xdfcfe000
bttv0: detected: Provideo PV150A-1 [card=98], PCI subsystem ID is aa00:1460
bttv0: using: ProVideo PV150 [card=98,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: tuner absent
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv: Bt8xx card found (1).
ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 19 (level, low) -> IRQ 19
bttv1: Bt878 (rev 17) at 0000:05:01.0, irq: 19, latency: 64, mmio: 
0xdfcfc000
bttv1: detected: Provideo PV150A-2 [card=98], PCI subsystem ID is aa01:1461
bttv1: using: ProVideo PV150 [card=98,autodetected]
bttv1: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv1: tuner absent
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv: Bt8xx card found (2).
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv2: Bt878 (rev 17) at 0000:05:02.0, irq: 16, latency: 64, mmio: 
0xdfcfa000
bttv2: detected: Provideo PV150A-3 [card=98], PCI subsystem ID is aa02:1462
bttv2: using: ProVideo PV150 [card=98,autodetected]
bttv2: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv2: tuner absent
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .. ok
bttv: Bt8xx card found (3).
ACPI: PCI Interrupt 0000:05:03.0[A] -> GSI 17 (level, low) -> IRQ 17
bttv3: Bt878 (rev 17) at 0000:05:03.0, irq: 17, latency: 64, mmio: 
0xdfcf8000
bttv3: detected: Provideo PV150A-4 [card=98], PCI subsystem ID is aa03:1463
bttv3: using: ProVideo PV150 [card=98,autodetected]
bttv3: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv3: tuner absent
bttv3: registered device video3
bttv3: registered device vbi3
bttv3: PLL: 28636363 => 35468950 .. ok
