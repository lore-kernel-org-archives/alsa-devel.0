From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001414]: Hercules Digifire - ADC control only mutes left channel
Date: Mon, 6 Feb 2006 23:03:35 +0100
Message-ID: <96200e3e81110588653163d973baf4c6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 877C81E1
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2006 23:03:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1414> 
======================================================================
Reported By:                a_r_schulz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1414
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrivia
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-11-2005 19:12 CEST
Last Modified:              02-06-2006 23:03 CET
======================================================================
Summary:                    Hercules Digifire - ADC control only mutes left
channel
Description: 
I would like to use my card for recording with audacity in LINUX, but it's
a little hard to get the levels right, since the ADC slider in both
alsamixer and kmix affect only the left input channel, leaving the right
channel at full volume. Had this problem with all 2.6 kernel versions so
far, but did not really care up to now...
======================================================================

----------------------------------------------------------------------
 a_r_schulz - 01-19-06 08:48 
----------------------------------------------------------------------
Cannot tell - I had a different soundcard before. I'm trying right now with
a Knoppix 3.4 CD and found my card as 'Cirrus Logic CS 4294' in KMix. KMix
shows a slider 'IGain' for the card, which appears to work properly, both
in combined and split-channel mode, together with the recording volume
slider of Audacity.

The Kernel on this distribution is:
Linux Knoppix 2.4.23-xfs #1 SMP Mi Dez 10 22:25:03 CET 2003 i686
GNU/Linux
but appears to still use OSS drivers (nothing of alsa in dmesg). Dmesg
says about sound:
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 22:39:02 Dec 10 2003
cs46xx: Card found at 0xe3100000 and 0xe3000000, IRQ 9
cs46xx: Unknown card (1681:A012) at 0xe3100000/0xe3000000, IRQ 9
ac97_codec: AC97 Modem codec, id: CRY45 (Cirrus Logic CS4294)

----------------------------------------------------------------------
 a_r_schulz - 02-06-06 23:03 
----------------------------------------------------------------------
No change in 1.0.10 final. Even more, when switching the red recording
buttons in kmix from line to e.g. aux or CD, the meter in audacity still
shows the line-in signal on the right channel.
I finally tried 1.0.11rc3, which at least seems to have fixed the problem
with the kmix recording buttons, but the ADC slider still only mutes the
left channel.
Behaviour of alsamixer is similar, except that the ADC slider has no
effect at all, while the capture slider boosts the signal when you raise
the level above 0, whereas the capture slider in kmix has no effect.
In addition, playback from audacity via the cs46xx driver suffers from
severe jitter and occasional distortions, whereas everything is fine when
using the plain on-board via82xxx chip.
Any suggestions for another, well-supported PCI soundcard?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 19:12 a_r_schulz     New Issue                                    
09-11-05 19:12 a_r_schulz     Distribution              => Mandrivia       
09-11-05 19:12 a_r_schulz     Kernel Version            => 2.6.13          
12-30-05 23:31 rlrevell       Note Added: 0007291                          
01-18-06 08:43 a_r_schulz     Note Added: 0007706                          
01-18-06 08:48 rlrevell       Note Added: 0007707                          
01-19-06 08:48 a_r_schulz     Note Added: 0007718                          
02-06-06 23:03 a_r_schulz     Note Added: 0007952                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
