From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000869]: alsa-oss-1.0.8rc1 can't find module linkages
Date: Wed, 13 Apr 2005 17:18:07 +0200
Message-ID: <ed57770456b30dd2b8ed3027a1ea7500@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3AE33254
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 17:18:08 +0200 (MEST)
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
Last Modified:              04-13-2005 17:18 CEST
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

----------------------------------------------------------------------
 jdthood - 04-13-05 17:18 
----------------------------------------------------------------------
Submitter: Do you see the same problem in 1.0.8 and 1.0.9rc2?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 18:30 lovett         New Issue                                    
04-13-05 17:18 jdthood        Note Added: 0004472                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
