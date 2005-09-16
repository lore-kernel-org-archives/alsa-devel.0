From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000832]: sound randomly distorts, clicks, pops and low level
Date: Fri, 16 Sep 2005 16:31:05 +0200
Message-ID: <8d24c53e8b16b007651f1a6f4111dc51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1E68187
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 16:31:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=832> 
======================================================================
Reported By:                Alister
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   832
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Suse linux
Kernel Version:             2.6.5-7.111.19-default
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2005 22:07 CET
Last Modified:              09-16-2005 16:31 CEST
======================================================================
Summary:                    sound randomly distorts, clicks, pops and low level
Description: 
reported here:
http://forums.suselinuxsupport.de/index.php?showtopic=7828

but in summary:
HW works perfectly under windows partition.
Despite several (hopeful) upgrades, sound persists in randomly becoming
low- level and/or VERY distorted (clipped?). Occurs anytime from few
seconds to many minutes after being cleared. Occassionally corrects itself
(temporary) just as randomly. But spends most of the time being badly
distorted, low level and no left channel.
Can always clear (temporarily) by using volume control in YaST to set max
volumes and play high level sound through card.
Left channel always affected worse than right.
======================================================================

----------------------------------------------------------------------
 Alister - 09-16-05 00:37 
----------------------------------------------------------------------
seems to have gone away, sorry not to have reported earlier, but lost ref
to bug. My mind is 50/50 whether it was a hardware fault or removed by
local re-compile of alsa thus avoiding other people's RPMs (a KDE upgrade
from Suse broke sound fairly comprehensively, thus local re-compile
needed.)

----------------------------------------------------------------------
 jdthood - 09-16-05 16:31 
----------------------------------------------------------------------
> seems to have gone away

Good to hear

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-05 22:07 Alister        New Issue                                    
01-17-05 22:07 Alister        Distribution              => Suse linux      
01-17-05 22:07 Alister        Kernel Version            =>
2.6.5-7.111.19-default
01-28-05 11:06 Alister        Note Added: 0003425                          
09-15-05 16:16 jdthood        Note Added: 0006214                          
09-16-05 00:37 Alister        Note Added: 0006234                          
09-16-05 16:31 jdthood        Status                   new => resolved     
09-16-05 16:31 jdthood        Resolution               open => fixed       
09-16-05 16:31 jdthood        Assigned To               => jdthood         
09-16-05 16:31 jdthood        Note Added: 0006246                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
