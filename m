From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000959]: After S3 resume: ali_stimer_read: stimer is not ready
Date: Fri, 8 Jul 2005 22:48:59 +0200
Message-ID: <7a8f74b2a5f2c2489b9fc379d9977a39@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD7D5185
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 22:48:59 +0200 (MEST)
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
Last Modified:              07-08-2005 22:48 CEST
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
 tiwai - 07-08-05 14:59 
----------------------------------------------------------------------
Hmm, since I got reports that PM of ali5451 driver itself did work on some
2.6 kernel, I suspect that your problem comes from ACPI.
Did you try pci=noacpi or acpi=off boot option?

----------------------------------------------------------------------
 avuton - 07-08-05 22:48 
----------------------------------------------------------------------
I'm very sorry, but this machine cannot use APM due to it not being
equipped for it (it has no bios). And acpi=off would work but then I
wouldn't be able to suspend any longer thus defeating the purpose of this
bug :).

Thanks, anything else I can do please let me know.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 18:41 avuton         New Issue                                    
03-03-05 18:41 avuton         Distribution              => Gentoo          
03-03-05 18:41 avuton         Kernel Version            => 2.6.11          
05-02-05 02:22 avuton         Note Added: 0004583                          
06-27-05 03:52 avuton         Note Added: 0005270                          
07-08-05 14:59 tiwai          Note Added: 0005431                          
07-08-05 22:48 avuton         Note Added: 0005436                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
