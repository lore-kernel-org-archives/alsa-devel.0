From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002163]: error running alsaconf
Date: Sat, 17 Jun 2006 18:36:46 +0200
Message-ID: <11b787960a7f5270508ee602ecfc04d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C453B157
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 18:36:46 +0200 (MEST)
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
Last Modified:              06-17-2006 18:36 CEST
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
 rlrevell - 06-17-06 18:25 
----------------------------------------------------------------------
Please post the output of:

/sbin/modinfo /lib/modules/`uname -r`/kernel/sound/core/snd.ko

Then find a working non-ALSA module (check lsmod) and post the modinfo
output for that.

----------------------------------------------------------------------
 friser - 06-17-06 18:36 
----------------------------------------------------------------------
[root@umberto ~]# /sbin/modinfo /lib/modules/`uname
-r`/kernel/sound/core/snd.ko
modinfo: could not find module
/lib/modules/2.6.16-1.2080_FC5/kernel/sound/core/snd.ko


[root@umberto ~]# /sbin/lsmod
Module                  Size  Used by
ppdev                   8645  0
autofs4                19013  1
sunrpc                136573  1
ip_conntrack_ftp        7601  0
ip_conntrack_netbios_ns     3009  0
ipt_REJECT              5441  1
xt_state                2241  7
ip_conntrack           49261  3
ip_conntrack_ftp,ip_conntrack_netbios_ns,xt_state
nfnetlink               6489  1 ip_conntrack
xt_tcpudp               3265  9
iptable_filter          3137  1
ip_tables              11657  1 iptable_filter
x_tables               12613  4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables
nls_utf8                2241  1
ntfs                  187924  1
ipv6                  225569  12
lp                     12296  0
parport_pc             25445  0
parport                34313  3 ppdev,lp,parport_pc
nvram                   8393  0
sg                     32348  0
ohci1394               31749  0
ieee1394              288665  1 ohci1394
joydev                  9473  0
ipw2200                95633  0
ehci_hcd               29005  0
ieee80211              28681  1 ipw2200
ieee80211_crypt         6081  1 ieee80211
nvidia               4544884  12
uhci_hcd               28881  0
e100                   33093  0
mii                     5313  1 e100
soundcore               9377  0
i2c_i801                8397  0
i2c_core               20673  2 nvidia,i2c_i801
hw_random               5849  0
dm_snapshot            15981  0
dm_zero                 2113  0
dm_mirror              19729  0
dm_mod                 50137  5 dm_snapshot,dm_zero,dm_mirror
ahci                   12613  0
ext3                  116169  2
jbd                    52693  1 ext3
ata_piix                9925  4
libata                 53969  2 ahci,ata_piix
sd_mod                 16449  5
scsi_mod              124649  4 sg,ahci,libata,sd_mod


[root@umberto ~]# modinfo soundcore
filename:       /lib/modules/2.6.16-1.2080_FC5/kernel/sound/soundcore.ko
description:    Core sound module
author:         Alan Cox
license:        GPL
alias:          char-major-14-*
vermagic:       2.6.16-1.2080_FC5 686 REGPARM 4KSTACKS gcc-4.1
depends:
srcversion:     DD426F1CCA2CC5F060F6F92

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
======================================================================
