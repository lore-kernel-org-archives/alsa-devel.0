From: noreply@alsa-project.org
Subject: [ALSA - driver 0000004]: snd.o misses undefined symbol sound_class
Date: Tue, 27 Jan 2004 21:15:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127201525.15CA423001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA14880
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:15:27 +0100
Received: from server.perex-int.cz (server-a.perex-int.cz [192.168.100.3])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 3126BEF
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 21:15:25 +0100 (MET)
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
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000004
======================================================================
Reporter:                   khali
Handler:                    
======================================================================
Project:                    ALSA - driver
Bug ID:                     4
Category:                   OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Slackware 8.0
Kernel Version:             2.4.24
======================================================================
Date Submitted:             01-27-2004 21:15 CET
Last Modified:              01-27-2004 21:15 CET
======================================================================
Summary:                    snd.o misses undefined symbol sound_class
Description: 
After installing the alsa drivers, I am unable to load snd.o. See the
output of "depmod -ae":
depmod: *** Unresolved symbols in
/lib/modules/2.4.24-1/kernel/sound/acore/snd.o
depmod:         sound_class

Configure options: --with-oss=yes --with-cards=intel8x0
Compilation successful.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:15 khali          New Bug                                      
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
