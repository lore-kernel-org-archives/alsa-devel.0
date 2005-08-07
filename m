From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001318]: Volume control per PCM
Date: Sun, 7 Aug 2005 14:45:14 +0200
Message-ID: <5eb348acc72701bb312d9d6159d21c88@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A6A63217
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 14:45:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1318> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1318
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-07-2005 14:45 CEST
Last Modified:              08-07-2005 14:45 CEST
======================================================================
Summary:                    Volume control per PCM
Description: 
Hi, i'm trying to implement a volume control per PCM streams, i've attached
a function that does the job. Unfortunally when it change the volume it
also change the equalizer cutting off low frequencyes. I think 
there is a problem with the second poke, infact withot that poke, the
volume works correctly for left case. Any suggestion? Any documentation?
Thanks,
   Dino

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-07-05 14:45 darkbrain      New Issue                                    
08-07-05 14:45 darkbrain      File Added: volume.c                         
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
