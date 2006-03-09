From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001841]: Mixer not working  / fujitsu laptop V2060 with HDA intel & AD1986A
Date: Thu, 9 Mar 2006 18:23:48 +0100
Message-ID: <f793c32605148b5a565a455d51d6895b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECD511A7
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2006 18:23:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1841> 
======================================================================
Reported By:                fchevalier
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1841
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-11-2006 14:13 CET
Last Modified:              03-09-2006 18:23 CET
======================================================================
Summary:                    Mixer not working  / fujitsu laptop V2060 with HDA
intel & AD1986A
Description: 
Hi all,

I am unable to use mixer settings on my laptop.
Basically ALSA correctly detects HDA intel, Analog device chip. Mixer
settings are there but changing volume, muting/unmuting does not make any
difference. Playing  mp3 file with xmms sometimes i can hear some sound,
but not loud enough.
I tried with the latest ALSA version available, still not luck :-(

Can anyone help ?

Fabien
======================================================================

----------------------------------------------------------------------
 fchevalier - 03-09-06 17:01 
----------------------------------------------------------------------
Looks like afterwards this is a duplicated of bug id 1531...

----------------------------------------------------------------------
 tiwai - 03-09-06 18:23 
----------------------------------------------------------------------
Could you check whether the attached patch works with "model=3stack" module
option?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-11-06 14:13 fchevalier     New Issue                                    
03-09-06 17:01 fchevalier     Note Added: 0008392                          
03-09-06 18:23 tiwai          Note Added: 0008393                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
