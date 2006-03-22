From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000656]: ICE1712 and multiple cards clock sync
Date: Wed, 22 Mar 2006 02:46:00 +0100
Message-ID: <fcde75ecad88eb1a7bd22dea82791eee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 257D218E
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 02:46:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=656> 
======================================================================
Reported By:                Michele Spinolo
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   656
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 1
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-19-2004 09:41 CET
Last Modified:              03-22-2006 02:45 CET
======================================================================
Summary:                    ICE1712 and multiple cards clock sync
Description: 
I have set up my PC with 3 Terratec EWS88D cards, based on ICE1712 chip.

They offer the chance to be synched one to each other, defining a master
one
and using an internal connector to send the clock signal.

The problem is that using both envy24control or alsa control panel there
is
no option releated to this feature, so multiple boards clock sync is
impossible to be used.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:45 
----------------------------------------------------------------------
Fixed in recent versions

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 09:41 Michele SpinoloNew Issue                                    
11-19-04 09:41 Michele SpinoloDistribution              => Fedora Core 1   
11-19-04 09:41 Michele SpinoloKernel Version            => 2.4.26          
11-24-04 19:12 Michele SpinoloIssue Monitored: Michele Spinolo                  
 
03-22-06 02:45 rlrevell       Status                   new => resolved     
03-22-06 02:45 rlrevell       Resolution               open => fixed       
03-22-06 02:45 rlrevell       Assigned To               => rlrevell        
03-22-06 02:45 rlrevell       Note Added: 0008785                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
