From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Wed, 29 Dec 2004 19:37:13 +0100
Message-ID: <edc93a0c67bfc49d117f1043e7c08f00@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 55BB51BA
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 19:37:14 +0100 (MET)
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
Last Modified:              12-29-2004 19:37 CET
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
 aquarichy - 12-29-04 19:17 
----------------------------------------------------------------------
So, after running alsamixer on 2.6.10 and storing its settings,
asound.state is missing both control.1 and control.2 which, under 2.6.8.1,
were the Master Playback Switch and Master Playback Volume respectively. 
Those items still exist though, as control.3 and control.4.  Meanwhile,
control.3 and control.4 used to be Headphone Playback Switch and Headphone
Playback Volume respectively.  These no longer exist under 2.6.10's
settings at all.  

As I mentioned before, using 'alsactl -F restore' on my asound.state from
the working 2.6.8.1 just ends up in complaints and now sound.  I tried
manually editing in 'Headphone Playback *' stuff into control.1 and
control.2 which failed and after that, tried moving 'Master Playback *'
back to 1 and 2 and Headhpone into 3 and 4 (just like in the working
2.6.8.1's settings) and get the same error I posted before.

The telling error messages seem to be "alsactl: set_control:784: failed to
obtain info for control #[insert whichever number I am assigning the
headphone controls to] (No such file or directory)".   
I suppose that control.1 and control.2 must exist for 'Master Playback *'
and because my 2.6.9 and 2.6.10's alsa do not wish to recognise it, I get
muted playback :|  

Any more suggestions?

----------------------------------------------------------------------
 aquarichy - 12-29-04 19:37 
----------------------------------------------------------------------
additional information: using Slackware, I have four ALSA packages
installed: driver, lib, oss, and utils. All are version 1.0.7.  Could any
of those may be conflicting with the in-kernel versions? or would these
packages contain independent software?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
12-29-04 19:17 aquarichy      Note Added: 0003008                          
12-29-04 19:37 aquarichy      Note Added: 0003009                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
