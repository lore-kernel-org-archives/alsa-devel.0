From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000626]: Oops on cat /dev/urandom > /dev/dsp
Date: Tue, 9 Nov 2004 19:41:48 +0100
Message-ID: <d05fcfee8876b5114a4ecbf3539f95ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 044C12B4
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 19:41:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=626> 
======================================================================
Reported By:                Luke-Jr
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   626
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-03-2004 15:14 CET
Last Modified:              11-09-2004 19:41 CET
======================================================================
Summary:                    Oops on cat /dev/urandom > /dev/dsp
Description: 
Oops: kernel access of bad area, sig: 11
[https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
NIP: D253BD20 LR: D253C634 SP: CE547DB0 REGS: ce547d00 TRAP: 0300    Not
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: D254203C, DSISR: 40000000
TASK = c07c77d0[7282] 'cat' THREAD: ce546000Last syscall: 4
GPR00: 000007FC CE547DB0 C07C77D0 CF7B7B40 CFC38980 C063C8E0 00000200
00000B03
GPR08: 00000001 D2541840 000007FC D2541880 CF7B7B24 1001C140 00000000
00000000
GPR16: 00000001 CFC38980 C063C8E0 00000000 00000000 10015080 00000001
00000000
GPR24: 00000000 CFC400A0 CFC38980 D253BCD8 CFC38980 CF7B7BB0 CF7B7B40
00000B03
NIP [d253bd20] resample_expand+0x48/0x3a8 [snd_pcm_oss]
LR [d253c634] rate_transfer+0x7c/0x98 [snd_pcm_oss]
Call trace:
 [d253c634] rate_transfer+0x7c/0x98 [snd_pcm_oss]
 [d2539020] snd_pcm_plug_write_transfer+0x1cc/0x2a0 [snd_pcm_oss]
 [d2534518] snd_pcm_oss_write2+0xb4/0x12c [snd_pcm_oss]
 [d2536c94] snd_pcm_oss_write+0x220/0x26c [snd_pcm_oss]
 [c0058320] vfs_write+0x114/0x13c
 [c0058424] sys_write+0x4c/0x90
 [c00063a0] ret_from_syscall+0x0/0x44

======================================================================

----------------------------------------------------------------------
 Luke-Jr - 11-09-04 19:22 
----------------------------------------------------------------------
gcc (GCC) 3.4.1 20040803 (Gentoo Linux 3.4.1-r3, ssp-3.4-2, pie-8.7.6.5)

----------------------------------------------------------------------
 tiwai - 11-09-04 19:41 
----------------------------------------------------------------------
Could you try to comiple with the frame pointer?
It's just to be sure, since the similar bug was fixed (avoided) by
compiling with the frame pointer....

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 15:14 Luke-Jr        New Issue                                    
11-09-04 18:51 tiwai          Note Added: 0002334                          
11-09-04 19:22 Luke-Jr        Note Added: 0002345                          
11-09-04 19:41 tiwai          Note Added: 0002349                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
