From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000695]: Turning off Audigy 2 NX makes keyboard unusable
Date: Sat, 11 Dec 2004 08:41:00 +0100
Message-ID: <15b31b10db3902fafe4c87431f5d7476@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 924B0374
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2004 08:41:00 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=695> 
======================================================================
Reported By:                jk
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   695
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.10-rc2-mm4
======================================================================
Date Submitted:             12-01-2004 12:59 CET
Last Modified:              12-11-2004 08:40 CET
======================================================================
Summary:                    Turning off Audigy 2 NX makes keyboard unusable
Description: 
If I turn off my Audigy 2 NX, my USB keyboard no longer works under X.  The
mouse plugged into the keyboard's hub still works.  dmesg doesn't show
anything suspicous at this point but after stopping X I get the following
oops:

Oops: Kernel access of bad area, sig: 11
[https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
SMP NR_CPUS=2 POWERMAC
NIP: C0000000001CE448 XER: 0000000020000000 LR: C0000000001C7C30
REGS: c00000000ff97230 TRAP: 0300   Not tainted  (2.6.10-rc2-mm4jk1)
MSR: 9000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000000000, DSISR: 0000000040000000
TASK: c00000000ffce030[7] 'events/1' THREAD: c00000000ff94000 CPU: 1
GPR00: C000000000221430 C00000000FF974B0 C00000000055B1A0
0000000000000000
GPR04: FFFFFFFFFFFFFFFF C0000000014EAEB0 000000000000001A
C00000000FEC4058
GPR08: 00000000000003A8 C00000000053E3C8 FFFFFFFFFFFFFFFF
0000000000000000
GPR12: 0000000022008042 C000000000461500 0000000000000000
0000000000000000
GPR16: 0000000001400000 C0000000004068D8 0000000001803C18
0000000001803C18
GPR20: C000000000488360 C00000000FF975D4 0000000000000000
C00000000FEC4058
GPR24: 00000000000003A8 C0000000014EAD98 00000000000000D0
C00000000FEC4130
GPR28: 0000000000000001 C00000000FEC4130 C0000000004E7340
C00000000FF974B0
NIP [c0000000001ce448] .strlen+0x4/0x18
LR [c0000000001c7c30] .kobject_get_path+0x44/0x11c
Call Trace:
[c00000000ff974b0] [c00000000ff97500] 0xc00000000ff97500 (unreliable)
[c00000000ff97560] [c000000000221430] .class_hotplug+0xe4/0x24c
[c00000000ff97640] [c0000000001c9194] .kobject_hotplug+0x34c/0x38c
[c00000000ff97730] [c0000000001c81b8] .kobject_del+0x28/0x58
[c00000000ff977c0] [c000000000221b84] .class_device_del+0x1ac/0x240
[c00000000ff97880] [c000000000221c3c] .class_device_unregister+0x24/0x44
[c00000000ff97910] [c000000000222534]
.class_simple_device_remove+0x104/0x128
[c00000000ff979a0] [d00000000003ca28] .snd_unregister_device+0x174/0x1d8
[snd]
[c00000000ff97a40] [d00000000008543c] .snd_pcm_dev_unregister+0xb4/0x208
[snd_pcm]
[c00000000ff97af0] [d000000000044ea4] .snd_device_free+0x140/0x224 [snd]
[c00000000ff97b80] [d000000000045540] .snd_device_free_all+0xb8/0x10c
[snd]
[c00000000ff97c20] [d00000000003d3c8] .snd_card_free+0xa0/0x36c [snd]
[c00000000ff97d20] [d00000000003d748] .snd_card_free_thread+0xb4/0x170
[snd]
[c00000000ff97db0] [c00000000005a4c0] .worker_thread+0x258/0x324
[c00000000ff97ee0] [c0000000000613dc] .kthread+0x168/0x1bc
[c00000000ff97f90] [c000000000013500] .kernel_thread+0x4c/0x6c

======================================================================

----------------------------------------------------------------------
 suamor - 12-11-04 08:40 
----------------------------------------------------------------------
I can confirm this problem. I have a Mandrake 10.1 system with Kernel
2.6.8.1. The bug happens on both the alsa from the kernel itself (1.6.0)
and with the current version. Also when shutting down X the keyboard
sometimes works on the console.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 12:59 jk             New Issue                                    
12-01-04 12:59 jk             Distribution              => Debian unstable 
12-01-04 12:59 jk             Kernel Version            => 2.6.10-rc2-mm4  
12-11-04 08:40 suamor         Note Added: 0002810                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
