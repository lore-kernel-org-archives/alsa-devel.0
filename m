From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000439]: swsusp for maestro can work with a small patch
Date: Thu, 19 Aug 2004 19:16:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040819171655.A9A4F1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EC280214
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2004 19:16:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000439
======================================================================
Reported By:                lupien_c
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     439
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               fedora core 2
Kernel Version:             2.6.7 + acpi + swsusp2
Resolution:                 fixed
======================================================================
Date Submitted:             08-14-2004 11:27 CEST
Last Modified:              08-19-2004 19:16 CEST
======================================================================
Summary:                    swsusp for maestro can work with a small patch
Description: 
With the maestro3.c driver in kernel 2.6.7, suspend to disk would lock the
driver. The module needed to manually be removed and reinstalled to
produce sound again. With the patch attached it now works properly.
======================================================================

----------------------------------------------------------------------
 lupien_c - 08-15-2004 05:51 CEST 
----------------------------------------------------------------------
I finally checked the latest alsa-driver-1.0.6rc2, and the patch is not
needed anymore. The latest alsa-driver seems to work out of the box. But I
wonder if the pci_set_master might still be needed on some platforms. (The
pci state is saved and restored  by core/init).

----------------------------------------------------------------------
 tiwai - 08-19-2004 19:16 CEST 
----------------------------------------------------------------------
I added pci_set_master() in resume callback (just to be sure :)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 11:27 lupien_c       New Bug                                      
08-14-04 11:27 lupien_c       File Added: maestro3.c.diff                    
08-14-04 11:27 lupien_c       Distribution              => fedora core 2   
08-14-04 11:27 lupien_c       Kernel Version            => 2.6.7 + acpi + swsusp2
08-15-04 05:51 lupien_c       Bugnote Added: 0001566                       
08-19-04 19:16 tiwai          Bugnote Added: 0001592                       
08-19-04 19:16 tiwai          Resolution               open => fixed       
08-19-04 19:16 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
