From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000536]: Sound no longer works on IBM ThinkPad 600x after waking from sleep
Date: Fri, 24 Sep 2004 16:23:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924142302.AFB313E01B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF0B0263
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 16:23:02 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id C002F25AEE
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 16:23:02 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000536
======================================================================
Reported By:                bkendig
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     536
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC2
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-24-2004 16:23 CEST
Last Modified:              09-24-2004 16:23 CEST
======================================================================
Summary:                    Sound no longer works on IBM ThinkPad 600x after waking from sleep
Description: 
After booting this laptop, sound works fine; but after putting the system
to sleep and waking it, sound will no longer work until the system is
rebooted.  No error messages are displayed.

This is an IBM ThinkPad 600x, which has a feature where it will cut power
to the PCI bus to save battery when the bus is not being used.  I believe
this is what's killing ALSA.

This system is running Fedora Core 2 with kernel version 2.6.9-rc2, but
the problem has occurred with every version of 2.6 since its release.

The sound modules can not be unloaded because the system believes they're
still in use. "/sbin/rmmod snd_cs46xx" returns "ERROR: Module snd_cs46xx
is in use".


======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 16:23 bkendig        New Bug                                      
09-24-04 16:23 bkendig        Distribution              => FC2             
09-24-04 16:23 bkendig        Kernel Version            => 2.6.9-rc2       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
