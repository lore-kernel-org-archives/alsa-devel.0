From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000406]: Multiple Kernel OOPS with multiple threads accessing sound device
Date: Fri, 8 Apr 2005 22:27:15 +0200
Message-ID: <6029b3a7937c3f0895dd4e3d46cece03@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE84B1F0
	for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2005 22:27:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=406> 
======================================================================
Reported By:                nickkral
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   406
Category:                   CORE OSS - pcm
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7-gentoo-r5
======================================================================
Date Submitted:             07-26-2004 07:55 CEST
Last Modified:              04-08-2005 22:27 CEST
======================================================================
Summary:                    Multiple Kernel OOPS with multiple threads accessing
sound device
Description: 
I have a program with two threads (pthreads)

One thread continually writes to /dev/dsp, and the other thread
continually calls the SNDCTL_DSP_GETODELAY ioctl.

At startup, there appears to be a race condition in the initialization of
some data structures which causes OOPSes in the linux kernel.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-08-05 22:27 
----------------------------------------------------------------------
Submitter: Was this problem ever solved in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-04 07:55 nickkral       New Issue                                    
07-26-04 07:55 nickkral       Distribution              => Gentoo          
07-26-04 07:55 nickkral       Kernel Version            => 2.6.7-gentoo-r5 
04-08-05 22:27 jdthood        Note Added: 0004376                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
