From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000651]: via82xxx No Sound Kernel 2.6.10-rc2
Date: Wed, 23 Mar 2005 15:25:50 +0100
Message-ID: <2dbc219ca64979e7e69338ac6ab1bf41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 75D56163
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 15:25:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=651> 
======================================================================
Reported By:                glen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   651
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0 + Dropline Gnome 2.8.0
Kernel Version:             2.6.10-rc2
======================================================================
Date Submitted:             11-17-2004 19:03 CET
Last Modified:              03-23-2005 15:25 CET
======================================================================
Summary:                    via82xxx No Sound Kernel 2.6.10-rc2
Description: 
Upgraded to kernel 2.6.10-rc2 from 2.6.10-rc1 with identical config.  No
compile problems.  No boot up problems.  No sound.
======================================================================

----------------------------------------------------------------------
 glen - 11-19-04 01:20 
----------------------------------------------------------------------
I'm not sure how to check if the playback DMA is working.  I can see with
procinfo that IRQs are piling up.  I use headphones and during a "normal"
bootup I can hear  some pops as the sound card is initialized.  Booting
this kernel results in dead silence, it's so quiet that the first time I
booted this kernel I checked that the  headphone was still connected -
it's just dead.
I've tried compiling soundcore as a modules and as part of the kernel and
found that when compiled as a module, that udevd is not making all of the
required /dev devices (/dev/dsp was missing and esd couldn't start which
hangs startx).  I've started checking my rc.d scripts and udev config to
see if these are the problem (yet these work OK for 2.6.10-rc1).
I realize that it quite possible that ALSA is working fine, but something
else in the new kernel is buggering it up.  I already tried the
pci=routeirq kernel parameter after noticing the new message in the kernel
bootup to try that if irqs don't get initialized correctly.  It made no
apparent difference.

----------------------------------------------------------------------
 jdthood - 03-23-05 15:25 
----------------------------------------------------------------------
Submitter: What happens if you build ALSA modules from the alsa-driver
tarball and use those instead of the modules that come with your kernel?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-04 19:03 glen           New Issue                                    
11-17-04 19:03 glen           File Added: config-2.6.10-rc2                    
11-17-04 19:03 glen           Distribution              => Slackware 10.0 +
Dropline Gnome 2.8.0
11-17-04 19:03 glen           Kernel Version            => 2.6.10-rc2      
11-17-04 19:05 glen           Note Added: 0002439                          
11-17-04 19:06 glen           File Added: lspci.txt                        
11-18-04 19:48 tiwai          Note Added: 0002466                          
11-19-04 01:04 glen           File Added: asound.state                     
11-19-04 01:04 glen           File Added: ac97#0-0                         
11-19-04 01:04 glen           File Added: ac97#0-0+regs                    
11-19-04 01:20 glen           Note Added: 0002473                          
03-23-05 15:25 jdthood        Note Added: 0004159                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
