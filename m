From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000479]: [Patch] VIA based AC97 modem driver
Date: Wed,  8 Sep 2004 17:03:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908150306.6A6A513002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E46642B3
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 17:03:07 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000479
======================================================================
Reported By:                sashak
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Bug ID:                     479
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             09-02-2004 21:24 CEST
Last Modified:              09-08-2004 17:03 CEST
======================================================================
Summary:                    [Patch] VIA based AC97 modem driver
Description: 
New 'via82xx_modem.c' driver supports VIA based AC97 modems. (tested with
2.6.8.1). The patch (for alsa-driver) is uploaded.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-03-2004 15:52 CEST 
----------------------------------------------------------------------
Thanks, the patch was applied to CVS.

----------------------------------------------------------------------
 sashak - 09-08-2004 16:36 CEST 
----------------------------------------------------------------------
Related config definition is needed to provide convensional "modem" device.

----------------------------------------------------------------------
 sashak - 09-08-2004 16:40 CEST 
----------------------------------------------------------------------
Uploaded patch is for 'alsa-lib' conf: VIA82XX-MODEM card definition.

----------------------------------------------------------------------
 tiwai - 09-08-2004 17:03 CEST 
----------------------------------------------------------------------
I forgot to commit my patch.

We don't need to add a new file since the configuration is
identical with ICH-MODEM.  The alias is added to CVS now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-02-04 21:24 sashak         New Bug                                      
09-02-04 21:24 sashak         File Added: via-modem.patch                    
09-03-04 15:52 tiwai          Bugnote Added: 0001692                       
09-03-04 15:52 tiwai          Resolution               open => fixed       
09-03-04 15:52 tiwai          Status                   assigned => resolved
09-08-04 16:36 sashak         Bugnote Added: 0001729                       
09-08-04 16:36 sashak         Resolution               fixed => reopened   
09-08-04 16:36 sashak         Status                   resolved => feedback
09-08-04 16:40 sashak         Bugnote Added: 0001730                       
09-08-04 17:03 tiwai          Bugnote Added: 0001731                       
09-08-04 17:03 tiwai          Resolution               reopened => fixed   
09-08-04 17:03 tiwai          Status                   feedback => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
