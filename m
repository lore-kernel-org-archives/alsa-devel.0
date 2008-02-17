From: Richard Lyons <richard@the-place.net>
Subject: unable to get alsa configured on Acer Aspire 1640Z
Date: Sun, 17 Feb 2008 18:18:41 +0100
Message-ID: <20080217171832.GI7750@mulinocarletti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bigben2.bytemark.co.uk (bigben2.bytemark.co.uk [80.68.81.132])
	by alsa0.perex.cz (Postfix) with ESMTP id BF32110383D
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2008 18:18:36 +0100 (CET)
Received: from the-place.net ([80.68.92.104] helo=localhost)
	by bigben2.bytemark.co.uk with esmtp (Exim 4.63)
	(envelope-from <richard@the-place.net>) id 1JQn9q-0001Ta-8n
	for alsa-devel@alsa-project.org; Sun, 17 Feb 2008 17:18:32 +0000
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

I hope this is the right place to report this.

Computer: laptop Acer Aspire 1640Z

distro: Debian etch
kernel: 2.6.17

lspci
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

lspci -nv
00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1025:009e
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

I've tried model=acer and acer-aspire to no avail.

I notice in dmesg after trying 'modprobe snd-hda-intel model=acer'
this:
    hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...

but alsamixer shows:
    Card: HDA Intel
    Chip: Realtek ALC883
at the top.

There seems to be uncertainty about which model number, 882 or 883.
I wonder if this is the source of the difficulty.

HTH

-- 
richard Lyons
