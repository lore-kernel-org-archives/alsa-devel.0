From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000713]: AC'97 codec issue: "AC'97 0 does not respond - RESET"
Date: Tue, 4 Apr 2006 23:37:18 +0200
Message-ID: <1aa06693258a5ba872e4f752fe0716f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31F02157
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 23:37:18 +0200 (MEST)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=713> 
======================================================================
Reported By:                jefke
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   713
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian sid
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-07-2004 19:43 CET
Last Modified:              04-04-2006 23:37 CEST
======================================================================
Summary:                    AC'97 codec issue: "AC'97 0 does not respond -
RESET"
Description: 
Souncard is working fine with oss module i810_audio, but isn't using alsa
modules. Several tests have been done under 2.6.8, 2.6.9 and 2.6.10rc3
kernels, using alsa-drivers version 1.0.7, without success.

Looks like the AC97 codec can't get initialized, and is unable to read PCI
registries on the sound card (AC97_VENDOR_ID1, AC97_VENDOR_ID2).

Cf uploaded file for configuration details.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:45 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

----------------------------------------------------------------------
 jefke - 04-04-06 23:37 
----------------------------------------------------------------------
FYI, issue finally fixed with latest development release, i.e. 10.0.11rc4.
ALSA is now running fine on my machine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 19:43 jefke          New Issue                                    
12-07-04 19:43 jefke          File Added: alsa-bug                         
12-07-04 19:43 jefke          Distribution              => Debian sid      
12-07-04 19:43 jefke          Kernel Version            => 2.6.9           
04-09-05 17:21 jdthood        Note Added: 0004420                          
12-30-05 04:45 rlrevell       Note Added: 0007222                          
03-01-06 01:02 rlrevell       Status                   new => closed       
04-04-06 23:34 jefke          Issue Monitored: jefke                       
04-04-06 23:34 jefke          Issue End Monitor: jefke                     
04-04-06 23:37 jefke          Assigned To               => rlrevell        
04-04-06 23:37 jefke          Status                   closed => feedback  
04-04-06 23:37 jefke          Resolution               open => reopened    
04-04-06 23:37 jefke          Note Added: 0009117                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
