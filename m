From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000397]: Bad sound quality on Asus K8V SE Deluxe (VIA8237 + AD1980)
Date: Wed, 27 Oct 2004 00:27:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1d71c0ccab4a08b0cd0353e90d157fc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 29D532FE
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 00:27:28 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=397> 
======================================================================
Reported By:                durval
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   397
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               My own, based on Redhat 6.2
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-18-2004 16:41 CEST
Last Modified:              10-27-2004 00:27 CEST
======================================================================
Summary:                    Bad sound quality on Asus K8V SE Deluxe (VIA8237 +
AD1980)
Description: 
Sound quality is noticiably bad; even someone with not-so-sensitive ears as
me perceives the low-frequency and high-frequency components of sound
getting mixed up and losing definition. I thought it could be a problem
with my hardware or speaker system, but rebooting the machine under
Windows2000 and playing the same music showed much better quality. 
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-04 14:56 
----------------------------------------------------------------------
The broken pipe at start is often an IRQ problem.
In the case of chip on mobo, it's likely an IRQ routing by the broken
ACPI support.  Try to turn off ACPI via boot option (e.g. acpi=off
or pci=noacpi).

----------------------------------------------------------------------
 badbunny - 10-27-04 00:27 
----------------------------------------------------------------------
I have a K8V and it works beutifully with the ALSA drivers. If you are
using the latest ALSA drivers, there is quirk in the driver that sets the
driver to the equilaent of "dxs_support=4". I'm running currently running
2.6.9. But I've been using it since 2.6.4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-04 16:41 durval         New Issue                                    
07-18-04 16:41 durval         Distribution              => My own, based on
Redhat 6.2
07-18-04 16:41 durval         Kernel Version            => 2.4.26          
07-18-04 16:43 durval         Note Added: 0001457                          
07-18-04 17:16 durval         Note Added: 0001458                          
07-18-04 17:17 durval         Issue Monitored: durval                      
07-30-04 17:32 tiwai          Note Added: 0001502                          
09-25-04 08:54 fangel         Note Added: 0001908                          
09-25-04 08:55 fangel         Note Added: 0001909                          
10-12-04 14:56 tiwai          Note Added: 0002101                          
10-27-04 00:27 badbunny       Note Added: 0002267                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
