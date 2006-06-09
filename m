From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002196]: Trying to build/load ALSA to
	support the laptop only at this point,
	no base extender involved at all
Date: Fri, 9 Jun 2006 03:39:14 +0200
Message-ID: <9e35f9839a195d339e2ab22197163ca9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40AD9175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 03:39:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2196> 
======================================================================
Reported By:                reconfigures
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2196
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r9
======================================================================
Date Submitted:             06-09-2006 03:29 CEST
Last Modified:              06-09-2006 03:39 CEST
======================================================================
Summary:                    Trying to build/load ALSA to support the laptop only
at this point, no base extender involved at all
Description: 
First action in dmesg:

ALSA sound/pci/hda/hda_intel.c:634: codec_mask = 0x3
ALSA sound/pci/hda/patch_realtek.c:3026: hda_codec: Unknown model for
ALC260
ALSA sound/pci/hda/hda_codec.c:2088: autoconfig: line_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2092:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2094:    hp=0x10, dig_out=0x18,
din_in=0x19
ALSA sound/pci/hda/hda_codec.c:2102:    inputs: mic=0x12, fmic=0x13,
line=0x14, fline=0x0, cd=0x16, aux=0x15


Goes on into net and Reiser stuff but eventually....

snd_page_alloc: exports duplicate symbol snd_dma_alloc_pages (owned by
kernel)
soundcore: exports duplicate symbol sound_class (owned by kernel)
snd: exports duplicate symbol snd_major (owned by kernel)
snd_timer: exports duplicate symbol snd_timer_open (owned by kernel)
snd_pcm: exports duplicate symbol snd_pcm_new (owned by kernel)
snd_hda_codec: exports duplicate symbol snd_hda_codec_read (owned by
kernel)
kobject_register failed for snd_hda_intel (-17)
 [<b0301aeb>] kobject_register+0x6b/0x80
 [<b0137f3f>] sys_init_module+0x170f/0x186d
 [<b030d940>] pci_bus_read_config_byte+0x0/0x90
 [<b012fe70>] autoremove_wake_function+0x0/0x60
 [<b0157fb5>] vfs_read+0xb5/0x190
 [<b015848b>] sys_read+0x4b/0x80
 [<b0102d27>] sysenter_past_esp+0x54/0x75


All hell breaks loose after that regarding ALSA so a reboot is not just a
good idea anymore
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-09-06 03:39 
----------------------------------------------------------------------
It sounds like you have ALSA built into the kernel and are trying to
install ALSA modules also.  This cannot work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 03:29 reconfigures   New Issue                                    
06-09-06 03:29 reconfigures   Distribution              => Gentoo          
06-09-06 03:29 reconfigures   Kernel Version            => 2.6.16-gentoo-r9
06-09-06 03:30 reconfigures   Issue Monitored: reconfigures                    
06-09-06 03:39 rlrevell       Note Added: 0010126                          
======================================================================
