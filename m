From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002111]: alsa-driver-1.0.11 kernel oops on module-unload snd_intel8x0
Date: Wed, 10 May 2006 14:37:31 +0200
Message-ID: <ae67e4c5e03e9668f6e673b63d27b41c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BBFDF154
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 14:37:31 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2111> 
======================================================================
Reported By:                SledgeHammer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2111
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo Linux 2006.0
Kernel Version:             2.6.16
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-10-2006 11:56 CEST
Last Modified:              05-10-2006 14:37 CEST
======================================================================
Summary:                    alsa-driver-1.0.11 kernel oops on module-unload
snd_intel8x0
Description: 
Compiled several 2.6.16 kernel-images with alsa-driver 1.0.11 under
Gentoo.
Everything went just fine. System is booting, modules are loaded and
sound is playing.

But while trying to unload the alsa-modules I get a segfault and
dmesg reports:
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
f8ec0737
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: w83627hf hwmon_vid hwmon eeprom i2c_isa i2c_i801
i2c_core snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm
snd_timer snd soundcore snd_page_alloc vfat fat rtc usb_storage scsi_mod
ehci_hcd uhci_hcd usbcore fglrx intel_agp agpgart
CPU:    0
EIP:    0060:[<f8ec0737>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.16-gentoo-r7 #1)
EIP is at snd_mixer_oss_notify_handler+0x37/0x23a [snd_mixer_oss]
eax: 00000000   ebx: f723d00b   ecx: ffffffff   edx: f8ec2180
esi: 00000000   edi: f2f4d400   ebp: f4412000   esp: f4413ea4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 9185, threadinfo=f4412000 task=f7c38540)
Stack: <0>f7c38540 c18074a0 00000000 c18074a0 00000202 f7cc6a90 c039ce30
c02ca92d
       c039ce2c 00000282 f7cc6a90 00000000 f4413f08 c18074a0 00000000
c18074a0
       00000001 00000001 00000000 00000282 f7cc6a90 fffffff0 bfe69f90
f4413f14
Call Trace:
 [<c02ca92d>] wait_for_completion+0xc2/0xca
 [<c0117373>] wake_up_process+0x1e/0x20
 [<c0132bde>] kthread_stop_sem+0x70/0xa8
 [<c0132b6a>] kthread_stop+0x17/0x1b
 [<c013ca70>] stop_machine_run+0x30/0x38
 [<f8ec0b74>] alsa_mixer_oss_exit+0x38/0x42 [snd_mixer_oss]
 [<c0138842>] sys_delete_module+0x14b/0x15a
 [<c01532ea>] sys_munmap+0x45/0x66
 [<c0102df3>] sysenter_past_esp+0x54/0x75
Code: 24 b0 00 00 00 8b bc 24 ac 00 00 00 85 c0 74 7b 83 e8 01 74 51 8b
9f 10 02 00 00 31 c0 85 db 74 3a c7 44 24 08 00 00 00 00 8b 03 <8b> 00
c7 04 24 05 00 00 00 89 44 24 04 e8 e3 e5 fa ff 8b 83 e4
 <6>ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Badness in remove_proc_entry at fs/proc/generic.c:707
 [<c0196e89>] remove_proc_entry+0x171/0x178
 [<f8e6b8f8>] snd_info_unregister+0x39/0x5e [snd]
 [<f8e6b49a>] snd_info_card_free+0x50/0x61 [snd]
 [<f8e69d67>] snd_card_free+0xdb/0x2c3 [snd]
 [<c02ca92d>] wait_for_completion+0xc2/0xca
 [<c02c9baf>] klist_release+0x0/0x72
 [<c01e4cfc>] kobject_put+0x1e/0x22
 [<c01e4cd4>] kobject_release+0x0/0xa
 [<c01e5512>] kref_put+0x3e/0x88
 [<f8eb16d2>] snd_intel8x0_remove+0x19/0x2b [snd_intel8x0]
 [<c01ee584>] pci_device_remove+0x35/0x37
 [<c023c1a9>] __device_release_driver+0xb0/0xdd
 [<c023c2af>] driver_detach+0xaa/0xac
 [<c023ba69>] bus_remove_driver+0x3e/0x61
 [<c023c61d>] driver_unregister+0x10/0x1c
 [<c01ee7bd>] pci_unregister_driver+0x13/0x20
 [<f8eb16f3>] alsa_card_intel8x0_exit+0xf/0x13 [snd_intel8x0]
 [<c0138842>] sys_delete_module+0x14b/0x15a
 [<c01532ea>] sys_munmap+0x45/0x66
 [<c0102df3>] sysenter_past_esp+0x54/0x75

Back to 2.6.15 and alsa-driver 1.0.10 everything works fine again.

I haven't tried to compile 1.0.11 against the 2.6.15 kernel but on every
2.6.16 kernel I've got the same error.

After the error my system is still responding until a application tries to
access the sound-device.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-10-06 14:37 
----------------------------------------------------------------------
Already fixed in the latest version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-10-06 11:56 SledgeHammer   New Issue                                    
05-10-06 11:56 SledgeHammer   Distribution              => Gentoo Linux 2006.0
05-10-06 11:56 SledgeHammer   Kernel Version            => 2.6.16          
05-10-06 14:37 tiwai          Status                   new => resolved     
05-10-06 14:37 tiwai          Resolution               open => fixed       
05-10-06 14:37 tiwai          Assigned To               => tiwai           
05-10-06 14:37 tiwai          Note Added: 0009710                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
