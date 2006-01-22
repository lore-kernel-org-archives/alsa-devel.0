From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000328]: snd-nm256 freezes Dell Latitude LS
Date: Sun, 22 Jan 2006 02:00:55 +0100
Message-ID: <d3abc64dad3f027df37d4a8d7866d774@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF1FC19C
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2006 02:00:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328> 
======================================================================
Reported By:                aaronkaplan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   328
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398
======================================================================
Date Submitted:             06-08-2004 23:13 CEST
Last Modified:              01-22-2006 02:00 CET
======================================================================
Summary:                    snd-nm256 freezes Dell Latitude LS
Description: 
My Dell Latitude LS with an NM256AV hangs when I insert the
snd-nm256 module.

The OSS driver works fine.

======================================================================

----------------------------------------------------------------------
 rlrevell - 01-21-06 02:03 
----------------------------------------------------------------------
tiwai on LKML:

"This might not conver all Dell models.  In such a case, try
reset_workaround2=1.  See the section of nm256 in
ALSA-Configuration.txt for details."

Try the various reset_workaround options amd report which (if any) help.

----------------------------------------------------------------------
 aaronkaplan - 01-22-06 02:00 
----------------------------------------------------------------------
With alsa 1.0.11rc2, modprobe snd_nm256 hangs the machine with all four
possible combinations of reset_workaround and reset_workaround_2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-04 23:13 aaronkaplan    New Issue                                    
06-08-04 23:13 aaronkaplan    Distribution              => Fedora Core 2   
06-08-04 23:13 aaronkaplan    Kernel Version            => 2.6.5-1.358     
06-08-04 23:13 aaronkaplan    Issue Monitored: aaronkaplan                    
06-30-04 16:55 tiwai          Note Added: 0001362                          
06-30-04 16:56 tiwai          File Added: nm256-dell-test.dif                   

07-01-04 16:01 aaronkaplan    File Added: lspci.out                        
07-01-04 16:03 aaronkaplan    Note Added: 0001370                          
08-13-04 01:33 fridolin       Note Added: 0001559                          
08-13-04 12:46 fridolin       Note Added: 0001562                          
08-13-04 15:17 fridolin       Note Added: 0001564                          
08-14-04 20:04 aaronkaplan    Note Added: 0001565                          
08-19-04 19:18 tiwai          Status                   assigned => resolved
08-19-04 19:18 tiwai          Resolution               open => fixed       
08-19-04 19:18 tiwai          Note Added: 0001593                          
09-24-04 13:43 tiwai          Status                   resolved => closed  
09-03-05 22:43 aaronkaplan    Distribution             Fedora Core 2 => Fedora
Core 4
09-03-05 22:43 aaronkaplan    Kernel Version           2.6.5-1.358 =>
2.6.12-1.1398
09-03-05 22:43 aaronkaplan    Status                   closed => feedback  
09-03-05 22:43 aaronkaplan    Resolution               fixed => reopened   
09-03-05 22:43 aaronkaplan    Note Added: 0006030                          
09-04-05 00:33 rlrevell       Note Added: 0006031                          
09-13-05 11:49 florentb5      Note Added: 0006152                          
11-08-05 18:47 tiwai          Note Added: 0006636                          
11-12-05 17:58 aaronkaplan    Note Added: 0006687                          
01-05-06 10:52 Adrian Bunk    Issue Monitored: Adrian Bunk                    
01-21-06 02:03 rlrevell       Note Added: 0007729                          
01-22-06 02:00 aaronkaplan    Note Added: 0007742                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
