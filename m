From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000328]: snd-nm256 freezes Dell Latitude LS
Date: Sat, 12 Nov 2005 17:58:45 +0100
Message-ID: <5b229c36a554ca6fbacc490eb17cf4c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9251C189
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 17:58:45 +0100 (MET)
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
Last Modified:              11-12-2005 17:58 CET
======================================================================
Summary:                    snd-nm256 freezes Dell Latitude LS
Description: 
My Dell Latitude LS with an NM256AV hangs when I insert the
snd-nm256 module.

The OSS driver works fine.

======================================================================

----------------------------------------------------------------------
 tiwai - 11-08-05 18:47 
----------------------------------------------------------------------
1.0.10rc3 has a fix for this laptop.  Give it a try.

----------------------------------------------------------------------
 aaronkaplan - 11-12-05 17:58 
----------------------------------------------------------------------
No, it still hangs with 1.0.10rc3.

During my testing, the first modprobe snd-nm256 after booting went ok, but
then rmmod and modprobe again caused it to hang.  Not sure if this is by
chance, but it happened three boots in a row.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
