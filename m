From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000328]: snd-nm256 freezes Dell Latitude LS
Date: Fri, 13 Aug 2004 01:33:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040812233319.C1C0F1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28F46289
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2004 01:33:20 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000328
======================================================================
Reported By:                aaronkaplan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     328
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.5-1.358
======================================================================
Date Submitted:             06-08-2004 23:13 CEST
Last Modified:              08-13-2004 01:33 CEST
======================================================================
Summary:                    snd-nm256 freezes Dell Latitude LS
Description: 
My Dell Latitude LS with an NM256AV hangs when I insert the
snd-nm256 module.

The OSS driver works fine.

======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:55 CEST 
----------------------------------------------------------------------
Does the attached patch have any effect?
If not, please show the output of lspci -nv.

----------------------------------------------------------------------
 aaronkaplan - 07-01-2004 16:03 CEST 
----------------------------------------------------------------------
No difference with the patch.  I'm attaching the output from lspci.

----------------------------------------------------------------------
 fridolin - 08-13-2004 01:33 CEST 
----------------------------------------------------------------------
Hi!


I have got a similar problem. My computer is a Latitude Cpi-R 400GT.

The machine hangs not immediately after inserting the nm-nm256 module, but
it freezes always when accessing the soundcard (by invoking alsamixer).

The similarity is, that I have already tried to activate/deactivate the
old "latitude_workaround"-thing, but this doesn't help.

The older OSS-driver works for me, too. 


I'm using the latest stable driver (alsa-driver-1.0.5.tar.bz2) compiled
over a linux 2.4.24-kernel.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-08-04 23:13 aaronkaplan    New Bug                                      
06-08-04 23:13 aaronkaplan    Distribution              => Fedora Core 2   
06-08-04 23:13 aaronkaplan    Kernel Version            => 2.6.5-1.358     
06-08-04 23:13 aaronkaplan    Bug Monitored: aaronkaplan                    
06-30-04 16:55 tiwai          Bugnote Added: 0001362                       
06-30-04 16:56 tiwai          File Added: nm256-dell-test.dif                    
07-01-04 16:01 aaronkaplan    File Added: lspci.out                        
07-01-04 16:03 aaronkaplan    Bugnote Added: 0001370                       
08-13-04 01:33 fridolin       Bugnote Added: 0001559                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
