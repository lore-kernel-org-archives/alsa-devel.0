From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000626]: Oops on cat /dev/urandom > /dev/dsp
Date: Wed, 3 Nov 2004 15:14:20 +0100
Message-ID: <f0106315ddc4031023b4d9465b8cfc79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E699F2BB
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 15:14:20 +0100 (MET)
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
Last Modified:              11-03-2004 15:14 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 15:14 Luke-Jr        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
