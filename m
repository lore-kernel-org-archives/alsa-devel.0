From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001806]: SPDIF and Wordclock I/O is broken on Delta 1010LT
Date: Mon, 6 Feb 2006 17:36:11 +0100
Message-ID: <61ecf6fa3164424d2c244acd76f669ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A5FC1D7
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2006 17:36:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1806> 
======================================================================
Reported By:                nostar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1806
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-01-2006 23:06 CET
Last Modified:              02-06-2006 17:36 CET
======================================================================
Summary:                    SPDIF and Wordclock I/O is broken on Delta 1010LT
Description: 
SPDIF output is non existant unless SPDIF In is connected to a valid output
source.  Then, the signal on SPDIF output is typically just noise.  If I
toggle between any internal clock setting and SPDIF In using
envy24control, eventually I will get audible audio.  Using an o-scope on
the wordclock output, I get flatline unless there is a valid SPDIF Input
signal.  I can switch to an internal clock setting while there is an SPDIF
In signal connected, and the Word Clock signal will be present, at the
frequency of the SPDIF In signal though, and not the frequency of the
selected internal clock frequency.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001785 ice1712 driver -cs8427 SPDIF chip not a...
======================================================================

----------------------------------------------------------------------
 nostar - 02-06-06 12:08 
----------------------------------------------------------------------
envy.diff fixes the problem of not being able to select word clock directly
from an internal clock source (on all cards, not just the 1010LT).



----------------------------------------------------------------------
 nostar - 02-06-06 17:36 
----------------------------------------------------------------------
I just uploaded driver02.diff. Please disregard driver.diff and use this
instead.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-06 23:06 nostar         New Issue                                    
02-01-06 23:06 nostar         File Added: snd_ice1712_proc_read.c               
    
02-02-06 08:59 perex          Relationship added       related to 0001785  
02-02-06 09:00 perex          Note Added: 0007871                          
02-03-06 16:14 nostar         Note Added: 0007898                          
02-06-06 11:41 nostar         Note Added: 0007947                          
02-06-06 11:41 nostar         File Added: driver.diff                      
02-06-06 12:03 nostar         Issue Monitored: nostar                      
02-06-06 12:05 nostar         Note Added: 0007948                          
02-06-06 12:05 nostar         File Added: envy.diff                        
02-06-06 12:06 nostar         Note Edited: 0007947                         
02-06-06 12:07 nostar         Note Edited: 0007947                         
02-06-06 12:08 nostar         Note Edited: 0007948                         
02-06-06 17:35 nostar         File Added: driver02.diff                    
02-06-06 17:36 nostar         Note Added: 0007949                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
