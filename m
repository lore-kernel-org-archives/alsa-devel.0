From: Christian Iversen <chrivers@iversen-net.dk>
Subject: kernel BUG, likely ALSA related
Date: Mon, 5 Mar 2007 13:33:58 +0100
Message-ID: <200703051333.59069.chrivers@iversen-net.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Please CC me, I'm not on the list.


Uname: 2.6.20-9-lowlatency #2 SMP PREEMPT x86_64 GNU/Linux (ubuntu feisty)

This bug also happens with 2.6.19 from ubuntu edgy.

When trying to run basically anything with wine, I get a brief click in my 
speakers, and the following in dmesg. Sound continues to work, but the wine 
process will be stuck in the D state.



[35573.213765] BUG: using smp_processor_id() in preemptible [00000001] code: 
winevdm.exe/29933
[35573.213773] caller is oops_begin+0xb/0x80
[35573.213775]
[35573.213776] Call Trace:
[35573.213785]  [<ffffffff803481bb>] debug_smp_processor_id+0xab/0xc0
[35573.213790]  [<ffffffff8026cadb>] oops_begin+0xb/0x80
[35573.213798]  [<ffffffff8026e9cd>] do_page_fault+0x6dd/0x890
[35573.213814]  [<ffffffff8026c1f5>] _spin_unlock_irq+0x15/0x40
[35573.213819]  [<ffffffff80269d55>] thread_return+0xb8/0x113
[35573.213842]  [<ffffffff8026c6fd>] error_exit+0x0/0x84
[35573.213874]  [<ffffffff8830f1f4>] :snd_pcm:snd_interval_list+0x24/0xc0
[35573.213889]  [<ffffffff8830ca82>] :snd_pcm:snd_pcm_hw_refine+0x2e2/0x450
[35573.213947]  
[<ffffffff88355583>] :snd_pcm_oss:snd_pcm_oss_change_params+0x263/0xd10
[35573.213962]  [<ffffffff802d7dfb>] kmem_cache_zalloc+0xab/0xd0
[35573.213981]  [<ffffffff882af7fd>] :soundcore:soundcore_open+0x28d/0x2d0
[35573.213999]  
[<ffffffff88356767>] :snd_pcm_oss:snd_pcm_oss_get_active_substream+0x47/0x80
[35573.214012]  
[<ffffffff883567e2>] :snd_pcm_oss:snd_pcm_oss_get_formats+0x12/0xf0
[35573.214028]  
[<ffffffff883570ef>] :snd_pcm_oss:snd_pcm_oss_ioctl+0x43f/0xc30
[35573.214036]  [<ffffffff8020d2c1>] dput+0x21/0x170
[35573.214046]  [<ffffffff802fa1af>] compat_sys_ioctl+0xef/0x330
[35573.214053]  [<ffffffff80225811>] filp_close+0x71/0x90
[35573.214071]  [<ffffffff80268722>] ia32_sysret+0x0/0xa
[35573.214090]
[35573.214092] Unable to handle kernel NULL pointer dereference at 
0000000000000031 RIP:
[35573.214096]  [<ffffffff8830f1f4>] :snd_pcm:snd_interval_list+0x24/0xc0
[35573.214108] PGD 38bb8067 PUD 5be02067 PMD 13566067 PTE 0
[35573.214112] Oops: 0000 [1] PREEMPT SMP
[35573.214116] CPU 0
[35573.214118] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat binfmt_misc 
cpufreq_ondemand cpufreq_userspace cpufreq_powersave powernow_k8 freq_table 
nfsd exportfs video battery container sbs button i2c_ec dock ac asus_acpi 
backlight nfs lockd sunrpc nls_utf8 ntfs ext3 jbd mbcache ipv6 fuse 
snd_intel8x0 sbp2 lp snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_usb_audio snd_usb_lib snd_ac97_codec 
ac97_bus nvidia(P) snd_pcm_oss snd_mixer_oss snd_seq_dummy uvcvideo 
snd_seq_oss snd_seq_midi snd_rawmidi emu10k1_gp gameport snd_pcm 
snd_page_alloc snd_util_mem snd_hwdep parport_pc snd_seq_midi_event videodev 
snd_seq snd_timer snd_seq_device snd soundcore pcspkr v4l1_compat v4l2_common 
psmouse serio_raw parport af_packet k8temp i2c_nforce2 i2c_core shpchp 
pci_hotplug tsdev evdev sr_mod cdrom usb_storage usbhid hid libusual reiserfs 
sg sd_mod amd74xx generic ata_generic floppy ohci_hcd forcedeth ehci_hcd 
usbcore ohci1394 ieee1394 sata_nv libata scsi_mod raid10 raid456 xor raid1 
raid0 multipath linear md_mod thermal processor fan fbcon tileblit font 
bitblit softcursor vesafb cfbcopyarea cfbimgblt cfbfillrect capability 
commoncap
[35573.214180] Pid: 29933, comm: winevdm.exe Tainted: P      
2.6.20-9-lowlatency #2
[35573.214183] RIP: 0010:[<ffffffff8830f1f4>]  
[<ffffffff8830f1f4>] :snd_pcm:snd_interval_list+0x24/0xc0
[35573.214195] RSP: 0000:ffff810069c4dbc0  EFLAGS: 00010202
[35573.214198] RAX: 0000000000000006 RBX: ffff81001147d450 RCX: 
0000000000000006
[35573.214201] RDX: 0000000000000019 RSI: 0000000069c4dc88 RDI: 
ffff810037bdf128
[35573.214205] RBP: ffff810069c4dd28 R08: 0000000031896a40 R09: 
0000000000000001
[35573.214208] R10: 00000000000f4240 R11: 00000000ffffff30 R12: 
ffff810037bdf000
[35573.214211] R13: 0000000000000017 R14: ffff8100554411b0 R15: 
0000000000000017
[35573.214216] FS:  000000007ffdc000(0063) GS:ffffffff8054c000(006b) 
knlGS:00000000f7d086b0
[35573.214219] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
[35573.214221] CR2: 0000000000000031 CR3: 0000000068ef9000 CR4: 
00000000000006e0
[35573.214225] Process winevdm.exe (pid: 29933, threadinfo ffff810069c4c000, 
task ffff8100310587e0)
[35573.214228] Stack:  ffffffff8830ca82 ffff81002c145005 0000000300000002 
0000000500000004
[35573.214235]  0000000700000006 0000000900000008 0000000b0000000a 
0000000d0000000c
[35573.214240]  0000000f0000000e 0000001100000010 0000001300000012 
0000001500000014
[35573.214244] Call Trace:
[35573.214253]  [<ffffffff8830ca82>] :snd_pcm:snd_pcm_hw_refine+0x2e2/0x450
[35573.214310]  
[<ffffffff88355583>] :snd_pcm_oss:snd_pcm_oss_change_params+0x263/0xd10
[35573.214325]  [<ffffffff802d7dfb>] kmem_cache_zalloc+0xab/0xd0
[35573.214343]  [<ffffffff882af7fd>] :soundcore:soundcore_open+0x28d/0x2d0
[35573.214362]  
[<ffffffff88356767>] :snd_pcm_oss:snd_pcm_oss_get_active_substream+0x47/0x80
[35573.214374]  
[<ffffffff883567e2>] :snd_pcm_oss:snd_pcm_oss_get_formats+0x12/0xf0
[35573.214390]  
[<ffffffff883570ef>] :snd_pcm_oss:snd_pcm_oss_ioctl+0x43f/0xc30
[35573.214397]  [<ffffffff8020d2c1>] dput+0x21/0x170
[35573.214407]  [<ffffffff802fa1af>] compat_sys_ioctl+0xef/0x330
[35573.214414]  [<ffffffff80225811>] filp_close+0x71/0x90
[35573.214428]  [<ffffffff80268722>] ia32_sysret+0x0/0xa
[35573.214447]
[35573.214448]
[35573.214449] Code: 8b 04 82 39 07 75 08 f6 47 08 01 75 04 eb 1f 72 0f 83 c1 
01
[35573.214459] RIP  [<ffffffff8830f1f4>] :snd_pcm:snd_interval_list+0x24/0xc0
[35573.214470]  RSP <ffff810069c4dbc0>
[35573.214472] CR2: 0000000000000031
[35573.214473]





To me, this looks like a bug in PCM handler code in ALSA. What do you think?




-- 
Regards,
Christian Iversen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
