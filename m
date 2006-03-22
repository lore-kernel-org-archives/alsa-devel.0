From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001953]: Onboard Soundcard (STAC9221) records only noise
Date: Wed, 22 Mar 2006 08:13:46 +0100
Message-ID: <e7d342181cc830f86f0245ea0aac891c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 432ED192
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 08:13:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1953> 
======================================================================
Reported By:                derquader
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1953
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Opensuse 10.0
Kernel Version:             2.6.13-15.8
======================================================================
Date Submitted:             03-22-2006 08:04 CET
Last Modified:              03-22-2006 08:13 CET
======================================================================
Summary:                    Onboard Soundcard (STAC9221) records only noise
Description: 
I am using a Intel 945GCZ board with an integrated Sigmatel STAC9221
soundcard.

When I try to record sound from my microphone I only get noise (and if I
listen very closely there is my voice very quiet in the background).

I have tried to set the amplification to maxium which gives me loud noise
but does not make my voice sound any better :-/

(Recording works well with WinXP)
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 08:13 
----------------------------------------------------------------------
Is the problem still present with ALSA CVS?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-06 08:04 derquader      New Issue                                    
03-22-06 08:04 derquader      Distribution              => Opensuse 10.0   
03-22-06 08:04 derquader      Kernel Version            => 2.6.13-15.8     
03-22-06 08:13 rlrevell       Note Added: 0008848                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
