From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000328]: snd-nm256 freezes Dell Latitude LS
Date: Sat, 3 Sep 2005 22:43:23 +0200
Message-ID: <1781fb67ece9d5d00430141b7970e40f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2137614B
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 22:43:24 +0200 (MEST)
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


The following issue has been REOPENED.
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
Last Modified:              09-03-2005 22:43 CEST
======================================================================
Summary:                    snd-nm256 freezes Dell Latitude LS
Description: 
My Dell Latitude LS with an NM256AV hangs when I insert the
snd-nm256 module.

The OSS driver works fine.

======================================================================

----------------------------------------------------------------------
 tiwai - 08-19-04 19:18 
----------------------------------------------------------------------
Ok now I close this.  Reopen if still something gets wrong.

----------------------------------------------------------------------
 aaronkaplan - 09-03-05 22:43 
----------------------------------------------------------------------
I upgraded to FC4 and the problem is back again.  When I modprobe
snd_nm256, sometimes it works, but more than half the time it hangs the
system.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
