From: noreply@alsa-project.org
Subject: [ALSA - driver 0000005]: alsa-driver-1.0.2: unresolved symbols in snd.o
Date: Tue, 27 Jan 2004 22:37:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127213716.448954904B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA19273
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 22:37:22 +0100
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


A BUGNOTE has been added to this bug.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000005
======================================================================
Reporter:                   ZlatkO
Handler:                    perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     5
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   immediate
Status:                     assigned
Distribution:               Slackware 8.1
Kernel Version:             2.4.24
======================================================================
Date Submitted:             01-27-2004 21:31 CET
Last Modified:              01-27-2004 22:37 CET
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

----------------------------------------------------------------------
 khali - 01-27-2004 22:18 CET 
----------------------------------------------------------------------
Doesn't work for me. Even worse, alsa-driver doesn't compile anymore after
I commented the line out:

sound.c: In function `snd_register_device_R1f4c5f07':
sound.c:239: `sound_class' undeclared (first use in this function)
sound.c:239: (Each undeclared identifier is reported only once
sound.c:239: for each function it appears in.)
sound.c: In function `alsa_sound_init':
sound.c:376: `sound_class' undeclared (first use in this function)
sound.c: At top level:
sound.c:41: warning: `device_mode' defined but not used
make[1]: *** [sound.o] Error 1
make[1]: Leaving directory `/usr/src/alsa-driver-1.0.2/acore'
make: *** [compile] Error 1

----------------------------------------------------------------------
 perex - 01-27-2004 22:37 CET 
----------------------------------------------------------------------
Ok, can you add '#define sound_class NULL' after removing of suggested line
(on the same place)? Note that the rebuilded alsa-driver package has this
fix included.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:31 ZlatkO         New Bug                                      
01-27-04 22:08 perex          Bugnote Added: 0000005                       
01-27-04 22:08 perex          Assigned To               => perex           
01-27-04 22:08 perex          Status                   new => assigned     
01-27-04 22:08 perex          Priority                 normal => immediate 
01-27-04 22:15 perex          Category                 CORE - control => 0_compilation problem_!!!
01-27-04 22:18 khali          Bugnote Added: 0000007                       
01-27-04 22:37 perex          Bugnote Added: 0000008                       
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
