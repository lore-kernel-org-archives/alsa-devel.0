From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001824]: Always mixed into one channel when recording stereo
Date: Sat, 25 Mar 2006 20:44:07 +0100
Message-ID: <2a08d4d2af2fbd8aeba09ce5c62849c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7563518A
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 20:44:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1824> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1824
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r4
======================================================================
Date Submitted:             02-06-2006 06:56 CET
Last Modified:              03-25-2006 20:44 CET
======================================================================
Summary:                    Always mixed into one channel when recording stereo
Description: 
When recording stereo audio (2 channels), the sound seems to mix to one
channel and then saved in the left track. I do not have anything in
asound.conf or ~/.asoundrc that will affect the recordings. I even cleared
them out to make sure that my code is not screwing up the recordings. It
has done this since I upgraded to 1.0.10 from 1.0.9. I thought 1.0.11rc3
will fix the problem but it still does it.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001527 amixer fails to set right 'Capture Sour...
======================================================================

----------------------------------------------------------------------
 ungod - 03-25-06 20:37 
----------------------------------------------------------------------
Since it works with Universe, but not Prodigy71, there problem can only be
in the initialization of the WM8770 chip (The chip responsible of A/D and
D/A conversion and volume control).
There are a few differences in the way the two initialize the chip. Here's
how prodigy71 behave compared to the universe:

1. Capture source is CD by default instead of AC'97
2. Front channel is not mixed with AC'97 output (Means that you can't hear
Line in and PCM simultaniously, but apparently you can do that anyway if I
understood correctly)
3. High-pass filter is enabled
4. The Master Mode Control register in the chip is set to an invalid
value.

My guess is that it is the 4th point which does the damage. The register
controls three clock pins related to both Analogue-to-Digital and
Digital-to-Analogue conversion (ADC and DAC respectively), and while the
bits related to DAC (Playback) are vaild, the bits related to ADC
(Capture) aren't.

I'll attach a patch which sets the register to the same value as for
aureon.

----------------------------------------------------------------------
 ungod - 03-25-06 20:44 
----------------------------------------------------------------------
The patch is uploaded as prodigy-wminit.diff

And I see now why you are capable of hearing both line in and PCM
regardless of the WM8770 initialization. The AC97 switch is actually
directly related to this bit.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 06:56 Electro        New Issue                                    
02-06-06 06:56 Electro        Distribution              => Gentoo          
02-06-06 06:56 Electro        Kernel Version            => 2.6.14-gentoo-r4
02-10-06 23:38 tartif         Note Added: 0008009                          
02-16-06 07:26 Electro        Note Added: 0008087                          
02-18-06 01:32 rlrevell       Relationship added       duplicate of 0001527
02-28-06 22:45 Electro        Note Added: 0008248                          
03-20-06 12:35 ungod          Note Added: 0008717                          
03-21-06 09:28 Electro        Note Added: 0008740                          
03-21-06 16:47 ungod          Note Added: 0008743                          
03-21-06 16:48 ungod          Note Edited: 0008743                         
03-25-06 06:53 Electro        Note Added: 0008942                          
03-25-06 20:37 ungod          Note Added: 0008949                          
03-25-06 20:38 ungod          File Added: prodigy-wminit.diff                   

03-25-06 20:44 ungod          Note Added: 0008950                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
