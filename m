From: noreply@alsa-project.org
Subject: [ALSA - driver 0000006]: Machine locks up hard on rmmod snd_es1968
Date: Tue, 27 Jan 2004 21:49:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127204958.5187025008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA15754
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:50:08 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 56C52F4
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:49:58 +0100 (MET)
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
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006
======================================================================
Reporter:                   Hai
Handler:                    
======================================================================
Project:                    ALSA - driver
Bug ID:                     6
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.0
Kernel Version:             2.6.1-4-default
======================================================================
Date Submitted:             01-27-2004 21:49 CET
Last Modified:              01-27-2004 21:49 CET
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
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
