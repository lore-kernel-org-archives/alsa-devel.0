From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000959]: After S3 resume: ali_stimer_read: stimer is not ready
Date: Mon, 27 Jun 2005 03:52:41 +0200
Message-ID: <2e2fa0b26076994d53095801c5d66637@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D24171CA
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 03:52:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=959> 
======================================================================
Reported By:                avuton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   959
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-03-2005 18:41 CET
Last Modified:              06-27-2005 03:52 CEST
======================================================================
Summary:                    After S3 resume: ali_stimer_read: stimer is not
ready
Description: 
After S3 resume, 'ali_stimer_read: stimer is not ready.' repeats until I
reset/power down the computer.

Workaround is to stop all audio activity and unload the driver, which
works fine.

This happens on my Libretto L5.
======================================================================

----------------------------------------------------------------------
 avuton - 05-02-05 02:22 
----------------------------------------------------------------------
This bug still exists in 2.6.12-rc3-mm2, I am a novice coder, and if this
is a simple issue I maybe able to deal with it. Pointers anyone?

The function the problem should be fixed in is: snd_ali_stimer_ready()
The file is: sound/pci/ali5451/ali5451.c

It seems like the sound card should be reset(?) in the do..while() in that
function.

Or am I totally missing things and should something happen before the
system goes to S3?

Any help would be appreciated, I will try taking a look at the other
drivers tonight for possible clues.

----------------------------------------------------------------------
 avuton - 06-27-05 03:52 
----------------------------------------------------------------------
This still does not work as of alsa 1.0.9b

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 18:41 avuton         New Issue                                    
03-03-05 18:41 avuton         Distribution              => Gentoo          
03-03-05 18:41 avuton         Kernel Version            => 2.6.11          
05-02-05 02:22 avuton         Note Added: 0004583                          
06-27-05 03:52 avuton         Note Added: 0005270                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
