From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Fri, 25 Nov 2005 08:22:02 +0100
Message-ID: <99365774e6e18ab904ddb070f3aee08c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DD951A2
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2005 08:22:03 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
======================================================================
Reported By:                Osiris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1025
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             03-30-2005 22:50 CEST
Last Modified:              11-25-2005 08:22 CET
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 Raymond - 08-24-05 11:04 
----------------------------------------------------------------------
Have you try alien999999999 's alsa-changes.tar.bz2 ?

If not,  would you please try the patch diff11.diff (against
alsa-driver-1.0.9b) at

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948 


void __iomem *mmio;

should be used instead of

unsigned long __iomem *mmio;

in snd_vortex_t for architecture independent (32-bits and 64-bits)

We need feedback from au8810/au8830 user in testing the Equalizer, MPU401,
Gameport, .... on 64 bits platform.

----------------------------------------------------------------------
 Raymond - 11-25-05 08:22 
----------------------------------------------------------------------
It seem that the au88x0 registers can be access through I/O ports (BAR1) in
additonal to MMIO (BAR0)

vortex->bar1 = pci_resource_start(pci, 1);



outl(offset,vortex->bar1); 
inl(vortex->bar1+4);

is equivalent to

readl(vortex->mmio+offset)  



and



outl(offset,vortex->bar1); 
outl(value,vortex->bar1+4);

is equivalent to

writel(value,vortex->mmio+offset)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 22:50 Osiris         New Issue                                    
03-30-05 22:50 Osiris         Distribution              => Debian          
03-30-05 22:50 Osiris         Kernel Version            => 2.6.11.6        
03-31-05 11:34 mjander        Note Added: 0004278                          
04-03-05 21:16 Osiris         Note Added: 0004320                          
04-04-05 10:19 alien999999999 Issue Monitored: alien999999999                   

04-04-05 11:00 alien999999999 File Added: alsa-changes.tar.bz2                  
 
04-04-05 11:00 alien999999999 Note Added: 0004325                          
08-24-05 11:04 Raymond        Note Added: 0005927                          
11-25-05 08:22 Raymond        Note Added: 0006848                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
