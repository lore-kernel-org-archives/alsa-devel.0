From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002021]: No sound from speakers (only headphone) after resume to suspend-to-ram
Date: Wed, 24 May 2006 05:49:02 +0200
Message-ID: <9e66cb267ff7c5f7fbd5f9a50d4e3d15@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39380162
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 05:49:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2021> 
======================================================================
Reported By:                tsaiming
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2021
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             suspend2-2.6.16-r2
======================================================================
Date Submitted:             04-15-2006 13:19 CEST
Last Modified:              05-24-2006 05:49 CEST
======================================================================
Summary:                    No sound from speakers (only headphone) after resume
to suspend-to-ram
Description: 
After suspend2-to-ram (but it happens also with the suspend kernel built
in) I have no more sound from speakers but only from headphones.
With suspend to disk all works good 
Also tried to stop alsasound and unload modules before suspending and
restart service after resume with no change.

======================================================================

----------------------------------------------------------------------
 tsaiming - 04-25-06 23:54 
----------------------------------------------------------------------
I have attached my diff regs (diff_via.diff, diff_ac.diff).
In via82xx I cannot restore (using echo ....) the value I had before
suspend (error is -su: /proc/asound/card0/via82xx: No such device). And
another issuse is that 04 value change during using sound device (when
speakers works), while 08 and 80 remain the same (but chance after a
suspend/resume cycle like showed in diff).
In ac97#0-0+regs I can change correctly only 60 value and no 5e.
I have compiled alsa-driver (1.0.11) with debug option.
Still only sound from headphone.

----------------------------------------------------------------------
 Voluspa - 05-24-06 05:49 
----------------------------------------------------------------------
Sigh... There really should be some correlation between the kernel and alsa
bug"zilla"s...

I've raised a thorough report about this in:

[Suspend to RAM permanently "mutes" all sound - ALSA loaded or unloaded.
PCI related - VIA VT8233] (really a VIA 8235 with VIA1612A)
http://bugzilla.kernel.org/show_bug.cgi?id=6072 (with PCI-dumps)

>From my point of view, acpi or something even lower level is responsible,
but hey-ho, I'm just a user so what do I know...

Not only the via82xx driver is effected as can be seen in:

[snd-intel8x0 speakers mute after resume from suspend to RAM]
http://bugzilla.kernel.org/show_bug.cgi?id=6181

I'd love it if the alsa people could fix this, but am sceptical.

Mvh
Mats Johannesson

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-06 13:19 tsaiming       New Issue                                    
04-15-06 13:19 tsaiming       File Added: codec97#0.txt                    
04-15-06 13:19 tsaiming       Distribution              => Gentoo          
04-15-06 13:19 tsaiming       Kernel Version            => suspend2-2.6.16-r2
04-22-06 15:12 mmp            Issue Monitored: mmp                         
04-22-06 15:14 mmp            Note Added: 0009435                          
04-22-06 15:15 mmp            File Added: regs.diff                        
04-24-06 16:44 tiwai          Note Added: 0009470                          
04-24-06 21:30 mmp            Note Added: 0009478                          
04-25-06 16:09 tiwai          Note Added: 0009491                          
04-25-06 20:37 mmp            Note Added: 0009495                          
04-25-06 23:40 tsaiming       Issue Monitored: tsaiming                    
04-25-06 23:41 tsaiming       Issue End Monitor: tsaiming                    
04-25-06 23:41 tsaiming       File Added: diff_via.diff                    
04-25-06 23:41 tsaiming       File Added: diff_ac.diff                     
04-25-06 23:54 tsaiming       Note Added: 0009497                          
05-24-06 05:49 Voluspa        Note Added: 0009953                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
