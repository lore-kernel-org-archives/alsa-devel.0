From: Tom van Leeuwen <thuis@tomvanleeuwen.nl>
Subject: No sound with Alsa
Date: Fri, 05 May 2006 19:21:47 +0200
Message-ID: <1146849707.11694.22.camel@tom.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo all,

I have a problem with my Alsa drivers, and I was told that this list
could help me.
I have an on-board C-Media sound chip and a Creative PCI sound card.
When I  use either of those cards to play a file with a program that
uses the Alsa output, it keeps repeating the first second. When I play a
file with OSS output, it jumps quickly through the file.
But sometimes it works flawless. I have no clue what causes the driver
to work or not. I tried rebooting vs cold boot etc. but I can't figure
out what causes the driver to work.
When I enable debugging in the kernel, it throws the following error:

Time: 01:02.04 [00:00.00] of 00:00.00 (  0.0%) Output Buffer:
2.75MALSA sound/core/pcm_lib.c:157: BUG: stream = 0, pos = 0xf7de,
buffer size = 0x4000, period size = 0x800

Running alsaconf doesn't make any difference.

When I enable the on-board sound chip and have the PCI card inserted,
the audio works fine, but it doesn't always use the same device. I can
choose the correct device with alssaconf, but when I reboot, it
sometimes uses the other device. I noticed that both cards have the same
IRQ.

I would like to use the on-board sound, and remove the PCI card.

Here is the output of lspci -v

0000:00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
        Subsystem: ASUSTeK Computer Inc. CMI8738 6ch-MX
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 201
        I/O ports at a800 [size=256]
        Capabilities: [c0] Power Management version 2

0000:00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Sound Blaster 16PCI 4.1ch
        Flags: bus master, slow devsel, latency 32, IRQ 201
        I/O ports at a400 [size=64]
        Capabilities: [dc] Power Management version 1



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
