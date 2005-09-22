From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000562]: No AC3 sound playable through S/PDIF with certain amplifiers
Date: Thu, 22 Sep 2005 16:10:57 +0200
Message-ID: <c3d38ba828aa5adc76c1c4dba1dee097@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51D34141
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 16:10:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=562> 
======================================================================
Reported By:                herpes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   562
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             10-03-2004 10:38 CEST
Last Modified:              09-22-2005 16:10 CEST
======================================================================
Summary:                    No AC3 sound playable through S/PDIF with certain
amplifiers
Description: 
This has already been on the mailing list, see also
http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg13822.html.

When playing AC3 through the S/PDIF out on my Terratec 512i, I get no
sound at all. Normal PCM and DTS streams work.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000481 IEC958 Output doesn't work
has duplicate       0001359 cs46xx DTS pass through works, but AC3/...
======================================================================

----------------------------------------------------------------------
 tiwai - 10-19-04 12:37 
----------------------------------------------------------------------
Some receiver requires the non-audio bit in IEC958 status for AC3
but not for DTS.

----------------------------------------------------------------------
 Gregoire - 09-22-05 16:10 
----------------------------------------------------------------------
Is there anything I could provide in order to have this bug resolved ?
My PC has also a SBLive and a via82xx in, for both AC3 works, but I need
the PCI of the SBLive and the quality of thevia82xx is not good (and I
need the firewire of the cs46xx card). Thank you very much :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 10:38 herpes         New Issue                                    
10-03-04 10:38 herpes         Distribution              => Debian          
10-03-04 10:38 herpes         Kernel Version            => 2.6.8.1         
10-06-04 12:14 tiwai          Note Added: 0002023                          
10-12-04 14:48 tiwai          Note Added: 0002097                          
10-19-04 00:46 herpes         File Added: codec-details-while-playing-dts.txt   
                
10-19-04 00:46 herpes         File Added: codec-details-while-playing-AC3.txt   
                
10-19-04 00:58 herpes         Note Added: 0002201                          
10-19-04 12:37 tiwai          Note Added: 0002203                          
04-09-05 16:20 jdthood        Relationship added       duplicate of 0000481
08-25-05 10:10 rjh            Issue Monitored: rjh                         
08-25-05 11:56 tiwai          Relationship added       has duplicate 0001359
09-22-05 16:10 Gregoire       Note Added: 0006353                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
