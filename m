From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Wed, 29 Dec 2004 08:23:40 +0100
Message-ID: <4f9ce71275443cd7ef1c116afeefdbba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 27A7B2C9
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 08:23:41 +0100 (MET)
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
Last Modified:              12-29-2004 08:23 CET
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
 aquarichy - 12-29-04 08:23 
----------------------------------------------------------------------
When booting into 2.6.10 after successfully running on 2.6.8.1, I get a
warning about mixer settings mismatch.  If I run alsamixer, ensure that
nothing is muted and that volume is up on everything, and then run
'alsactl store' I still do not have volume.  However, if I then boot back
into 2.6.8.1, I get the following message during boot up: 
"Loading ALSA mixer settings: /usr/bin/alsactl restore
/usr/sbin/alsactl: set_control:805: warning: name mismatch (Master
Playback Switch/Headphone Playback Switch) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3
/usr/sbin/alsactl: set_control:805: warning: name mismatch (Master
Playback Volume/Headphone Playback Volume) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4"
and if I enter alsamixer, the Master 'item' is /now/ set to mute.  

I am guessing that 2.6.9 <= kernel versions have different control values
or something, and perhaps it believes the Master sound is muted? 
Alsamixer in 2.6.9 <= reports itself as non-muted, though no sound comes
out, and while in <= 2.6.8.1 after using 2.6.10, alsamixer says the master
had been muted :|

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
