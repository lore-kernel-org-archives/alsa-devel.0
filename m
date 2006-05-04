From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002072]: Module generates error message when loading, and error when trying to play an au-file.
Date: Thu, 4 May 2006 22:15:05 +0200
Message-ID: <c2b0ac6ed214446dde89c917217eeede@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74D15232
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 22:15:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2072> 
======================================================================
Reported By:                eivindt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2072
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.17_rc2
======================================================================
Date Submitted:             04-26-2006 00:17 CEST
Last Modified:              05-04-2006 22:15 CEST
======================================================================
Summary:                    Module generates error message when loading, and
error when trying to play an au-file.
Description: 
When loading the module (snd-hda-intel) i get an error message on the
console.  The modules still loads and creates the expected devices and
proc files (as far as I can see).

When trying to use the module, by cat-ing a au-file into /dev/sound/audio,
I get another error message on the console, and no sound out.

This is compiled with the lates version from hg.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-04-06 11:34 
----------------------------------------------------------------------
Try HG version.  Some tweaks for thinkpad *60 were applied.

----------------------------------------------------------------------
 eivindt - 05-04-06 22:15 
----------------------------------------------------------------------
I _am_ using the latest HG version...

Please let me know if there's anything I should do to get more debug
info...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 00:17 eivindt        New Issue                                    
04-26-06 00:17 eivindt        Distribution              => Gentoo          
04-26-06 00:17 eivindt        Kernel Version            => 2.6.17_rc2      
05-04-06 08:08 eivindt        Note Added: 0009607                          
05-04-06 11:34 tiwai          Note Added: 0009609                          
05-04-06 22:15 eivindt        Note Added: 0009621                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
