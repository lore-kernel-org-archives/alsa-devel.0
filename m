From: noreply@alsa-project.org
Subject: [ALSA - driver 0000192]: kernel oops on resume from sleep (ppc iBook G3)
Date: Fri, 16 Jul 2004 12:52:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105233.F05F626008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3536019A
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:52:34 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000192
======================================================================
Reported By:                kpiris
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     192
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian sid
Kernel Version:             vanilla 2.6.5 +laptop-mode patch
======================================================================
Date Submitted:             04-06-2004 14:18 CEST
Last Modified:              07-16-2004 12:52 CEST
======================================================================
Summary:                    kernel oops on resume from sleep (ppc iBook G3)
Description: 
When resuming my iBook G3 (PowerPC) from sleep, having alsa loaded I get
the following kernel oops (oops text copied by hand, could have made
mistakes typing):

---8<---
Oops: kernel access of bad area, sig: 11 [https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001]
NIP: DA378C3C LR: DA468E0C SP: D4F13D70 REGS: d4f13cc0 TRAP: 0301    Not
tainted
MSR: 0000b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
DAR: 00000006, DSISR: 40000000
TASK = d74920c0[1233] 'pmud' Last syscall: 54
GPR00: DA468E0C D4F13D70 D74920C0 00000000 00000040 00000000 00000000
00000040
GPR08: 00000002 FFFFFFFF D74920C0 00000000 2DE985CF
Call trace:
 [da468e0c] snapper_set_capture_source+0x28/0x38 [snd_powermac]
 [da46936c] tumbler_resume+0xa0/0x138 [snd_powermac]
 [da466318] snd_pmac_resume+0xf4/0xf8 [snd_powermac]
 [da466364] snd_pmac_sleep_notify+0x48/0x54 [snd_powermac]
 [c030788c] 0xc030788c
 [c0307fe0] 0xc0307fe0
 [c03084c4] 0xc03084c4
 [c0308d2c] 0xc0308d2c
 [c0067c04] sys_ioctl+0xdc/0x2f4
 [c0007600] ret_from_syscall+0x0/0x44
--->8---

If I suspend it having unloaded alsa, it resumes ok.
======================================================================

----------------------------------------------------------------------
 kpiris - 04-21-2004 14:00 CEST 
----------------------------------------------------------------------
After someone pointed me this:

http://lists.debian.org/debian-powerpc/2004/debian-powerpc-200404/msg00482.html

I tried it and now I don't get the oops. I suspect it could be related to
that: "trying to access mixer too early after wakeup". The question is
that now it does not crash:

http://lists.debian.org/debian-powerpc/2004/debian-powerpc-200404/msg00496.html

I've suspended and waked it up about a dozen of times and now it works
fine.

If it is this, the bug could be still there (or not). So, if you want to
close the bug I'll be fine with it. If I can provide any additional
information, please let me know.

Thanks.

-- 
Kiko

----------------------------------------------------------------------
 obi_wan - 04-21-2004 23:00 CEST 
----------------------------------------------------------------------
I generally read debianppc and see people complaining about this problem a
lot, since I have patched it in mandrakes ppc kernel I might as well post
it here.

I mailed a bit with Takashi and we are trying to fix it in a less ugly
way, but for now, this at least works.

Kiko, perhaps forward this to debianppc.

It also fixes the mixer errors (requiring you to restart alsa).

d.

----------------------------------------------------------------------
 kpiris - 04-22-2004 13:10 CEST 
----------------------------------------------------------------------
Thanks for your reply obi_wan,

sorry for the late reply, I cannot open alsa bugtracking page from home
(might be an issue with the fu%$#&% transparent proxy of my isp). From my
office I can access here w/o problems

%-)

I will try this patch this afternoon and post it to debian-ppc if it
causes me no problems.

Many thanks for now.

-- 
Kiko

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:10 CEST 
----------------------------------------------------------------------
the patch is now on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-06-04 14:18 kpiris         New Bug                                      
04-06-04 14:18 kpiris         Distribution              => Debian sid      
04-06-04 14:18 kpiris         Kernel Version            => vanilla 2.6.5 +laptop-mode patch
04-06-04 14:22 kpiris         Bugnote Added: 0000757                       
04-06-04 14:45 kpiris         Bugnote Deleted: 0000757                     
04-21-04 14:00 kpiris         Bugnote Added: 0000891                       
04-21-04 23:00 obi_wan        Bugnote Added: 0000892                       
04-21-04 23:00 obi_wan        File Added: PP30_tumbler.patch                    
04-22-04 13:10 kpiris         Bugnote Added: 0000893                       
04-23-04 17:10 tiwai          Bugnote Added: 0000899                       
04-23-04 17:10 tiwai          Resolution               open => fixed       
04-23-04 17:10 tiwai          Status                   assigned => resolved
07-16-04 12:52 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
