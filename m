From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000567]: S/PDIF control missing in mixer
Date: Thu, 14 Oct 2004 16:31:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041014143101.1597F2D0BF@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F83A276
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2004 16:31:01 +0200 (MEST)
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
Last Modified:              10-14-2004 16:31 CEST
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

----------------------------------------------------------------------
 pmatil - 10-14-2004 13:14 CEST 
----------------------------------------------------------------------
ac97#0-0: no change, ac97#0-0+regs changed, prev_+reg is the file before
patch and current_+reg after patch. BTW, how do I turn on the loudness?

edited on: 10-14-04 13:14

----------------------------------------------------------------------
 tiwai - 10-14-2004 14:27 CEST 
----------------------------------------------------------------------
Hmm, it seems your codec is cs4294, not cs498, and cs494 has no
SPDIF indeed.
Could you see the board and check it (whether the chip is really
CS4294)?

Or, do you have another codec, shown in /proc/asound/card0/codec97#1/*?

----------------------------------------------------------------------
 tiwai - 10-14-2004 14:39 CEST 
----------------------------------------------------------------------
Or: maybe the missing IEC958 switches play no role, anyway.
You can ignore them.

Isn't SPDIF output working?

----------------------------------------------------------------------
 pmatil - 10-14-2004 16:20 CEST 
----------------------------------------------------------------------
The chip is CS4624... No other codec in /proc/asound/card0/. Now that you
mentioned what bothers me is that gamix shows 'Sound Fusion CS46xx: Cirrus
Logic CS4294 rev 5' although I have a CS4624. S/PDIF -output worked before
(slider present), I only tested it then by XMMS and selecting iec958 (or
sth like that) as output. Also, rear channel 'hw:0,1' should be there. Now
there is only 'default' and 'hw:0,0'.

----------------------------------------------------------------------
 tiwai - 10-14-2004 16:31 CEST 
----------------------------------------------------------------------
Did you build with the new DSP option?

When you build with all cards (no --with-cards or --with-cards=all), it
should be enabled as default.
Otherwise, if you used --with-cards=cs46xx, you have to specify
--with-cards=cs46xx,cs46xx-new-dsp to enable SPDIF and surround features.

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
10-14-04 13:11 pmatil         File Added: prev_+reg                        
10-14-04 13:11 pmatil         File Added: current_+reg                     
10-14-04 13:13 pmatil         Bugnote Added: 0002143                       
10-14-04 13:14 pmatil         Bugnote Edited: 0002143                      
10-14-04 14:27 tiwai          Bugnote Added: 0002145                       
10-14-04 14:39 tiwai          Bugnote Added: 0002146                       
10-14-04 16:20 pmatil         Bugnote Added: 0002153                       
10-14-04 16:31 tiwai          Bugnote Added: 0002155                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
