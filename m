From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000526]: Kernel crash during the module snd-azx load
Date: Tue, 9 Nov 2004 16:39:44 +0100
Message-ID: <db7cb2241088be513b9b5752657e2abf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D7D502B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:39:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=526> 
======================================================================
Reported By:                Grazy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   526
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-23-2004 19:33 CEST
Last Modified:              11-09-2004 16:39 CET
======================================================================
Summary:                    Kernel crash during the module snd-azx load
Description: 
The kernel crash during the load of the snd-azx.
It is the recursive funtion set_mic_rp_wid_connection wich never end.

======================================================================

----------------------------------------------------------------------
 tiwai - 09-28-04 23:20 
----------------------------------------------------------------------
Thanks, applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 19:33 Grazy          New Issue                                    
09-23-04 19:33 Grazy          File Added: patch_azx_discover.gz                 
  
09-23-04 19:33 Grazy          Distribution              => Debian          
09-23-04 19:33 Grazy          Kernel Version            => 2.6.8           
09-28-04 23:20 tiwai          Status                   new => resolved     
09-28-04 23:20 tiwai          Resolution               open => fixed       
09-28-04 23:20 tiwai          Assigned To               => tiwai           
09-28-04 23:20 tiwai          Note Added: 0001960                          
11-09-04 16:39 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
