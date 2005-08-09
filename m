From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000215]: Kernel freezes after an hour when using the powermac driver
Date: Tue, 9 Aug 2005 13:19:43 +0200
Message-ID: <5f2d514c5645134f8754493e546ba468@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA5EA19C
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:19:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=215> 
======================================================================
Reported By:                sjoyeux
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   215
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-16-2004 10:01 CEST
Last Modified:              08-09-2005 13:19 CEST
======================================================================
Summary:                    Kernel freezes after an hour when using the powermac
driver
Description: 
I have an ibook G4 and using alsa freezes the system (I have about 1 hr of
uptime when I'm listening to music, no problem when not using the
soundcard). 

I'm using the OSS driver now, as it does not show the problem.

I experienced it on every 2.4 and 2.6 kernel I used. I'm using now vanilla
2.6.5, without any patch, and with preempt disabled. No trace of a kernel
panic in the logs.

Tell me if I can do anything to provide more useful informations
======================================================================

----------------------------------------------------------------------
 perex - 08-09-05 13:11 
----------------------------------------------------------------------
reported: could you test the latest kernel and ALSA?

----------------------------------------------------------------------
 sjoyeux - 08-09-05 13:19 
----------------------------------------------------------------------
Fixex in latest kernels. Sorry I did not reported that earlier.
Btw, isn't there a way to change the status myself ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-04 10:01 sjoyeux        New Issue                                    
04-16-04 10:01 sjoyeux        Distribution              => Debian unstable 
04-16-04 10:01 sjoyeux        Kernel Version            => 2.6.5           
08-09-05 13:11 perex          Note Added: 0005728                          
08-09-05 13:19 sjoyeux        Note Added: 0005730                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
