From: alex <alex@slab.org>
Subject: kernel oops when loading vxpocket firmware
Date: Tue, 01 Feb 2005 10:25:05 +0000
Message-ID: <1107253505.1749.15.camel@chop.state51.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hello,

I've been trying to get my vxpocket to work in time for a gig this
weekend.

Right now I'm trying with the kernel 2.6.10-2.1.ll.rhfc3.ccrma, but
whenever I insert the card I get the below in /var/log/messages.
I'm using the latest planet ccrma on fedora core.

I emailed the planet ccrma mailing list about this and was pointed here.
Any suggestions much appreciated.

alex


Jan 31 22:01:41 localhost cardmgr[3322]: socket 1: Digigram VX-POCKET
Jan 31 22:01:41 localhost kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jan 31 22:01:42 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan 31 22:01:42 localhost kernel:  printing eip:
Jan 31 22:01:42 localhost kernel: c021b657
Jan 31 22:01:42 localhost kernel: *pde = 00000000
Jan 31 22:01:42 localhost kernel: Oops: 0000 [#1]
Jan 31 22:01:42 localhost kernel: PREEMPT
Jan 31 22:01:42 localhost kernel: Modules linked in: snd_vxpocket(U) snd_vx_cs(U) snd_vx_lib(U) realtime(U) commoncap(U) md5(U) ipv6(U) parport_pc(U) lp(U) parport(U) autofs4(U) sunrpc(U) pcmcia(U) ipt_REJECT(U) ipt_state(U) ip_conntrack(U) iptable_filter(U) ip_tables(U) vfat(U) fat(U) dm_mod(U) video(U) button(U) battery(U) ac(U) ohci1394(U) ieee1394(U) yenta_socket(U) pcmcia_core(U) uhci_hcd(U) ehci_hcd(U) i2c_i801(U) i2c_core(U) snd_intel8x0m(U) snd_intel8x0(U) snd_ac97_codec(U) snd_pcm_oss(U) snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd(U) soundcore(U) snd_page_alloc(U) 3c59x(U) ext3(U) jbd(U)
Jan 31 22:01:42 localhost kernel: CPU:    0
Jan 31 22:01:42 localhost kernel: EIP:    0060:[<c021b657>]    Not tainted VLI
Jan 31 22:01:42 localhost kernel: EFLAGS: 00010246   (2.6.10-2.1.ll.rhfc3.ccrma)
Jan 31 22:01:42 localhost kernel: EIP is at get_kobj_path_length+0x27/0x40
Jan 31 22:01:42 localhost kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ffffffff
Jan 31 22:01:42 localhost kernel: esi: 00000001   edi: 00000000   ebp: dcc94278   esp: de1c9940
Jan 31 22:01:42 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 31 22:01:42 localhost kernel: Process cardmgr (pid: 3322, threadinfo=de1c8000 task=ddb88aa0)
Jan 31 22:01:42 localhost kernel: Stack: 000000d0 dcc94254 dc268c98 dcc94278 c021b6ec ddedab84 c0405800 dcc94254
Jan 31 22:01:42 localhost kernel:        dc268c98 dc268f80 c029bffd dc268f88 ffffffff ffffffff fffffffd 0000000a
Jan 31 22:01:42 localhost kernel:        242c07d3 dbd3f82d c03b65af 00000000 00000000 00000000 c0405800 dc268c80
Jan 31 22:01:42 localhost kernel: Call Trace:
Jan 31 22:01:42 localhost kernel:  [<c021b6ec>] kobject_get_path+0x1c/0x70
Jan 31 22:01:42 localhost kernel:  [<c029bffd>] class_hotplug+0x6d/0x1d0
Jan 31 22:01:42 localhost kernel:  [<c021c5c1>] kobject_hotplug+0x411/0x430
Jan 31 22:01:42 localhost kernel:  [<c01de9c1>] create_dir+0x191/0x2a0
Jan 31 22:01:42 localhost kernel:  [<c021b92c>] kobject_add+0x10c/0x130
Jan 31 22:01:42 localhost kernel:  [<c029c32e>] class_device_add+0x7e/0x160
Jan 31 22:01:42 localhost kernel:  [<c021b765>] kobject_init+0x25/0x40
Jan 31 22:01:42 localhost kernel:  [<c029f5ce>] fw_register_class_device+0x17e/0x1e0
Jan 31 22:01:42 localhost kernel:  [<c029f65e>] fw_setup_class_device+0x2e/0xf0
Jan 31 22:01:42 localhost kernel:  [<c029f781>] request_firmware+0x61/0x170
Jan 31 22:01:42 localhost kernel:  [<e0a62495>] snd_vx_setup_firmware+0x85/0x100 [snd_vx_lib]
Jan 31 22:01:42 localhost kernel:  [<e0b5b3c0>] snd_vxpocket_assign_resources+0x70/0x90 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e0b5b619>] vxpocket_config+0x1a9/0x210 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e098de58>] pccard_get_first_tuple+0x78/0x120 [pcmcia_core]
Jan 31 22:01:42 localhost kernel:  [<e098f81a>] pccard_read_tuple+0x7a/0xb0 [pcmcia_core]
Jan 31 22:01:42 localhost kernel:  [<e0b5b79e>] vxpocket_event+0x11e/0x130 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e098c345>] pcmcia_register_client+0x235/0x260 [pcmcia_core]
Jan 31 22:01:42 localhost kernel:  [<e08ebce5>] snd_device_new+0x45/0xe0 [snd]
Jan 31 22:01:42 localhost kernel:  [<c021ec19>] vsnprintf+0x319/0x550
Jan 31 22:01:42 localhost kernel:  [<e08e68e7>] snd_hidden_kcalloc+0x37/0x70 [snd]
Jan 31 22:01:42 localhost kernel:  [<e08ebce5>] snd_device_new+0x45/0xe0 [snd]
Jan 31 22:01:42 localhost kernel:  [<e0b5b680>] vxpocket_event+0x0/0x130 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e0b5b2c2>] snd_vxpocket_attach+0x1f2/0x280 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e0b5b680>] vxpocket_event+0x0/0x130 [snd_vx_cs]
Jan 31 22:01:42 localhost kernel:  [<e0a566f2>] bind_request+0x132/0x240 [pcmcia]
Jan 31 22:01:42 localhost kernel:  [<e0a574f8>] ds_ioctl+0x6f8/0x740 [pcmcia]
Jan 31 22:01:42 localhost kernel:  [<c015b2e6>] buffered_rmqueue+0xe6/0x310
Jan 31 22:01:42 localhost kernel:  [<c015b5bb>] __alloc_pages+0xab/0x330
Jan 31 22:01:42 localhost kernel:  [<c01fe3a2>] avc_has_perm+0x62/0x78
Jan 31 22:01:42 localhost kernel:  [<c0200013>] inode_has_perm+0x53/0x90
Jan 31 22:01:42 localhost kernel:  [<c0203195>] selinux_file_ioctl+0x105/0x3a0
Jan 31 22:01:42 localhost kernel:  [<c016a5ed>] zap_pte_range+0x5d/0x2d0
Jan 31 22:01:42 localhost kernel:  [<c016a90d>] unmap_page_range+0x3d/0x70
Jan 31 22:01:42 localhost kernel:  [<c016aa51>] unmap_vmas+0x111/0x350
Jan 31 22:01:42 localhost kernel:  [<c01fff02>] task_has_perm+0x32/0x40
Jan 31 22:01:42 localhost kernel:  [<c016ee0a>] remove_vm_struct+0x10a/0x1c0
Jan 31 22:01:42 localhost kernel:  [<c0170fa6>] unmap_region+0x96/0xf0
Jan 31 22:01:42 localhost kernel:  [<c0170efa>] unmap_vma_list+0x1a/0x30
Jan 31 22:01:42 localhost kernel:  [<c01712fe>] do_munmap+0x1be/0x2c0
Jan 31 22:01:42 localhost kernel:  [<c019f7a9>] sys_ioctl+0x169/0x260
Jan 31 22:01:42 localhost kernel:  [<c0103b59>] sysenter_past_esp+0x52/0x75
Jan 31 22:01:42 localhost kernel: Code: 00 00 00 00 55 ba ff ff ff ff 89 c5 57 56 be 01 00 00 00 53 31 db 8d b4 26 00 00 00
00 8d bc 27 00 00 00 00 8b 7d 00 89 d1 89 d8 <f2> ae f7 d1 49 8b 6d 24 8d 74 31 01 85 ed 75 e9 5b 89 f0 5e 5f
Jan 31 22:02:44 localhost cardmgr[4897]: open_sock(socket 1) failed: Device or resource busy
Jan 31 22:02:44 localhost cardmgr[4897]: watching 1 socket
Jan 31 22:02:44 localhost cardmgr[4897]: could not adjust resource: IO ports 0xc00-0xcff: Device or resource busy
Jan 31 22:02:44 localhost cardmgr[4897]: could not adjust resource: IO ports 0x100-0x4ff: Device or resource busy
Jan 31 22:02:44 localhost cardmgr[4897]: could not adjust resource: memory 0xc0000-0xfffff: Input/output error
Jan 31 22:02:44 localhost cardmgr[4897]: could not adjust resource: memory 0xa0000000-0xa0ffffff: Input/output error
Jan 31 22:02:44 localhost cardmgr[4897]: could not adjust resource: IO ports 0xa00-0xaff: Device or resource busy





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
