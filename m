From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001515]: snd_ali5451 soft lockup [regression]
Date: Sat, 19 Nov 2005 00:38:06 +0100
Message-ID: <41cdd69676eccf0fff78ac87780e3108@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4E608187
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 00:38:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1515> 
======================================================================
Reported By:                roucariesbastien
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1515
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.14
======================================================================
Date Submitted:             10-30-2005 19:20 CET
Last Modified:              11-19-2005 00:38 CET
======================================================================
Summary:                    snd_ali5451 soft lockup [regression]
Description: 
Snd_ali5451 oops on loading and obviously no sound. It is a regression
2.6.10 vanilla
work.

ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNK7] -> GSI 11 (level, low)
-> IRQ 11
BUG: soft lockup detected on CPU#0!

Pid: 7750, comm:             modprobe
EIP: 0060:[<dccbe031>] CPU: 0
EIP is at snd_ali_codec_ready+0x31/0x90 [snd_ali5451]
 EFLAGS: 00000212    Not tainted  (2.6.14-1-686)
EAX: 5374807e EBX: 5374807e ECX: 00008800 EDX: 00008840
ESI: 0006abe9 EDI: c3366000 EBP: 00000040 DS: 007b ES: 007b
CR0: 8005003b CR2: b7e40430 CR3: 03328000 CR4: 000006d0
 [<dccbe2a8>] snd_ali_codec_peek+0xb8/0xf0 [snd_ali5451]
 [<dccbe353>] snd_ali_codec_read+0x23/0x30 [snd_ali5451]
 [<dcf22235>] snd_ac97_read+0x35/0x50 [snd_ac97_codec]
 [<dcf29c91>] patch_ad1881_chained1+0x71/0x100 [snd_ac97_codec]
 [<dcf29e85>] patch_ad1881_chained+0x165/0x1a0 [snd_ac97_codec]
 [<dcf2a057>] patch_ad1881+0x197/0x1e0 [snd_ac97_codec]
 [<dcf2a3b0>] patch_ad1981b+0x10/0x50 [snd_ac97_codec]
 [<dcf2574e>] snd_ac97_mixer+0x2ee/0xc90 [snd_ac97_codec]
 [<dcc729d4>] snd_info_register+0x34/0xa0 [snd]
 [<c01492cf>] kzalloc+0x1f/0x50
 [<dcc7568d>] snd_device_new+0x1d/0x70 [snd]
 [<dcf25338>] snd_ac97_bus+0x78/0xb0 [snd_ac97_codec]
 [<dccc00cd>] snd_ali_mixer+0xed/0x120 [snd_ali5451]
 [<dccbffc0>] snd_ali_mixer_free_ac97+0x0/0x20 [snd_ali5451]
 [<dccc0bdf>] snd_ali_probe+0xcf/0x170 [snd_ali5451]
 [<c01da326>] pci_match_device+0x26/0xc0
 [<c01da436>] __pci_device_probe+0x56/0x70
 [<c01da47f>] pci_device_probe+0x2f/0x50
 [<c0231fa3>] driver_probe_device+0x43/0xd0
 [<c02320b0>] __driver_attach+0x0/0x50
 [<c02320f1>] __driver_attach+0x41/0x50
 [<c02314dd>] bus_for_each_dev+0x5d/0x80
 [<c0232125>] driver_attach+0x25/0x30
 [<c02320b0>] __driver_attach+0x0/0x50
 [<c0231a39>] bus_add_driver+0x89/0xf0
 [<c01da6f2>] pci_register_driver+0x62/0x90
 [<dcc5200f>] alsa_card_ali_init+0xf/0x11 [snd_ali5451]
 [<c01371d1>] sys_init_module+0xc1/0x1a0
 [<c01030b5>] syscall_call+0x7/0xb
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
ali mixer 1 creating error.


lspci output:

0000:00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 02)
        Subsystem: Sony Corporation: Unknown device 8158
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort-<MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at e0401000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 9
cpu MHz         : 332.224
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5318.81

======================================================================

----------------------------------------------------------------------
 roucariesbastien - 11-19-05 00:38 
----------------------------------------------------------------------
Could you close please Solved on lkml

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 19:20 roucariesbastienNew Issue                                    
10-30-05 19:20 roucariesbastienDistribution              => debian          
10-30-05 19:20 roucariesbastienKernel Version            => 2.6.14          
11-19-05 00:34 roucariesbastienIssue Monitored: roucariesbastien                
   
11-19-05 00:36 roucariesbastienIssue End Monitor: roucariesbastien              
     
11-19-05 00:38 roucariesbastienNote Added: 0006759                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
