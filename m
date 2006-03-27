From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001824]: Always mixed into one channel when recording stereo
Date: Mon, 27 Mar 2006 02:54:56 +0200
Message-ID: <a45edb149014f628b661f6926b68a9b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 514641E5
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 02:54:57 +0200 (MEST)
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
Last Modified:              03-27-2006 02:54 CEST
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
 ungod - 03-25-06 20:44 
----------------------------------------------------------------------
The patch is uploaded as prodigy-wminit.diff

And I see now why you are capable of hearing both line in and PCM
regardless of the WM8770 initialization. The AC97 switch is actually
directly related to this bit.

----------------------------------------------------------------------
 Electro - 03-27-06 02:54 
----------------------------------------------------------------------
The patch has no effect. It changes the wrong lines, so I remake the patch
myself that corrects the proper lines. While it is compiling, I check the
file to make sure it apply was correct and yes it is correct.

All the debugging and trying to fix it is making the the code for
Audiotrak Prodigy 7.1 worst than before. The whole code for the Audiotrak
Prodigy 7.1 need to be rewritten at a different view point.

I am using alsa-driver-1.0.10-rc2.ebuild which uses alsa-1.0.10. I edit
the ebuild to apply the patch below.

diff -Nru alsa-kernel/pci/ice1712/aureon.c
alsa-kernel.new/pci/ice1712/aureon.c
--- alsa-kernel/pci/ice1712/aureon.c    2005-11-04 06:58:11.000000000
-0700
+++ alsa-kernel.new/pci/ice1712/aureon.c        2006-03-25
22:52:58.867880192 -0700
@@ -1743,7 +1743,7 @@
                0x18, 0x000,            /* All power-up */
 
                0x16, 0x022,            /* I2S, normal polarity, 24bit,
high-pass on */
-               0x17, 0x006,            /* 128fs, slave mode */
+               0x17, 0x022,            /* 256fs, slave mode */
 
                0x00, 0,                /* DAC1 analog mute */
                0x01, 0,                /* DAC2 analog mute */


Until it is fixed, I will just manually specify the cset values using
amixer to record from either AUX, Lin in, Mic, or AC97.

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
03-27-06 02:54 Electro        Note Added: 0008982                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
