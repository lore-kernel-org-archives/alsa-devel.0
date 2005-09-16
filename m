From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001428]: My Audigy 1 Player [SB0090] card don't detect correct by alsa utils
Date: Fri, 16 Sep 2005 23:45:45 +0200
Message-ID: <93b51c33a44a166246367c06838aafc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B12D151
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 23:45:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1428> 
======================================================================
Reported By:                rusxakep
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1428
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.12
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-16-2005 18:56 CEST
Last Modified:              09-16-2005 23:45 CEST
======================================================================
Summary:                    My Audigy 1 Player [SB0090] card don't detect
correct by alsa utils
Description: 
On my soundcard (lspci -vvvn) .subsystem is 0x00511102
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-16-05 23:22 
----------------------------------------------------------------------
Fixed in ALSA 1.0.10-rc1.  The easiest fix is to upgrade to kernel 2.6.13.

----------------------------------------------------------------------
 rlrevell - 09-16-05 23:45 
----------------------------------------------------------------------
Fixed in 1.0.10-rc1 and kernel 2.6.13

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-16-05 18:56 rusxakep       New Issue                                    
09-16-05 18:56 rusxakep       Distribution              => Gentoo          
09-16-05 18:56 rusxakep       Kernel Version            => 2.6.12          
09-16-05 18:56 rusxakep       Issue Monitored: rusxakep                    
09-16-05 23:22 rlrevell       Note Added: 0006247                          
09-16-05 23:45 rlrevell       Status                   new => resolved     
09-16-05 23:45 rlrevell       Resolution               open => fixed       
09-16-05 23:45 rlrevell       Assigned To               => rlrevell        
09-16-05 23:45 rlrevell       Note Added: 0006248                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
