From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000567]: S/PDIF control missing in mixer
Date: Wed, 13 Oct 2004 15:50:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013135015.C93F61B00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 42C072F0
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 15:50:16 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000567
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     567
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
======================================================================
Date Submitted:             10-05-2004 17:47 CEST
Last Modified:              10-13-2004 15:50 CEST
======================================================================
Summary:                    S/PDIF control missing in mixer
Description: 
Since 1.0.4 (somewhere around there), the S/PDIF-controls have disappeared
from the mixer... It has been there before and there IS one on my
soundcard (Terratec DMX Xfire 1024, cs46xx)
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-2004 11:13 CEST 
----------------------------------------------------------------------
Please attach /proc/asound/card0/codec97#0/* files and /etc/asound.state.

----------------------------------------------------------------------
 pmatil - 10-07-2004 18:23 CEST 
----------------------------------------------------------------------
1. Asound.state is from /var/lib/alsa/asound.state
2. The actual files from /proc/asound/card0/codec97#0/* cannot be uploaded
so I uploaded a text file which shows what those files have inside (files
ac97#0-0 and ac97#0-0+reg.

----------------------------------------------------------------------
 tiwai - 10-11-2004 14:07 CEST 
----------------------------------------------------------------------
Could you try the attached patch?

----------------------------------------------------------------------
 pmatil - 10-13-2004 13:05 CEST 
----------------------------------------------------------------------
I changed the line in
/usr/src/modules/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c as
indicated in the diff file and recompiled+installed the modules package.
No change... lspci: 0000:00:0a.0 Multimedia audio controller: Cirrus Logic
CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01).

----------------------------------------------------------------------
 tiwai - 10-13-2004 15:50 CEST 
----------------------------------------------------------------------
Any changes in /proc/asound/card0/codec97#0/* files after patch?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:47 pmatil         New Bug                                      
10-05-04 17:47 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:47 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:13 tiwai          Bugnote Added: 0002018                       
10-07-04 18:06 pmatil         File Added: asound.state                     
10-07-04 18:20 pmatil         File Added: codec97#0                        
10-07-04 18:23 pmatil         Bugnote Added: 0002037                       
10-11-04 14:07 tiwai          Bugnote Added: 0002077                       
10-11-04 14:08 tiwai          File Added: cs4298-spdif.diff                    
10-13-04 13:05 pmatil         Bugnote Added: 0002122                       
10-13-04 15:50 tiwai          Bugnote Added: 0002123                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
