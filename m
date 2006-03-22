From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000934]: crash in snd-serial-u16550 as non-root user
Date: Wed, 22 Mar 2006 03:29:31 +0100
Message-ID: <2a46ee1e48200e7f82706aa9039fa7ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 086F113C
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:29:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=934> 
======================================================================
Reported By:                laurent
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   934
Category:                   GENERIC - serial-u16550
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.4.29 and 2.6.10
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-23-2005 07:42 CET
Last Modified:              03-22-2006 03:29 CET
======================================================================
Summary:                    crash in snd-serial-u16550 as non-root user
Description: 
Whenever I try to use a sequencer application (I tried: seq24, museseq,
rosegarden) as a non-root user, I get a kernel Oops.

I was using alsa-driver 1.0.8 with the 2.4.29 kernel, and the built-in
modules for the 2.6.10 kernel.

If you need more information than the stacks traces and lsmod please ask
and I will do my best to provide them.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-22-05 14:56 
----------------------------------------------------------------------
Submitter: Do you still have this problem?

If so, what are the module parameters of snd-serial-u16550?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:29 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 07:42 laurent        New Issue                                    
02-23-05 07:42 laurent        Distribution              => Gentoo          
02-23-05 07:42 laurent        Kernel Version            => 2.4.29 and 2.6.10
03-08-05 11:45 Clemens LadischNote Added: 0003814                          
09-22-05 14:56 jdthood        Note Added: 0006338                          
03-22-06 03:29 rlrevell       Status                   new => closed       
03-22-06 03:29 rlrevell       Note Added: 0008821                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
