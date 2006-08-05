From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002157]: Regression on HP dc7600
	(0x103c, 0x3012)
Date: Sat, 5 Aug 2006 11:17:27 +0200
Message-ID: <e3cedb0010cf50fcf63cfcdd4daf7f47@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB99E188
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 11:17:27 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2157> 
======================================================================
Reported By:                ondrej
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2157
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux
Kernel Version:             2.6.15-23-amd64-xen
======================================================================
Date Submitted:             05-24-2006 11:39 CEST
Last Modified:              08-05-2006 11:17 CEST
======================================================================
Summary:                    Regression on HP dc7600 (0x103c, 0x3012)
Description: 
Sound stopped working when upgraded to anything higher then 1.0.9, there
was new code to add support for HDA intel (Realtek) on HP machines.

0x3012 is almost same as 0x3013, just Headphones and Front is reversed. 
And BTW "Front" is connector on the back of machine.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-26-06 15:00 
----------------------------------------------------------------------
I changed the model to HP3013 on HG repo now.

Does the capture from other source work?  What kind of error did you get?

----------------------------------------------------------------------
 mattb - 08-05-06 11:17 
----------------------------------------------------------------------
I have had this same problem as well, except my motherboard reports a
slightly different PCI id. I am using Ubuntu dapper.

0000:00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 3010
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at e0a00000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

However the fix in the patch above works for me too. I used the patch
below on 2.6.17.8 and 2.6.16.18, in both cases I have no sound without the
patch, once the patch is applied audio playback works perfectly.

--- sound/pci/hda/patch_realtek.c.orig 2006-08-05 21:13:49.000000000
+1200
+++ sound/pci/hda/patch_realtek.c 2006-08-05 20:33:17.000000000 +1200
@@ -2951,7 +2951,7 @@
{ .pci_subvendor = 0x152d, .pci_subdevice = 0x0729,
.config = ALC260_BASIC }, /* CTL Travel Master U553W */
{ .modelname = "hp", .config = ALC260_HP },
- { .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config = ALC260_HP
},
+ { .pci_subvendor = 0x103c, .pci_subdevice = 0x3010, .config =
ALC260_HP_3013 },
{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3011, .config = ALC260_HP
},
{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3012, .config = ALC260_HP
},
{ .pci_subvendor = 0x103c, .pci_subdevice = 0x3013, .config =
ALC260_HP_3013 },

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 11:39 ondrej         New Issue                                    
05-24-06 11:39 ondrej         Distribution              => Ubuntu Linux    
05-24-06 11:39 ondrej         Kernel Version            => 2.6.15-23-amd64-xen
05-24-06 13:26 ondrej         Issue Monitored: ondrej                      
05-24-06 13:50 fuman          Issue Monitored: fuman                       
05-24-06 21:10 ondrej         Note Added: 0009959                          
05-26-06 15:00 tiwai          Note Added: 0009978                          
08-05-06 11:17 mattb          Note Added: 0011426                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
