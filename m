From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000467]: Need quirk added for Sony S1XP laptop
Date: Mon, 14 Feb 2005 19:35:43 +0100
Message-ID: <0791c9f7b8009e70cb97ac40c59a1275@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5D1F6248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:35:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=467> 
======================================================================
Reported By:                hadess
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   467
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               FC2
Kernel Version:             2.6.6-1.435.2.3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-26-2004 23:35 CEST
Last Modified:              02-14-2005 19:35 CET
======================================================================
Summary:                    Need quirk added for Sony S1XP laptop
Description: 
Sound on the Sony S1XP only works with ac97_quirk=-1

lspci -vn output:
00:1f.5 Class 0401: 8086:24c5 (rev 03)
        Subsystem: 104d:8197
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at 1c00
        I/O ports at 18c0 [size=64]
        Memory at d0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at d0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

Let me know if you need any more details.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-20-04 17:45 
----------------------------------------------------------------------
Try to install 1.0.7rc1.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:22 
----------------------------------------------------------------------
Closing this now...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 23:35 hadess         New Issue                                    
08-26-04 23:35 hadess         Distribution              => FC2             
08-26-04 23:35 hadess         Kernel Version            => 2.6.6-1.435.2.3 
08-26-04 23:37 hadess         Note Added: 0001638                          
08-26-04 23:46 hadess         Note Added: 0001639                          
09-01-04 23:06 tiwai          Note Added: 0001680                          
09-03-04 16:12 tiwai          Note Added: 0001695                          
09-03-04 16:12 tiwai          File Added: inv-eapd.dif                     
09-04-04 00:43 hadess         Note Added: 0001699                          
09-07-04 03:13 ichino         Issue Monitored: ichino                      
09-20-04 17:45 tiwai          Note Added: 0001792                          
01-13-05 17:22 tiwai          Status                   new => resolved     
01-13-05 17:22 tiwai          Resolution               open => fixed       
01-13-05 17:22 tiwai          Assigned To               => tiwai           
01-13-05 17:22 tiwai          Note Added: 0003191                          
01-13-05 17:22 tiwai          Assigned To              tiwai =>            
02-14-05 19:35 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
