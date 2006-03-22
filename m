From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000941]: Behringer BCA 2000 USB device not recognized
Date: Wed, 22 Mar 2006 03:44:36 +0100
Message-ID: <5b69e59216183f9bf50da0255dc92ae6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 591711A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:44:36 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=941> 
======================================================================
Reported By:                sten69
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   941
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Project CCRMA/Fedora Core 1
Kernel Version:             2.4.26-1.ll.rhfc1.ccrma
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-24-2005 13:59 CET
Last Modified:              03-22-2006 03:44 CET
======================================================================
Summary:                    Behringer BCA 2000 USB device not recognized
Description: 
The Behringer BCA 2000 device is not recognized by ALSA as a USB sound
card.  The device is recognized by Windows XP using the Behringer drivers.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000918 Behringer BCA-2000
======================================================================

----------------------------------------------------------------------
 sten69 - 03-05-05 20:33 
----------------------------------------------------------------------
The device didn't work even under Windows and with the newest Behringer
drivers.  (It was recognized as a sound card, but playback stopped after
1:30 or so; not something that you're apt to notice when you're just
testing.  Recording did not work at all.)  Some people also have this
problem and Behringer is working on the issue.

That means that (a) the device won't work using a generic USB audio driver
and (b) Behringer itself is having problems controlling its own device.  I
have returned the BCA today and got my money back.

The ALSA soundcard matrix only says about USB that "all USB devicews that
are standards compliant will work."  Which standards are these? How can I,
as a consumer, check whether a device that I have in mind is "standards
compliant" or not?

Thanks for the support and keep up the good work.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:44 
----------------------------------------------------------------------
Not a bug (device uses proprietary protocol which can't be supported)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-05 13:59 sten69         New Issue                                    
02-24-05 13:59 sten69         Distribution              => Project CCRMA/Fedora
Core 1
02-24-05 13:59 sten69         Kernel Version            =>
2.4.26-1.ll.rhfc1.ccrma
02-24-05 14:01 sten69         Issue Monitored: sten69                      
02-28-05 18:15 Clemens LadischRelationship added       has duplicate 0000918
02-28-05 18:21 Clemens LadischNote Added: 0003747                          
02-28-05 21:33 rlrevell       Note Added: 0003748                          
03-01-05 09:25 Clemens LadischNote Added: 0003754                          
03-05-05 20:33 sten69         Note Added: 0003804                          
03-22-06 03:44 rlrevell       Status                   assigned => closed  
03-22-06 03:44 rlrevell       Note Added: 0008834                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
