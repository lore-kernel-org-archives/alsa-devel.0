From: Alnie <alnieb@yahoo.com>
Subject: Issues w/ Creative Labs [SB X-Fi Xtreme Audio]
	CA0110-IBG
Date: Sun, 15 Feb 2015 13:33:55 -0800
Message-ID: <54E110C3.70509@yahoo.com>
References: <54E10F0C.7070802@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm24-vm5.bullet.mail.ne1.yahoo.com
 (nm24-vm5.bullet.mail.ne1.yahoo.com [98.138.91.246])
 by alsa0.perex.cz (Postfix) with ESMTP id E413A2605D1
 for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2015 22:33:58 +0100 (CET)
In-Reply-To: <54E10F0C.7070802@yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am having a problem getting this card working in Mint 17.1 (64bit). I
have found reports from others around the net claiming to have this card
working (around 2010/2011 mostly). I also tried xubuntu with the same
results. On a fresh distro when I install the card, it is recognized but
isn't associated with any driver, if I install the 3.16 kernel or the
alsa-daily repo it becomes associated with a driver but I get the
following errors from dmesg...

[    3.713183] snd_hda_intel 0000:06:00.0: Probing card using HDA DKMS, version 0.201502151246~ubuntu14.04.1
[    3.720010] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
[    4.744035] snd_hda_intel 0000:06:00.0: Codec #1 probe error; disabling it...
[    4.748009] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
[    9.772075] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
[    9.772100] snd_hda_intel 0000:06:00.0: no codecs initialized

and here is my lspci output...

05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge (prog-if 00 [Normal decode])
     Physical Slot: 3
     Flags: bus master, fast devsel, latency 0
     Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
     Memory behind bridge: f4300000-f43fffff
     Capabilities: [50] Power Management version 3
     Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
     Capabilities: [80] Subsystem: Creative Labs Device 0040
     Capabilities: [90] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
     Capabilities: [100] Advanced Error Reporting

06:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
     Subsystem: Creative Labs SB1040
     Flags: bus master, fast Back2Back, medium devsel, latency 32, IRQ 19
     Memory at f4300000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [dc] Power Management version 3
     Kernel driver in use: snd_hda_intel

thank you for any advice & feedback on this.
