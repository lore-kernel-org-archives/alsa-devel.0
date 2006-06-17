From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002163]: error running alsaconf
Date: Sat, 17 Jun 2006 19:10:58 +0200
Message-ID: <e25275cfacbaa3a7c90efcd0a8d3312e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D40C2159
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 19:10:58 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2163> 
======================================================================
Reported By:                friser
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2163
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 5
Kernel Version:             2.6.16-1.2080_FC5
======================================================================
Date Submitted:             05-26-2006 16:27 CEST
Last Modified:              06-17-2006 19:10 CEST
======================================================================
Summary:                    error running alsaconf
Description: 
Hello, 
when I try to confugure the alsa driver with alsaconf on my sony vaio I
obtain this error:

Loading driver...
Starting sound driver: snd-hda-intel WARNING: Error inserting
snd_page_alloc
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-page-alloc.ko):
Invalid module format
WARNING: Error inserting snd
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd.ko): Invalid module
format
WARNING: Error inserting snd_timer
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-timer.ko): Invalid
module format
WARNING: Error inserting snd_page_alloc
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-page-alloc.ko):
Invalid module format
WARNING: Error inserting snd
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd.ko): Invalid module
format
WARNING: Error inserting snd_timer
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-timer.ko): Invalid
module format
FATAL: Error inserting snd_pcm
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-pcm.ko): Invalid
module format
WARNING: Error running install command for snd_pcm
WARNING: Error inserting snd_hda_codec
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/pci/hda/snd-hda-codec.ko):
Invalid module format
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/pci/hda/snd-hda-intel.ko):
Invalid module format
done
Starting sound driver: snd-hda-intel WARNING: Error inserting
snd_page_alloc
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-page-alloc.ko):
Invalid module format
WARNING: Error inserting snd
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd.ko): Invalid module
format
WARNING: Error inserting snd_timer
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-timer.ko): Invalid
module format
WARNING: Error inserting snd_page_alloc
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-page-alloc.ko):
Invalid module format
WARNING: Error inserting snd
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd.ko): Invalid module
format
WARNING: Error inserting snd_timer
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-timer.ko): Invalid
module format
FATAL: Error inserting snd_pcm
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/acore/snd-pcm.ko): Invalid
module format
WARNING: Error running install command for snd_pcm
WARNING: Error inserting snd_hda_codec
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/pci/hda/snd-hda-codec.ko):
Invalid module format
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.16-1.2080_FC5/kernel/sound/pci/hda/snd-hda-intel.ko):
Invalid module format
done
Setting default volumes...

Thanks 

======================================================================

----------------------------------------------------------------------
 rlrevell - 06-17-06 18:56 
----------------------------------------------------------------------
You are running a kernel compiled for 686 but your ALSA modules are
compiled for 586.  You need to remove kernel-devel.i586 and install the
kernel-devel.i686 package.

vermagic: 2.6.16-1.2080_FC5 686 REGPARM 4KSTACKS gcc-4.1

vermagic: 2.6.16-1.2080_FC5 586 REGPARM 4KSTACKS gcc-4.1

Unfortunately I don't run Fedora so I can't tell you exactly how.

----------------------------------------------------------------------
 friser - 06-17-06 19:10 
----------------------------------------------------------------------
I can't do this now because my laptop doesn't have enaugh battery and I
left the power supply in office. I will try next monday ....

Is this operation "dangerous"? Do you think that something could stop to
work after the change of kernel-devel package?

Thank you so much

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-26-06 16:27 friser         New Issue                                    
05-26-06 16:27 friser         Distribution              => fedora core 5   
05-26-06 16:27 friser         Kernel Version            => 2.6.16-1.2080_FC5
06-14-06 17:17 friser         Issue Monitored: djdeath                     
06-14-06 17:17 friser         Note Added: 0010213                          
06-14-06 17:18 friser         Note Deleted: 0010213                        
06-14-06 17:19 friser         Note Added: 0010214                          
06-15-06 10:10 friser         Note Added: 0010236                          
06-15-06 17:50 rlrevell       Note Added: 0010240                          
06-16-06 14:14 friser         Note Added: 0010253                          
06-16-06 14:15 friser         File Added: alsa-output.txt                    
06-16-06 14:18 friser         File Added: modprobe.conf                    
06-16-06 14:19 friser         Note Added: 0010254                          
06-16-06 20:00 rlrevell       Note Added: 0010259                          
06-17-06 16:35 friser         Note Added: 0010271                          
06-17-06 17:06 friser         Note Added: 0010272                          
06-17-06 17:13 Raymond        Note Added: 0010273                          
06-17-06 17:14 Raymond        Note Edited: 0010273                         
06-17-06 17:19 friser         Note Added: 0010274                          
06-17-06 17:24 Raymond        Note Added: 0010275                          
06-17-06 17:26 Raymond        Note Edited: 0010275                         
06-17-06 17:34 Raymond        Note Edited: 0010275                         
06-17-06 17:46 friser         Note Added: 0010276                          
06-17-06 17:57 Raymond        Note Added: 0010277                          
06-17-06 17:59 Raymond        Note Edited: 0010277                         
06-17-06 18:07 friser         Note Added: 0010278                          
06-17-06 18:11 friser         Note Added: 0010279                          
06-17-06 18:25 rlrevell       Note Added: 0010281                          
06-17-06 18:36 friser         Note Added: 0010282                          
06-17-06 18:39 rlrevell       Note Added: 0010283                          
06-17-06 18:45 friser         Note Added: 0010284                          
06-17-06 18:56 rlrevell       Note Added: 0010285                          
06-17-06 19:10 friser         Note Added: 0010286                          
======================================================================
