From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Sun, 28 Aug 2005 11:32:27 +0800
Message-ID: <4311304B.8060600@netvigator.com>
References: <1118256592.28940.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1118256592.28940.0.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik <assie2@zonnet.nl>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

void __iomem *mmio;

should be used instead of

unsigned long __iomem *mmio;

in snd_vortex_t for architecture independent (32-bits and 64-bits)


-#define	hwread(x,y) readl((x)+((y)>>2))
-#define	hwwrite(x,y,z) writel((z),(x)+((y)>>2))
+#define	hwread(x,y) readl((x)+(y))
+#define	hwwrite(x,y,z) writel((z),(x)+(y))


Would you please try the patch diff11.diff (against
alsa-driver-1.0.9b) at

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948

We need feedback from au8810/au8820/au8830 users in testing the 
Equalizer, MPU401, Gameport, 4-channels, .... on 32/64-bits platform.


Erik wrote:
> i installed mandriva 2005 X86-64 and out of the box sound was not
> working
> getting error message /dev/dsp not exist 
> with lsmod i saw the module snd-au8830 was running 
> can't rmmod even the -f option didn't remove the snd-au8830 module
> 
> so i thought i compile a new kernel with alsa and oss options
> outcommented only sound as module
> compiled alsa-driver version 1.09 lib and utils (had to do
> --libdir=/usr/lib64 to get utils to work)
> 
> but after compilation and rebooting
> au8830 is getting loaded but nothing works
> alsamixer give me this error message: alsamixer: function snd_ctl_open
> failed for default: No such file or directory
> 
> so i looked in /var/log/messages and snipped this out of it:
> 
> Jun  6 02:29:05 localhost kernel: ACPI: PCI Interrupt Link [APC3]
> enabled at IRQ 18
> Jun  6 02:29:05 localhost kernel: ACPI: PCI interrupt 0000:02:08.0[A] ->
> GSI 18 (level, low) -> IRQ 209
> Jun  6 02:29:05 localhost kernel: Vortex: init.... <1>Unable to handle
> kernel paging request at ffffc200003d4018 RIP: 
> Jun  6 02:29:05 localhost kernel: [__nosave_end+131365506/2133123072]
> Jun  6 02:29:05 localhost kernel: [<ffffffff880f9a82>]
> Jun  6 02:29:05 localhost kernel: PGD 3ffd2067 PUD 3ffd1067 PMD 3fcba067
> PTE 0
> Jun  6 02:29:05 localhost kernel: Oops: 0002 [1] 
> Jun  6 02:29:05 localhost kernel: CPU 0 
> Jun  6 02:29:05 localhost kernel: Modules linked in: snd_au8830
> snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore af_packet floppy forcedeth
> ide_cd loop vfat fat nls_iso8859_1 ntfs ext3 jbd ehci_hcd ohci_hcd
> usbcore thermal processor fan container button sd_mod sata_nv libata
> Jun  6 02:29:05 localhost kernel: Pid: 4681, comm: modprobe Not tainted
> 2.6.11.11
> Jun  6 02:29:05 localhost kernel: RIP: 0010:[__nosave_end
> +131365506/2133123072] [__nosave_end+131365506/2133123072]
> Jun  6 02:29:05 localhost kernel: RIP: 0010:[<ffffffff880f9a82>]
> [<ffffffff880f9a82>]
> Jun  6 02:29:05 localhost kernel: RSP: 0018:ffff81003ecd3c18  EFLAGS:
> 00010292
> Jun  6 02:29:05 localhost kernel: RAX: ffffc20000380000 RBX:
> 0000000000000000 RCX: 0000000000003fff
> Jun  6 02:29:05 localhost kernel: RDX: 0000000000000006 RSI:
> 000000000000353a RDI: 0000000000000005
> Jun  6 02:29:05 localhost kernel: RBP: ffff81003dd08000 R08:
> 0000000000000036 R09: ffff810001d676c0
> Jun  6 02:29:05 localhost kernel: R10: 000000000003ac90 R11:
> 0000000000000000 R12: 00000000ffffffed
> Jun  6 02:29:05 localhost kernel: R13: ffff81003fc07000 R14:
> ffff81003fc07000 R15: ffff81003e9f2400
> Jun  6 02:29:05 localhost kernel: FS:  00002aaaaadf2b00(0000)
> GS:ffffffff8037e940(0000) knlGS:0000000000000000
> Jun  6 02:29:05 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 000000008005003b
> Jun  6 02:29:05 localhost kernel: CR2: ffffc200003d4018 CR3:
> 000000003f3af000 CR4: 00000000000006e0
> Jun  6 02:29:05 localhost kernel: Process modprobe (pid: 4681,
> threadinfo ffff81003ecd2000, task ffff81003e49ce90)
> Jun  6 02:29:05 localhost kernel: Stack: 0000000000000000
> 0000000000000000 000000d000000000 ffff81003ecd3c30 
> Jun  6 02:29:05 localhost kernel:        ffff81003ecd3c30
> 0000000000000000 0000000000000282 ffffffff8031f398 
> Jun  6 02:29:05 localhost kernel:        ffff81003e9f2459
> ffffffff801c2c0e 
> Jun  6 02:29:05 localhost kernel: Call Trace:[kobject_hotplug+622/672]
> [pci_device_probe+134/368] [driver_probe_device+77/128] 
> Jun  6 02:29:05 localhost kernel: Call Trace:[<ffffffff801c2c0e>]
> [<ffffffff801cba56>] [<ffffffff80229c6d>] 
> Jun  6 02:29:05 localhost kernel:        [driver_attach+75/160]
> [bus_add_driver+152/336] [driver_register+50/64] 
> Jun  6 02:29:05 localhost kernel:        [<ffffffff80229d8b>]
> [<ffffffff8022a148>] [<ffffffff8022a6a2>] 
> Jun  6 02:29:05 localhost kernel:        [pci_register_driver+110/160]
> [sys_init_module+4916/5200] [rb_insert_color+201/240] 
> Jun  6 02:29:05 localhost kernel:        [<ffffffff801cb75e>]
> [<ffffffff801482c4>] [<ffffffff801c43a9>] 
> Jun  6 02:29:05 localhost kernel:        [__nosave_end
> +131383296/2133123072] [do_munmap+854/912] [system_call+126/131] 
> Jun  6 02:29:05 localhost kernel:        [<ffffffff880fe000>]
> [<ffffffff801618f6>] [<ffffffff8010e21a>] 
> Jun  6 02:29:05 localhost kernel:        
> Jun  6 02:29:05 localhost kernel: 
> Jun  6 02:29:05 localhost kernel: Code: c7 80 18 40 05 00 ff ff ff ff e8
> 6f 07 04 f8 48 8b 95 e8 40 
> Jun  6 02:29:05 localhost kernel: RIP [__nosave_end
> +131365506/2133123072] RSP <ffff81003ecd3c18>
> Jun  6 02:29:05 localhost kernel: RIP [<ffffffff880f9a82>] RSP
> <ffff81003ecd3c18>
> Jun  6 02:29:05 localhost kernel: CR2: ffffc200003d4018
> Jun  6 02:29:05 localhost sound: Loading sound module (snd-au8830)
> failed
> 
> and i can't rmmod this snd-au8830 either.
> 
> Does anyone know what the problem is?
> 
> Erik
> 
> 
> amd64 3500+
> msi k8n neo2
> diamond monster 3d sound (au8830)
> 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
