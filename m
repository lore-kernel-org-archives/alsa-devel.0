From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000266]: I receive pages of unresolved symbols when I attempt to load the intel8x0 module.
Date: Tue, 9 Nov 2004 16:16:07 +0100
Message-ID: <740f781c57d2d84fb6b1189ed58a7a66@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C018F244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:16:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=266> 
======================================================================
Reported By:                malkuth
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   266
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2115.nptl
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-10-2004 05:36 CEST
Last Modified:              11-09-2004 16:16 CET
======================================================================
Summary:                    I receive pages of unresolved symbols when I attempt
to load the intel8x0 module.
Description: 
I had version 0.9.8 and had the problem, so I downloaded and built the
1.0.4 version. The following is the output from the load of the module.
Starting sound driver: snd-card-intel8x0 Warning: ignoring snd_major=116,
no such parameter in this module
Warning: ignoring snd_cards_limit=1, no such parameter in this module
Warning: ignoring snd_device_mode=0666, no such parameter in this module
Warning: ignoring snd_device_gid=0, no such parameter in this module
Warning: ignoring snd_device_uid=0, no such parameter in this module
Module snd loaded, with warnings
Module gameport loaded, with warnings
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_suspend_all_R43c50b57
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_ac97_mixer_Rf5b599af
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_ac97_set_rate_R1be27d60
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_new_Rd565b6d2
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_card_new_Rc2b77688
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_lib_free_pages_Re8dafa0a
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_verbose_printk_R49d4e4d1
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_hw_constraint_integer_R5eb3e8f8
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_ac97_tune_hardware_R94360210
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_ac97_resume_Re12d8194
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_period_elapsed_Re6e6b098
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_lib_preallocate_pci_pages_for_all_Rd644d0aa
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_lib_ioctl_R8482811c
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_card_register_R492d494a
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_free_pci_pages_Ra2184231
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_device_new_R371c74fc
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_set_ops_Rad3c274a
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_malloc_pci_pages_R516d0d40
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_hw_constraint_list_R74cb7c63
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_card_proc_new_Ra82b74c6
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_pcm_lib_malloc_pages_R0407e1db
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_mpu401_uart_new_Ra520c930
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_ac97_update_bits_R2f6d9192
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
unresolved symbol snd_card_free_Rf8b77bec
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
insmod
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o
failed
/lib/modules/2.4.22-1.2115.nptl/kernel/drivers/sound/pci/snd-card-intel8x0.o:
insmod snd-card-intel8x0 failed

======================================================================

----------------------------------------------------------------------
 perex - 09-07-04 16:36 
----------------------------------------------------------------------
Too old, please, try latest ALSA version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-10-04 05:36 malkuth        New Issue                                    
05-10-04 05:36 malkuth        Distribution              => Fedora Core 1   
05-10-04 05:36 malkuth        Kernel Version            => 2.4.22-1.2115.nptl
05-10-04 05:38 malkuth        Issue Monitored: malkuth                     
09-07-04 16:36 perex          Status                   assigned => resolved
09-07-04 16:36 perex          Resolution               open => fixed       
09-07-04 16:36 perex          Note Added: 0001710                          
11-09-04 16:16 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
