From: noreply@alsa-project.org
Subject: [ALSA - driver 0000401]: alsaconf correctly identifies the driver, but it fails to load properly
Date: Wed, 21 Jul 2004 18:30:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040721163031.E5AD92D0BD@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54814259
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2004 18:30:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000401
======================================================================
Reported By:                ronis
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     401
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               slackware-10.0
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-21-2004 18:30 CEST
Last Modified:              07-21-2004 18:30 CEST
======================================================================
Summary:                    alsaconf correctly identifies the driver, but it fails to load properly
Description: 
alsaconf chooses this driver, but when it tries to load:

 kernel: ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error
-13

No sound, needless to say.


======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 18:30 ronis          New Bug                                      
07-21-04 18:30 ronis          Distribution              => slackware-10.0  
07-21-04 18:30 ronis          Kernel Version            => 2.6.7           
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
