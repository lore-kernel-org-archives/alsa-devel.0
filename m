From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000452]: Rate control sticks in IEC958 value
Date: Thu, 26 Aug 2004 17:48:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040826154847.257D324006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 63524277
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2004 17:48:47 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000452
======================================================================
Reported By:                Andrew
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     452
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             08-18-2004 12:51 CEST
Last Modified:              08-26-2004 17:48 CEST
======================================================================
Summary:                    Rate control sticks in IEC958 value
Description: 
After setting Multi Track Internal Clock control
to IEC958 value, this control sticks in this value.
It is impossible to change the control value to any
other of the enumerated values. Rebooting does not
help here. All audio apps do not work now.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 17:02 CEST 
----------------------------------------------------------------------
The attached patch should fix.

----------------------------------------------------------------------
 Andrew - 08-25-2004 23:56 CEST 
----------------------------------------------------------------------
I have tried the driver from current CVS - the problem seem to be
gone away without suggested patch. Is it still worth to try the patch?

----------------------------------------------------------------------
 tiwai - 08-26-2004 17:48 CEST 
----------------------------------------------------------------------
No, cvs already includes this fix.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 12:51 Andrew         New Bug                                      
08-25-04 17:02 tiwai          Bugnote Added: 0001623                       
08-25-04 17:02 tiwai          File Added: ice1724-rate-lock.dif                    
08-25-04 23:56 Andrew         Bugnote Added: 0001629                       
08-26-04 17:48 tiwai          Bugnote Added: 0001631                       
08-26-04 17:48 tiwai          Assigned To               => tiwai           
08-26-04 17:48 tiwai          Resolution               open => fixed       
08-26-04 17:48 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
