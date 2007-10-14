From: "ilya .d" <errordeveloper@gmail.com>
Subject: snd-hdsp in 2.6.22 crashes badly
Date: Sun, 14 Oct 2007 22:21:22 +0000
Message-ID: <20071014222122.GA9228@00110101.errordevlopment.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E158248D2
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 00:19:47 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so817161ugf
	for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2007 15:19:45 -0700 (PDT)
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Description: bug report
Content-Disposition: inline

Hello.

i'm using RME Hammerfall HDSP9632..
it worked fine with 2.6.17 and 2.6.20 (-gentoo), i don't think gentoo
team modifies alsa tree ..

as soon as i upgraded to 2.6.22[-gentoo-r8], it booted fine, but when i
started gnome-settigs-daemon, kernell generated OOPS, and i couldn't
inload the module with modprobe.

i disabled gnome-settings-daemon, and reboot.
i managed to use hdspconf , hdspmixer + a couple of applications
(puredata and snd editor), it was all good.
as soon as i ran alsamixer (well , normaly you don't need it for
snd-hdsp, but i wanted to configure my second soundcard, which is
SB_live, but forgot to give it '-c 1') - so here the same crash heppends.

i tried 2.6.20 back - and all absolutely fine with it.

looking at hdsp.c in both kernels i spoted quite a few changes , however
i don't know much about it ;[

so i attached the details below.

-- 
cheers,
ilya .d

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="snd-hdsp@linux-2.6.22-gentoo-r8-111"

Linux 00110101 2.6.20-gentoo-r8-111 #7 SMP PREEMPT Wed Aug 29 23:56:20
UTC 2007 x86_64 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
AuthenticAMD GNU/Linux

gcc (GCC) 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.10)

----------------------------------------------------------------------

Oct 13 01:28:46 00110101 [ 9156.032955] divide error: 0000 [1] PREEMPT SMP 
Oct 13 01:28:46 00110101 [ 9156.032962] CPU 1 
Oct 13 01:28:46 00110101 [ 9156.032964] Modules linked in: radeon snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_m
idi_emul snd_seq_midi snd_seq_midi_event snd_seq snd_emu10k1 snd_ac97_codec snd_util_mem snd_hdsp snd_rawmidi snd_seq_device
 snd_pcm snd_timer snd_page_alloc snd_hwdep snd reiser4 ipv6 ohci1394 ieee1394 capability commoncap softdog raid0 pcspkr rtc
 _cmos rtc_core rtc_lib force
 deth floppy serio_raw ac97_bus analog radeonfb fb fb_ddc backlight i2c_algo_bit cfbcopyarea cfbimgblt cfbfillrect parport_pc parport emu10k1_gp gameport
 Oct 13 01:28:46 00110101 [ 9156.033000] Pid: 8942, comm: alsamixer Not tainted 2.6.22-gentoo-r8-111 #2
 Oct 13 01:28:46 00110101 [ 9156.033004] RIP: 0010:[<ffffffff880b96e4>]  [<ffffffff880b96e4>] :snd_hdsp:hdsp_dds_offset+0x1f/0x47
 Oct 13 01:28:46 00110101 [ 9156.033020] RSP: 0018:ffff810035c59d48  EFLAGS: 00010246
 Oct 13 01:28:46 00110101 [ 9156.033023] RAX: 00005f5e10000000 RBX: 0000000000000000 RCX: 00005f5e10000000
 Oct 13 01:28:46 00110101 [ 9156.033027] RDX: 0000000000000000 RSI: 000000000000ac44 RDI: ffff81003da80278
 Oct 13 01:28:46 00110101 [ 9156.033030] RBP: 00000000fffffff3 R08: ffff810038827cc0 R09: 0000000000000000
 Oct 13 01:28:46 00110101 [ 9156.033034] R10: 0000000000000000 R11: 0000000000000246 R12: ffff81003da80000
 Oct 13 01:28:46 00110101 [ 9156.033038] R13: 00007fffdf41ece0 R14: ffff81003da80000 R15: ffff8100381ce900
 Oct 13 01:28:46 00110101 [ 9156.033042] FS:  00002abfcc0a22b0(0000) GS:ffff81003ffdd080(0000) knlGS:0000000000000000
 Oct 13 01:28:46 00110101 [ 9156.033046] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
 Oct 13 01:28:46 00110101 [ 9156.033049] CR2: 0000000000523048 CR3: 0000000038b8f000 CR4: 00000000000006e0
 Oct 13 01:28:46 00110101 [ 9156.033053] Process alsamixer (pid: 8942, threadinfo ffff810035c58000, task ffff810005805500)
 Oct 13 01:28:46 00110101 [ 9156.033056] Stack:  ffff810018668000 ffffffff880b973d ffff810018668000 ffffffff88067510
 Oct 13 01:28:46 00110101 [ 9156.033064]  0000000000000000 ffff810018668000 ffff81003da80218 ffffffff88067f57
 Oct 13 01:28:46 00110101 [ 9156.033070]  000000020000001e 0000000000000000 706d615320534444 206574615220656c
 Oct 13 01:28:46 00110101 [ 9156.033075] Call Trace:
 Oct 13 01:28:46 00110101 [ 9156.033085]  [<ffffffff880b973d>] :snd_hdsp:snd_hdsp_get_dds_offset+0x10/0x17
 Oct 13 01:28:46 00110101 [ 9156.033102]  [<ffffffff88067510>] :snd:snd_ctl_elem_read+0x95/0xb0
 Oct 13 01:28:46 00110101 [ 9156.033115]  [<ffffffff88067f57>] :snd:snd_ctl_ioctl+0x355/0x76c
 Oct 13 01:28:46 00110101 [ 9156.033135]  [<ffffffff8028ba5f>] do_ioctl+0x2f/0xb2
 Oct 13 01:28:46 00110101 [ 9156.033140]  [<ffffffff8028bd38>] vfs_ioctl+0x256/0x267
 Oct 13 01:28:46 00110101 [ 9156.033147]  [<ffffffff8028bda2>] sys_ioctl+0x59/0x7b
 Oct 13 01:28:46 00110101 [ 9156.033153]  [<ffffffff80209bee>] system_call+0x7e/0x83
 Oct 13 01:28:46 00110101 [ 9156.033160] 
 Oct 13 01:28:46 00110101 [ 9156.033161] 
 Oct 13 01:28:46 00110101 [ 9156.033162] Code: 48 f7 f3 81 fe 7f b5 01 00 48 89 c1 7e 06 48 c1 e1 02 eb 0e 
 Oct 13 01:28:46 00110101 [ 9156.033174] RIP  [<ffffffff880b96e4>] :snd_hdsp:hdsp_dds_offset+0x1f/0x47
 Oct 13 01:28:46 00110101 [ 9156.033184]  RSP <ffff810035c59d48>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--7JfCtLOvnd9MIVvH--
