From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001287]: oss emulation does not work any more.
Date: Fri, 29 Jul 2005 01:00:20 +0200
Message-ID: <875387b50a3998a7a2a77d8a82fb7d9a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BE64B16E
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 01:00:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1287> 
======================================================================
Reported By:                eNTi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1287
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             Linux eNTi 2.6.12-gentoo-r6
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 SMP Thu Jul 28 22:36:42
CEST 2005 i686 AMD Athlon(tm) 64 Processor 3500+ AuthenticAMD GNU/Linux
======================================================================
Date Submitted:             07-29-2005 01:00 CEST
Last Modified:              07-29-2005 01:00 CEST
======================================================================
Summary:                    oss emulation does not work any more.
Description: 
i'm getting these error messages, when the kernel starts up:

kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_hwdep: Unknown symbol snd_verbose_printk
kobject_register failed for snd_page_alloc (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_timer: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_verbose_printk
snd_ac97_codec: Unknown symbol snd_verbose_printk
snd_seq_device: Unknown symbol snd_verbose_printk
snd_rawmidi: Unknown symbol snd_verbose_printk
snd_emu10k1: Unknown symbol snd_verbose_printk
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508d0000ee8226]
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00023c01510808b8]
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3
13:12:                       
51 PST 2004
Velocity is AUTO mode
eth0: Link autonegation speed 1000M bps full duplex
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_hwdep: Unknown symbol snd_verbose_printk
kobject_register failed for snd_page_alloc (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_timer: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_verbose_printk
snd_ac97_codec: Unknown symbol snd_verbose_printk
snd_seq_device: Unknown symbol snd_verbose_printk
snd_rawmidi: Unknown symbol snd_verbose_printk
snd_emu10k1: Unknown symbol snd_verbose_printk
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_seq_device: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_verbose_printk
snd_seq: Unknown symbol snd_verbose_printk
snd_seq_oss: Unknown symbol snd_verbose_printk
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_mixer_oss: Unknown symbol snd_verbose_printk
kobject_register failed for snd_page_alloc (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_timer: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm_oss: Unknown symbol snd_verbose_printk
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_mixer_oss: Unknown symbol snd_verbose_printk
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_mixer_oss: Unknown symbol snd_verbose_printk
kobject_register failed for snd (-17)
 [<c0206fe9>] kobject_register+0x49/0x80
 [<c0136b00>] mod_sysfs_setup+0x50/0xb0
 [<c0137d34>] load_module+0x8b4/0xb90
 [<c01380a4>] sys_init_module+0x64/0x220
 [<c0102f1b>] sysenter_past_esp+0x54/0x75
snd_seq_device: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_verbose_printk
snd_seq: Unknown symbol snd_verbose_printk

no /dev/sound/dsp, /dev/sound/mixer and /dev/sound/audio are created (by
udev).

alsa still works (xmms is playing fine).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 01:00 eNTi           New Issue                                    
07-29-05 01:00 eNTi           Distribution              => gentoo          
07-29-05 01:00 eNTi           Kernel Version            => Linux eNTi
2.6.12-gentoo-r6 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 SMP
Thu Jul 28 22:36:42 CEST 2005 i686 AMD Athlon(tm) 64 Processor 3500+
AuthenticAMD GNU/Linux
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
