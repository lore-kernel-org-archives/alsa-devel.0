From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000674]: sound modules loaded, unmuted channels, progressbar moving STILL no output
Date: Sun, 28 Nov 2004 21:11:37 +0100
Message-ID: <a6e106127a93f7d1893f13cce5066bf7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BDDB821F
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 21:11:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=674> 
======================================================================
Reported By:                IceRAM
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   674
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ArchLinux
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-24-2004 13:12 CET
Last Modified:              11-28-2004 21:11 CET
======================================================================
Summary:                    sound modules loaded, unmuted channels, progressbar
moving STILL no output
Description: 
I can't get any sound out of the integrated sound card, even though I've
tried everything possible (I think - oh, I haven't tried Windows, yet)
======================================================================

----------------------------------------------------------------------
 IceRAM - 11-24-04 18:43 
----------------------------------------------------------------------
I've noticed I keep getting this kind of messages:
Nov 24 18:14:14 server intel8x0_measure_ac97_clock: measured 49330 usecs
Nov 24 18:14:14 server intel8x0: clocking to 48000
Nov 24 18:16:08 server intel8x0_measure_ac97_clock: measured 49333 usecs
Nov 24 18:16:08 server intel8x0: clocking to 48000
Nov 24 18:20:06 server intel8x0_measure_ac97_clock: measured 49337 usecs
Nov 24 18:20:06 server intel8x0: clocking to 48000
Nov 24 18:40:55 server intel8x0_measure_ac97_clock: measured 49329 usecs
Nov 24 18:40:55 server intel8x0: clocking to 48000
Nov 24 19:10:51 server intel8x0_measure_ac97_clock: measured 49335 usecs
Nov 24 19:10:51 server intel8x0: clocking to 48000

while trying to access the sound card... I think.

----------------------------------------------------------------------
 IceRAM - 11-28-04 21:11 
----------------------------------------------------------------------
pzad (11-24-04 16:07) guided me to:
http://sourceforge.net/mailarchive/message.php?msg_id=10061173

 > Greetings -
 > 
 > I have an ABIT AN7 motherboard with an nForce2 audio controller.  The
AC97
 > chip is an ALC658, and the patch from ac97_patch.c from 1.30 to 1.31
in
 > CVS seems to have broken standard stereo output.  I can get some sound
 > output from my speakers if I enable Line-In As Surround and Duplicate
 > Front, but it is very faint.  Without these features enabled, I don"t
get
 > any audio output from any of the analog output jacks.
 > 
 > I"ve looked at the code, for patch_alc655() as compared to
patch_alc650()
 > but I"m not proficient enough to figure out what to change to make it
 > work, so I"ve simply modified ac97_codec.c to use patch_alc650() for
my
 > ALC658.  There seem to be other people on the alsa-users list with a
 > similar problem, and I"d be happy to help try and diagnose the problem
 > further, but I"m not sure what other information will be helpful.
 > 

I have installed today Windows. To my surprise, the Line Out jack doesn't
work, no matter what output I would choose in Windows (2ch,4ch,6ch).
Surprisingly, the Line in works (in 4ch), but I can only hear sound in the
right speaker & the sound in the left speaker is very faint.

I took is as a hardware problem of the MB and left it as is (I left the
speakers in the Line in jack).

Sometime later I booted into Linux. Playing through the filesystem, I
don't know what made me choose Play from the context menu over a file.
Surprisingly, amarok started and I got sound in the right speaker.
Amaizing improvement.

I've continued my reasearch in the configs and discovered, after my recent
playing in them, that "Duplicate front" and "Line in as surround" were
checked. Unchecking turned off the sound. It was kind of obvious that I
would get sound through the Line in jack with these 2 selected.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 13:12 IceRAM         New Issue                                    
11-24-04 13:12 IceRAM         File Added: asound.state                     
11-24-04 13:12 IceRAM         Distribution              => ArchLinux       
11-24-04 13:12 IceRAM         Kernel Version            => 2.6.9           
11-24-04 13:13 IceRAM         File Added: .asoundrc                        
11-24-04 13:17 IceRAM         File Added: modprobe.conf                    
11-24-04 13:19 IceRAM         Note Added: 0002560                          
11-24-04 13:19 IceRAM         File Added: lsmod.txt                        
11-24-04 13:20 IceRAM         Issue Monitored: IceRAM                      
11-24-04 15:36 IceRAM         File Added: lspci_v.txt                      
11-24-04 15:39 IceRAM         Note Added: 0002568                          
11-24-04 16:07 pzad           Note Added: 0002569                          
11-24-04 16:31 IceRAM         Note Added: 0002570                          
11-24-04 18:02 tiwai          Note Added: 0002576                          
11-24-04 18:37 IceRAM         File Added: ac97#0-0                         
11-24-04 18:37 IceRAM         File Added: ac97#0-0+regs                    
11-24-04 18:39 IceRAM         Note Added: 0002578                          
11-24-04 18:43 IceRAM         Note Added: 0002579                          
11-28-04 21:11 IceRAM         Note Added: 0002629                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
