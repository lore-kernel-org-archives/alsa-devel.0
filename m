From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001873]: emu10k1 AC97 loopback on left channel only.
Date: Fri, 7 Apr 2006 19:25:48 +0200
Message-ID: <5fa9e0556107974ff12e9622a8cd373a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5B3615C
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 19:25:48 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1873> 
======================================================================
Reported By:                kenm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1873
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Slackware current
Kernel Version:             2.6.15.3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-24-2006 00:28 CET
Last Modified:              04-07-2006 19:25 CEST
======================================================================
Summary:                    emu10k1 AC97 loopback on left channel only.
Description: 
Creative Labs CT4832 SBLive Value
With alsa-driver versions 1.0.9b and previously, it was possible to set
both "AC97" and "AC97 Capture" to full volume in alsamixer, to set up
digital loopback to monitor in real time the sound recorded through "line
in" via "line out".  With version 1.0.10, the monitored sound appears on
the left channel only.  The right channel is completely muted.
======================================================================

----------------------------------------------------------------------
 kenm - 04-04-06 12:07 
----------------------------------------------------------------------
After some investigation, I now think this is an issue with AlsaMixer
v1.0.10, NOT with the emu10k1 driver.  It appears that alsamixer is only
setting the capture source for the left-hand channel.  The mixer settings
stored with alsactl include:

	control.64 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Line
		value.1 Mic
	}

Alsamixer only appears to be modifying the "value.0" entry.  Editing the
file manually to set "value.1 Line" and then re-loading the configuration
corrects the problem, giving expected output on both channels.

----------------------------------------------------------------------
 tiwai - 04-07-06 19:25 
----------------------------------------------------------------------
This bug is already fixed in the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-06 00:28 kenm           New Issue                                    
02-24-06 00:28 kenm           Distribution              => Slackware current
02-24-06 00:28 kenm           Kernel Version            => 2.6.15.3        
04-04-06 12:07 kenm           Note Added: 0009113                          
04-07-06 19:25 tiwai          Status                   new => resolved     
04-07-06 19:25 tiwai          Resolution               open => fixed       
04-07-06 19:25 tiwai          Assigned To               => tiwai           
04-07-06 19:25 tiwai          Note Added: 0009148                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
