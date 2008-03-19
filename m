From: "Gerard Neil" <xyzzy@devferret.org>
Subject: Kernel Oops unloading snd_ymfpci, 2.6.24
Date: Wed, 19 Mar 2008 15:57:56 +1100
Message-ID: <6b22a6b40803182157p59cb89bai208a96e76b201069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by alsa0.perex.cz (Postfix) with ESMTP id EECA7243F3
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 05:57:59 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so317800wxc.23
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 21:57:58 -0700 (PDT)
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

I'm just upgraded to kernel 2.6.24 and I'm seeing a kernel OOPS every
time I unload the snd_ymfpci module...

Below is what I see in my log. My naive interpretation of this is that
the system is barfing in the interrupt handler at the time it is
trying to free the interrupt.... so maybe the interrupt hasn't been
disabled properly before the free_irq() call? As I say, it's a naive
interpretation.

Anyway, I'd appreciate it if somebody could look this over and tell me
what my next step should be. I'm available to debug if necessary.

Thanks,

Gerard

Mar 18 00:16:58 {kern,info}	ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI
18 (level, low) -> IRQ 16
Mar 18 00:17:00 {kern,err}	codec_ready: codec 0 is not ready [0x802a]
Mar 18 00:17:00 {kern,alert}	BUG: unable to handle kernel paging
request at virtual address f8e10100
Mar 18 00:17:00 {kern,alert}	printing eip: f8e2b430 *pde = 37770067
*pte = 00000000
Mar 18 00:17:00 {kern,emerg}	Oops: 0000 [#1] SMP
Mar 18 00:17:00 {kern,warning}	Modules linked in: snd_ymfpci snd_seq
snd_ac97_codec snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc
snd_mpu401_uart snd_rawmidi snd_seq_device snd w83627hf hwmon_vid
hwmon eeprom nfsd lockd nfs_acl sunrpc exportfs af_packet loop usbhid
floppy ac97_bus soundcore ohci_hcd via_agp agpgart ehci_hcd skge
uhci_hcd i2c_viapro i2c_core e100
Mar 18 00:17:00 {kern,warning}	
Mar 18 00:17:00 {kern,warning}	Pid: 8543, comm: rmmod Not tainted
(2.6.24-gentoo-r3 #1)
Mar 18 00:17:00 {kern,warning}	EIP: 0060:[<f8e2b430>] EFLAGS: 00210092 CPU: 1
Mar 18 00:17:00 {kern,warning}	EIP is at
snd_ymfpci_interrupt+0x10/0x1e0 [snd_ymfpci]
Mar 18 00:17:00 {kern,warning}	EAX: 00000010 EBX: f77f0200 ECX:
e5a36980 EDX: f8e10000
Mar 18 00:17:00 {kern,warning}	ESI: 00000010 EDI: dd74f000 EBP:
c041e1d0 ESP: dd7a7e4c
Mar 18 00:17:00 {kern,warning}	DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Mar 18 00:17:00 {kern,emerg}	Process rmmod (pid: 8543, ti=dd7a6000
task=e5a8aa60 task.ti=dd7a6000)
Mar 18 00:17:00 {kern,emerg}	Stack: f7c82960 00200286 000007b0
00000010 00000003 00200246 f77f0200 00000010
Mar 18 00:17:00 {kern,emerg}	00200282 c041e1d0 c01415b2 dd7b8000
1d7b8000 f7c57c4c e9e2a000 dd74f000
Mar 18 00:17:00 {kern,emerg}	00200216 dd74f000 e9e2a140 00002fff
e9e2a000 f8e28d4f 00001fff f77f0d40
Mar 18 00:17:00 {kern,emerg}	Call Trace:
Mar 18 00:17:00 {kern,emerg}	[<c01415b2>] free_irq+0x102/0x160
Mar 18 00:17:00 {kern,emerg}	[<f8e28d4f>] snd_ymfpci_free+0x10f/0x150
[snd_ymfpci]
Mar 18 00:17:00 {kern,emerg}	[<f88bd6f3>] snd_device_free+0x63/0xb0 [snd]
Mar 18 00:17:00 {kern,emerg}	[<f88bd798>] snd_device_free_all+0x58/0x60 [snd]
Mar 18 00:17:00 {kern,emerg}	[<f88b96cd>] snd_card_do_free+0x2d/0xe0 [snd]
Mar 18 00:17:00 {kern,emerg}	[<f88ba361>] snd_card_free+0x91/0xa0 [snd]
Mar 18 00:17:00 {kern,emerg}	[<c022318b>] kref_put+0x2b/0x80
Mar 18 00:17:00 {kern,emerg}	[<c03417cc>] wait_for_common+0x1c/0x140
Mar 18 00:17:00 {kern,emerg}	[<f8e2801e>]
snd_card_ymfpci_remove+0xe/0x20 [snd_ymfpci]
Mar 18 00:17:00 {kern,emerg}	[<c02309f6>] pci_device_remove+0x16/0x40
Mar 18 00:17:00 {kern,emerg}	[<c027c6d4>] __device_release_driver+0x64/0xa0
Mar 18 00:17:00 {kern,emerg}	[<c027cc21>] driver_detach+0xc1/0xd0
Mar 18 00:17:00 {kern,emerg}	[<c027c235>] bus_remove_driver+0x75/0xa0
Mar 18 00:17:00 {kern,emerg}	[<c0230ace>] pci_unregister_driver+0xe/0x70
Mar 18 00:17:00 {kern,emerg}	[<c013f27a>] sys_delete_module+0x11a/0x1c0
Mar 18 00:17:00 {kern,emerg}	[<c0114297>] do_page_fault+0xe7/0x620
Mar 18 00:17:00 {kern,emerg}	[<c01553b7>] do_munmap+0x197/0x1f0
Mar 18 00:17:00 {kern,emerg}	[<c0102b8e>] sysenter_past_esp+0x5f/0x85
Mar 18 00:17:00 {kern,emerg}	[<c0340000>] unix_bind+0x170/0x2b0
Mar 18 00:17:00 {kern,emerg}	=======================
Mar 18 00:17:00 {kern,emerg}	Code: a8 c8 00 00 00 8b 47 10 8b 14 24 89
90 c0 00 00 00 8b 43 2c e9 40 ff ff ff 66 90 55 57 89 d7 56 53 83 ec
18 89 44 24 0c 8b 52 10 <8b> 82 00 01 00 00 85 c0 78 50 0f b7 42 04 0f
b7 d8 f6 c3 01 74
Mar 18 00:17:00 {kern,emerg}	EIP: [<f8e2b430>]
snd_ymfpci_interrupt+0x10/0x1e0 [snd_ymfpci] SS:ESP 0068:dd7a7e4c
Mar 18 00:17:00 {kern,warning}	---[ end trace 8697168af0baea4f ]---
