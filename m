From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000748]: Kernel 2.6.9 and 2.6.10 makes sound of Ali 5455 chipset choppy, plays to fast
Date: Sun, 23 Jan 2005 01:38:07 +0100
Message-ID: <af83cc92d07c3c6258bc1da4884b061b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A35BC1C7
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2005 01:38:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=748> 
======================================================================
Reported By:                pcmcginty
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   748
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Arch Linux
Kernel Version:             2.6.10
======================================================================
Date Submitted:             12-26-2004 06:50 CET
Last Modified:              01-23-2005 01:38 CET
======================================================================
Summary:                    Kernel 2.6.9 and 2.6.10 makes sound of Ali 5455
chipset choppy, plays to fast
Description: 
I've been spending a lot of time getting sound to work on my Sharp Actius
MM20 laptop. The platform has an ALI 5455 chip that is using the intel8x0
ALSA driver. On a 2.6.7 kernel, the sound is 100% perfect. The 2.6.9 and
2.6.10 kernel series cause the sound to become garbled as if the song is
skipping through the music faster than it should. I have not tried ont he
2.6.8 series. I can compile and try out if required. It is possible this
is some other kernel issue, however I'm not sure how to track down where
the kernel might be breaking the ALSA driver.
======================================================================

----------------------------------------------------------------------
 bengan - 01-22-05 02:12 
----------------------------------------------------------------------
I have the same problem. I've got an ACER Ferrari 3000 with VIA
VT8233/A/8235. It uses the snd_via82xx module. I'm not sure that I can
help but I do get the right sound when I play with ecasound and saying:
ecasound -i:filname.wav -o:alsa
but with hw:0 the sound sounds as if it is played faster.
ecasound -i:filname.wav -o:alsa,hw:0

[bengan@ibanez] cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15
07:17:53 2004 UTC).
Compiled on Jan 18 2005 for kernel 2.6.10-gentoo-r4



----------------------------------------------------------------------
 JonathanL - 01-23-05 01:38 
----------------------------------------------------------------------
I've tried ecasound : 
with -o alsa, the sound is the same as with other programs, too fast. here
is the output : 
****************************************************************************
*               ecasound v2.3.3 (C) 1997-2004 Kai Vehmanen
****************************************************************************
- [ Session created ]
------------------------------------------------------
- [ Chainsetup created (cmdline) ]
-----------------------------------------
- [ Connecting chainsetup ]
------------------------------------------------
(eca-chainsetup) 'rt' buffering mode selected.
(eca-chainsetup) Audio object "08 - Coup Du Lapin.ogg", mode "read".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
(eca-chainsetup) Audio object "alsa", mode "write".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
- [ Chainsetup connected ]
-------------------------------------------------
(eca-controller) Connected chainsetup:  "command-line-setup".
- [ Controller/Starting batch processing ]
---------------------------------
- [ Engine init - Driver start ]
-------------------------------------------
(eca-engine) Prefilling i/o buffers.
(audioio-alsa) warning! playback underrun - samples lost!  Break was at
least 0.07 ms long.
(audioio-alsa) warning! playback underrun - samples lost!  Break was at
least 0.03 ms long.
(audioio-alsa) warning! playback underrun - samples lost!  Break was at
least 0.03 ms long.
(audioio-alsa) warning! playback underrun - samples lost!  Break was at
least 0.03 ms long.
etc...

with the options : -o alsa,hw:0, it's slower but still too fast, I've got
the same output messages, the errors are still there but less numerous.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 06:50 pcmcginty      New Issue                                    
12-26-04 06:50 pcmcginty      Distribution              => Arch Linux      
12-26-04 06:50 pcmcginty      Kernel Version            => 2.6.10          
12-26-04 06:51 pcmcginty      Issue Monitored: pcmcginty                    
12-27-04 15:12 tiwai          Note Added: 0002961                          
12-27-04 19:26 pcmcginty      File Added: codec97#0_2.6.7                    
12-27-04 19:26 pcmcginty      File Added: codec97#0_2.6.10                    
12-27-04 19:28 pcmcginty      Note Added: 0002973                          
01-12-05 13:57 JonathanL      Issue Monitored: JonathanL                    
01-12-05 14:13 JonathanL      Note Added: 0003163                          
01-12-05 14:16 JonathanL      File Added: codec97#0_cvs_jonathanl               
    
01-12-05 15:02 tiwai          Note Added: 0003164                          
01-12-05 15:03 tiwai          Note Added: 0003165                          
01-12-05 15:04 tiwai          Note Added: 0003166                          
01-12-05 16:01 JonathanL      File Added: kernel-2.6.7                     
01-12-05 16:02 JonathanL      File Added: kernel-2.6.10_alsa-cvs                
   
01-12-05 16:13 JonathanL      Note Added: 0003174                          
01-12-05 20:45 tiwai          Note Added: 0003178                          
01-12-05 23:23 JonathanL      File Added: sub0                             
01-12-05 23:23 JonathanL      Note Added: 0003180                          
01-13-05 12:53 tiwai          Note Added: 0003184                          
01-22-05 02:02 bengan         Note Added: 0003371                          
01-22-05 02:03 bengan         Note Edited: 0003371                         
01-22-05 02:12 bengan         Note Edited: 0003371                         
01-23-05 01:38 JonathanL      Note Added: 0003384                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
