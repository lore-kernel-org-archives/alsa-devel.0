From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000244]: aplay loops like a broken record with YMF-724F
Date: Tue, 9 Nov 2004 16:19:01 +0100
Message-ID: <7bd9b17ea35a7cf03a932cbff80da329@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C539D247
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:19:01 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=244> 
======================================================================
Reported By:                dant
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   244
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.26-1.ll.rh90.ccrma
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-28-2004 04:18 CEST
Last Modified:              11-09-2004 16:19 CET
======================================================================
Summary:                    aplay loops like a broken record with YMF-724F
Description: 
I have downloaded the latest kernel and Alsa RPMs from CCRMA site and was
able to get the sound drivers to work
for Yamaha YMF-724F sound card.

KMidi seems to play fine.  The only problem so far that I can see is
'aplay' with WAV files.

Here is what I tried:

[root@linux sounds]# aplay email.wav
Playing WAVE 'email.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
ALSA lib pcm_hw.c:523:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
Input/output error

This sound was supposed to play once.  I hear a repeat of this sound 20
times exactly.  I tried all other wave files with the same results!  It
sounds like a broken record up to 20 times.

I have scanned google and found only two references where others have
reported simliar results but no response fixes were given.

Help!

Best regards!
Dan Thurman
dant@cdkkt.com
======================================================================

----------------------------------------------------------------------
 tiwai - 04-30-04 10:56 
----------------------------------------------------------------------
the symoptom looks like an IRQ problem.
if you have PNP-OS setting in BIOS, try to turn it off.

----------------------------------------------------------------------
 perex - 09-07-04 16:53 
----------------------------------------------------------------------
Yes, it looks like a general IRQ problem. Please, ask on lkml or enter this
problem to kernel's bugzilla.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 04:18 dant           New Issue                                    
04-28-04 04:18 dant           Kernel Version            =>
2.4.26-1.ll.rh90.ccrma
04-30-04 10:55 tiwai          Category                 0_compilation problem_!!!
=> PCI - ymfpci
04-30-04 10:56 tiwai          Note Added: 0000974                          
09-07-04 16:53 perex          Status                   assigned => resolved
09-07-04 16:53 perex          Resolution               open => fixed       
09-07-04 16:53 perex          Note Added: 0001718                          
11-09-04 16:19 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
