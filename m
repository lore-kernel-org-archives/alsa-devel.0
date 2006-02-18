From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001847]: hda-intel on acer laptop (travelmate 3002) - no recording
Date: Sat, 18 Feb 2006 01:32:38 +0100
Message-ID: <8f04fc74c73e0cd853aabd01579eecd9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7CCD31A7
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 01:32:38 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001643.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1847> 
======================================================================
Reported By:                lrupn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1847
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.1
Kernel Version:             2.6.12
======================================================================
Date Submitted:             02-15-2006 14:18 CET
Last Modified:              02-18-2006 01:32 CET
======================================================================
Summary:                    hda-intel on acer laptop (travelmate 3002) - no
recording
Description: 
I have an Acer laptop with sound card that claim to be Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev
04)
that is recognized as a SigmaTel STAC9200. 
With 1.0.11rc2 there is some noise when I unmute line-in (external
microphone) and try to record something. The amplitude response is ok and
actualy i am able to hear my voice but there is a lot of noise. I thing
that the problem is the mixer... The internal micorphone is not working at
all.\
With 1.0.11rc3 some new controls apear in the alsamixer but neither
speakers nor microphone is working....
I have found a similr bug report:
http://sourceforge.net/tracker/index.php?func=detail&aid=1389026&group_id=27464&atid=390601


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001643 Microphone is muted and no mic option a...
======================================================================

----------------------------------------------------------------------
 MACHINE - 02-16-06 12:13 
----------------------------------------------------------------------
The problem is also described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1643

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-15-06 14:18 lrupn          New Issue                                    
02-15-06 14:18 lrupn          Distribution              => Slackware 10.1  
02-15-06 14:18 lrupn          Kernel Version            => 2.6.12          
02-16-06 12:13 MACHINE        Note Added: 0008095                          
02-18-06 01:32 rlrevell       Relationship added       duplicate of 0001643
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
