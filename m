From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000956]: mixer devices missing & no sound
Date: Wed, 23 Mar 2005 02:25:12 +0100
Message-ID: <83ede6e65d62913e79e5f61363926341@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 12CBD259
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 02:25:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=956> 
======================================================================
Reported By:                calebmiles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   956
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core
Kernel Version:             2.6.10
======================================================================
Date Submitted:             03-02-2005 13:09 CET
Last Modified:              03-23-2005 02:25 CET
======================================================================
Summary:                    mixer devices missing & no sound
Description: 
after compiling the 1.0.8 alsa-driver version from source or integrating it
into the kernel sourcecode and rebooting i run alsamixer and find most of
the devices in the mixer missing such as master master mono cd aux etc 
======================================================================

----------------------------------------------------------------------
 jdthood - 03-22-05 22:26 
----------------------------------------------------------------------
Does the problem go away if you upgrade your alsa-lib to the same version?

----------------------------------------------------------------------
 calebmiles - 03-23-05 02:25 
----------------------------------------------------------------------
no, I was using the Planet CCRMA alsa rpms, but I just recompliled the
kernel with out its built in alsa support and installed all the alsa
packages from source and things worked fine

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 13:09 calebmiles     New Issue                                    
03-02-05 13:09 calebmiles     Distribution              => Fedora Core     
03-02-05 13:09 calebmiles     Kernel Version            => 2.6.10          
03-22-05 22:26 jdthood        Note Added: 0004141                          
03-23-05 02:25 calebmiles     Note Added: 0004148                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
