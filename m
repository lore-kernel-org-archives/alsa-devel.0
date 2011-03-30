From: Svante Signell <srs@kth.se>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Wed, 30 Mar 2011 12:25:44 +0200
Message-ID: <1301480744.21366.110.camel@hp.my.own.domain>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
	<1301396296.32453.1.camel@s1499.it.kth.se>
	<s5h7hbi41xs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pH5JywAdetmQX+q1U27V"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-1.sys.kth.se (smtp-1.sys.kth.se [130.237.32.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E91C24386
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 12:25:56 +0200 (CEST)
In-Reply-To: <s5h7hbi41xs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 619034@bugs.debian.org, alsa-devel@alsa-project.org, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--=-pH5JywAdetmQX+q1U27V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-03-29 at 13:10 +0200, Takashi Iwai wrote:
> At Tue, 29 Mar 2011 12:58:16 +0200,
> Svante Signell wrote:
> > 
> > On Tue, 2011-03-29 at 12:31 +0200, Takashi Iwai wrote:
> > > At Tue, 29 Mar 2011 12:24:40 +0200,
> > > Svante Signell wrote:
...
> > > But let's check the Oops first as below.
> 
> > > Also, please try to decode the line from the code shown in the Oops.
> > > It's a bit too little information to analyze, unfortunately.
...
> As mentioned, you can decode the binary dump in Oops to guess which
> line of the source code corresponds to the Oops point.
> Use gdb or objdump to figure out the disassembled code.
> For example,
> 
> 	% objdump -D -l /lib/modules/$(uname -r)/kernel/sound/pci/hda/snd-hda-intel.ko
> 
> Then look for azx_probe.  Calculate the position from the offset
> Oops gave, compare the hex codes with the data show in "Code" section
> of Oops.
> objdump with -l will show the source code line as well, so you'll see
> now more exactly where it was triggered.

Below is the kernel Oops and the objdump output related to azx_probe.
Unfortunately I don't know where to find the Oops offset!

Kernel Oops when booting:
=========================
[    4.631033] Oops: 0009 [#1] SMP 
[    4.631187] last sysfs file: /sys/devices/virtual/net/lo/operstate
[    4.631243] CPU 0 
[    4.631293] Modules linked in: snd_hda_intel(+) snd_hda_codec tpm_tis
tpm pcspkr snd_hwdep tpm_bios shpchp(+) pci_hotplug k8temp nouveau(+)
snd_pcm ttm drm_kms_helper drm parport_pc i2c_viapro i2c_algo_bit usblp
power_supply i2c_core parport edac_core video edac_mce_amd processor
psmouse evdev serio_raw button snd_seq snd_timer snd_seq_device snd
soundcore snd_page_alloc thermal_sys ext3 jbd mbcache sg sr_mod cdrom
usbhid sd_mod crc_t10dif ata_generic hid sata_via uhci_hcd pata_via
libata ehci_hcd usbcore scsi_mod via_rhine floppy mii nls_base [last
unloaded: scsi_wait_scan]
[    4.632005] 
[    4.632005] Pid: 632, comm: work_for_cpu Not tainted 2.6.38-1-amd64
#1 MICRO-STAR INTERNATIONAL CO., LTD MS-7253/MS-7253
[    4.632005] RIP: 0010:[<ffffffffa061f416>]  [<ffffffffa061f416>]
azx_probe+0x3ad/0x870 [snd_hda_intel]
[    4.632005] RSP: 0018:ffff88007c05be50  EFLAGS: 00010286
[    4.632005] RAX: ffffc90013c98000 RBX: ffff880036de6000 RCX:
0000000000000006
[    4.632005] RDX: 0000000000000000 RSI: 0000000000000246 RDI:
0000000000000246
[    4.632005] RBP: ffff88007c93d000 R08: 0000000000000000 R09:
0000000000000040
[    4.632005] R10: 0000000000000286 R11: 000000000000a971 R12:
ffff880036de5c00
[    4.632005] R13: 0000000000000000 R14: 0000000000000000 R15:
ffff88007c93d090
[    4.632005] FS:  00007f1cd2afb7a0(0000) GS:ffff88007fc00000(0000)
knlGS:0000000000000000
[    4.632005] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    4.632005] CR2: ffffc90013c98000 CR3: 000000007c00f000 CR4:
00000000000006f0
[    4.632005] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    4.632005] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400
[    4.632005] Process work_for_cpu (pid: 632, threadinfo
ffff88007c05a000, task ffff88003713a880)
[    4.632005] Stack:
[    4.632005]  0000000000000005 ffffffff81240724 0000000000000001
ffff880036de5c00
[    4.632005]  0000000000013700 ffff88007c93d000 ffff88007c93d090
ffff88007a7c7dc8
[    4.632005]  ffff88007c93d200 0000000000000000 0000000000000000
ffffffff811b1a42
[    4.632005] Call Trace:
[    4.632005]  [<ffffffff81240724>] ? __pm_runtime_set_status
+0x162/0x186
[    4.632005]  [<ffffffff811b1a42>] ? local_pci_probe+0x49/0x92
[    4.632005]  [<ffffffff8105aad2>] ? do_work_for_cpu+0x0/0x1b
[    4.632005]  [<ffffffff8105aad2>] ? do_work_for_cpu+0x0/0x1b
[    4.632005]  [<ffffffff8105aadd>] ? do_work_for_cpu+0xb/0x1b
[    4.632005]  [<ffffffff8105fcdf>] ? kthread+0x7a/0x82
[    4.632005]  [<ffffffff8100a764>] ? kernel_thread_helper+0x4/0x10
[    4.632005]  [<ffffffff8105fc65>] ? kthread+0x0/0x82
[    4.632005]  [<ffffffff8100a760>] ? kernel_thread_helper+0x0/0x10
[    4.632005] Code: f4 01 00 00 ef 31 f6 48 89 df e8 15 dd ff ff 85 c0
0f 88 2b 03 00 00 48 89 ef e8 ee 11 b9 e0 8b 7b 40 e8 9f 25 a7 e0 48 8b
43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be 
[    4.632005] RIP  [<ffffffffa061f416>] azx_probe+0x3ad/0x870
[snd_hda_intel]
[    4.632005]  RSP <ffff88007c05be50>
[    4.632005] CR2: ffffc90013c98000
[    4.632005] ---[ end trace c6748815fe9ff43b ]---

objdump -D -l /lib/modules/$(uname
-r)/kernel/sound/pci/hda/snd-hda-intel.ko

/lib/modules/2.6.38-1-amd64/kernel/sound/pci/hda/snd-hda-intel.ko:
file format elf64-x86-64

00000000000001fd <azx_probe>:
azx_probe():

(see attachment)


--=-pH5JywAdetmQX+q1U27V
Content-Disposition: attachment; filename="objdump_axz_probe.out"
Content-Type: text/plain; name="objdump_axz_probe.out"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


/lib/modules/2.6.38-1-amd64/kernel/sound/pci/hda/snd-hda-intel.ko:     file format elf64-x86-64


00000000000001fd <azx_probe>:
azx_probe():
 1fd:	41 57                	push   %r15
 1ff:	41 56                	push   %r14
 201:	41 be ed ff ff ff    	mov    $0xffffffed,%r14d
 207:	41 55                	push   %r13
 209:	41 54                	push   %r12
 20b:	55                   	push   %rbp
 20c:	48 89 fd             	mov    %rdi,%rbp
 20f:	53                   	push   %rbx
 210:	48 89 f3             	mov    %rsi,%rbx
 213:	48 83 ec 28          	sub    $0x28,%rsp
 217:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 21d <azx_probe+0x20>
 21d:	83 fa 1f             	cmp    $0x1f,%edx
 220:	0f 8f 35 08 00 00    	jg     a5b <azx_probe+0x85e>
 226:	48 63 c2             	movslq %edx,%rax
 229:	83 3c 85 00 00 00 00 	cmpl   $0x0,0x0(,%rax,4)
 230:	00 
 231:	75 13                	jne    246 <azx_probe+0x49>
 233:	ff c2                	inc    %edx
 235:	41 be fe ff ff ff    	mov    $0xfffffffe,%r14d
 23b:	89 15 00 00 00 00    	mov    %edx,0x0(%rip)        # 241 <azx_probe+0x44>
 241:	e9 15 08 00 00       	jmpq   a5b <azx_probe+0x85e>
 246:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 24d:	00 
 24e:	8b 3c 85 00 00 00 00 	mov    0x0(,%rax,4),%edi
 255:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
 25a:	31 c9                	xor    %ecx,%ecx
 25c:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 263:	e8 00 00 00 00       	callq  268 <azx_probe+0x6b>
 268:	85 c0                	test   %eax,%eax
 26a:	41 89 c6             	mov    %eax,%r14d
 26d:	79 13                	jns    282 <azx_probe+0x85>
 26f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 276:	31 c0                	xor    %eax,%eax
 278:	e8 00 00 00 00       	callq  27d <azx_probe+0x80>
 27d:	e9 d9 07 00 00       	jmpq   a5b <azx_probe+0x85e>
 282:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 287:	4c 8d bd 90 00 00 00 	lea    0x90(%rbp),%r15
 28e:	48 89 ef             	mov    %rbp,%rdi
 291:	4c 89 b8 40 02 00 00 	mov    %r15,0x240(%rax)
 298:	48 8b 5b 18          	mov    0x18(%rbx),%rbx
 29c:	44 8b 2d 00 00 00 00 	mov    0x0(%rip),%r13d        # 2a3 <azx_probe+0xa6>
 2a3:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
 2a8:	48 89 1c 24          	mov    %rbx,(%rsp)
 2ac:	e8 00 00 00 00       	callq  2b1 <azx_probe+0xb4>
 2b1:	85 c0                	test   %eax,%eax
 2b3:	41 89 c6             	mov    %eax,%r14d
 2b6:	0f 88 95 07 00 00    	js     a51 <azx_probe+0x854>
 2bc:	bf 50 02 00 00       	mov    $0x250,%edi
 2c1:	e8 00 00 00 00       	callq  2c6 <azx_probe+0xc9>
 2c6:	48 85 c0             	test   %rax,%rax
 2c9:	48 89 c3             	mov    %rax,%rbx
 2cc:	75 21                	jne    2ef <azx_probe+0xf2>
 2ce:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 2d5:	31 c0                	xor    %eax,%eax
 2d7:	41 be f4 ff ff ff    	mov    $0xfffffff4,%r14d
 2dd:	e8 00 00 00 00       	callq  2e2 <azx_probe+0xe5>
 2e2:	48 89 ef             	mov    %rbp,%rdi
 2e5:	e8 00 00 00 00       	callq  2ea <azx_probe+0xed>
 2ea:	e9 62 07 00 00       	jmpq   a51 <azx_probe+0x854>
 2ef:	48 8d 78 48          	lea    0x48(%rax),%rdi
 2f3:	c7 40 44 00 00 00 00 	movl   $0x0,0x44(%rax)
 2fa:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 301:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 308:	e8 00 00 00 00       	callq  30d <azx_probe+0x110>
 30d:	4c 89 23             	mov    %r12,(%rbx)
 310:	48 89 6b 08          	mov    %rbp,0x8(%rbx)
 314:	c7 43 40 ff ff ff ff 	movl   $0xffffffff,0x40(%rbx)
 31b:	8b 04 24             	mov    (%rsp),%eax
 31e:	89 43 14             	mov    %eax,0x14(%rbx)
 321:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0(%rip)        # 328 <azx_probe+0x12b>
 328:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 32e:	7c 08                	jl     338 <azx_probe+0x13b>
 330:	0f 95 c2             	setne  %dl
 333:	c1 e2 04             	shl    $0x4,%edx
 336:	eb 48                	jmp    380 <azx_probe+0x183>
 338:	83 c8 10             	or     $0x10,%eax
 33b:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 342:	48 89 ef             	mov    %rbp,%rdi
 345:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 34b:	e8 00 00 00 00       	callq  350 <azx_probe+0x153>
 350:	48 85 c0             	test   %rax,%rax
 353:	49 89 c6             	mov    %rax,%r14
 356:	74 35                	je     38d <azx_probe+0x190>
 358:	0f b7 50 02          	movzwl 0x2(%rax),%edx
 35c:	0f b7 30             	movzwl (%rax),%esi
 35f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 366:	8b 48 08             	mov    0x8(%rax),%ecx
 369:	31 c0                	xor    %eax,%eax
 36b:	e8 00 00 00 00       	callq  370 <azx_probe+0x173>
 370:	41 8b 56 08          	mov    0x8(%r14),%edx
 374:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 37a:	83 e2 01             	and    $0x1,%edx
 37d:	c1 e2 04             	shl    $0x4,%edx
 380:	83 e0 ef             	and    $0xffffffffffffffef,%eax
 383:	09 d0                	or     %edx,%eax
 385:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 38b:	eb 1b                	jmp    3a8 <azx_probe+0x1ab>
 38d:	83 7b 14 08          	cmpl   $0x8,0x14(%rbx)
 391:	75 15                	jne    3a8 <azx_probe+0x1ab>
 393:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 39a:	31 c0                	xor    %eax,%eax
 39c:	e8 00 00 00 00       	callq  3a1 <azx_probe+0x1a4>
 3a1:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
 3a8:	48 8d 83 20 02 00 00 	lea    0x220(%rbx),%rax
 3af:	44 89 6b 10          	mov    %r13d,0x10(%rbx)
 3b3:	48 c7 83 18 02 00 00 	movq   $0x20100,0x218(%rbx)
 3ba:	00 01 02 00 
 3be:	48 c7 83 30 02 00 00 	movq   $0x0,0x230(%rbx)
 3c5:	00 00 00 00 
 3c9:	48 89 83 20 02 00 00 	mov    %rax,0x220(%rbx)
 3d0:	48 89 83 28 02 00 00 	mov    %rax,0x228(%rbx)
 3d7:	49 63 c5             	movslq %r13d,%rax
 3da:	8b 04 85 00 00 00 00 	mov    0x0(,%rax,4),%eax
 3e1:	8d 50 ff             	lea    -0x1(%rax),%edx
 3e4:	83 fa 02             	cmp    $0x2,%edx
 3e7:	76 51                	jbe    43a <azx_probe+0x23d>
 3e9:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
 3ed:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 3f4:	e8 00 00 00 00       	callq  3f9 <azx_probe+0x1fc>
 3f9:	48 85 c0             	test   %rax,%rax
 3fc:	49 89 c6             	mov    %rax,%r14
 3ff:	74 1e                	je     41f <azx_probe+0x222>
 401:	0f b7 48 02          	movzwl 0x2(%rax),%ecx
 405:	0f b7 10             	movzwl (%rax),%edx
 408:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 40f:	8b 70 08             	mov    0x8(%rax),%esi
 412:	31 c0                	xor    %eax,%eax
 414:	e8 00 00 00 00       	callq  419 <azx_probe+0x21c>
 419:	41 8b 46 08          	mov    0x8(%r14),%eax
 41d:	eb 1b                	jmp    43a <azx_probe+0x23d>
 41f:	8b 53 14             	mov    0x14(%rbx),%edx
 422:	31 c0                	xor    %eax,%eax
 424:	8d 4a fd             	lea    -0x3(%rdx),%ecx
 427:	83 f9 02             	cmp    $0x2,%ecx
 42a:	77 0e                	ja     43a <azx_probe+0x23d>
 42c:	48 63 d2             	movslq %edx,%rdx
 42f:	48 83 ea 03          	sub    $0x3,%rdx
 433:	8b 04 95 00 00 00 00 	mov    0x0(,%rdx,4),%eax
 43a:	89 83 ec 01 00 00    	mov    %eax,0x1ec(%rbx)
 440:	89 83 e8 01 00 00    	mov    %eax,0x1e8(%rbx)
 446:	49 63 c5             	movslq %r13d,%rax
 449:	8b 04 85 00 00 00 00 	mov    0x0(,%rax,4),%eax
 450:	89 83 c4 00 00 00    	mov    %eax,0xc4(%rbx)
 456:	ff c0                	inc    %eax
 458:	75 3a                	jne    494 <azx_probe+0x297>
 45a:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
 45e:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 465:	e8 00 00 00 00       	callq  46a <azx_probe+0x26d>
 46a:	48 85 c0             	test   %rax,%rax
 46d:	49 89 c6             	mov    %rax,%r14
 470:	74 22                	je     494 <azx_probe+0x297>
 472:	0f b7 48 02          	movzwl 0x2(%rax),%ecx
 476:	0f b7 10             	movzwl (%rax),%edx
 479:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 480:	8b 70 08             	mov    0x8(%rax),%esi
 483:	31 c0                	xor    %eax,%eax
 485:	e8 00 00 00 00       	callq  48a <azx_probe+0x28d>
 48a:	41 8b 46 08          	mov    0x8(%r14),%eax
 48e:	89 83 c4 00 00 00    	mov    %eax,0xc4(%rbx)
 494:	8b b3 c4 00 00 00    	mov    0xc4(%rbx),%esi
 49a:	83 fe ff             	cmp    $0xffffffffffffffff,%esi
 49d:	74 25                	je     4c4 <azx_probe+0x2c7>
 49f:	f7 c6 00 01 00 00    	test   $0x100,%esi
 4a5:	74 1d                	je     4c4 <azx_probe+0x2c7>
 4a7:	66 81 e6 ff 00       	and    $0xff,%si
 4ac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 4b3:	31 c0                	xor    %eax,%eax
 4b5:	66 89 b3 c0 00 00 00 	mov    %si,0xc0(%rbx)
 4bc:	0f b7 f6             	movzwl %si,%esi
 4bf:	e8 00 00 00 00       	callq  4c4 <azx_probe+0x2c7>
 4c4:	8b 15 00 00 00 00    	mov    0x0(%rip),%edx        # 4ca <azx_probe+0x2cd>
 4ca:	8a 83 f4 01 00 00    	mov    0x1f4(%rbx),%al
 4d0:	83 e2 01             	and    $0x1,%edx
 4d3:	83 e0 fb             	and    $0xfffffffffffffffb,%eax
 4d6:	c1 e2 02             	shl    $0x2,%edx
 4d9:	09 d0                	or     %edx,%eax
 4db:	49 63 d5             	movslq %r13d,%rdx
 4de:	88 83 f4 01 00 00    	mov    %al,0x1f4(%rbx)
 4e4:	83 3c 95 00 00 00 00 	cmpl   $0x0,0x0(,%rdx,4)
 4eb:	00 
 4ec:	79 15                	jns    503 <azx_probe+0x306>
 4ee:	8b 43 14             	mov    0x14(%rbx),%eax
 4f1:	83 f8 02             	cmp    $0x2,%eax
 4f4:	19 c0                	sbb    %eax,%eax
 4f6:	83 e0 e1             	and    $0xffffffffffffffe1,%eax
 4f9:	83 c0 20             	add    $0x20,%eax
 4fc:	89 04 95 00 00 00 00 	mov    %eax,0x0(,%rdx,4)
 503:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 50a:	48 89 ef             	mov    %rbp,%rdi
 50d:	e8 00 00 00 00       	callq  512 <azx_probe+0x315>
 512:	85 c0                	test   %eax,%eax
 514:	41 89 c6             	mov    %eax,%r14d
 517:	79 15                	jns    52e <azx_probe+0x331>
 519:	48 89 df             	mov    %rbx,%rdi
 51c:	e8 00 00 00 00       	callq  521 <azx_probe+0x324>
 521:	48 89 ef             	mov    %rbp,%rdi
 524:	e8 00 00 00 00       	callq  529 <azx_probe+0x32c>
 529:	e9 23 05 00 00       	jmpq   a51 <azx_probe+0x854>
 52e:	48 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%rax
 535:	31 f6                	xor    %esi,%esi
 537:	48 89 ef             	mov    %rbp,%rdi
 53a:	48 89 43 30          	mov    %rax,0x30(%rbx)
 53e:	e8 00 00 00 00       	callq  543 <azx_probe+0x346>
 543:	48 85 c0             	test   %rax,%rax
 546:	48 89 43 38          	mov    %rax,0x38(%rbx)
 54a:	75 17                	jne    563 <azx_probe+0x366>
 54c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 553:	41 be fa ff ff ff    	mov    $0xfffffffa,%r14d
 559:	e8 00 00 00 00       	callq  55e <azx_probe+0x361>
 55e:	e9 64 03 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 563:	f6 83 f4 01 00 00 10 	testb  $0x10,0x1f4(%rbx)
 56a:	74 18                	je     584 <azx_probe+0x387>
 56c:	be 01 00 00 00       	mov    $0x1,%esi
 571:	48 89 ef             	mov    %rbp,%rdi
 574:	e8 00 00 00 00       	callq  579 <azx_probe+0x37c>
 579:	85 c0                	test   %eax,%eax
 57b:	79 07                	jns    584 <azx_probe+0x387>
 57d:	80 a3 f4 01 00 00 ef 	andb   $0xef,0x1f4(%rbx)
 584:	31 f6                	xor    %esi,%esi
 586:	48 89 df             	mov    %rbx,%rdi
 589:	e8 00 00 00 00       	callq  58e <azx_probe+0x391>
 58e:	85 c0                	test   %eax,%eax
 590:	0f 88 2b 03 00 00    	js     8c1 <azx_probe+0x6c4>
 596:	48 89 ef             	mov    %rbp,%rdi
 599:	e8 00 00 00 00       	callq  59e <azx_probe+0x3a1>
 59e:	8b 7b 40             	mov    0x40(%rbx),%edi
 5a1:	e8 00 00 00 00       	callq  5a6 <azx_probe+0x3a9>
 5a6:	48 8b 43 38          	mov    0x38(%rbx),%rax
 5aa:	66 8b 10             	mov    (%rax),%dx
 5ad:	66 89 14 24          	mov    %dx,(%rsp)
 5b1:	8b 43 14             	mov    0x14(%rbx),%eax
 5b4:	83 e8 03             	sub    $0x3,%eax
 5b7:	83 f8 01             	cmp    $0x1,%eax
 5ba:	77 32                	ja     5ee <azx_probe+0x3f1>
 5bc:	31 d2                	xor    %edx,%edx
 5be:	be 85 43 00 00       	mov    $0x4385,%esi
 5c3:	bf 02 10 00 00       	mov    $0x1002,%edi
 5c8:	e8 00 00 00 00       	callq  5cd <azx_probe+0x3d0>
 5cd:	48 85 c0             	test   %rax,%rax
 5d0:	74 1c                	je     5ee <azx_probe+0x3f1>
 5d2:	8b 14 24             	mov    (%rsp),%edx
 5d5:	8b 0c 24             	mov    (%rsp),%ecx
 5d8:	48 89 c7             	mov    %rax,%rdi
 5db:	83 e2 fe             	and    $0xfffffffffffffffe,%edx
 5de:	80 78 48 2f          	cmpb   $0x2f,0x48(%rax)
 5e2:	0f 46 ca             	cmovbe %edx,%ecx
 5e5:	66 89 0c 24          	mov    %cx,(%rsp)
 5e9:	e8 00 00 00 00       	callq  5ee <azx_probe+0x3f1>
 5ee:	8b 04 24             	mov    (%rsp),%eax
 5f1:	8b 14 24             	mov    (%rsp),%edx
 5f4:	83 e0 fe             	and    $0xfffffffffffffffe,%eax
 5f7:	83 7b 14 09          	cmpl   $0x9,0x14(%rbx)
 5fb:	0f 44 d0             	cmove  %eax,%edx
 5fe:	66 89 14 24          	mov    %dx,(%rsp)
 602:	80 e2 01             	and    $0x1,%dl
 605:	74 2d                	je     634 <azx_probe+0x437>
 607:	48 83 ce ff          	or     $0xffffffffffffffff,%rsi
 60b:	4c 89 ff             	mov    %r15,%rdi
 60e:	e8 00 00 00 00       	callq  613 <azx_probe+0x416>
 613:	85 c0                	test   %eax,%eax
 615:	75 1d                	jne    634 <azx_probe+0x437>
 617:	48 83 ce ff          	or     $0xffffffffffffffff,%rsi
 61b:	4c 89 ff             	mov    %r15,%rdi
 61e:	e8 00 00 00 00       	callq  623 <azx_probe+0x426>
 623:	85 c0                	test   %eax,%eax
 625:	74 37                	je     65e <azx_probe+0x461>
 627:	48 c7 85 50 02 00 00 	movq   $0xffffffffffffffff,0x250(%rbp)
 62e:	ff ff ff ff 
 632:	eb 2a                	jmp    65e <azx_probe+0x461>
 634:	be ff ff ff ff       	mov    $0xffffffff,%esi
 639:	4c 89 ff             	mov    %r15,%rdi
 63c:	e8 00 00 00 00       	callq  641 <azx_probe+0x444>
 641:	be ff ff ff ff       	mov    $0xffffffff,%esi
 646:	4c 89 ff             	mov    %r15,%rdi
 649:	e8 00 00 00 00       	callq  64e <azx_probe+0x451>
 64e:	85 c0                	test   %eax,%eax
 650:	74 0c                	je     65e <azx_probe+0x461>
 652:	be ff ff ff ff       	mov    $0xffffffff,%esi
 657:	48 89 b5 50 02 00 00 	mov    %rsi,0x250(%rbp)
 65e:	8b 0c 24             	mov    (%rsp),%ecx
 661:	89 ca                	mov    %ecx,%edx
 663:	0f b6 c5             	movzbl %ch,%eax
 666:	66 c1 ea 0c          	shr    $0xc,%dx
 66a:	83 e0 0f             	and    $0xf,%eax
 66d:	0f b7 d2             	movzwl %dx,%edx
 670:	89 43 20             	mov    %eax,0x20(%rbx)
 673:	85 d2                	test   %edx,%edx
 675:	89 53 18             	mov    %edx,0x18(%rbx)
 678:	75 3f                	jne    6b9 <azx_probe+0x4bc>
 67a:	85 c0                	test   %eax,%eax
 67c:	75 3b                	jne    6b9 <azx_probe+0x4bc>
 67e:	8b 43 14             	mov    0x14(%rbx),%eax
 681:	83 f8 04             	cmp    $0x4,%eax
 684:	74 15                	je     69b <azx_probe+0x49e>
 686:	83 f8 07             	cmp    $0x7,%eax
 689:	75 20                	jne    6ab <azx_probe+0x4ae>
 68b:	c7 43 18 06 00 00 00 	movl   $0x6,0x18(%rbx)
 692:	c7 43 20 05 00 00 00 	movl   $0x5,0x20(%rbx)
 699:	eb 1e                	jmp    6b9 <azx_probe+0x4bc>
 69b:	c7 43 18 01 00 00 00 	movl   $0x1,0x18(%rbx)
 6a2:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%rbx)
 6a9:	eb 0e                	jmp    6b9 <azx_probe+0x4bc>
 6ab:	c7 43 18 04 00 00 00 	movl   $0x4,0x18(%rbx)
 6b2:	c7 43 20 04 00 00 00 	movl   $0x4,0x20(%rbx)
 6b9:	8b 7b 20             	mov    0x20(%rbx),%edi
 6bc:	48 ba ff ff ff ff ff 	movabs $0x1ffffffffffffff,%rdx
 6c3:	ff ff 01 
 6c6:	31 c0                	xor    %eax,%eax
 6c8:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%rbx)
 6cf:	89 7b 1c             	mov    %edi,0x1c(%rbx)
 6d2:	03 7b 18             	add    0x18(%rbx),%edi
 6d5:	89 7b 28             	mov    %edi,0x28(%rbx)
 6d8:	48 63 ff             	movslq %edi,%rdi
 6db:	48 39 d7             	cmp    %rdx,%rdi
 6de:	77 0e                	ja     6ee <azx_probe+0x4f1>
 6e0:	48 c1 e7 07          	shl    $0x7,%rdi
 6e4:	be d0 80 00 00       	mov    $0x80d0,%esi
 6e9:	e8 00 00 00 00       	callq  6ee <azx_probe+0x4f1>
 6ee:	31 ed                	xor    %ebp,%ebp
 6f0:	48 85 c0             	test   %rax,%rax
 6f3:	48 89 43 68          	mov    %rax,0x68(%rbx)
 6f7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 6fe:	75 3f                	jne    73f <azx_probe+0x542>
 700:	eb 31                	jmp    733 <azx_probe+0x536>
 702:	48 63 cd             	movslq %ebp,%rcx
 705:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 70c:	ba 00 10 00 00       	mov    $0x1000,%edx
 711:	48 c1 e1 07          	shl    $0x7,%rcx
 715:	48 03 4b 68          	add    0x68(%rbx),%rcx
 719:	bf 02 00 00 00       	mov    $0x2,%edi
 71e:	e8 00 00 00 00       	callq  723 <azx_probe+0x526>
 723:	85 c0                	test   %eax,%eax
 725:	41 89 c6             	mov    %eax,%r14d
 728:	79 13                	jns    73d <azx_probe+0x540>
 72a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 731:	31 c0                	xor    %eax,%eax
 733:	e8 00 00 00 00       	callq  738 <azx_probe+0x53b>
 738:	e9 8a 01 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 73d:	ff c5                	inc    %ebp
 73f:	8b 53 28             	mov    0x28(%rbx),%edx
 742:	48 8b 73 08          	mov    0x8(%rbx),%rsi
 746:	39 d5                	cmp    %edx,%ebp
 748:	7c b8                	jl     702 <azx_probe+0x505>
 74a:	c1 e2 03             	shl    $0x3,%edx
 74d:	48 8d 8b b8 01 00 00 	lea    0x1b8(%rbx),%rcx
 754:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 75b:	bf 02 00 00 00       	mov    $0x2,%edi
 760:	48 63 d2             	movslq %edx,%rdx
 763:	e8 00 00 00 00       	callq  768 <azx_probe+0x56b>
 768:	85 c0                	test   %eax,%eax
 76a:	41 89 c6             	mov    %eax,%r14d
 76d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 774:	78 bb                	js     731 <azx_probe+0x534>
 776:	48 8b 73 08          	mov    0x8(%rbx),%rsi
 77a:	48 8d 8b 88 01 00 00 	lea    0x188(%rbx),%rcx
 781:	ba 00 10 00 00       	mov    $0x1000,%edx
 786:	bf 02 00 00 00       	mov    $0x2,%edi
 78b:	48 81 c6 90 00 00 00 	add    $0x90,%rsi
 792:	e8 00 00 00 00       	callq  797 <azx_probe+0x59a>
 797:	85 c0                	test   %eax,%eax
 799:	41 89 c6             	mov    %eax,%r14d
 79c:	78 0e                	js     7ac <azx_probe+0x5af>
 79e:	ba 80 00 00 00       	mov    $0x80,%edx
 7a3:	31 c9                	xor    %ecx,%ecx
 7a5:	be 01 00 00 00       	mov    $0x1,%esi
 7aa:	eb 4d                	jmp    7f9 <azx_probe+0x5fc>
 7ac:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 7b3:	e9 79 ff ff ff       	jmpq   731 <azx_probe+0x534>
 7b8:	8d 3c cd 00 00 00 00 	lea    0x0(,%rcx,8),%edi
 7bf:	48 63 c1             	movslq %ecx,%rax
 7c2:	48 c1 e0 07          	shl    $0x7,%rax
 7c6:	48 03 43 68          	add    0x68(%rbx),%rax
 7ca:	48 63 ff             	movslq %edi,%rdi
 7cd:	48 03 bb c8 01 00 00 	add    0x1c8(%rbx),%rdi
 7d4:	48 89 78 30          	mov    %rdi,0x30(%rax)
 7d8:	48 63 fa             	movslq %edx,%rdi
 7db:	48 03 7b 38          	add    0x38(%rbx),%rdi
 7df:	83 c2 20             	add    $0x20,%edx
 7e2:	88 48 75             	mov    %cl,0x75(%rax)
 7e5:	48 89 78 58          	mov    %rdi,0x58(%rax)
 7e9:	89 f7                	mov    %esi,%edi
 7eb:	d3 e7                	shl    %cl,%edi
 7ed:	89 78 60             	mov    %edi,0x60(%rax)
 7f0:	8d 79 01             	lea    0x1(%rcx),%edi
 7f3:	ff c1                	inc    %ecx
 7f5:	40 88 78 74          	mov    %dil,0x74(%rax)
 7f9:	3b 4b 28             	cmp    0x28(%rbx),%ecx
 7fc:	7c ba                	jl     7b8 <azx_probe+0x5bb>
 7fe:	48 89 df             	mov    %rbx,%rdi
 801:	4d 63 ed             	movslq %r13d,%r13
 804:	e8 00 00 00 00       	callq  809 <azx_probe+0x60c>
 809:	42 8b 34 ad 00 00 00 	mov    0x0(,%r13,4),%esi
 810:	00 
 811:	48 89 df             	mov    %rbx,%rdi
 814:	d1 ee                	shr    %esi
 816:	83 f6 01             	xor    $0x1,%esi
 819:	83 e6 01             	and    $0x1,%esi
 81c:	e8 00 00 00 00       	callq  821 <azx_probe+0x624>
 821:	66 83 bb c0 00 00 00 	cmpw   $0x0,0xc0(%rbx)
 828:	00 
 829:	75 19                	jne    844 <azx_probe+0x647>
 82b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 832:	31 c0                	xor    %eax,%eax
 834:	41 be ed ff ff ff    	mov    $0xffffffed,%r14d
 83a:	e8 00 00 00 00       	callq  83f <azx_probe+0x642>
 83f:	e9 83 00 00 00       	jmpq   8c7 <azx_probe+0x6ca>
 844:	4c 89 e7             	mov    %r12,%rdi
 847:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx
 84e:	48 89 da             	mov    %rbx,%rdx
 851:	be 00 20 00 00       	mov    $0x2000,%esi
 856:	e8 00 00 00 00       	callq  85b <azx_probe+0x65e>
 85b:	85 c0                	test   %eax,%eax
 85d:	41 89 c6             	mov    %eax,%r14d
 860:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 867:	0f 88 c4 fe ff ff    	js     731 <azx_probe+0x534>
 86d:	49 8d 7c 24 14       	lea    0x14(%r12),%rdi
 872:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
 879:	49 8d 6c 24 24       	lea    0x24(%r12),%rbp
 87e:	e8 00 00 00 00       	callq  883 <azx_probe+0x686>
 883:	48 63 43 14          	movslq 0x14(%rbx),%rax
 887:	48 89 ef             	mov    %rbp,%rdi
 88a:	ba 20 00 00 00       	mov    $0x20,%edx
 88f:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 896:	00 
 897:	e8 00 00 00 00       	callq  89c <azx_probe+0x69f>
 89c:	44 8b 4b 40          	mov    0x40(%rbx),%r9d
 8a0:	4c 8b 43 30          	mov    0x30(%rbx),%r8
 8a4:	49 8d 7c 24 44       	lea    0x44(%r12),%rdi
 8a9:	48 89 e9             	mov    %rbp,%rcx
 8ac:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
 8b3:	be 50 00 00 00       	mov    $0x50,%esi
 8b8:	31 c0                	xor    %eax,%eax
 8ba:	e8 00 00 00 00       	callq  8bf <azx_probe+0x6c2>
 8bf:	eb 19                	jmp    8da <azx_probe+0x6dd>
 8c1:	41 be f0 ff ff ff    	mov    $0xfffffff0,%r14d
 8c7:	48 89 df             	mov    %rbx,%rdi
 8ca:	e8 00 00 00 00       	callq  8cf <azx_probe+0x6d2>
 8cf:	45 85 f6             	test   %r14d,%r14d
 8d2:	0f 88 79 01 00 00    	js     a51 <azx_probe+0x854>
 8d8:	31 db                	xor    %ebx,%ebx
 8da:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
 8df:	48 89 df             	mov    %rbx,%rdi
 8e2:	48 89 98 70 01 00 00 	mov    %rbx,0x170(%rax)
 8e9:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 8f0 <azx_probe+0x6f3>
 8f0:	8b 14 85 00 00 00 00 	mov    0x0(,%rax,4),%edx
 8f7:	89 93 d0 00 00 00    	mov    %edx,0xd0(%rbx)
 8fd:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 904:	00 
 905:	e8 f6 f6 ff ff       	callq  0 <azx_codec_create>
 90a:	85 c0                	test   %eax,%eax
 90c:	41 89 c6             	mov    %eax,%r14d
 90f:	0f 88 3c 01 00 00    	js     a51 <azx_probe+0x854>
 915:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 91c <azx_probe+0x71f>
 91c:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 923:	00 
 924:	48 85 f6             	test   %rsi,%rsi
 927:	74 39                	je     962 <azx_probe+0x765>
 929:	80 3e 00             	cmpb   $0x0,(%rsi)
 92c:	74 34                	je     962 <azx_probe+0x765>
 92e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
 935:	31 c0                	xor    %eax,%eax
 937:	e8 00 00 00 00       	callq  93c <azx_probe+0x73f>
 93c:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 943 <azx_probe+0x746>
 943:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 94a:	48 8b 34 c5 00 00 00 	mov    0x0(,%rax,8),%rsi
 951:	00 
 952:	e8 00 00 00 00       	callq  957 <azx_probe+0x75a>
 957:	85 c0                	test   %eax,%eax
 959:	41 89 c6             	mov    %eax,%r14d
 95c:	0f 88 ef 00 00 00    	js     a51 <azx_probe+0x854>
 962:	48 63 05 00 00 00 00 	movslq 0x0(%rip),%rax        # 969 <azx_probe+0x76c>
 969:	f6 04 85 00 00 00 00 	testb  $0x1,0x0(,%rax,4)
 970:	01 
 971:	75 38                	jne    9ab <azx_probe+0x7ae>
 973:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 97a:	48 8b 68 58          	mov    0x58(%rax),%rbp
 97e:	eb 0c                	jmp    98c <azx_probe+0x78f>
 980:	48 89 ef             	mov    %rbp,%rdi
 983:	e8 00 00 00 00       	callq  988 <azx_probe+0x78b>
 988:	48 8b 6d 10          	mov    0x10(%rbp),%rbp
 98c:	48 83 ed 10          	sub    $0x10,%rbp
 990:	48 8b 45 10          	mov    0x10(%rbp),%rax
 994:	48 8d 55 10          	lea    0x10(%rbp),%rdx
 998:	0f 18 08             	prefetcht0 (%rax)
 99b:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 9a2:	48 83 c0 58          	add    $0x58,%rax
 9a6:	48 39 c2             	cmp    %rax,%rdx
 9a9:	75 d5                	jne    980 <azx_probe+0x783>
 9ab:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 9b2:	e8 00 00 00 00       	callq  9b7 <azx_probe+0x7ba>
 9b7:	85 c0                	test   %eax,%eax
 9b9:	41 89 c6             	mov    %eax,%r14d
 9bc:	0f 88 8f 00 00 00    	js     a51 <azx_probe+0x854>
 9c2:	48 8b bb c8 00 00 00 	mov    0xc8(%rbx),%rdi
 9c9:	e8 00 00 00 00       	callq  9ce <azx_probe+0x7d1>
 9ce:	85 c0                	test   %eax,%eax
 9d0:	41 89 c6             	mov    %eax,%r14d
 9d3:	78 7c                	js     a51 <azx_probe+0x854>
 9d5:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
 9da:	e8 00 00 00 00       	callq  9df <azx_probe+0x7e2>
 9df:	85 c0                	test   %eax,%eax
 9e1:	41 89 c6             	mov    %eax,%r14d
 9e4:	78 6b                	js     a51 <azx_probe+0x854>
 9e6:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 9eb:	4c 89 ff             	mov    %r15,%rdi
 9ee:	e8 00 00 00 00       	callq  9f3 <azx_probe+0x7f6>
 9f3:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 9fa:	80 8b f4 01 00 00 01 	orb    $0x1,0x1f4(%rbx)
 a01:	48 8b 68 58          	mov    0x58(%rax),%rbp
 a05:	eb 0c                	jmp    a13 <azx_probe+0x816>
 a07:	48 89 ef             	mov    %rbp,%rdi
 a0a:	e8 00 00 00 00       	callq  a0f <azx_probe+0x812>
 a0f:	48 8b 6d 10          	mov    0x10(%rbp),%rbp
 a13:	48 83 ed 10          	sub    $0x10,%rbp
 a17:	48 8b 45 10          	mov    0x10(%rbp),%rax
 a1b:	48 8d 55 10          	lea    0x10(%rbp),%rdx
 a1f:	0f 18 08             	prefetcht0 (%rax)
 a22:	48 8b 83 c8 00 00 00 	mov    0xc8(%rbx),%rax
 a29:	48 83 c0 58          	add    $0x58,%rax
 a2d:	48 39 c2             	cmp    %rax,%rdx
 a30:	75 d5                	jne    a07 <azx_probe+0x80a>
 a32:	48 8d bb 38 02 00 00 	lea    0x238(%rbx),%rdi
 a39:	48 c7 83 38 02 00 00 	movq   $0x0,0x238(%rbx)
 a40:	00 00 00 00 
 a44:	e8 00 00 00 00       	callq  a49 <azx_probe+0x84c>
 a49:	ff 05 00 00 00 00    	incl   0x0(%rip)        # a4f <azx_probe+0x852>
 a4f:	eb 0a                	jmp    a5b <azx_probe+0x85e>
 a51:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
 a56:	e8 00 00 00 00       	callq  a5b <azx_probe+0x85e>
 a5b:	48 83 c4 28          	add    $0x28,%rsp
 a5f:	44 89 f0             	mov    %r14d,%eax
 a62:	5b                   	pop    %rbx
 a63:	5d                   	pop    %rbp
 a64:	41 5c                	pop    %r12
 a66:	41 5d                	pop    %r13
 a68:	41 5e                	pop    %r14
 a6a:	41 5f                	pop    %r15
 a6c:	c3                   	retq   

--=-pH5JywAdetmQX+q1U27V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-pH5JywAdetmQX+q1U27V--
