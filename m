From: noreply@alsa-project.org
Subject: [ALSA - driver 0000006]: Machine locks up hard on rmmod snd_es1968
Date: Wed, 28 Jan 2004 11:37:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040128103758.7A31A30003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA08085
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 11:38:00 +0100
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
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006
======================================================================
Reporter:                   Hai
Handler:                    tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     6
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.0
Kernel Version:             2.6.1-4-default
======================================================================
Date Submitted:             01-27-2004 21:49 CET
Last Modified:              01-28-2004 11:37 CET
======================================================================
Summary:                    Machine locks up hard on rmmod snd_es1968
Description: 
When my init scripts rmmod snd_es1968 on shutdown, the machine locks up
completely. SysRq-[TPUS] all do not work, only SysRq-[OB] work. This means
I get an hang on every shutdown/reboot
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:49 Hai            New Bug                                      
01-28-04 11:37 tiwai          Assigned To               => tiwai           
01-28-04 11:37 tiwai          Status                   new => assigned     
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
