From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: HDA Intel sound driver fails on Acer notebook
Date: Sun, 3 Dec 2006 02:30:34 -0500
Message-ID: <200612030233_MC3-1-D3BB-DE9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from liaag2aa.mx.compuserve.com (liaag2aa.mx.compuserve.com
	[149.174.40.154])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EFE6162
	for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2006 08:36:13 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The HDA Intel sound driver still fails to load on my Acer Aspire 5102
notebook (Turion64 X2, ATI chipset):

Here is the PCI info while running x86_64.  I tried i386 and x86_64 and it fails
on both:

00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
        Subsystem: Acer Incorporated [ALI] Unknown device 009f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
00: 02 10 7b 43 06 00 10 04 01 00 03 04 08 40 00 00
10: 04 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 9f 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 00 00 00
40: 00 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

On i386 I get this after doing
        insmod snd-hda-codec.ko ;  insmod snd-hda-intel.ko

Dec  1 17:38:29 ac kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 18
Dec  1 17:38:29 ac kernel: codec_mask = 0xb
Dec  1 17:38:30 ac kernel: hda_codec: PCI 1025:9f, codec config 5 is selected
Dec  1 17:38:31 ac kernel: hda_intel: azx_get_response timeout, switching to polling mode...
Dec  1 17:38:32 ac kernel: hda_intel: azx_get_response timeout, switching to single_cmd mode...
Dec  1 17:38:32 ac kernel: hda-intel: get_response timeout: IRS=0x0
Dec  1 17:38:36 ac last message repeated 24618 times
Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
Dec  1 17:38:36 ac kernel: hda-intel: get_response timeout: IRS=0x0
Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
Dec  1 17:38:36 ac kernel: hda_codec: invalid dep_range_val 0:7fff
Dec  1 17:38:36 ac kernel: hda-intel: get_response timeout: IRS=0x0

The last three lines repeat many thousands of times, followed by:

Dec  1 17:38:39 ac kernel: hda_generic: no proper input path found
Dec  1 17:38:39 ac kernel: hda_generic: no proper output path found
Dec  1 17:38:39 ac kernel: hda_generic: no PCM found

Looking at /proc/interrupts, I see exactly 110 interrupts were processed
by the driver while all this was happening:

 18:          0        110   IO-APIC-fasteoi   HDA Intel

On x86_64 I forgot to enable verbose messages, so there's less information
but it fails the same way.

-- 
Chuck
"Even supernovas have their duller moments."

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
