From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001382]: audio stuttered when playing DVD/VCD using xine
Date: Wed, 31 Aug 2005 12:15:09 +0200
Message-ID: <0cedf09b0a2a7e0e6796435be90a68d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F8AF208
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 12:15:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1382> 
======================================================================
Reported By:                zhllg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1382
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-31-2005 10:20 CEST
Last Modified:              08-31-2005 12:15 CEST
======================================================================
Summary:                    audio stuttered when playing DVD/VCD using xine
Description: 
The motherboard is intel D945GTP
Other application works well, like mplayer
but audio will stutter when playing DVD/VCD using xine
The symptom is one second's audio in the movie will be played for several
times consecutively, before next sec's sound can be played. Then the same
happened to the audio of next sec.
What could be the cause?
======================================================================

----------------------------------------------------------------------
 zhllg - 08-31-05 10:30 
----------------------------------------------------------------------
Correction:
mplayer just work well for a little while, then similar problem occurs,
too

----------------------------------------------------------------------
 zhllg - 08-31-05 12:15 
----------------------------------------------------------------------
solved
just enable APIC in the kernel

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 10:20 zhllg          New Issue                                    
08-31-05 10:30 zhllg          Note Added: 0005985                          
08-31-05 10:42 zhllg          Issue Monitored: zhllg                       
08-31-05 12:15 zhllg          Note Added: 0005987                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
