From: noreply@alsa-project.org
Subject: [ALSA - driver 0000005]: alsa-driver-1.0.2: unresolved symbols in snd.o
Date: Tue, 27 Jan 2004 22:08:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127210829.C477325009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA18314
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 22:08:35 +0100
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


The following bug has been ASSIGNED.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000005
======================================================================
Reporter:                   ZlatkO
Handler:                    perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     5
Category:                   CORE - control
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 8.1
Kernel Version:             2.4.24
======================================================================
Date Submitted:             01-27-2004 21:31 CET
Last Modified:              01-27-2004 22:08 CET
======================================================================
Summary:                    alsa-driver-1.0.2: unresolved symbols in snd.o
Description: 
snd.o fails to load due to an unresolved symbol ("sound_class") on a
Slackware 8.1 system, kernel 2.4.24 (plain vanilla from kernel.org),
modutils-2.4.16.

There is no "sound_class" in the kernel's own
/usr/src/linux-2.4.24/drivers/sound/sound_core.c - am I supposed to
replace it with alsa-kernel/sound_core.c? This was not necessary in
previous ALSA versions.
======================================================================

----------------------------------------------------------------------
 perex - 01-27-2004 22:08 CET 
----------------------------------------------------------------------
I cannot reproduce this bug, but it might be possible that removing
of line 'extern struct class_simple *sound_class;' in
alsa-driver/alsa-kernel/core/sound.c solves this bug.

Can you confirm?

I've recreated new alsa-driver package with date:

Jan 27 22:02 alsa-driver-1.0.2.tar.bz2

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:31 ZlatkO         New Bug                                      
01-27-04 22:08 perex          Bugnote Added: 0000005                       
01-27-04 22:08 perex          Assigned To               => perex           
01-27-04 22:08 perex          Status                   new => assigned     
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
