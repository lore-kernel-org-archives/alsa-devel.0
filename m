From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000432]: Impossible de se connecter : NODIALTONE
Date: Sat, 28 Aug 2004 04:24:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040828022419.13A4F2D0BD@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8704C22B
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2004 04:24:19 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000432
======================================================================
Reported By:                Cyrille
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Bug ID:                     432
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10
Kernel Version:             2.4.24
======================================================================
Date Submitted:             08-08-2004 19:02 CEST
Last Modified:              08-28-2004 04:24 CEST
======================================================================
Summary:                    Impossible de se connecter : NODIALTONE
Description: 
I've got a TOSHIBA SATELITTE A30 222 laptop
Sound card and modem are based upon ATI IXP
But I'm not able to run modem in spite of the differents bug-report on
ALSA web site
(https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000422
-
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
 -
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000417
) and on Unixtrix.com (http://www.unixtrix.com/)

Even if I do like Ronis or Netstar say -bugtrack.alsa-project :
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
-, I'm always in the same situation : compilation is OK, modem driver OK
but I'm not able to connect : NODIALTONE
======================================================================

----------------------------------------------------------------------
 sashak - 08-25-2004 19:11 CEST 
----------------------------------------------------------------------
There is similar problem - some BIOSes doesn't report valid MODEM_PRESENT
bit in ATI_REG_CMD register (reg 003, bit 27 - look in
'/proc/asound/card1/atiixp'). Device behaviuor in this case is identical
to reported here - DMA works ok, line still be disconnected.

Uploaded patch solves the problem.

----------------------------------------------------------------------
 netstar - 08-26-2004 01:18 CEST 
----------------------------------------------------------------------
Additional problems with patch when applied to alsa CVS.  All conditions
necessary are met.

----------------------------------------------------------------------
 netstar - 08-26-2004 18:54 CEST 
----------------------------------------------------------------------
Forget that, now working fine, congratulations.

----------------------------------------------------------------------
 Cyrille - 08-26-2004 21:46 CEST 
----------------------------------------------------------------------
Concretrely, does it mean the current version of alsa driver will not run
with this hardware ?
Thanx

----------------------------------------------------------------------
 Cyrille - 08-26-2004 21:47 CEST 
----------------------------------------------------------------------
Oups, I've got not see the last Netstar message...
I try to test it...

----------------------------------------------------------------------
 Cyrille - 08-27-2004 15:41 CEST 
----------------------------------------------------------------------
Hello
I have try Sashak's tip but the upload patch don't solve the problem.
Always the same error message : NODIALTONE.
(with alsa-driver/lib/... 1.0.6 ; test with slmodem-2.9.9 unless patch and
with Ronis's patch).
At your mind, is there really no hope to run it ?

----------------------------------------------------------------------
 netstar - 08-28-2004 04:24 CEST 
----------------------------------------------------------------------
It seems that the new patch fixes the issues.  Note:  The earlier 
"fixed" slmodem package on my site was actually broken, attaching a fixed
version to this page and updating the file on my site.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 19:02 Cyrille        New Bug                                      
08-08-04 19:02 Cyrille        Distribution              => Slackware 10    
08-08-04 19:02 Cyrille        Kernel Version            => 2.4.24          
08-08-04 19:02 Cyrille        Bug Monitored: Cyrille                       
08-25-04 19:04 sashak         File Added: atiixp_modem.patch                    
08-25-04 19:11 sashak         Bugnote Added: 0001624                       
08-26-04 01:16 netstar        File Added: debugging.tar.gz                    
08-26-04 01:18 netstar        Bugnote Added: 0001630                       
08-26-04 18:54 netstar        Bugnote Added: 0001634                       
08-26-04 21:46 Cyrille        Bugnote Added: 0001636                       
08-26-04 21:47 Cyrille        Bugnote Added: 0001637                       
08-27-04 15:41 Cyrille        Bugnote Added: 0001644                       
08-27-04 19:33 tiwai          Assigned To              tiwai => sashak     
08-28-04 04:24 netstar        Bugnote Added: 0001660                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
