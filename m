From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001223]: Unable to select card for playback
Date: Sat, 10 Sep 2005 13:06:45 +0200
Message-ID: <2a7770a556f99c1b1226e7ae07b7ffba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA07E1C4
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 13:06:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1223> 
======================================================================
Reported By:                nframpton
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1223
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Leaf Bering v1.2
Kernel Version:             2.4.31
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-01-2005 02:59 CEST
Last Modified:              09-10-2005 13:06 CEST
======================================================================
Summary:                    Unable to select card for playback
Description: 
I have an Intel D875PBZ motherboard and several SB Live 24-bit (model
SB0410) cards.  If only one card is installed the ca0106 driver works
fine.  If multiple cards are installed I am unable to select a specific
card for playback.

# aplay -D hw:0,0 /tmp/new.wav
Playing WAVE '/tmp/new.wav' : Signed 16 bit Little Endian, Rate 16000 Hz,
Mono
aplay: set_params:862: Channels count non available

I am using the default configuration supplied with alsa-lib 1.0.9.

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jun 30 2005 for kernel 2.4.31-NANO.

# cat /proc/asound/cards
0 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0410] at 0xb800 irq 3
1 [CA0106_1       ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0410] at 0xbc00 irq 10

# cat /proc/asound/devices
 19: [0- 3]: digital audio playback
 27: [0- 3]: digital audio capture
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
 51: [1- 3]: digital audio playback
 59: [1- 3]: digital audio capture
 50: [1- 2]: digital audio playback
 58: [1- 2]: digital audio capture
 49: [1- 1]: digital audio playback
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl

# cat /proc/interrupts
           CPU0
  0:      31884          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  snd_ca0106
  4:        635          XT-PIC  serial
 10:        726          XT-PIC  snd_ca0106, eth0
 14:       7402          XT-PIC  ide0
NMI:          0
ERR:          0

# cat /proc/asound/modules
0 snd-ca0106
1 snd-ca0106

# cat /proc/asound/pcm
00-00: ca0106 : CA0106 : playback 1 : capture 1
00-01: ca0106 : CA0106 : playback 1 : capture 1
00-02: ca0106 : CA0106 : playback 1 : capture 1
00-03: ca0106 : CA0106 : playback 1 : capture 1
01-00: ca0106 : CA0106 : playback 1 : capture 1
01-01: ca0106 : CA0106 : playback 1 : capture 1
01-02: ca0106 : CA0106 : playback 1 : capture 1
01-03: ca0106 : CA0106 : playback 1 : capture 1


======================================================================

----------------------------------------------------------------------
 nframpton - 07-04-05 10:28 
----------------------------------------------------------------------
That worked fine, thanks.  Is this documented somewhere?

----------------------------------------------------------------------
 jcdutton - 09-10-05 13:06 
----------------------------------------------------------------------
Fixed. Configuation problem, and not a driver bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 02:59 nframpton      New Issue                                    
07-01-05 02:59 nframpton      Distribution              => Leaf Bering v1.2
07-01-05 02:59 nframpton      Kernel Version            => 2.4.31          
07-01-05 12:32 jcdutton       Note Added: 0005331                          
07-01-05 12:32 jcdutton       Status                   assigned => feedback
07-04-05 10:28 nframpton      Note Added: 0005383                          
09-10-05 13:06 jcdutton       Status                   feedback => closed  
09-10-05 13:06 jcdutton       Note Added: 0006116                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
