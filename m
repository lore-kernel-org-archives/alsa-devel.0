From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001246]: Sound card loops and doesn't play any more
Date: Sat, 23 Jul 2005 13:38:16 +0200
Message-ID: <4408e0fbfd51565407231ed7a31cab26@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 96A38179
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 13:38:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1246> 
======================================================================
Reported By:                syberdave
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1246
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Testing
Kernel Version:             2.6.7-grsec
======================================================================
Date Submitted:             07-09-2005 17:04 CEST
Last Modified:              07-23-2005 13:38 CEST
======================================================================
Summary:                    Sound card loops and doesn't play any more
Description: 
I installed a second sound card (ESS 1868 F/ISA) and when I send data to
it, it plays the first second or so and starts repeating it and it doesn't
move on. I notice that when I make the sound mono and bring the bitrate
down, the data that it repeats becomes longer: mpg321 --wav - music.mp3
|sox -t wav - -t ossdsp -c 1 -r 4096 /dev/dsp1

And when I try to play it with ALSA, this command works for my first sound
card:
mpg321 --wav - music.mp3 |aplay -D hw:0,0
But this command doesn't - it does that loop thing again:
mpg321 --wav - music.mp3 |aplay -D hw:1,0

This is my results for lsmod:
Module                  Size  Used by
snd_es18xx             29100  0 
snd_cs4231_lib         21280  0 
snd_sb16_dsp            8064  0 
snd_sb_common          13152  1 snd_sb16_dsp
snd_ymfpci             54084  1 
snd_ac97_codec         60356  1 snd_ymfpci
snd_opl3_lib            8320  2 snd_es18xx,snd_ymfpci
snd_hwdep               7136  1 snd_opl3_lib
snd_mpu401_uart         5824  2 snd_es18xx,snd_ymfpci
snd_rawmidi            19872  1 snd_mpu401_uart

Any help would be appreciated.
======================================================================

----------------------------------------------------------------------
 syberdave - 07-10-05 06:49 
----------------------------------------------------------------------
Never mind - I found the Sound FAQ and it says that it's because of an IRQ
conflict. I'll fix that... somehow.

----------------------------------------------------------------------
 twhitehead - 07-23-05 13:38 
----------------------------------------------------------------------
Are you sure it's because of an IRQ conflict.  I had this problem on my
Alpha PWS 500au, and it turned out to be the interupt detection code.

There are two versions of the detection code in the source.  The second
one (which I understand to be the old one) is commented out.  Uncommenting
it (and re-commenting the first) did the trick for me.

I'm attached a patch if you want to give it a go.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 17:04 syberdave      New Issue                                    
07-09-05 17:04 syberdave      Distribution              => Debian Testing  
07-09-05 17:04 syberdave      Kernel Version            => 2.6.7-grsec     
07-09-05 17:04 syberdave      Issue Monitored: syberdave                    
07-10-05 06:49 syberdave      Note Added: 0005441                          
07-23-05 13:38 twhitehead     Note Added: 0005552                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
