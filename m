From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000440]: Gateway Solo 250 nma2 - no soundcard detected
Date: Wed, 18 Aug 2004 11:59:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818095925.D11B71102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 411251E5
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 11:59:26 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000440
======================================================================
Reported By:                thelight
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     440
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             08-14-2004 19:38 CEST
Last Modified:              08-18-2004 11:59 CEST
======================================================================
Summary:                    Gateway Solo 250 nma2 - no soundcard detected
Description: 
The laptops specs say it has a 'neomagic nma 2' sound card onboard. From
what I can tell this is some sort of NeoMagic nm256 equivalent.

My main problem is that I simply get no sound. The fedora core 2 program
system-config-soundcard doesnt actually detect a soundcard at all. Im
using the 1.0.3 rpms of alsa which came with fedora. 
======================================================================

----------------------------------------------------------------------
 tiwai - 08-18-2004 11:59 CEST 
----------------------------------------------------------------------
2.6 kernel can load the unused modules.
I guess the PCI id of your device isn't listed on the supported
id table in nm256 driver.

Check it via lspci and try to add it to the pci_id table.
(Note that this may likely cause hang-up :)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 19:38 thelight       New Bug                                      
08-14-04 19:38 thelight       Distribution              => Fedora Core 2   
08-14-04 19:38 thelight       Kernel Version            => 2.6.6-1.435.2.3 
08-18-04 11:59 tiwai          Bugnote Added: 0001577                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
