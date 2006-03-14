From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001801]: Audiophile USB noisy analog capture
Date: Tue, 14 Mar 2006 16:55:57 +0100
Message-ID: <02504019c105226aec5ebcba78cf53e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BCE371BA
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 16:55:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1801> 
======================================================================
Reported By:                lemeur
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1801
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.15.1-rt3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-31-2006 16:04 CET
Last Modified:              03-14-2006 16:55 CET
======================================================================
Summary:                    Audiophile USB noisy analog capture
Description: 
The audiophile usb analog capture interface seems to be unreliably
initialized by the ALSA driver.

Just after bootup (or after an /etc/init.d/alsasound restart) the sound
recorded on the analog capture port is sometimes either:
- Case A: saturated/distorted (as if it had a very high volume gain)
or
- Case B: completly inaudible and loud white noised
or
- Case C: sometimes the sound is good

This issue affects:
* only the analog capture interface and not the SPDIF digital capture
interface
* playback is always working
* both hw:1,1 (analog capture) and plughw:1,1 (analog cpautre with plug)


======================================================================

----------------------------------------------------------------------
 lemeur - 03-14-06 15:28 
----------------------------------------------------------------------
The bug was due to the way the snd-usb-audio driver initializes the
audiophile usb device.

I've submitted a patch (now included into CVS). For this patch to take
effect you should use the new "device_setup" module parameter as described
in the included doc (alsa-kernel/Documentation/Audiophile-Usb.txt).

Thanks a lot to you guys who helped me troubleshooting and tracking down
this issue (Takashi, Andreas, Sander, ...).

I suppose that this ticket can be closed now.

----------------------------------------------------------------------
 tiwai - 03-14-06 16:55 
----------------------------------------------------------------------
Closing now.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 16:04 lemeur         New Issue                                    
01-31-06 16:04 lemeur         Kernel Version            => 2.6.15.1-rt3    
02-02-06 14:20 lemeur         Issue Monitored: lemeur                      
02-07-06 10:23 lemeur         Note Added: 0007956                          
03-14-06 15:28 lemeur         Note Added: 0008482                          
03-14-06 16:55 tiwai          Status                   assigned => resolved
03-14-06 16:55 tiwai          Resolution               open => fixed       
03-14-06 16:55 tiwai          Note Added: 0008489                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
