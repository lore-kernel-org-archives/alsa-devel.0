From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001954]: Patch from bug 0001895 hasn't been put in CVS yet
Date: Wed, 29 Mar 2006 18:55:16 +0200
Message-ID: <72076a8e7ea369f945744b21224e2faf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 341B6132
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:55:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1954> 
======================================================================
Reported By:                johnfivealive
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1954
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora 5 x86_64
Kernel Version:             2.6.15-1.2054_FC5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-23-2006 07:17 CET
Last Modified:              03-29-2006 18:55 CEST
======================================================================
Summary:                    Patch from bug 0001895 hasn't been put in CVS yet
Description: 
Hello, the patch created in bug 0001895 as far as I can see hasn't been
applied to CVS yet. The last note from tiwai says he put it in CVS, but
I'm assuming he meant to but perhaps forgot. This is just a reminder if
that is the case. I tried the patch myself and my onboard sound seems to
be working fine now. My mobo is an Asus A8N-VM, same chip discussed in bug
0001895. Thanks.

======================================================================

----------------------------------------------------------------------
 johnfivealive - 03-27-06 06:49 
----------------------------------------------------------------------
There seems to be one small problem now, the GNOME Volume Control mixer
seems to now be selecting the Headphone channel as the main volume control
instead of the Front channel, which appears to be the one which controls
the main volume. The Volume Control program seems to be selecting the
correct main channel (Front) with model=laptop, not sure what the
discrepancy here is and how I would go about correcting it. Maybe a
setting in the driver could correct this?

----------------------------------------------------------------------
 tiwai - 03-29-06 18:55 
----------------------------------------------------------------------
It's basically an issue of mixer apps, which don't let you access the
"Front" control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-06 07:17 johnfivealive  New Issue                                    
03-23-06 07:17 johnfivealive  Distribution              => Fedora 5 x86_64 
03-23-06 07:17 johnfivealive  Kernel Version            => 2.6.15-1.2054_FC5
03-23-06 07:19 johnfivealive  Issue Monitored: johnfivealive                    
03-23-06 11:08 tiwai          Note Added: 0008880                          
03-23-06 21:01 johnfivealive  Note Added: 0008902                          
03-23-06 21:08 tiwai          Note Added: 0008903                          
03-24-06 06:18 johnfivealive  Note Added: 0008913                          
03-26-06 01:54 tiwai          Note Added: 0008962                          
03-27-06 06:44 johnfivealive  Note Added: 0008990                          
03-27-06 06:49 johnfivealive  Note Added: 0008991                          
03-29-06 18:55 tiwai          Status                   assigned => resolved
03-29-06 18:55 tiwai          Resolution               open => fixed       
03-29-06 18:55 tiwai          Note Added: 0009003                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
