From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001954]: Patch from bug 0001895 hasn't been put in CVS yet
Date: Thu, 23 Mar 2006 21:01:27 +0100
Message-ID: <afc6665d21087bea13628b25ac56fd3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD90919D
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 21:01:27 +0100 (MET)
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
Status:                     assigned
Distribution:               Fedora 5 x86_64
Kernel Version:             2.6.15-1.2054_FC5
======================================================================
Date Submitted:             03-23-2006 07:17 CET
Last Modified:              03-23-2006 21:01 CET
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
 tiwai - 03-23-06 11:08 
----------------------------------------------------------------------
The model is named as "laptop", since it's mainly designed for laptops.

If it doesn't work or any mixer controls don't match with the actual I/O,
let me know.

----------------------------------------------------------------------
 johnfivealive - 03-23-06 21:01 
----------------------------------------------------------------------
tiwai, I downloaded the just released rc4 drivers and the hda-intel driver
now works fine with my A8N-VM with model=laptop passed as an option in
modprobe.conf. Without this option the driver still is buggy like before.
But with model=laptop everything seems to be fine. Thanks very much!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-06 07:17 johnfivealive  New Issue                                    
03-23-06 07:17 johnfivealive  Distribution              => Fedora 5 x86_64 
03-23-06 07:17 johnfivealive  Kernel Version            => 2.6.15-1.2054_FC5
03-23-06 07:19 johnfivealive  Issue Monitored: johnfivealive                    
03-23-06 11:08 tiwai          Note Added: 0008880                          
03-23-06 21:01 johnfivealive  Note Added: 0008902                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
