From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000567]: "Loudness" and "Sim. stereo" controls missing in mixer
Date: Mon, 28 Mar 2005 04:19:45 +0200
Message-ID: <35732e53686348cc8f775e7172e06643@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6C24253
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 04:19:45 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=567> 
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   567
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
======================================================================
Date Submitted:             10-05-2004 17:47 CEST
Last Modified:              03-28-2005 04:19 CEST
======================================================================
Summary:                    "Loudness" and "Sim. stereo" controls missing in
mixer
Description: 
Since 1.0.4 (somewhere around there), the S/PDIF-controls have disappeared
from the mixer... It has been there before and there IS one on my
soundcard (Terratec DMX Xfire 1024, cs46xx)
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-04 11:13 
----------------------------------------------------------------------
Please attach /proc/asound/card0/codec97#0/* files and /etc/asound.state.

----------------------------------------------------------------------
 pmatil - 10-07-04 18:23 
----------------------------------------------------------------------
1. Asound.state is from /var/lib/alsa/asound.state
2. The actual files from /proc/asound/card0/codec97#0/* cannot be uploaded
so I uploaded a text file which shows what those files have inside (files
ac97#0-0 and ac97#0-0+reg.

----------------------------------------------------------------------
 tiwai - 10-11-04 14:07 
----------------------------------------------------------------------
Could you try the attached patch?

----------------------------------------------------------------------
 pmatil - 10-13-04 13:05 
----------------------------------------------------------------------
I changed the line in
/usr/src/modules/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c as
indicated in the diff file and recompiled+installed the modules package.
No change... lspci: 0000:00:0a.0 Multimedia audio controller: Cirrus Logic
CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01).

----------------------------------------------------------------------
 tiwai - 10-13-04 15:50 
----------------------------------------------------------------------
Any changes in /proc/asound/card0/codec97#0/* files after patch?

----------------------------------------------------------------------
 pmatil - 10-14-04 13:14 
----------------------------------------------------------------------
ac97#0-0: no change, ac97#0-0+regs changed, prev_+reg is the file before
patch and current_+reg after patch. BTW, how do I turn on the loudness?

edited on: 10-14-04 13:14

----------------------------------------------------------------------
 tiwai - 10-14-04 14:27 
----------------------------------------------------------------------
Hmm, it seems your codec is cs4294, not cs498, and cs494 has no
SPDIF indeed.
Could you see the board and check it (whether the chip is really
CS4294)?

Or, do you have another codec, shown in /proc/asound/card0/codec97#1/*?

----------------------------------------------------------------------
 tiwai - 10-14-04 14:39 
----------------------------------------------------------------------
Or: maybe the missing IEC958 switches play no role, anyway.
You can ignore them.

Isn't SPDIF output working?

----------------------------------------------------------------------
 pmatil - 10-14-04 16:20 
----------------------------------------------------------------------
The chip is CS4624... No other codec in /proc/asound/card0/. Now that you
mentioned what bothers me is that gamix shows 'Sound Fusion CS46xx: Cirrus
Logic CS4294 rev 5' although I have a CS4624. S/PDIF -output worked before
(slider present), I only tested it then by XMMS and selecting iec958 (or
sth like that) as output. Also, rear channel 'hw:0,1' should be there. Now
there is only 'default' and 'hw:0,0'.

----------------------------------------------------------------------
 tiwai - 10-14-04 16:31 
----------------------------------------------------------------------
Did you build with the new DSP option?

When you build with all cards (no --with-cards or --with-cards=all), it
should be enabled as default.
Otherwise, if you used --with-cards=cs46xx, you have to specify
--with-cards=cs46xx,cs46xx-new-dsp to enable SPDIF and surround features.

----------------------------------------------------------------------
 pmatil - 10-15-04 13:53 
----------------------------------------------------------------------
S/PDIF is now present, as is ADC capture and DAC capture... I just had to
compile with cs46xx_new_dsp. I didn't know that until now... Anyway, it
works, now I have to find out how to get a52 (dolby digital) out from
S/PDIF and that software mixing from 2 channels to 4. And, how to get
loudness on (as mentioned in ac97#0-0)... Thanks for assistance!

edited on: 10-15-04 13:53

----------------------------------------------------------------------
 tiwai - 10-18-04 17:44 
----------------------------------------------------------------------
What do you mean "loudness"?

----------------------------------------------------------------------
 pmatil - 10-20-04 21:32 
----------------------------------------------------------------------
In codec97#0-0 there is a line: Loudness: off and Sim. stereo: off. Can
these be adjusted somewhere?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:47 pmatil         New Issue                                    
10-05-04 17:47 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:47 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:13 tiwai          Note Added: 0002018                          
10-07-04 18:06 pmatil         File Added: asound.state                     
10-07-04 18:20 pmatil         File Added: codec97#0                        
10-07-04 18:23 pmatil         Note Added: 0002037                          
10-11-04 14:07 tiwai          Note Added: 0002077                          
10-11-04 14:08 tiwai          File Added: cs4298-spdif.diff                    
10-13-04 13:05 pmatil         Note Added: 0002122                          
10-13-04 15:50 tiwai          Note Added: 0002123                          
10-14-04 13:11 pmatil         File Added: prev_+reg                        
10-14-04 13:11 pmatil         File Added: current_+reg                     
10-14-04 13:13 pmatil         Note Added: 0002143                          
10-14-04 13:14 pmatil         Note Edited: 0002143                         
10-14-04 14:27 tiwai          Note Added: 0002145                          
10-14-04 14:39 tiwai          Note Added: 0002146                          
10-14-04 16:20 pmatil         Note Added: 0002153                          
10-14-04 16:31 tiwai          Note Added: 0002155                          
10-14-04 18:08 pmatil         Note Added: 0002157                          
10-15-04 13:53 pmatil         Note Edited: 0002157                         
10-18-04 17:44 tiwai          Note Added: 0002196                          
10-20-04 21:32 pmatil         Note Added: 0002219                          
03-28-05 04:19 jdthood        Summary                  S/PDIF control missing in
mixer => "Loudness" and "Sim. stereo" controls missing in mixer
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
