From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Mon, 20 Dec 2004 17:37:26 +0100
Message-ID: <2af86e09d81efb292305d320984d5a84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D59962AC
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 17:37:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=384> 
======================================================================
Reported By:                bryanb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo dev sources
Kernel Version:             2.6
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              12-20-2004 17:37 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 wallsga - 12-20-04 17:27 
----------------------------------------------------------------------
Thank's for the quick response and analysis.  Regretabbly,
 I won't have test results until 27 Dec 04 (after the Holiday).

However, I believe the codec chip does get left at its
default rate.  If you can think of anything else for me to try,
post it *before 1630 EST today*. 

Recall that the original 1.0.7 ALSA driver does work approx 10% of the
time.

Let me highlight something in the alsa_codec_init file I uploaded:

...
reg 0x2a read  0x0000  VRA off
reg 0x2a write 0x0001  VRA enable
reg 0x2c write 0x2af8  11 kHz
reg 0x2c read  0x2af8
...
reg 0x2c write 0xac44  44.1 kHz
reg 0x2c read  0xac44
reg 0x2c write 0xbb80  48 kHz (codec default based on AK4544A specs)
reg 0x2c read  0xbb80  
....                           (DRA probes don't seem to follow.  I might
be wrong.)
reg 0x2a read  0x0001  VRA enabled
reg 0x2a write 0x0001  VRA enable   (why?  Maybe it should be followed
with a 
                                                   reg 0x2c write 0xbb80
?)

-Andy



----------------------------------------------------------------------
 tiwai - 12-20-04 17:37 
----------------------------------------------------------------------
Maybe you're right. 48kHz is probed as the last, so it should remain 48k.

If the VRA is really culprit, you can turn on/off dynamically by writing
/proc/asound/card0/codec97#0/ac97#0-0+regs files like:

  echo 2a 0000 > /proc/asound/card0/codec97#0/ac97#0-0+regs

If changing VRA triggers/removes the cracky sound, we can simply add a
sequence to disable VRA in ymfpci, since it doesn't need VRA anyway.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:28 bryanb         New Issue                                    
07-13-04 19:28 bryanb         Distribution              => Gentoo dev sources
07-13-04 19:28 bryanb         Kernel Version            => 2.6             
07-29-04 22:43 codefathers    Note Added: 0001485                          
07-29-04 22:45 codefathers    Issue Monitored: codefathers                    
09-03-04 03:37 Derek_Burdick  Issue Monitored: Derek_Burdick                    
09-03-04 03:40 Derek_Burdick  Note Added: 0001684                          
10-23-04 23:24 c0ldevil       Note Added: 0002257                          
10-23-04 23:27 c0ldevil       Note Edited: 0002257                         
10-23-04 23:55 c0ldevil       Note Added: 0002259                          
10-23-04 23:56 c0ldevil       Note Added: 0002260                          
11-10-04 12:48 tiwai          Note Added: 0002369                          
11-17-04 18:14 c0ldevil       Note Added: 0002436                          
11-17-04 20:33 c0ldevil       Note Added: 0002442                          
11-17-04 20:39 rlrevell       Note Added: 0002443                          
11-18-04 14:30 tiwai          Note Added: 0002445                          
11-18-04 15:46 c0ldevil       Note Added: 0002446                          
11-18-04 15:56 c0ldevil       Note Added: 0002447                          
11-18-04 15:59 c0ldevil       File Added: dumps.zip                        
11-18-04 16:00 c0ldevil       Note Added: 0002448                          
11-18-04 19:44 tiwai          Note Added: 0002465                          
11-18-04 21:05 c0ldevil       Note Added: 0002471                          
11-18-04 21:29 c0ldevil       Note Edited: 0002471                         
11-22-04 14:24 wallsga        Note Added: 0002496                          
11-22-04 14:26 wallsga        Note Edited: 0002496                         
11-22-04 14:30 wallsga        Issue Monitored: wallsga                     
11-22-04 14:37 tiwai          Note Added: 0002498                          
11-23-04 16:14 wallsga        File Added: tecra8100-bug-data.tar.gz             
      
11-23-04 16:15 wallsga        Note Added: 0002520                          
12-16-04 22:44 wallsga        Note Added: 0002843                          
12-20-04 16:08 wallsga        Note Added: 0002883                          
12-20-04 16:10 wallsga        File Added: tecra8100demo.patch                   

12-20-04 16:11 wallsga        File Added: codec-init-seq.tar.gz                 
  
12-20-04 16:59 tiwai          Note Added: 0002887                          
12-20-04 17:00 tiwai          File Added: ac97-default-rate-fix.diff            
       
12-20-04 17:25 wallsga        Note Added: 0002888                          
12-20-04 17:27 wallsga        Note Edited: 0002888                         
12-20-04 17:37 tiwai          Note Added: 0002890                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
