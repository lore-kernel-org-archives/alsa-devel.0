From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: PCMCIA and snd-hdsp
Date: Wed, 28 Aug 2002 18:24:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020828162406.GB557@finnendahl.de>
References: <20020828055904.GA770@finnendahl.de> <200208281233.g7SCXO255193@icemserv.folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200208281233.g7SCXO255193@icemserv.folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Am Mittwoch, den 28. August 2002 um 08:30:21 Uhr (-0400) schrieb Paul Davis:
> 
> i don't have the working setup (with pcmcia), but i would obviously
> like to hear more about whatever has broken. do you still have the old
> kernel, and does it still work?

Yes and no. This is what happened:

I compiled a new debian kernel package with a 2.4.19 kernel. My
working kernel was 2.4.18-686 and in addition I had the original
2.4.18-bf2.4 (both available with debian). After I had compiled and
installed the kernel, it didn't work until I had deinstalled and
reinstalled the old 2.4.18-686 kernel and the appropriate pcmcia-cs
and pcmcia-modules. After that, I recompiled the whole ALSA.

Now the snd-hammerfall-mem install o.k. but snd-hdsp segfaults (and I
have to reboot in order to get rid of the module).

I found out that I got a new version of pcmcia-cs (3.2 instead of the
old potato version 3.1.22) and the syslog looks different in that
respect. I'll attach the syslog message with the relevant part. The
Aug 27 8:07 h one is the working one, the other one the failing one. I
even tried to reinstall the old potato pcmcia cardservices but that
seems to be broken with the upgrade of debian to woody. It seems to be
quite a mess and I try to get down to the problem. This is clear:

- pcmcia works fine with other cards with the new setup.

- my built-in soundcard (ali5451) works fine with the fresh compiled ALSA

When I try to get information about the snd-hdsp card (/proc/irq or io
settings), nothing is displayed although snd-hammerfall-mem finds the
inserted card.

I would like to know whether the problem is on the side of the
cardservices (e.g. by not providing the necessary irq and io
information for the hdsp driver) or how the whole mechanism works. I
couldn't find the relvant information anywhere.

--
Orm



here are the logs:

startup (multiface connected, but the snd-hdsp driver not yet loaded)

Aug 27 08:07:06 grisey kernel: Linux Kernel Card Services 3.1.22
Aug 27 08:07:06 grisey kernel:   options:  [pci] [cardbus] [pm]
Aug 27 08:07:07 grisey kernel: isapnp: Scanning for PnP cards...
Aug 27 08:07:07 grisey kernel: isapnp: No Plug & Play device found
Aug 27 08:07:07 grisey kernel: Intel PCIC probe: not found.
Aug 27 08:07:07 grisey kernel: PCI: Guessed IRQ 11 for device 00:13.0
Aug 27 08:07:07 grisey kernel: PCI: Sharing IRQ 11 with 00:13.1
Aug 27 08:07:07 grisey kernel: PCI: Guessed IRQ 11 for device 00:13.1
Aug 27 08:07:07 grisey kernel: PCI: Sharing IRQ 11 with 00:13.0
Aug 27 08:07:07 grisey kernel: Yenta IRQ list 0238, PCI irq11
Aug 27 08:07:07 grisey kernel: Socket status: 30000826
Aug 27 08:07:07 grisey kernel: Yenta IRQ list 0238, PCI irq11
Aug 27 08:07:07 grisey kernel: Socket status: 30000006
Aug 27 08:07:08 grisey kernel: cs: cb_alloc(bus 2): vendor 0x10ee, device 0x3fc5
Aug 27 08:07:08 grisey kernel: PCI: Enabling device 02:00.0 (0080 -> 0082)
Aug 27 08:07:08 grisey cardmgr[290]: error in file './hdsp.conf' line 2: syntax error
Aug 27 08:07:08 grisey cardmgr[290]: watching 2 sockets
Aug 27 08:07:08 grisey kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 27 08:07:08 grisey kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 27 08:07:08 grisey kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Aug 27 08:07:08 grisey kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 27 08:07:08 grisey cardmgr[291]: starting, version is 3.2.0
Aug 27 08:07:08 grisey cardmgr[291]: socket 0: CardBus hotplug device
Aug 27 08:07:09 grisey kernel: Hammerfall memory allocator: buffers allocated for 1 cards


loading of the driver:


Aug 27 14:53:18 grisey kernel: cs: cb_free(bus 2)
Aug 27 14:53:22 grisey kernel: cs: cb_alloc(bus 2): vendor 0x10ee, device 0x3fc5
Aug 27 14:53:22 grisey kernel: PCI: Enabling device 02:00.0 (0080 -> 0082)
Aug 27 14:53:22 grisey cardmgr[291]: socket 0: CardBus hotplug device
Aug 27 14:53:28 grisey kernel: PCI: Setting latency timer of device 02:00.0 to 64
Aug 27 14:53:28 grisey kernel: ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:453: wait for FIFO status <= 0 failed after 100 iterations
Aug 27 14:53:28 grisey kernel: looks like a multiface



This setup doesn't work:

Aug 28 18:16:37 grisey kernel: Linux PCMCIA Card Services 3.2.0
Aug 28 18:16:37 grisey kernel:   kernel build: 2.4.18-686 unknown
Aug 28 18:16:37 grisey kernel:   options:  [pci] [cardbus] [apm]
Aug 28 18:16:37 grisey kernel: Intel ISA/PCI/CardBus PCIC probe:
Aug 28 18:16:37 grisey kernel: PCI: Guessed IRQ 11 for device 00:13.0
Aug 28 18:16:37 grisey kernel: PCI: Sharing IRQ 11 with 00:13.1
Aug 28 18:16:37 grisey kernel: PCI: Guessed IRQ 11 for device 00:13.1
Aug 28 18:16:37 grisey kernel: PCI: Sharing IRQ 11 with 00:13.0
Aug 28 18:16:37 grisey kernel:   O2Micro OZ6933 rev 01 PCI-to-CardBus at slot 00:13, mem 0x10000000
Aug 28 18:16:37 grisey kernel:     host opts [0]: [pci/way] [pci irq 11] [lat 32/176] [bus 2/5]
Aug 28 18:16:37 grisey kernel:     host opts [1]: [pci/way] [pci irq 11] [lat 32/176] [bus 6/9]
Aug 28 18:16:37 grisey kernel:     ISA irqs (default) = 3,4,5,7,9,12 PCI status changes
Aug 28 18:16:38 grisey cardmgr[296]: watching 2 sockets
Aug 28 18:16:38 grisey cardmgr[297]: starting, version is 3.2.0
Aug 28 18:16:38 grisey kernel: cs: cb_alloc(bus 2): vendor 0x10ee, device 0x3fc5
Aug 28 18:16:38 grisey cardmgr[297]: unsupported card in socket 0
Aug 28 18:16:38 grisey cardmgr[297]:   product info: "Martin Kirst", "Hammerfall DSP", "CardBus Audio Card 1.00"
Aug 28 18:16:38 grisey cardmgr[297]:   PCI id: 0x10ee, 0x3fc5
Aug 28 18:16:38 grisey kernel: Hammerfall memory allocator: buffers allocated for 1 cards

Trying to modprobe snd-hdsp...

Aug 28 18:18:11 grisey kernel: PCI: No IRQ known for interrupt pin A of device . Please try using pci=biosirq.
Aug 28 18:18:11 grisey kernel: PCI: Setting latency timer of device  to 64
Aug 28 18:18:11 grisey kernel: ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:2967: unable to grab memory region 0x0-0x1447
Aug 28 18:18:11 grisey kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000040
Aug 28 18:18:11 grisey kernel:  printing eip:
Aug 28 18:18:11 grisey kernel: d0a2741b
Aug 28 18:18:11 grisey kernel: *pde = 00000000
Aug 28 18:18:11 grisey kernel: Oops: 0002
Aug 28 18:18:11 grisey kernel: CPU:    0
Aug 28 18:18:11 grisey kernel: EIP:    0010:[ide-mod:ide_devfs_handle_Reb53c0a2+1796923/253010458]    Not tainted
Aug 28 18:18:11 grisey kernel: EFLAGS: 00010246
Aug 28 18:18:11 grisey kernel: eax: 00000000   ebx: cba581a8   ecx: cba58140   edx: 00000000
Aug 28 18:18:11 grisey kernel: esi: fffffff0   edi: d0ae7480   ebp: cba581a8   esp: cba5debc
Aug 28 18:18:11 grisey kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 18:18:11 grisey kernel: Process modprobe (pid: 547, stackpage=cba5d000)
Aug 28 18:18:11 grisey kernel: Stack: cba58000 d0a2748c cba581a8 d0a05aa3 cba58000 cba58000 d0a27578 cba58000 
Aug 28 18:18:11 grisey kernel:        d0ae6f90 cf7aa41c d0ae7480 00000000 c017a12e cf7aa41c d0ae6f90 cf7aa41c 
Aug 28 18:18:11 grisey kernel:        d0ae7480 00000000 000c34ac c017a194 d0ae7480 cf7aa41c d0a24000 00000004 
Aug 28 18:18:11 grisey kernel: Call Trace: [ide-mod:ide_devfs_handle_Reb53c0a2+1797036/253010345] [ide-mod:ide_devfs_handle_Reb53c0a2+1659331/253148050] [ide-mod:ide_devfs_handle_Reb53c0a2+1797272/253010109] [ide-mod:ide_devfs_handle_Reb53c0a2+2582192/252225189] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] 
Aug 28 18:18:11 grisey kernel:    [pci_announce_device+54/84] [ide-mod:ide_devfs_handle_Reb53c0a2+2582192/252225189] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [pci_register_driver+72/96] [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [ide-mod:ide_devfs_handle_Reb53c0a2+1797340/253010041] 
Aug 28 18:18:11 grisey kernel:    [ide-mod:ide_devfs_handle_Reb53c0a2+2583456/252223925] [sys_init_module+1285/1448] [ide-mod:ide_devfs_handle_Reb53c0a2+1783680/253023701] [system_call+51/56] 
Aug 28 18:18:11 grisey kernel: 
Aug 28 18:18:11 grisey kernel: Code: 89 50 40 8b 83 c4 00 00 00 85 c0 7c 0a 53 50 e8 c5 0d 6e ef 








-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
