From: Voluspa <lista1@telia.com>
Subject: Re: via82xx dxs_support=5 OK
Date: Fri, 29 Jul 2005 14:21:56 +0200
Message-ID: <20050729142156.289887cc.lista1@telia.com>
References: <20050729070401.525b58fd.lista1@telia.com>
	<s5hy87pc0r3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pne-smtpout1-sn2.hy.skanova.net (pne-smtpout1-sn2.hy.skanova.net [81.228.8.83])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F186218E
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 14:21:59 +0200 (MEST)
In-Reply-To: <s5hy87pc0r3.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Jul 2005 13:25:36 +0200 Takashi Iwai wrote:
> Thanks for the report.  What is your hardware (mobo or product name)?
> It's necessary as a comment of the table entry.

Yes, it surprised me that no mention of that was made in the plea,
but I settled on you having a big-arse lookup table somewhere.

According to /proc/pci (and this info can't be had from lspci) It looks
to be VIA K8M800 (northbridge K8M800 + southbridge VT8237 PCI bridge [K8T800 South]).
The notebook is an Acer Aspire 1524 WMLi (the european?/swedish? version of 1520).

I'll give you the whole /proc/pci below. As for the tests you ask us to
perform, it would be better if you provided a link to some prepared
soundfiles on your site, with instructions on how to play them. There could
be people too unsure of the proper method to even begin, never mind
sending you the results. Just a thought.

root:sleipner:~# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1106:0204 (VIA Technologies, Inc.) (rev 0).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   0, function  1:
    Host bridge: PCI device 1106:1204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  2:
    Host bridge: PCI device 1106:2204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  3:
    Host bridge: VIA Technologies, Inc. K8M800 (rev 0).
  Bus  0, device   0, function  4:
    Host bridge: PCI device 1106:4204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  7:
    Host bridge: VIA Technologies, Inc. K8M800 (rev 0).
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device  10, function  0:
    Ethernet controller: Linksys, A Division of Cisco Systems [AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01) (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=32.
      I/O at 0x1c00 [0x1c1f].
      Non-prefetchable 32 bit memory at 0xc0006000 [0xc000601f].
      Non-prefetchable 32 bit memory at 0xc0005000 [0xc00057ff].
  Bus  0, device  11, function  0:
    CardBus bridge: Texas Instruments PCI7420 CardBus Controller (rev 0).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x28020000 [0x28020fff].
  Bus  0, device  11, function  1:
    CardBus bridge: Texas Instruments PCI7420 CardBus Controller (#2) (rev 0).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x28021000 [0x28021fff].
  Bus  0, device  11, function  2:
    FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xc0005800 [0xc0005fff].
      Non-prefetchable 32 bit memory at 0xc0000000 [0xc0003fff].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 16).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0xc0006400 [0xc00064ff].
  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c20 [0x1c3f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2) (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c40 [0x1c5f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3) (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c60 [0x1c7f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 18.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xc0006800 [0xc00068ff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0x1c80 [0x1c8f].
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 80).
      IRQ 19.
      I/O at 0x1400 [0x14ff].
  Bus  0, device  17, function  6:
    Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 128).
      IRQ 11.
      I/O at 0x1800 [0x18ff].
  Bus  0, device  24, function  0:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration (rev 0).
  Bus  0, device  24, function  1:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map (rev 0).
  Bus  0, device  24, function  2:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller (rev 0).
  Bus  0, device  24, function  3:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control (rev 0).
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV36 [GeForce FX Go5700] (rev 161).
      IRQ 20.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xc1000000 [0xc1ffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].

Mvh
Mats Johannesson
--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
