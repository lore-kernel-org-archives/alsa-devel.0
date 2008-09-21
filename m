From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+1kf5@trn.iki.fi>
Subject: OOPS on USB sound card disconnect while in use
Date: Mon, 22 Sep 2008 01:00:30 +0300
Message-ID: <48D6C3FE.3000108@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E966243A3
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 00:00:34 +0200 (CEST)
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
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This has been broken for a long time.

Symtoms: programs using the card while it is disconnected get stuck and 
cannot be killed, and OOPS is printed on the log:

[108034.041573] usb 9-2: USB disconnect, address 3
[108043.576040] usb 9-2: new full speed USB device using uhci_hcd and 
address 4
[108043.757185] usb 9-2: configuration #1 chosen from 1 choice
[108057.602616] BUG: unable to handle kernel paging request at 
000061d855001080
[108057.602621] IP: [<ffffffffa00e0c71>] hcd_buffer_free+0x11/0x90 [usbcore]
[108057.602643] PGD 0
[108057.602647] Oops: 0000 [1] SMP
[108057.602652] CPU 0
[108057.602655] Modules linked in: nls_cp437 cifs af_packet binfmt_misc 
rfcomm l2cap bluetooth ppdev ipv6 cpufreq_conservative cpufreq_ondemand 
cpufreq_powersave cpufreq_userspace cpufreq_stats freq_table container 
video output sbs sbshc pci_slot wmi battery iptable_filter ip_tables 
x_tables ext2 ac lp loop snd_seq_dummy arc4 snd_hda_intel snd_seq_oss 
ecb crypto_blkcipher snd_usb_audio snd_usb_lib snd_pcm_oss snd_mixer_oss 
snd_seq_midi snd_pcm snd_rawmidi ath9k snd_seq_midi_event snd_hwdep 
snd_seq mac80211 psmouse snd_timer snd_seq_device cfg80211 snd serio_raw 
iTCO_wdt iTCO_vendor_support soundcore nvidia(P) snd_page_alloc i2c_core 
parport_pc parport button shpchp pci_hotplug intel_agp evdev joydev ext3 
jbd mbcache sg sd_mod crc_t10dif ata_generic ata_piix pata_jmicron 
usbhid hid pata_acpi ahci libata scsi_mod dock sky2 uhci_hcd ehci_hcd 
usbcore raid10 raid456 async_xor async_memcpy async_tx xor raid1 raid0 
multipath linear md_mod thermal processor fan fbcon tileblit font 
bitblit softcursor uvesafb cn fuse
[108057.602714] Pid: 15655, comm: rhythmbox Tainted: P 
2.6.27-3-generic #1
[108057.602716] RIP: 0010:[<ffffffffa00e0c71>]  [<ffffffffa00e0c71>] 
hcd_buffer_free+0x11/0x90 [usbcore]
[108057.602727] RSP: 0018:ffff8801a7d97cc8  EFLAGS: 00010286
[108057.602729] RAX: ffff880219061680 RBX: ffff88021a162e00 RCX: 
0000000037836060
[108057.602731] RDX: ffff880037836060 RSI: 0000000000000020 RDI: 
000061d855001080
[108057.602733] RBP: ffff8801a7d97cc8 R08: ffff880037836060 R09: 
0000000000000566
[108057.602734] R10: 0000000000000002 R11: 0000000000000000 R12: 
ffff88021a1630c8
[108057.602736] R13: 0000000000001fff R14: ffff88021a44e400 R15: 
0000000000000000
[108057.602738] FS:  00007ffd6f42f7a0(0000) GS:ffffffff806ffa80(0000) 
knlGS:0000000000000000
[108057.602740] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[108057.602742] CR2: 000061d855001080 CR3: 00000001d80ff000 CR4: 
00000000000006e0
[108057.602744] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[108057.602745] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[108057.602747] Process rhythmbox (pid: 15655, threadinfo 
ffff8801a7d96000, task ffff8801c68cd9c0)
[108057.602749] Stack:  ffff8801a7d97cd8 ffffffffa00d3425 
ffff8801a7d97cf8 ffffffffa0b391d5
[108057.602754]  ffff88021aa00c00 ffff88021aa00c00 ffff8801a7d97d18 
ffffffffa0b39212
[108057.602758]  ffff88021a163000 ffff88021a163000 ffff8801a7d97d28 
ffffffffa0b39275
[108057.602761] Call Trace:
[108057.602775]  [<ffffffffa00d3425>] usb_buffer_free+0x25/0x30 [usbcore]
[108057.602780]  [<ffffffffa0b391d5>] 
snd_usbmidi_out_endpoint_delete+0x35/0x50 [snd_usb_lib]
[108057.602784]  [<ffffffffa0b39212>] snd_usbmidi_free+0x22/0x70 
[snd_usb_lib]
[108057.602787]  [<ffffffffa0b39275>] snd_usbmidi_rawmidi_free+0x15/0x20 
[snd_usb_lib]
[108057.602792]  [<ffffffffa0af9287>] snd_rawmidi_free+0xf7/0x110 
[snd_rawmidi]
[108057.602796]  [<ffffffffa0af92b2>] snd_rawmidi_dev_free+0x12/0x20 
[snd_rawmidi]
[108057.602805]  [<ffffffffa0a1a8b1>] snd_device_free+0x71/0xd0 [snd]
[108057.602811]  [<ffffffffa0a1a974>] snd_device_free_all+0x64/0x70 [snd]
[108057.602818]  [<ffffffffa0a14a1f>] snd_card_do_free+0x3f/0xe0 [snd]
[108057.602824]  [<ffffffffa0a14bff>] snd_card_file_remove+0x13f/0x170 [snd]
[108057.602833]  [<ffffffffa0b09f86>] snd_pcm_release+0xa6/0xc0 [snd_pcm]
[108057.602839]  [<ffffffffa0a15630>] ? snd_disconnect_release+0x0/0xb0 
[snd]
[108057.602846]  [<ffffffffa0a156a6>] snd_disconnect_release+0x76/0xb0 [snd]
[108057.602852]  [<ffffffff802ec8a9>] __fput+0xc9/0x1b0
[108057.602854]  [<ffffffff802ec9b5>] fput+0x25/0x30
[108057.602858]  [<ffffffff802c67e3>] remove_vma+0x43/0x90
[108057.602860]  [<ffffffff802c860a>] do_munmap+0x2ea/0x330
[108057.602862]  [<ffffffff802c86a5>] sys_munmap+0x55/0x80
[108057.602866]  [<ffffffff8021288a>] system_call_fastpath+0x16/0x1b
[108057.602868]
[108057.602869]
[108057.602870] Code: 07 48 ff 84 02 00 02 00 00 4c 89 f1 49 89 4d 20 eb 
9f 90 90 90 90 90 90 90 90 55 48 89 e5 0f 1f 44 00 00 48 85 d2 49 89 d0 
74 3b <48> 8b 07 48 83 b8 c0 01 00 00 00 74 52 48 c7 c2 20 90 0e a0 31
[108057.602896] RIP  [<ffffffffa00e0c71>] hcd_buffer_free+0x11/0x90 
[usbcore]
[108057.602907]  RSP <ffff8801a7d97cc8>
[108057.602909] CR2: 000061d855001080
[108057.602917] ---[ end trace 8c6a5ea5cd36c92b ]---

asound.conf:

# Allow mixing of multiple output streams to this device
pcm.output {
     type dmix
     ipc_key 1024
     ipc_perm 0660 # Sound for everybody in your group!
     slave.pcm "hw:UA25"

     slave {
          # This stuff provides some fixes for latency issues.
          # buffer_size should be set for your audio chipset.
          period_time 0
          period_size 1024
          buffer_size 8192
	 rate 48000
     }

     bindings {
          0 0
          1 1
     }
}


pcm.!default {
	type plug
	slave.pcm "output"
	slave.rate 48000
}


uname -a:
Linux Kaidenn 2.6.27-3-generic #1 SMP Wed Sep 10 16:18:52 UTC 2008 
x86_64 GNU/Linux

And yes, I know that it is tainted. Live with it.
