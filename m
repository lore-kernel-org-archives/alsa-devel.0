From: noreply@alsa-project.org
Subject: [ALSA - driver 0000005]: alsa-driver-1.0.2: unresolved symbols in snd.o
Date: Tue, 27 Jan 2004 21:31:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127203153.D6C6A23002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA15270
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:31:55 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id E832FEF
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:31:53 +0100 (MET)
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


The following NEW bug has been ADDED.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000005
======================================================================
Reporter:                   ZlatkO
Handler:                    
======================================================================
Project:                    ALSA - driver
Bug ID:                     5
Category:                   CORE - control
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Slackware 8.1
Kernel Version:             2.4.24
======================================================================
Date Submitted:             01-27-2004 21:31 CET
Last Modified:              01-27-2004 21:31 CET
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:31 ZlatkO         New Bug                                      
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
