From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000866]: Can not install snd-intel8x0
Date: Mon, 31 Jan 2005 05:30:14 +0100
Message-ID: <bc3225e96478f445d349483806a4c306@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 194581DA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 05:30:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=866> 
======================================================================
Reported By:                ghostdaemon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   866
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-31-2005 05:30 CET
Last Modified:              01-31-2005 05:30 CET
======================================================================
Summary:                    Can not install snd-intel8x0
Description: 
I have to use Redhat Linux 7.3.I have  tried ALSA 1.0.8 and 0.9.6,but they
all failed .when i extact driver package to ./config;make;make install
,some errors infomation displayed.such as:
 unresolved symbol fasync_helper_Rsmp_0f820065
 unresolved symbol proc_symlink_Rsmp_515b8074
 ...........
 ...........

when i use modpobe command:
[root@localhost root]# modprobe snd-intel8x0
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
fasync_helper_Rsmp_0f820065
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
proc_symlink_Rsmp_515b8074
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
remove_proc_entry_Rsmp_18199406
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
kill_fasync_Rsmp_f866c12a
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
proc_root_Rsmp_c79b35f0
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
register_chrdev_Rsmp_10735b95
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
create_proc_entry_Rsmp_9cfe096c
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
register_sound_special_Rsmp_3a650025
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
remove_wait_queue_Rsmp_ca8842ea
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
add_wait_queue_Rsmp_2fd0ca84
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: unresolved symbol
__pollwait_Rsmp_4c541ea9
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: insmod
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o failed
/lib/modules/2.4.18-3smp/kernel/sound/acore/snd.o: insmod snd-intel8x0
failed
[root@localhost root]#

My Motherboard is ASUS P4P800, AD1985 integrated on it.

Many thanks !


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 05:30 ghostdaemon    New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
