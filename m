From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001388]: Some patches from Cyberlink
Date: Fri, 2 Sep 2005 15:11:32 +0200
Message-ID: <5990cb45f22b8891ea0b1527f7076fa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9E3D184
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 15:11:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1388> 
======================================================================
Reported By:                DrData
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1388
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.12.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-01-2005 18:04 CEST
Last Modified:              09-02-2005 15:11 CEST
======================================================================
Summary:                    Some patches from Cyberlink
Description: 
Cyberlink released in 
http://download.gocyberlink.com//ftpdload/linux/source/PCMLinux_GPL_sources-01.zip
some patches to alsa-driver-1.0.9rc2.
One of them cured the problem on my Targa Traveller 826, where I had sound
only over the headphone. It appears to be a ac97 device named ALC658D.

I included the diff against the standard 1.0.9.rc2 version.

I would be more than happy, if at least that patch would make it in the
main strem and possibly also in the kernel sources.

Michael

PS: I got a kernel with working sound be exchanging the sound and
include/sound directories in the kernel 2.6.12.5 sources by the respective
dirs in the cyberlink distribution.

======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 12:19 
----------------------------------------------------------------------
There was a typo in the first patch.  Use alc658-fix2.diff.

----------------------------------------------------------------------
 tiwai - 09-02-05 15:11 
----------------------------------------------------------------------
The patch is on alsa CVS tree.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 18:04 DrData         New Issue                                    
09-01-05 18:04 DrData         File Added:
alsa-driver-1.0.9rc2.cyberlink.patch.bz2                    
09-01-05 18:04 DrData         Kernel Version            => 2.6.12.5        
09-01-05 18:10 tiwai          Note Added: 0005996                          
09-01-05 18:30 DrData         File Added: cyberlink.patch.bz2                   

09-01-05 18:41 DrData         Note Added: 0005998                          
09-02-05 11:54 tiwai          File Added: alc658d-fix.diff                    
09-02-05 11:55 tiwai          Note Added: 0006006                          
09-02-05 12:19 tiwai          File Added: alc658d-fix2.diff                    
09-02-05 12:19 tiwai          Note Added: 0006007                          
09-02-05 15:11 tiwai          Status                   assigned => resolved
09-02-05 15:11 tiwai          Resolution               open => fixed       
09-02-05 15:11 tiwai          Note Added: 0006009                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
