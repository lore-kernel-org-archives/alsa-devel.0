From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000406]: Multiple Kernel OOPS with multiple threads accessing sound device
Date: Thu, 16 Mar 2006 08:31:37 +0100
Message-ID: <1b33771af7466aa89719216069c0b7b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 370BB1FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:31:37 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.7-gentoo-r5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-26-2004 07:55 CEST
Last Modified:              03-16-2006 08:31 CET
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

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:31 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-04 07:55 nickkral       New Issue                                    
07-26-04 07:55 nickkral       Distribution              => Gentoo          
07-26-04 07:55 nickkral       Kernel Version            => 2.6.7-gentoo-r5 
04-08-05 22:27 jdthood        Note Added: 0004376                          
03-16-06 08:31 rlrevell       Note Added: 0008591                          
03-16-06 08:31 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
