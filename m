From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000777]: Kernel crashes when using external sound controls
Date: Fri, 4 Feb 2005 18:01:55 +0100
Message-ID: <eb3d50aa1929a416236e5307b5646474@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DE95B1ED
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 18:01:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=777> 
======================================================================
Reported By:                jan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   777
Category:                   CORE - control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Slackware current
Kernel Version:             Kernel 2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-02-2005 14:49 CET
Last Modified:              02-04-2005 18:01 CET
======================================================================
Summary:                    Kernel crashes when using external sound controls
Description: 
Since I upgraded from Kernel 2.6.8.1 to 2.6.10 (ALSA 1.0.6) the whole
system crashes when I try to adjust to sound volume via the external
volume controls of my laptop. Everything else including the alsamixer
works as expected. (Whole system crashes means, that I can do nothing, but
hard reset.)
I could use these external controls successfully with previous kernel
versions.
When I compile the kernel without ALSA support it doesn't crash (I have no
sound support then of course).
The soundchip in this laptop is:
00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev
10)
Please let me know what additional infos you need.
Thanks in advance
======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 12:03 
----------------------------------------------------------------------
Already fixed in CVS (or 1.0.8).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 14:49 jan            New Issue                                    
01-02-05 14:49 jan            Distribution              => Slackware current
01-02-05 14:49 jan            Kernel Version            => Kernel 2.6.10   
01-03-05 12:03 tiwai          Status                   new => resolved     
01-03-05 12:03 tiwai          Resolution               open => fixed       
01-03-05 12:03 tiwai          Assigned To               => tiwai           
01-03-05 12:03 tiwai          Note Added: 0003051                          
01-03-05 12:03 tiwai          Assigned To              tiwai =>            
02-04-05 18:01 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
