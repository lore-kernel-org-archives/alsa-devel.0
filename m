From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Wed, 29 Dec 2004 19:02:17 +0100
Message-ID: <8cbb8beba8bad7720fa3bc370e216e7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C56826B
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 19:02:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=750> 
======================================================================
Reported By:                aquarichy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   750
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             2.6.9+
======================================================================
Date Submitted:             12-28-2004 02:20 CET
Last Modified:              12-29-2004 19:02 CET
======================================================================
Summary:                    no sound since 2.6.8.1
Description: 
Sound using a kernel.org 2.6.8.1 kernel with ALSA built-in worked.  When I
compile  any newer stable kernel, there is no sound.  Compilation executes
without complaints.  No Sound related options change.  I have even tried
saying No to all the new options 2.6.9 and .10 provided in fear that one
of those might be interfering, but nada.  
======================================================================

----------------------------------------------------------------------
 tiwai - 12-29-04 14:12 
----------------------------------------------------------------------
Use -F option for alsactl to force to load controls in such a case.
The init script should use this.

----------------------------------------------------------------------
 aquarichy - 12-29-04 19:02 
----------------------------------------------------------------------
Thank you. Though -F failed to improve the situation it provided more
messages!

First off, I should have put this in my last post, but when I go into
2.6.10 from a working 2.6.8.1, I see the following during boot:

Loading ALSA mixer settings: /usr/sbin/alsactl restore
/usr/sbin/alsactl: set_control:797: warning: numid mismatch (1/3) for
control https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
/usr/sbin/alsactl: set_control:797: warning: numid mismatch (2/4) for
control https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
/usr/sbin/alsactl: set_control:805: warning: name mismatch (Headphone
Playback S
witch/Master Playback Switch) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3
/usr/sbin/alsactl: set_control:805: warning: name mismatch (Headphone
Playback V
olume/Master Playback Volume) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4


Using -F, I get: 

# alsactl -F restore
alsactl: set_control:797: warning: numid mismatch (1/3) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
alsactl: set_control:797: warning: numid mismatch (2/4) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
alsactl: set_control:784: failed to obtain info for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 (No such
file or 
directory)
alsactl: set_control:784: failed to obtain info for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 (No such
file or 
directory)

I will now try to research this numid business :|  Thank you again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
