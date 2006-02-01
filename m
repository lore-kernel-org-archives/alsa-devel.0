From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001805]: sound in headphones, but not in speakers with SIS 7012 ALC 655 rev 0
Date: Wed, 1 Feb 2006 16:33:38 +0100
Message-ID: <5bd6026ee7ff88c287c1be8b4ea58aa0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D62761E1
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 16:33:38 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1805> 
======================================================================
Reported By:                dragonic_pchan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1805
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               mandriva linux 2006
Kernel Version:             2.6.15.2
======================================================================
Date Submitted:             02-01-2006 16:33 CET
Last Modified:              02-01-2006 16:33 CET
======================================================================
Summary:                    sound in headphones, but not in speakers with SIS
7012 ALC 655 rev 0
Description: 
I dont have sounds through the speakers of my laptop (MSI megabook S250),
but i can hear sound through headphones. I tried to mute/unmute things in
alsamixer while headphones are plugged and mplayer is playing music. Here
are the results :

master button : mutes sounds
pcm button : mutes sound
phones button : doesn't mute sound !!!
other buttons do nothing when muting

Under windows sounds works fine. Nothing changes wether i use in-kernel
alsa or the latest alsa 1.0.11rc3.

Note : I have to pass option "nolapic" to the kernel for the sound card to
work, as well as the ethenet card.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-06 16:33 dragonic_pchan New Issue                                    
02-01-06 16:33 dragonic_pchan File Added: asound.state                     
02-01-06 16:33 dragonic_pchan Distribution              => mandriva linux 2006
02-01-06 16:33 dragonic_pchan Kernel Version            => 2.6.15.2        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
