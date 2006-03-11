From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001364]: Channel mapping mixed-up for SB Extigy
Date: Sat, 11 Mar 2006 16:14:27 +0100
Message-ID: <741f751c584dea1e6af61e28e029a712@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C0E91A2
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 16:14:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1364> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1364
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.12.1
======================================================================
Date Submitted:             08-24-2005 01:00 CEST
Last Modified:              03-11-2006 16:14 CET
======================================================================
Summary:                    Channel mapping mixed-up for SB Extigy
Description: 
The channels mapping for my Extigy seems to be wrong.
"Rear Left" controls the Subwoofer
"Rear Right" controls the left rear speaker
"Subwoofer" controls the right rear speaker
======================================================================

----------------------------------------------------------------------
 andersin - 08-24-05 01:04 
----------------------------------------------------------------------
Sorry for the space, see bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001210 for details on 6
channel problems

----------------------------------------------------------------------
 andersin - 03-11-06 16:14 
----------------------------------------------------------------------
The problem is still present in 1.0.10rc3 in kernel 2.6.16-rc4.
When using amixer to check the speaker outputs with an AC3 testfile that
is directly send to the card through its 2nd device hw:Extigy,2 I get a
slightly different mapping ( maybe I messed it up the first time around:

control:      speaker:
front left   front left
front right  front right
rear left    front center
rear right   woofer
front center rear left
woofer       rear right

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 01:00 andersin       New Issue                                    
08-24-05 01:00 andersin       Distribution              => Gentoo Linux    
08-24-05 01:00 andersin       Kernel Version            => 2.6.12.1        
08-24-05 01:04 andersin       Note Added: 0005923                          
03-11-06 16:14 andersin       Note Added: 0008417                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
