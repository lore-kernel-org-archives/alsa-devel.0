From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001860]: Writing MIDI messages to the MIDI output of an M-Audio Audiophile 2496 causes a hard lockup of the system
Date: Mon, 20 Feb 2006 19:58:36 +0100
Message-ID: <252cdb3e4e8ce01f3d2c5164faea9a9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 428641C7
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2006 19:58:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1860> 
======================================================================
Reported By:                Vesuri
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1860
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               DIY
Kernel Version:             2.6.15.3
======================================================================
Date Submitted:             02-19-2006 21:14 CET
Last Modified:              02-20-2006 19:58 CET
======================================================================
Summary:                    Writing MIDI messages to the MIDI output of an
M-Audio Audiophile 2496 causes a hard lockup of the system
Description: 
When MIDI messages are sent through the MIDI output port of an M-Audio
Audiophile 2496 for a while the entire system locks up completely. Even
the magic SysRq key won't do anything. I have no way to debug through the
serial port so I don't know if anything is written to the system log - at
least nothing is written so that it would get shown on the screen. This
occurs after playing a MIDI song (for example) for a while - sometimes
after a few seconds, sometimes after a few minutes. Usually it takes 1-2
minutes to reproduce the lockup.

This is a major annoyance since it is not possible to compose anything on
the system due to the lockups.
======================================================================

----------------------------------------------------------------------
 Vesuri - 02-20-06 19:39 
----------------------------------------------------------------------
Does not occur with Linux 2.6.12.6 (ALSA 1.0.9rc2).

----------------------------------------------------------------------
 Vesuri - 02-20-06 19:58 
----------------------------------------------------------------------
Does not occur with Linux 2.6.13.5 (ALSA 1.0.9b).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-06 21:14 Vesuri         New Issue                                    
02-19-06 21:14 Vesuri         Distribution              => DIY             
02-19-06 21:14 Vesuri         Kernel Version            => 2.6.15.3        
02-19-06 21:16 Vesuri         Note Added: 0008136                          
02-19-06 23:29 Vesuri         Note Added: 0008139                          
02-20-06 19:39 Vesuri         Note Added: 0008145                          
02-20-06 19:58 Vesuri         Note Added: 0008146                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
