From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000934]: crash in snd-serial-u16550 as non-root user
Date: Thu, 22 Sep 2005 14:56:47 +0200
Message-ID: <4a53675c4b2dd19e9473248556072791@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 443D3146
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 14:56:48 +0200 (MEST)
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
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.4.29 and 2.6.10
======================================================================
Date Submitted:             02-23-2005 07:42 CET
Last Modified:              09-22-2005 14:56 CEST
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
 Clemens Ladisch - 03-08-05 11:45 
----------------------------------------------------------------------
What are the module parameters of snd-serial-u16550?

----------------------------------------------------------------------
 jdthood - 09-22-05 14:56 
----------------------------------------------------------------------
Submitter: Do you still have this problem?

If so, what are the module parameters of snd-serial-u16550?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 07:42 laurent        New Issue                                    
02-23-05 07:42 laurent        Distribution              => Gentoo          
02-23-05 07:42 laurent        Kernel Version            => 2.4.29 and 2.6.10
03-08-05 11:45 Clemens LadischNote Added: 0003814                          
09-22-05 14:56 jdthood        Note Added: 0006338                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
