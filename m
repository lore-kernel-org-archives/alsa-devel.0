From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001785]: ice1712 driver -cs8427 SPDIF chip not always set up correctly
Date: Fri, 27 Jan 2006 21:48:12 +0100
Message-ID: <eb520a375bdf97b51f60add8ee5b88e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 093421B6
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 21:48:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1785> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1785
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-26-2006 23:27 CET
Last Modified:              01-27-2006 21:48 CET
======================================================================
Summary:                    ice1712 driver -cs8427 SPDIF chip not always set up
correctly
Description: 
There are regular occasions when SPDIF IN operates spuriously, on Terratec
DMX6fire (& presumably others, like delta1010LT?).

At start-up or when changing between non-spdif master clock settings,
Digital Input stream has incorrect signal present, real enough to be
recorded with audacity.  The cause is errors in writing to the cs8427
spdif chip.  Will add notes with my findings.
======================================================================

----------------------------------------------------------------------
 perex - 01-27-06 14:46 
----------------------------------------------------------------------
Ok, I selected the second way. I implemented the initialization for
ice1712.c. Could you test it and change the cs8427 code if necessary when
rate changes?

My code is in out.txt file attached to this bug.



----------------------------------------------------------------------
 nostar - 01-27-06 21:48 
----------------------------------------------------------------------
I have a Delta 1010LT with broken SPDIF as well. I tried manually
overriding the conditional, and applying the patch.  Neither of these mods
fix my problem.  This test in question, "if ((oval & ICE1712_SPDIF_MASTER)
!= (inb(ICEMT(ice, RATE)) & ICE1712_SPDIF_MASTER))" seems okay to me. 
It's only purpose is to test if the old master clock source had changed
between SPDIF In and any of the Internal clock settings. By toggling
between 48k and 44.1k as in the example given, they are both Internal
clock settings and therefore toggling the SPDIF In signal on or off as the
master clock source is not necessary.  

See my reply to "ice1712 -wordclock and SPDIF" on the alsa-devel list for
a description of the behavior I am seeing

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-26-06 23:27 alanmann       New Issue                                    
01-26-06 23:41 alanmann       Note Added: 0007795                          
01-26-06 23:50 alanmann       Note Edited: 0007795                         
01-27-06 10:10 alanmann       Note Added: 0007797                          
01-27-06 14:30 perex          File Added: out.txt                          
01-27-06 14:44 perex          File Deleted: out.txt                        
01-27-06 14:44 perex          File Added: out.txt                          
01-27-06 14:45 perex          Note Added: 0007801                          
01-27-06 14:46 perex          Note Edited: 0007801                         
01-27-06 21:48 nostar         Note Added: 0007806                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
