From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000792]: alsa fails to initialize after UDEV is installed
Date: Mon, 14 Feb 2005 19:38:04 +0100
Message-ID: <e86072a3861bd92023cc5a524980a0a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 35903248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:38:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=792> 
======================================================================
Reported By:                sluce
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   792
Category:                   alisp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-08-2005 04:12 CET
Last Modified:              02-14-2005 19:38 CET
======================================================================
Summary:                    alsa fails to initialize after UDEV is installed
Description: 
I'm really running 1.0.7 but that wasn't an option above.
The kernel reports that it finds my CMI8330 card and alsa says:
pnp: the driver 'cmi8330' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'cmi8330'
pnp: match found with the PnP device '01:01.03' and the driver 'cmi8330'
pnp: Device 01:01.00 activated.
pnp: Device 01:01.03 activated.
ALSA sound/isa/sb/sb_common.c:130: SB [0x220]: DSP chip found, version =
4.13

I am unable to use the sound card.  KDE is configured to use alsa but is
unable to open the sound device.

I'll happily provide more information if you tell me what you want to see.
======================================================================

----------------------------------------------------------------------
 sluce - 01-13-05 17:53 
----------------------------------------------------------------------
Thanks to Thomas Hood, this issue is resolved.  The problem was a too
backlevel hotplug installation.  I upgraded hotplug to sarge and all is
well.



----------------------------------------------------------------------
 tiwai - 01-13-05 20:42 
----------------------------------------------------------------------
OK, closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-05 04:12 sluce          New Issue                                    
01-08-05 18:43 sluce          Issue Monitored: sluce                       
01-08-05 18:44 sluce          Issue End Monitor: sluce                     
01-08-05 23:34 sluce          File Added: 792.txt                          
01-08-05 23:35 sluce          Note Added: 0003131                          
01-10-05 15:03 tiwai          Note Added: 0003136                          
01-10-05 20:49 sluce          Note Added: 0003139                          
01-12-05 06:05 sluce          Note Edited: 0003139                         
01-13-05 17:52 sluce          Note Added: 0003197                          
01-13-05 17:53 sluce          Note Edited: 0003197                         
01-13-05 20:42 tiwai          Status                   new => resolved     
01-13-05 20:42 tiwai          Resolution               open => fixed       
01-13-05 20:42 tiwai          Assigned To               => tiwai           
01-13-05 20:42 tiwai          Note Added: 0003200                          
01-13-05 20:42 tiwai          Assigned To              tiwai =>            
02-14-05 19:38 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
