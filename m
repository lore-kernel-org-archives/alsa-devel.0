From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001806]: SPDIF and Wordclock I/O is broken on Delta 1010LT
Date: Fri, 10 Feb 2006 05:00:48 +0100
Message-ID: <2a8a21991d439143d07b0d193d949041@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF798149
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 05:00:48 +0100 (MET)
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
Last Modified:              02-10-2006 05:00 CET
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
 perex - 02-08-06 09:24 
----------------------------------------------------------------------
nostar: I applied envy.diff to CVS. But for driver - I just like to confirm
that only change in the driver is that the Word Clock GPIO bit is inverted
for 1010LT. Ok? Is this tested? From your previous comments I guess that
you have still problems with Word Clock syncing.

----------------------------------------------------------------------
 nostar - 02-10-06 05:00 
----------------------------------------------------------------------
1010lt_spdif_fixes.diff is a final patch for the driver.  This patch
includes everything, so once again, disregard the others.  I added a
control "Word Clock Status" for the 1010LT.  With this control, it now
correctly updates between 'Locked' and 'No Signal' when
connecting/disconnecting a valid spdif signal to SPDIF In.

perex:  To answer your question, yes; the specific fix for spdif
functionality on the 1010LT is the invert bit.   This completely fixes
both SPDIF In and Out, and also Word Clock out. Still no Word Clock Input
though.  I hope that you will add the GPIO register outputs to the proc
call too, as it is invaluable in helping others on irc, etc get dual
1010LT's set up correctly and other troubleshooting.  I will continue to
investigate word clock input, but this fix gives me the long awaited
ability to use dual 1010lt's for 16 track recording, so I'm going to to do
some serious recording for a while first.

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
02-08-06 09:24 perex          Note Added: 0007963                          
02-10-06 05:00 nostar         Note Added: 0007985                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
