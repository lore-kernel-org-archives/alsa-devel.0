From: Daniel Blueman <daniel.blueman@gmx.net>
Subject: [2.6.0-test4] [BUG, ALSA] no 44.1KHz sound for i8x0 ICH2...
Date: Mon, 8 Sep 2003 11:33:58 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <31962.1063013638@www28.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I can't get any sound output with an Intel 815 chipset at 44.1KHz. ALSA
reports the sound chipset can clock to 41KHz.

What information do I need to post here?

Please CC me on any replies.

--- [ lspci -v ]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audi=
o
(rev 11)
        Subsystem: Dell Computer Corporation: Unknown device 00be
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at c800 [size=3D256]
        I/O ports at cc40 [size=3D64]

--- [ dmesg ]

Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:2=
7:13
2003 UTC).
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
intel8x0: clocking to 41151          <----- should be 44100?
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0xc800, irq 10

--=20
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualit=E4tssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e=
-Post
