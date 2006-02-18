From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001643]: Microphone is muted and no mic option available
Date: Sat, 18 Feb 2006 01:32:41 +0100
Message-ID: <5e01c2d8e31cbbf6a6b53271f8476513@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0DFB1AF
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 01:32:41 +0100 (MET)
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


The issue 0001847 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1643> 
======================================================================
Reported By:                MACHINE
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1643
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-12-2005 04:12 CET
Last Modified:              02-16-2006 21:45 CET
======================================================================
Summary:                    Microphone is muted and no mic option available
Description: 
This issue exists since I bought this notebook, and it was never solved
since ALSA 1.0.9, no matter what kernel I use.

The only mixer option related to microphone is "Input Source", and there
is a "Front Mic", but useless.

in 'alsamixer -V capture', the only three columns are IEC958, Capture, and
Capture (not a typo!)

I unmuted everything and push every volumes to 100%. Everything works
fine, except microphone.

Hardware has no problem (checked by Windows2000).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001847 hda-intel on acer laptop (travelmate 30...
======================================================================

----------------------------------------------------------------------
 lrupn - 02-16-06 21:45 
----------------------------------------------------------------------
Do You have a "PCM" control in alsamixer?
When I start my Slackware in console mode (without kde) i do not have PCM
control and there is no sound from the speakers, however if i start a kde
sesion it magicaly aperas and everything is working.... (except
microphone)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 04:12 MACHINE        New Issue                                    
12-12-05 04:12 MACHINE        File Added: alsa                             
12-12-05 04:12 MACHINE        Distribution              => Gentoo          
12-12-05 04:12 MACHINE        Kernel Version            => 2.6.14.3        
02-16-06 17:56 lrupn          Issue Monitored: lrupn                       
02-16-06 21:45 lrupn          Note Added: 0008102                          
02-18-06 01:32 rlrevell       Relationship added       has duplicate 0001847
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
