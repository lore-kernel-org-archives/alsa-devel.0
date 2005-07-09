From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001246]: Sound card loops and doesn't play any more
Date: Sat, 9 Jul 2005 17:04:03 +0200
Message-ID: <2f39437bf4e532a5ac9240961c9f654a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E41B185
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 17:04:04 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              07-09-2005 17:04 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 17:04 syberdave      New Issue                                    
07-09-05 17:04 syberdave      Distribution              => Debian Testing  
07-09-05 17:04 syberdave      Kernel Version            => 2.6.7-grsec     
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
