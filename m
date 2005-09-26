From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001461]: Kernel oops with 32bit compatibility emulation and Sun JDK5.0 32bit version
Date: Mon, 26 Sep 2005 16:13:34 +0200
Message-ID: <22fd5e277435616058b70d74c4360283@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54D1F13B
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 16:13:34 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1461> 
======================================================================
Reported By:                mador
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1461
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1456_FC4smp #1 SMP Thu Sep 22 02:23:57 EDT
2005 x86_64 x86_64 x86_64 GNU/Linux
======================================================================
Date Submitted:             09-26-2005 16:13 CEST
Last Modified:              09-26-2005 16:13 CEST
======================================================================
Summary:                    Kernel oops with 32bit compatibility emulation and
Sun JDK5.0 32bit version
Description: 
When using the Sun's JDK5.0 32bit version on my SMP 64bit enabled kernel I
get the following OOPS:
Sep 26 15:21:45 naima kernel: divide error: 0000 [1] SMP
Sep 26 15:21:45 naima kernel: CPU 0
Sep 26 15:21:45 naima kernel: Modules linked in: fglrx(U) nfs lockd
parport_pc lp parport autofs4 i2c_dev i2c_core sunrpc pcmcia yenta_socket
rsrc_nonstatic pcmcia_core vfat fat ext3 jbd video button battery ac md5
ipv6 usb_storage ohci1394 ieee1394 uhci_hcd ehci_hcd hw_random
snd_hda_intel(U) snd_hda_codec(U) snd_seq_dummy(U) snd_seq_oss(U)
snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U)
snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd(U) soundcore
snd_page_alloc(U) e100 mii dm_snapshot dm_zero dm_mirror reiserfs dm_mod
ahci libata sd_mod scsi_mod
Sep 26 15:21:45 naima kernel: Pid: 4712, comm: java Tainted: P     
2.6.12-1.1456_FC4smp
Sep 26 15:21:45 naima kernel: RIP: 0010:[<ffffffff880ef59c>]
<ffffffff880ef59c>{:snd_pcm:snd_pcm_ioctl_compat+1391}
Sep 26 15:21:45 naima kernel: RSP: 0018:ffff810019ebde08  EFLAGS:
00010046
Sep 26 15:21:45 naima kernel: RAX: 0000000000000000 RBX: 0000000000000000
RCX: 0000000000000001
Sep 26 15:21:45 naima kernel: RDX: 0000000000000000 RSI: 00000000c0844123
RDI: ffff81003e365ac8
Sep 26 15:21:45 naima kernel: RBP: 00000000ffff93c8 R08: ffff810019ebc000
R09: 00000000ffff9464
Sep 26 15:21:45 naima kernel: R10: 0000000000000000 R11: 0000000000000000
R12: ffff81003e365ac8
Sep 26 15:21:45 naima kernel: R13: 0000000000000000 R14: ffff8100140c2000
R15: 0000000000000000
Sep 26 15:21:45 naima kernel: FS:  0000000000000000(0000)
GS:ffffffff804e7e80(0063) knlGS:00000000f7fd2ba0
Sep 26 15:21:45 naima kernel: CS:  0010 DS: 002b ES: 002b CR0:
000000008005003b
Sep 26 15:21:45 naima kernel: CR2: 00000000d0d62b50 CR3: 0000000014843000
CR4: 00000000000006e0
Sep 26 15:21:45 naima kernel: Process java (pid: 4712, threadinfo
ffff810019ebc000, task ffff810010437800)
Sep 26 15:21:45 naima kernel: Stack: ffff81003ece44c0 00000000ffff9410
ffff81003e365ac8 00000000ffff940c
Sep 26 15:21:45 naima kernel:        0000000000000001 0000000000000000
0000000000000000 ffff810011ef1840
Sep 26 15:21:45 naima kernel:        ffff81003ece4538 0000000000000001
Sep 26 15:21:45 naima kernel: Call
Trace:<ffffffff80171a62>{do_mmap_pgoff+1870}
<ffffffff8015b2b0>{audit_syscall_entry+309}
Sep 26 15:21:46 naima kernel:       
<ffffffff801a5f1c>{compat_sys_ioctl+216}
<ffffffff80111560>{syscall_trace_enter+172}
Sep 26 15:21:46 naima kernel:       
<ffffffff8012412b>{sysenter_do_call+27}
Sep 26 15:21:46 naima kernel:
Sep 26 15:21:46 naima kernel: Code: 49 f7 f5 49 89 d4 4d 8b 7e 18 4d 8b 6e
10 45 8b 76 20 48 8b
Sep 26 15:21:46 naima kernel: RIP
<ffffffff880ef59c>{:snd_pcm:snd_pcm_ioctl_compat+1391} RSP
<ffff810019ebde08>
Sep 26 15:21:46 naima kernel:  <3>Debug: sleeping function called from
invalid context at include/linux/rwsem.h:43
Sep 26 15:21:46 naima kernel: in_atomic():0, irqs_disabled():1
Sep 26 15:21:46 naima kernel:
Sep 26 15:21:46 naima kernel: Call
Trace:<ffffffff8013789a>{profile_task_exit+21}
<ffffffff80138a66>{do_exit+34}
Sep 26 15:21:46 naima kernel:       
<ffffffff8024c12f>{do_unblank_screen+137}
<ffffffff80110213>{default_do_nmi+0}
Sep 26 15:21:46 naima kernel:       
<ffffffff80110ddc>{do_divide_error+160}
<ffffffff880ef59c>{:snd_pcm:snd_pcm_ioctl_compat+1391}
Sep 26 15:21:46 naima kernel:        <ffffffff8032d09c>{io_schedule+49}
<ffffffff8032d884>{__wait_on_bit_lock+99}
Sep 26 15:21:46 naima kernel:        <ffffffff8010f25d>{error_exit+0}
<ffffffff880ef59c>{:snd_pcm:snd_pcm_ioctl_compat+1391}
Sep 26 15:21:46 naima kernel:       
<ffffffff880ef555>{:snd_pcm:snd_pcm_ioctl_compat+1320}
Sep 26 15:21:46 naima kernel:       
<ffffffff80171a62>{do_mmap_pgoff+1870}
<ffffffff8015b2b0>{audit_syscall_entry+309}
Sep 26 15:21:46 naima kernel:       
<ffffffff801a5f1c>{compat_sys_ioctl+216}
<ffffffff80111560>{syscall_trace_enter+172}
Sep 26 15:21:46 naima kernel:       
<ffffffff8012412b>{sysenter_do_call+27}

I don't have problems with J2SDK1.4.2 which is available only in 32bit
version for my processor (Intel EM64T). And neither with JDK5.0 in X86_64
compiled version. I need instead the 32bit version in order to run applets
in browsers. But slideshows with sound implemented as applets lock
completely the window and the process after throwing the kernel OOPS. The
other processes still work but the sound is dead.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 16:13 mador          New Issue                                    
09-26-05 16:13 mador          Distribution              => Fedora Core 4   
09-26-05 16:13 mador          Kernel Version            => 2.6.12-1.1456_FC4smp
#1 SMP Thu Sep 22 02:23:57 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
