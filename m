From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000310]: Alsa freeze on shutdown in kernel 2.6.6
Date: Tue, 9 Nov 2004 16:31:09 +0100
Message-ID: <6e99cdd0aa6c4cc19fae445089db4a14@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EAD392A9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:31:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=310> 
======================================================================
Reported By:                hjheins
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   310
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Mandrake 10.0 modified
Kernel Version:             2.6.6
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-27-2004 14:07 CEST
Last Modified:              11-09-2004 16:31 CET
======================================================================
Summary:                    Alsa freeze on shutdown in kernel 2.6.6
Description: 
On shutdown, the alsa module does not shut down, it hangs.
if I'm quick enough, I can break the operation with <ctrl>+<c>, and
shutdown goes ok. If I don't break. The shutdown sequence hangs on the
Alsa module.
======================================================================

----------------------------------------------------------------------
 hjheins - 06-08-04 17:37 
----------------------------------------------------------------------
Final remark:

It seems to have been related to the init script.
Apparently before I used an older init script that wouldn't work with alsa
1.0.4 or 1.0.5.
Currently I use the script that comes with alsa 1.0.5 and that works fine.

----------------------------------------------------------------------
 perex - 09-08-04 18:20 
----------------------------------------------------------------------
New version solved problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-04 14:07 hjheins        New Issue                                    
05-27-04 14:07 hjheins        Distribution              => Mandrake 10.0
modified
05-27-04 14:07 hjheins        Kernel Version            => 2.6.6           
05-28-04 17:04 tiwai          Note Added: 0001267                          
05-28-04 20:04 hjheins        Note Added: 0001272                          
05-28-04 20:43 hjheins        Note Added: 0001273                          
06-04-04 18:13 hjheins        Note Added: 0001291                          
06-08-04 17:37 hjheins        Note Added: 0001295                          
09-08-04 18:20 perex          Status                   new => resolved     
09-08-04 18:20 perex          Resolution               open => fixed       
09-08-04 18:20 perex          Assigned To               => perex           
09-08-04 18:20 perex          Note Added: 0001738                          
11-09-04 16:31 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
