From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001382]: audio stuttered when playing DVD/VCD using xine
Date: Fri, 2 Sep 2005 19:39:28 +0200
Message-ID: <d72feff4a9b6656b449523098a0a2045@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A284F175
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 19:39:28 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             08-31-2005 10:20 CEST
Last Modified:              09-02-2005 19:39 CEST
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
09-02-05 19:39 tiwai          Status                   assigned => resolved
09-02-05 19:39 tiwai          Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
