From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000414]: sb cant grab irq 65535
Date: Wed, 18 Aug 2004 16:25:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818142530.C765124006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 308C7146
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 16:25:31 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000414
======================================================================
Reported By:                montjoie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     414
Category:                   ISA - sb8
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian Testing
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-30-2004 11:20 CEST
Last Modified:              08-18-2004 16:25 CEST
======================================================================
Summary:                    sb cant grab irq 65535
Description: 
Laptop toshiba satelitte CD2520CDS
Soundcard WSS & sb built in

Alsa say when loading sb driver:
"sb cant grab irq 65535" three times
I try both to make sb module and to built in sb in the kernel(no modules)
but it make the same.
I compile alsaconf ant try but no change.(on a kernel discution i saw a
man that say to do that).
I change all hardware config (irq dma etc..) but no change.
I try to force irq= when loading module but no change

======================================================================

----------------------------------------------------------------------
 montjoie - 08-02-2004 18:13 CEST 
----------------------------------------------------------------------
bug also in 2.6.8-rc2 and 2.6.5

----------------------------------------------------------------------
 tiwai - 08-02-2004 18:18 CEST 
----------------------------------------------------------------------
You have to give irq module parameter for sb8 module.

Which parameter did you use exactly?

----------------------------------------------------------------------
 montjoie - 08-18-2004 16:23 CEST 
----------------------------------------------------------------------
on kernel 2.4.26 no error

----------------------------------------------------------------------
 montjoie - 08-18-2004 16:25 CEST 
----------------------------------------------------------------------
oops i dont see that you have ask me a question. sorry.
i try some irq= (5 7 etc...) and dma= but the error remains the same.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-30-04 11:20 montjoie       New Bug                                      
07-30-04 11:20 montjoie       Distribution              => Debian Testing  
07-30-04 11:20 montjoie       Kernel Version            => 2.6.7           
08-02-04 18:12 montjoie       Bug Monitored: montjoie                      
08-02-04 18:13 montjoie       Bugnote Added: 0001520                       
08-02-04 18:18 tiwai          Bugnote Added: 0001522                       
08-18-04 16:23 montjoie       Bugnote Added: 0001585                       
08-18-04 16:25 montjoie       Bugnote Added: 0001586                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
