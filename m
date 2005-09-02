From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001388]: Some patches from Cyberlink
Date: Fri, 2 Sep 2005 11:55:16 +0200
Message-ID: <ee8c36cbea6d3ca190da23b17730adc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BC09D18A
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 11:55:16 +0200 (MEST)
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
Status:                     assigned
Distribution:               
Kernel Version:             2.6.12.5
======================================================================
Date Submitted:             09-01-2005 18:04 CEST
Last Modified:              09-02-2005 11:55 CEST
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
 DrData - 09-01-05 18:41 
----------------------------------------------------------------------
Just uploaded it.

----------------------------------------------------------------------
 tiwai - 09-02-05 11:55 
----------------------------------------------------------------------
Could you try alc658d-fix.diff on the top of ALSA 1.0.10rc1 (or better 
ALSA CVS)?

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
