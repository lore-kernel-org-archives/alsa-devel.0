From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000488]: stac946x.h is missing in CVS
Date: Wed,  8 Sep 2004 13:21:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908112130.1BBFC13002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C9FC62A8
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 13:21:30 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 2F23721005
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 13:21:30 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000488
======================================================================
Reported By:                sashak
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     488
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.7-gentoo-r13
======================================================================
Date Submitted:             09-08-2004 13:21 CEST
Last Modified:              09-08-2004 13:21 CEST
======================================================================
Summary:                    stac946x.h is missing in CVS
Description: 
Today's 7/09 CVS snapshot 'prodigy192.c' (new file) compilation fails
because of missing 'stac946x.h' file (most likely
alsa-kernel/pci/ice1712/stac946x.h). Error message frag is below:

In file included from
/home/sashak/alsa/alsa-driver/pci/ice1712/prodigy192.c:2:
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c:37:22:
stac946x.h: No such file or directory
In file included from
/home/sashak/alsa/alsa-driver/pci/ice1712/prodigy192.c:2:
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c: In
function `stac9460_dac_mute_get':
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c:68:
error: `STAC946X_MASTER_VOLUME' undeclared (first use in this function)
...
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 13:21 sashak         New Bug                                      
09-08-04 13:21 sashak         Kernel Version            => 2.6.7-gentoo-r13
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
