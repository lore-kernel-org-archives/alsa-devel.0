From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002163]: error running alsaconf
Date: Fri, 16 Jun 2006 14:19:35 +0200
Message-ID: <fe7a338847041e027ba494ec243ad7e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 529C7178
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 14:19:35 +0200 (MEST)
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
Last Modified:              06-16-2006 14:19 CEST
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
 friser - 06-16-06 14:14 
----------------------------------------------------------------------
No, I didn't use rpm
I downloaded the alsa-driver-1.0.11.tar.bz2 file and then installed the
software with standard procedure. 
The only thing I did is to set the kernel dir in configure command.
I attach a file with the output of procedure.
- configure
- make
- make install
- snddevices

After this I run alsaconf and get the error.
I've noticed that the output of alsaconf refer to
/lib/modules/2.6.16-1.2080_FC5/kernel/sound directory while I set the
option --with-kernel=/usr/src/kernels/2.6.16-1.2080_FC5-i586 in configure
command.
Is it correct?

Is there another way to configure the alsa driver without running
alsaconf?

thanks

----------------------------------------------------------------------
 friser - 06-16-06 14:19 
----------------------------------------------------------------------
I've attached modprobe.conf file

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
======================================================================
