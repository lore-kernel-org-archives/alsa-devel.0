From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000558]: Hardware Monitoring is missing for EWS88D
Date: Tue, 9 Nov 2004 16:41:03 +0100
Message-ID: <b055fbe9ce3ea159225236d21c72b948@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08F212B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:41:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=558> 
======================================================================
Reported By:                theitch
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   558
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               FC 1 - CCRMA
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-02-2004 05:03 CEST
Last Modified:              11-09-2004 16:41 CET
======================================================================
Summary:                    Hardware Monitoring is missing for EWS88D
Description: 
The Hardware Monitoring for the the envy24/ice1712-based Terratec EWS88D
does not function when using the ice1712 driver.
======================================================================

----------------------------------------------------------------------
 theitch - 10-11-04 02:16 
----------------------------------------------------------------------
Thank you for the patch Takashi. It works PERFECTLY. envy24control reads
the adc & and dac as expected. HW monitoring works! Thanks again.

Robb

----------------------------------------------------------------------
 tiwai - 10-11-04 12:08 
----------------------------------------------------------------------
Ok, now I committed to CVS.  Thanks for testing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-02-04 05:03 theitch        New Issue                                    
10-02-04 05:03 theitch        Distribution              => FC 1 - CCRMA    
10-02-04 05:03 theitch        Kernel Version            => 2.4.26          
10-03-04 20:36 theitch        Issue Monitored: theitch                     
10-04-04 18:55 tiwai          Note Added: 0002012                          
10-05-04 16:00 theitch        Note Added: 0002016                          
10-05-04 16:06 theitch        Note Edited: 0002016                         
10-06-04 12:11 tiwai          Note Added: 0002021                          
10-06-04 12:33 tiwai          Note Added: 0002025                          
10-06-04 12:33 tiwai          File Added: ews88d.dif                       
10-11-04 02:16 theitch        Note Added: 0002069                          
10-11-04 12:08 tiwai          Status                   new => resolved     
10-11-04 12:08 tiwai          Resolution               open => fixed       
10-11-04 12:08 tiwai          Assigned To               => tiwai           
10-11-04 12:08 tiwai          Note Added: 0002073                          
11-09-04 16:41 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
