From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001035]: can't load module
Date: Mon, 4 Apr 2005 13:33:44 +0200
Message-ID: <4c9961ae67f6acab411c6fe4df53bf12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CF765165
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 13:33:44 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1035> 
======================================================================
Reported By:                j_arroba
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1035
Category:                   OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.2.14-5.0
======================================================================
Date Submitted:             04-04-2005 13:33 CEST
Last Modified:              04-04-2005 13:33 CEST
======================================================================
Summary:                    can't load module
Description: 
when i try to load the following module it display an error that i don't
understand. Does ALSA suport es1327 soundcard?

insmod snd-ens1371.o
snd-ens1371.o: unresolved symbol snd_pci_compat_register_driver_R24b60ddb
snd-ens1371.o: unresolved symbol snd_card_new_Re3f68a14
snd-ens1371.o: unresolved symbol snd_pcm_period_elapsed_R35a184ef
snd-ens1371.o: unresolved symbol snd_compat_kcalloc_Rc0712957
snd-ens1371.o: unresolved symbol snd_card_register_Ra57a1948
snd-ens1371.o: unresolved symbol
snd_pcm_lib_preallocate_pages_for_all_Rdca9ad3e
snd-ens1371.o: unresolved symbol snd_rawmidi_set_ops_R3e79a629
snd-ens1371.o: unresolved symbol snd_device_new_Re9a21320
snd-ens1371.o: unresolved symbol snd_pci_compat_set_driver_data_Rb45861dc
snd-ens1371.o: unresolved symbol snd_rawmidi_transmit_R8f8fefcf
snd-ens1371.o: unresolved symbol snd_ac97_bus_Re80aaea7
snd-ens1371.o: unresolved symbol snd_pcm_format_width_R55eb2175
snd-ens1371.o: unresolved symbol snd_pcm_lib_malloc_pages_Rb2c82a91
snd-ens1371.o: unresolved symbol snd_pci_compat_request_regions_R638cfd12
snd-ens1371.o: unresolved symbol snd_pcm_set_sync_Rbd154a61
snd-ens1371.o: unresolved symbol snd_pci_compat_enable_device_Ref3ce1d2
snd-ens1371.o: unresolved symbol snd_pci_compat_set_power_state_R6fc1f444
snd-ens1371.o: unresolved symbol snd_pcm_new_Rcf08368a
snd-ens1371.o: unresolved symbol snd_pcm_hw_constraint_ratnums_R7230e5f5
snd-ens1371.o: unresolved symbol snd_ctl_add_Rf904d21f
snd-ens1371.o: unresolved symbol snd_card_free_Rf1f80924
snd-ens1371.o: unresolved symbol snd_ctl_new1_R251d35d6
snd-ens1371.o: unresolved symbol snd_pci_compat_release_regions_Rb397c6da
snd-ens1371.o: unresolved symbol snd_rawmidi_new_Rc109e7b6
snd-ens1371.o: unresolved symbol snd_iprintf_R2f0b152f
snd-ens1371.o: unresolved symbol snd_pcm_set_ops_Rc465bfdd
snd-ens1371.o: unresolved symbol snd_pcm_hw_constraint_ratdens_Rba2fcd0d
snd-ens1371.o: unresolved symbol
snd_pcm_lib_preallocate_free_for_all_Rb773f7ea
snd-ens1371.o: unresolved symbol snd_card_proc_new_R31210e8a
snd-ens1371.o: unresolved symbol snd_ac97_mixer_R80d94356
snd-ens1371.o: unresolved symbol snd_pcm_lib_free_pages_R720f96d9
snd-ens1371.o: unresolved symbol
snd_pci_compat_unregister_driver_R17b61f4b
snd-ens1371.o: unresolved symbol snd_verbose_printk_Rf52a421e
snd-ens1371.o: unresolved symbol snd_rawmidi_receive_R36abb2e2
snd-ens1371.o: unresolved symbol snd_pcm_lib_ioctl_Rd8f4e5cd
snd-ens1371.o: unresolved symbol snd_pci_compat_get_driver_data_R7a7d7436

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-05 13:33 j_arroba       New Issue                                    
04-04-05 13:33 j_arroba       Kernel Version            => 2.2.14-5.0      
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
