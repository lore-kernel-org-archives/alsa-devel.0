From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000706]: SERR: Status=4210 followed by NMI reason 34 leading to reboot
Date: Thu, 16 Dec 2004 18:22:16 +0100
Message-ID: <2cd997270a9401c82895643b9d1bec27@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CE91024B
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:22:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=706> 
======================================================================
Reported By:                dlc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   706
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               DeMuDi1.2.0
Kernel Version:             2.4.25
======================================================================
Date Submitted:             12-04-2004 00:36 CET
Last Modified:              12-16-2004 18:22 CET
======================================================================
Summary:                    SERR: Status=4210 followed by NMI reason 34 leading
to reboot
Description: 
System reboots when attempting to install a game under Wine.
======================================================================

----------------------------------------------------------------------
 dlc - 12-16-04 17:45 
----------------------------------------------------------------------
I pulled the Delta card and the crash failed to manifest.  I put it back in
and the crash occurred as described.  Is there any kind of tracing
available for the driver that would provide a better idea of what is
occurring?  Or should I start looking at the code?

----------------------------------------------------------------------
 tiwai - 12-16-04 18:22 
----------------------------------------------------------------------
I don't think it's a bug of drivers.  The code doesn't reach even to the
initialization of sound stuff at all.

Try much newer kernels?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-04 00:36 dlc            New Issue                                    
12-04-04 00:36 dlc            Distribution              => DeMuDi1.2.0     
12-04-04 00:36 dlc            Kernel Version            => 2.4.25          
12-07-04 18:52 tiwai          Note Added: 0002760                          
12-07-04 19:22 dlc            Note Added: 0002763                          
12-16-04 17:45 dlc            Note Added: 0002830                          
12-16-04 18:22 tiwai          Note Added: 0002832                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
