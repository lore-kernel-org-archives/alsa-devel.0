From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000204]: No volume control
Date: Mon, 14 Feb 2005 19:36:47 +0100
Message-ID: <3c635a9c46207007784bb2b1d6155bfe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 37214248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:36:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=204> 
======================================================================
Reported By:                pborman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   204
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2115.nptl
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-12-2004 21:01 CEST
Last Modified:              02-14-2005 19:36 CET
======================================================================
Summary:                    No volume control
Description: 
Sound plays ok, system events, xmms etc.
Can mute sound using amixer set PCM off
but can't control volume with amixer or alsamixer, master volume control
moves up & down but volume doesn't change
======================================================================

----------------------------------------------------------------------
 pborman - 04-14-04 00:34 
----------------------------------------------------------------------
Using alsa driver 1.0.4
ASRock motherboard with SiS7012 chipset, correctly identified by
alsaconfig

----------------------------------------------------------------------
 tiwai - 01-13-05 17:26 
----------------------------------------------------------------------
ALSA 1.0.8 includes the softvol plugin for this problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-04 21:01 pborman        New Issue                                    
04-12-04 21:01 pborman        Distribution              => Fedora Core 1   
04-12-04 21:01 pborman        Kernel Version            => 2.4.22-1.2115.nptl
04-14-04 00:34 pborman        Note Added: 0000801                          
04-28-04 20:48 pborman        Issue Monitored: pborman                     
01-13-05 17:26 tiwai          Status                   new => resolved     
01-13-05 17:26 tiwai          Resolution               open => fixed       
01-13-05 17:26 tiwai          Assigned To               => tiwai           
01-13-05 17:26 tiwai          Note Added: 0003194                          
01-13-05 17:26 tiwai          Assigned To              tiwai =>            
02-14-05 19:36 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
