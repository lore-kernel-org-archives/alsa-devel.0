From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000869]: alsa-oss-1.0.8rc1 can't find module linkages
Date: Mon, 31 Jan 2005 18:30:56 +0100
Message-ID: <4605fa88ad522cd3dc5860dfc6bd685d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 305CF21C
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 18:30:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=869> 
======================================================================
Reported By:                lovett
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   869
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-31-2005 18:30 CET
Last Modified:              01-31-2005 18:30 CET
======================================================================
Summary:                    alsa-oss-1.0.8rc1 can't find module linkages
Description: 
alsa-driver-1.0.8rc1 | alsa-lib-1.0.8rc1 | alsa-utils-1.0.8rc1
alsa-oss-1.0.8rc1 all compiled from source and installed without
fatal compliant.

Booting enters this error into syslog
	kernel: Error seeking in /dev/kmem 
	kernel: Symbol #snd-page-alloc, value 002c4000 
	kernel: Error adding kernel module table entry.
	modprobe: modprobe: Can't locate module snd-seq-client-62
	
Now invoking the most recent TiMidity gives an error message:
	# /usr/local/bin/timidity -p64:0 file.mid   -->
Requested buffer size 32768, fragment size 8192
ALSA pcm 'default' can't set hw_params

Now invoking aplaymidi runs in the sense that CPU cycles are
consumed, but no sound is produced and syslog reports (several times)
	# aplaymidi -p65:0 file.mid   -->
	kernel: ALSA pcm_oss.c:450: HW_PARAMS failed: -12

How should I go about finding what is missing?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 18:30 lovett         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
