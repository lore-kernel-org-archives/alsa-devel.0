From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000641]: Bug in WM8770 init on aureon
Date: Thu, 16 Dec 2004 18:17:17 +0100
Message-ID: <4b0651d389d2c8536cb991fcab3521bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 83816200
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:17:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=641> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   641
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-11-2004 00:03 CET
Last Modified:              12-16-2004 18:17 CET
======================================================================
Summary:                    Bug in WM8770 init on aureon
Description: 
On aureon cards the ADC on WM8770 is initialized to AIN6L/AIN5R, although
the comment states AC'97.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-15-04 20:09 
----------------------------------------------------------------------
Applied to CVS.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 00:03 ungod          New Issue                                    
11-11-04 00:03 ungod          File Added: aureon-wm-init-fix.diff               
    
11-15-04 20:09 tiwai          Status                   new => resolved     
11-15-04 20:09 tiwai          Resolution               open => fixed       
11-15-04 20:09 tiwai          Assigned To               => tiwai           
11-15-04 20:09 tiwai          Note Added: 0002418                          
12-16-04 18:17 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
