From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002163]: error running alsaconf
Date: Thu, 15 Jun 2006 17:50:03 +0200
Message-ID: <099a56b1bf48e78d41394b309de9db78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 73EC0191
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 17:50:03 +0200 (MEST)
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
Last Modified:              06-15-2006 17:49 CEST
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
 friser - 06-15-06 10:10 
----------------------------------------------------------------------
Some details about the laptop

model: sony vaio vgn-s5m
cpu: Intel pentium M 740 - 1.73 Ghz
sound card: realtek high definition

----------------------------------------------------------------------
 rlrevell - 06-15-06 17:49 
----------------------------------------------------------------------
How did you install ALSA?  Did you use a third party RPM?

Those errors mean that the ALSA modules were not compiled for the kernel
you have running.

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
======================================================================
