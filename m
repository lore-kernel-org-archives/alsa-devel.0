From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000314]: Sound too fast, sometimes sound crackles
Date: Tue, 30 Aug 2005 12:21:34 +0200
Message-ID: <e4afe7a12f200b86986c7b77c6b940a5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8B2BF1C7
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:21:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=314> 
======================================================================
Reported By:                vikkk
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   314
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Archlinux
Kernel Version:             2.6.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-30-2004 09:49 CEST
Last Modified:              08-30-2005 12:21 CEST
======================================================================
Summary:                    Sound too fast, sometimes sound crackles
Description: 
Randomly the sound plays too fast, up to a few times faster than it should.
Sometimes there's also noise and stuff in the background. 

Also: If who applications tries to play a sound at the same time the
entire system crashes. I've tried several applications and the same things
happens.
======================================================================

----------------------------------------------------------------------
 mjander - 05-30-04 18:54 
----------------------------------------------------------------------
This bug is very well known, and was fixed a long time ago. Next time
reporting a bug, please make sure that the bug has not been fixed before.
The current ALSA driver tarball contains the bug fix, but as usual it will
take some time until Linus' kernel tree catches up with these changes.

Apply the attached patch and try again.

Best Regards

Manuel Jander

----------------------------------------------------------------------
 jdthood - 08-30-05 12:21 
----------------------------------------------------------------------
Reported fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-04 09:49 vikkk          New Issue                                    
05-30-04 09:49 vikkk          Distribution              => Archlinux       
05-30-04 09:49 vikkk          Kernel Version            => 2.6.6           
05-30-04 18:51 mjander        File Added: aureal-2.6.6.diff.gz                  
 
05-30-04 18:54 mjander        Note Added: 0001278                          
08-30-05 12:21 jdthood        Status                   assigned => resolved
08-30-05 12:21 jdthood        Resolution               open => fixed       
08-30-05 12:21 jdthood        Note Added: 0005972                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
