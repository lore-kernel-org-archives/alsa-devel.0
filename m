From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000510]: Utilization of AC'97 on Aureon 7.1 Space
Date: Tue, 9 Nov 2004 16:38:32 +0100
Message-ID: <403db3fa4bdbbd3e0db798939d52ae31@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 96FB72B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:38:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=510> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   510
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux
Kernel Version:             3.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-21-2004 09:41 CEST
Last Modified:              11-09-2004 16:38 CET
======================================================================
Summary:                    Utilization of AC'97 on Aureon 7.1 Space
Description: 
As of now, the Aureon driver lacks the capability to playback both analog
input channels and the PCM channel, and the input channels have no
seperate volume control, although the AC'97 chip on the board, STAC9744,
apparently has the capability.

I tried some commercial OSS drivers, and they worked properly, so I know
that it is possible.
======================================================================

----------------------------------------------------------------------
 ungod - 09-27-04 20:18 
----------------------------------------------------------------------
Oh - my bad. I'll keep that in mind with future patches

----------------------------------------------------------------------
 tiwai - 09-28-04 19:12 
----------------------------------------------------------------------
Ok, let's close this bug now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-04 09:41 ungod          New Issue                                    
09-21-04 09:41 ungod          Distribution              => Debian GNU/Linux
09-21-04 09:41 ungod          Kernel Version            => 3.1             
09-21-04 11:54 tiwai          Note Added: 0001796                          
09-23-04 20:45 ungod          Note Added: 0001848                          
09-23-04 20:47 ungod          Note Edited: 0001848                         
09-23-04 20:47 ungod          Note Edited: 0001848                         
09-27-04 00:33 ungod          Note Added: 0001929                          
09-27-04 00:37 ungod          Note Added: 0001930                          
09-27-04 00:37 ungod          File Added: aureon-ac97.diff                    
09-27-04 00:42 ungod          Note Edited: 0001929                         
09-27-04 00:42 ungod          Note Edited: 0001929                         
09-27-04 00:44 ungod          Note Edited: 0001929                         
09-27-04 00:45 ungod          Note Edited: 0001929                         
09-27-04 16:46 tiwai          Note Added: 0001940                          
09-27-04 20:18 ungod          Note Added: 0001942                          
09-28-04 19:12 tiwai          Status                   new => resolved     
09-28-04 19:12 tiwai          Resolution               open => fixed       
09-28-04 19:12 tiwai          Assigned To               => tiwai           
09-28-04 19:12 tiwai          Note Added: 0001954                          
11-09-04 16:38 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
