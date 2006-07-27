From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001629]: error for "modprobe snd-mia"
Date: Thu, 27 Jul 2006 08:38:38 +0200
Message-ID: <52abeb8d38a01f4b86d0d867231c42c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25A3621A
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 08:38:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1629> 
======================================================================
Reported By:                wbrown338
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1629
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             12-08-2005 03:06 CET
Last Modified:              07-27-2006 08:38 CEST
======================================================================
Summary:                    error for "modprobe snd-mia"
Description: 
Greetings:

I get the following error when trying to install the mia driver after
compiling the latest release against the latest kernel for Ubuntu.

root@ubuntu:/usr/src/alsa-driver-1.0.10 # modprobe snd-mia
FATAL: Error inserting snd_mia
(/lib/modules/2.6.12-10-386/kernel/sound/pci/echoaudio/snd-mia.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error running install command for snd_mia




dmesg output:
[4295682.670000] snd_mia: disagrees about version of symbol
snd_rawmidi_receive
[4295682.670000] snd_mia: Unknown symbol snd_rawmidi_receive
[4295682.670000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_empty
[4295682.670000] snd_mia: Unknown symbol snd_rawmidi_transmit_empty
[4295682.670000] snd_mia: disagrees about version of symbol snd_ctl_add
[4295682.670000] snd_mia: Unknown symbol snd_ctl_add
[4295682.670000] snd_mia: disagrees about version of symbol snd_pcm_new
[4295682.670000] snd_mia: Unknown symbol snd_pcm_new
[4295682.670000] snd_mia: disagrees about version of symbol
snd_card_register
[4295682.670000] snd_mia: Unknown symbol snd_card_register
[4295682.670000] snd_mia: disagrees about version of symbol snd_card_free
[4295682.671000] snd_mia: Unknown symbol snd_card_free
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_set_sync
[4295682.671000] snd_mia: Unknown symbol snd_pcm_set_sync
[4295682.671000] snd_mia: Unknown symbol snd_verbose_printk
[4295682.671000] snd_mia: disagrees about version of symbol snd_ctl_new1
[4295682.671000] snd_mia: Unknown symbol snd_ctl_new1
[4295682.671000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_ack
[4295682.671000] snd_mia: Unknown symbol snd_rawmidi_transmit_ack
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_hw_rule_add
[4295682.671000] snd_mia: Unknown symbol snd_pcm_hw_rule_add
[4295682.671000] snd_mia: Unknown symbol snd_compat_kzalloc
[4295682.671000] snd_mia: disagrees about version of symbol snd_card_new
[4295682.671000] snd_mia: Unknown symbol snd_card_new
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_lib_malloc_pages
[4295682.671000] snd_mia: Unknown symbol snd_pcm_lib_malloc_pages
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_lib_ioctl
[4295682.671000] snd_mia: Unknown symbol snd_pcm_lib_ioctl
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_lib_free_pages
[4295682.671000] snd_mia: Unknown symbol snd_pcm_lib_free_pages
[4295682.671000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_peek
[4295682.671000] snd_mia: Unknown symbol snd_rawmidi_transmit_peek
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_set_ops
[4295682.671000] snd_mia: Unknown symbol snd_pcm_set_ops
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_list
[4295682.671000] snd_mia: Unknown symbol snd_pcm_hw_constraint_list
[4295682.671000] snd_mia: disagrees about version of symbol
snd_device_new
[4295682.671000] snd_mia: Unknown symbol snd_device_new
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_sgbuf_ops_page
[4295682.671000] snd_mia: Unknown symbol snd_pcm_sgbuf_ops_page
[4295682.671000] snd_mia: disagrees about version of symbol
snd_rawmidi_new
[4295682.671000] snd_mia: Unknown symbol snd_rawmidi_new
[4295682.671000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_integer
[4295682.671000] snd_mia: Unknown symbol snd_pcm_hw_constraint_integer
[4295682.672000] snd_mia: disagrees about version of symbol
snd_rawmidi_set_ops
[4295682.672000] snd_mia: Unknown symbol snd_rawmidi_set_ops
[4295682.672000] snd_mia: disagrees about version of symbol
snd_pcm_lib_preallocate_pages
[4295682.672000] snd_mia: Unknown symbol snd_pcm_lib_preallocate_pages
[4295682.672000] snd_mia: disagrees about version of symbol
snd_pcm_period_elapsed
[4295682.672000] snd_mia: Unknown symbol snd_pcm_period_elapsed
[4295682.672000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_step
[4295682.672000] snd_mia: Unknown symbol snd_pcm_hw_constraint_step
[4296236.343000] snd_mia: disagrees about version of symbol
snd_rawmidi_receive
[4296236.343000] snd_mia: Unknown symbol snd_rawmidi_receive
[4296236.343000] snd_mia: Unknown symbol snd_hidden_kzalloc
[4296236.343000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_empty
[4296236.343000] snd_mia: Unknown symbol snd_rawmidi_transmit_empty
[4296236.343000] snd_mia: disagrees about version of symbol snd_ctl_add
[4296236.343000] snd_mia: Unknown symbol snd_ctl_add
[4296236.343000] snd_mia: disagrees about version of symbol snd_pcm_new
[4296236.343000] snd_mia: Unknown symbol snd_pcm_new
[4296236.343000] snd_mia: disagrees about version of symbol
snd_card_register
[4296236.343000] snd_mia: Unknown symbol snd_card_register
[4296236.343000] snd_mia: disagrees about version of symbol snd_card_free
[4296236.343000] snd_mia: Unknown symbol snd_card_free
[4296236.343000] snd_mia: Unknown symbol snd_wrapper_kfree
[4296236.343000] snd_mia: Unknown symbol snd_hidden_kfree
[4296236.343000] snd_mia: disagrees about version of symbol
snd_pcm_set_sync
[4296236.343000] snd_mia: Unknown symbol snd_pcm_set_sync
[4296236.344000] snd_mia: Unknown symbol snd_verbose_printk
[4296236.344000] snd_mia: disagrees about version of symbol snd_ctl_new1
[4296236.344000] snd_mia: Unknown symbol snd_ctl_new1
[4296236.344000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_ack
[4296236.344000] snd_mia: Unknown symbol snd_rawmidi_transmit_ack
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_hw_rule_add
[4296236.344000] snd_mia: Unknown symbol snd_pcm_hw_rule_add
[4296236.344000] snd_mia: disagrees about version of symbol snd_card_new
[4296236.344000] snd_mia: Unknown symbol snd_card_new
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_lib_malloc_pages
[4296236.344000] snd_mia: Unknown symbol snd_pcm_lib_malloc_pages
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_lib_ioctl
[4296236.344000] snd_mia: Unknown symbol snd_pcm_lib_ioctl
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_lib_free_pages
[4296236.344000] snd_mia: Unknown symbol snd_pcm_lib_free_pages
[4296236.344000] snd_mia: disagrees about version of symbol
snd_rawmidi_transmit_peek
[4296236.344000] snd_mia: Unknown symbol snd_rawmidi_transmit_peek
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_set_ops
[4296236.344000] snd_mia: Unknown symbol snd_pcm_set_ops
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_list
[4296236.344000] snd_mia: Unknown symbol snd_pcm_hw_constraint_list
[4296236.344000] snd_mia: disagrees about version of symbol
snd_device_new
[4296236.344000] snd_mia: Unknown symbol snd_device_new
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_sgbuf_ops_page
[4296236.344000] snd_mia: Unknown symbol snd_pcm_sgbuf_ops_page
[4296236.344000] snd_mia: disagrees about version of symbol
snd_rawmidi_new
[4296236.344000] snd_mia: Unknown symbol snd_rawmidi_new
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_integer
[4296236.344000] snd_mia: Unknown symbol snd_pcm_hw_constraint_integer
[4296236.344000] snd_mia: disagrees about version of symbol
snd_rawmidi_set_ops
[4296236.344000] snd_mia: Unknown symbol snd_rawmidi_set_ops
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_lib_preallocate_pages
[4296236.344000] snd_mia: Unknown symbol snd_pcm_lib_preallocate_pages
[4296236.344000] snd_mia: Unknown symbol snd_hidden_kmalloc
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_period_elapsed
[4296236.344000] snd_mia: Unknown symbol snd_pcm_period_elapsed
[4296236.344000] snd_mia: disagrees about version of symbol
snd_pcm_hw_constraint_step
[4296236.344000] snd_mia: Unknown symbol snd_pcm_hw_constraint_step

let me know if there is anything I can do to help get this to work.  
Thanks. 

======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-27-06 08:38 
----------------------------------------------------------------------
It seems you compiled the driver against the wrong headers and/or the
configuration of the tree with the headers doesn't match the configuration
of the currently running kernel.

Which parameters did you give to configure?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-05 03:06 wbrown338      New Issue                                    
12-08-05 03:06 wbrown338      Distribution              => Ubuntu          
12-08-05 03:06 wbrown338      Kernel Version            => 2.6.12-10-386   
07-27-06 08:38 Adrian Bunk    Note Added: 0011262                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
