From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001623]: Kernel oopsed when modprobing snd_mpu401 module
Date: Tue, 6 Dec 2005 19:57:36 +0100
Message-ID: <7df9baedb21ef584a54604156dd3d74f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99A671AB
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 19:57:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1623> 
======================================================================
Reported By:                cartman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1623
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Pardus Linux
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-06-2005 19:50 CET
Last Modified:              12-06-2005 19:57 CET
======================================================================
Summary:                    Kernel oopsed when modprobing snd_mpu401 module
Description: 
When I try to modprobe snd_mpu401 I get this:


Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: snd_mpu401 snd_opl3_lib snd_hwdep snd_cs4231_lib
parport_pc
parport i2c_viapro i2c_core via_agp agpgart snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_via82xx
snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
snd_seq_device snd sbp2 ohci1394 ieee1394 usb_storage uhci_hcd ohci_hcd
ehci_hcd
usbcore sata_sil sata_nv sata_mv sata_promise sata_sis sata_svw sata_via
sata_uli sata_vsc sata_sx4 sym53c8xx sg a100u2w scsi_transport_sas dc395x
tmscsim ahci BusLogic aacraid sr_mod 3w_xxxx lpfc qla1280 ipr st ch
megaraid
megaraid_mbox megaraid_mm megaraid_sas dmx3191d atp870u nsp32 aic7xxx
aic79xx
scsi_transport_spi osst qlogicfas408 ata_piix libata 3w_9xxx aha152x
qla6312
qla2200 qla2322 qla2100 qla2300 qla2xxx firmware_class scsi_transport_fc
sd_mod
scsi_mod
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14.3-10)
EIP is at rest_init+0x3feffdc0/0x40
eax: ccbf3e00   ebx: 00000000   ecx: d244d1b4   edx: d244d1b4
esi: d244d1b4   edi: ccbf3e08   ebp: ccbf3e08   esp: cba15db8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 9771, threadinfo=cba14000 task=cee87a50)
Stack: d2442011 ccbf3e00 c03031ca ccbf3e08 00000000 cba15dec c0303230
c030323f
       d244d1b4 ccbf3e08 c0302a5d d244d1b4 ccbf3e08 c04264f8 c04264f8
d244d20c
       ccbf3eb2 ccbf3e08 c0426400 ccbf3e08 00000000 c030329b c0426400
00000000
Call Trace:
 [<d2442011>] snd_platform_driver_probe+0x11/0x20 [snd]
 [<c03031ca>] driver_probe_device+0x2a/0x90
 [<c0303230>] __device_attach+0x0/0x20
 [<c030323f>] __device_attach+0xf/0x20
 [<c0302a5d>] bus_for_each_drv+0x4d/0x70
 [<c030329b>] device_attach+0x4b/0x60
 [<c0303230>] __device_attach+0x0/0x20
 [<c0302b83>] bus_add_device+0x23/0x90
 [<c0301cb6>] device_add+0xa6/0x120
 [<c0301d41>] device_register+0x11/0x20
 [<c0304889>] platform_device_register+0x119/0x170
 [<d244386f>] snd_generic_device_register+0x4f/0x90 [snd]
 [<d24438eb>] snd_card_set_generic_dev+0xb/0x30 [snd]
 [<d25680e8>] snd_mpu401_create+0xe8/0x160 [snd_mpu401]
 [<c02f1b07>] compare_pnp_id+0x77/0x90
 [<d2568207>] snd_mpu401_pnp_probe+0x57/0x90 [snd_mpu401]
 [<c02f1c85>] pnp_device_probe+0x75/0xa0
 [<c03031ca>] driver_probe_device+0x2a/0x90
 [<c03032b0>] __driver_attach+0x0/0x40
 [<c03032eb>] __driver_attach+0x3b/0x40
 [<c030294d>] bus_for_each_dev+0x4d/0x70
 [<c0291102>] kobject_add+0x72/0xc0
 [<c0303305>] driver_attach+0x15/0x20
 [<c03032b0>] __driver_attach+0x0/0x40
 [<c0302d9b>] bus_add_driver+0x5b/0xa0
 [<c03036d4>] driver_register+0x34/0x40
 [<c02f1d4f>] pnp_register_driver+0x2f/0x60
 [<d231b14a>] alsa_card_mpu401_init+0x4a/0x92 [snd_mpu401]
 [<c01388a2>] sys_init_module+0x122/0x1f0
 [<c0102f2b>] sysenter_past_esp+0x54/0x79
Code:  Bad EIP value.

======================================================================

----------------------------------------------------------------------
 tiwai - 12-06-05 19:57 
----------------------------------------------------------------------
Does it still happen with the ALSA CVS version?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-06-05 19:50 cartman        New Issue                                    
12-06-05 19:50 cartman        Distribution              => Pardus Linux    
12-06-05 19:50 cartman        Kernel Version            => 2.6.14          
12-06-05 19:57 tiwai          Note Added: 0006932                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
