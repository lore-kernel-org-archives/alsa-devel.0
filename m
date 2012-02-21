From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: v3.1.8: hda-intel broken
Date: Tue, 21 Feb 2012 23:58:07 +0000
Message-ID: <20120221235807.GO22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 26EBC103E7E
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 00:58:14 +0100 (CET)
Received: from n2100.arm.linux.org.uk
	([2002:4e20:1eda:1:214:fdff:fe10:4f86]:41180)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76) (envelope-from <linux@arm.linux.org.uk>)
	id 1Rzzaz-0002nu-Hn
	for alsa-devel@alsa-project.org; Tue, 21 Feb 2012 23:58:10 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>) id 1Rzzay-0002oM-BB
	for alsa-devel@alsa-project.org; Tue, 21 Feb 2012 23:58:08 +0000
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

v3.1.8:

<4>[1641072.853409] WARNING: at sound/pci/hda/hda_codec.c:5152 snd_array_new+0x47/0x9b [snd_hda_codec]()
<4>[1641072.853412] Hardware name: 2081CTO
<4>[1641072.853413] BUG? (num >= 4096)
<4>[1641072.853415] Modules linked in: lp cdc_ether usbnet mii cdc_acm cdc_wdm usblp ftdi_sio usbserial parport_jtag fuse joydev cpufreq_ondemand acpi_cpufreq mperf nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device arc4 snd_pcm snd_timer r852 sm_common nand nand_ids nand_ecc mtd iwlagn mac80211 snd_page_alloc ppdev iTCO_wdt parport_pc cfg80211 iTCO_vendor_support i2c_i801 thinkpad_acpi rfkill e1000e snd soundcore parport pcspkr wmi microcode firewire_ohci sdhci_pci sdhci mmc_core firewire_core crc_itu_t yenta_socket i915 drm_kms_helper drm i2c_algo_bit i2c_core video [last unloaded: ftdi_sio]
<4>[1641072.853459] Pid: 3089, comm: bash Tainted: G        W   3.1.8 #2
<4>[1641072.853461] Call Trace:
<4>[1641072.853466]  [<c04387eb>] warn_slowpath_common+0x6a/0x7f
<4>[1641072.853472]  [<f861d5d0>] ? snd_array_new+0x47/0x9b [snd_hda_codec]
<4>[1641072.853475]  [<c0438873>] warn_slowpath_fmt+0x2b/0x2f
<4>[1641072.853481]  [<f861d5d0>] snd_array_new+0x47/0x9b [snd_hda_codec]
<4>[1641072.853488]  [<f861d65c>] snd_hda_input_jack_add+0x38/0xa2 [snd_hda_codec]
<4>[1641072.853493]  [<f872dcc4>] cxt5051_init+0x62/0xea [snd_hda_codec_conexant]
<4>[1641072.853500]  [<f8621c51>] hda_call_codec_resume+0xa5/0xba [snd_hda_codec]
<4>[1641072.853506]  [<f861f369>] snd_hda_power_up+0x46/0x5c [snd_hda_codec]
<4>[1641072.853513]  [<f861f3b9>] codec_exec_verb+0x3a/0xc7 [snd_hda_codec]
<4>[1641072.853519]  [<f861f482>] snd_hda_codec_write+0x3c/0x43 [snd_hda_codec]
<4>[1641072.853526]  [<f861f4b9>] set_pincfg+0x30/0x45 [snd_hda_codec]
<4>[1641072.853532]  [<f861f507>] restore_pincfgs+0x39/0x46 [snd_hda_codec]
<4>[1641072.853539]  [<f861fa0a>] snd_hda_codec_free+0x6c/0x1f8 [snd_hda_codec]
<4>[1641072.853545]  [<f861fbdb>] snd_hda_bus_free+0x45/0x7c [snd_hda_codec]
<4>[1641072.853552]  [<f861fdb9>] snd_hda_bus_dev_free+0x17/0x19 [snd_hda_codec]<4>[1641072.853560]  [<f80979a4>] snd_device_free+0x91/0xde [snd]
<4>[1641072.853566]  [<f8097c9c>] snd_device_free_all+0x68/0x80 [snd]
<4>[1641072.853572]  [<f80936e3>] snd_card_do_free+0x4e/0xdf [snd]
<4>[1641072.853577]  [<f8094160>] snd_card_free+0x89/0x94 [snd]
<4>[1641072.853581]  [<c044fcee>] ? wake_up_bit+0x20/0x20
<4>[1641072.853585]  [<f86ccddf>] azx_remove+0x13/0x1f [snd_hda_intel]
<4>[1641072.853589]  [<c05de80d>] pci_device_remove+0x2c/0x74
<4>[1641072.853593]  [<c066371d>] __device_release_driver+0x66/0x9c
<4>[1641072.853596]  [<c0663770>] device_release_driver+0x1d/0x28
<4>[1641072.853599]  [<c0662caf>] driver_unbind+0x4d/0x7b
<4>[1641072.853601]  [<c0662c62>] ? store_drivers_probe+0x33/0x33
<4>[1641072.853604]  [<c06627fb>] drv_attr_store+0x24/0x28
<4>[1641072.853607]  [<c05263a6>] sysfs_write_file+0xb3/0xec
<4>[1641072.853609]  [<c05262f3>] ? sysfs_poll+0x73/0x73
<4>[1641072.853612]  [<c04df254>] vfs_write+0x87/0xde
<4>[1641072.853615]  [<c04e678e>] ? path_put+0x1a/0x1d
<4>[1641072.853617]  [<c04df428>] sys_write+0x40/0x62
<4>[1641072.853621]  [<c07c751f>] sysenter_do_call+0x12/0x28
<4>[1641072.853623] ---[ end trace 3d590d4bbb62d735 ]---

>From what I can see, this uses the suspend/resume methods on device open/
close.  The suspend method does nothing apart from "shutting up pins".  The
resume method adds new jacks via snd_array_new(), which eventually ends up
getting (after many many days of uptime) to 4096 entries.  And then it
starts exploding with warnings every so often, filling my screen from top
to bottom with abrtd boxes warning me that my kernel is doing this.

Then, if I try to unbind the PCI device associated with this to shut the
thing up, it oopses and takes the machine out:

<1>[1641072.855748] BUG: unable to handle kernel NULL pointer dereference at 00000018
<1>[1641072.855796] IP: [<c06cf531>] is_event_supported+0xf/0x20
<4>[1641072.855830] *pde = 00000000
<0>[1641072.855849] Oops: 0000 [#1] SMP
<4>[1641072.855873] Modules linked in: lp cdc_ether usbnet mii cdc_acm cdc_wdm usblp ftdi_sio usbserial parport_jtag fuse joydev cpufreq_ondemand acpi_cpufreq mperf nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 uinput snd_hda_codec_conexant snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device arc4 snd_pcm snd_timer r852 sm_common nand nand_ids nand_ecc mtd iwlagn mac80211 snd_page_alloc ppdev iTCO_wdt parport_pc cfg80211 iTCO_vendor_support i2c_i801 thinkpad_acpi rfkill e1000e snd soundcore parport pcspkr wmi microcode firewire_ohci sdhci_pci sdhci mmc_core firewire_core crc_itu_t yenta_socket i915 drm_kms_helper drm i2c_algo_bit i2c_core video [last unloaded: ftdi_sio]
<4>[1641072.856004]
<4>[1641072.856004] Pid: 3089, comm: bash Tainted: G        W   3.1.8 #2 LENOVO 2081CTO/2081CTO
<4>[1641072.856004] EIP: 0060:[<c06cf531>] EFLAGS: 00210293 CPU: 1
<4>[1641072.856004] EIP is at is_event_supported+0xf/0x20
<4>[1641072.856004] EAX: 00000005 EBX: 00000000 ECX: 0000001f EDX: 00000018
<4>[1641072.856004] ESI: 00000005 EDI: 00000000 EBP: c42a3d50 ESP: c42a3d4c
<4>[1641072.856004]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
<0>[1641072.856004] Process bash (pid: 3089, ti=c42a2000 task=c8009920 task.ti=c42a2000)
<0>[1641072.856004] Stack:
<4>[1641072.856004]  00000000 c42a3d6c c06d075f 00000000 00000002 f1a47780 00000000 00000000
<4>[1641072.856004]  c42a3d84 f8098c00 00000000 c13005a0 f46c6000 00000078 c42a3da4 f862132e
<4>[1641072.856004]  00000000 00000016 00160016 f8731ce8 f46c6000 00000000 c42a3dc8 f872dcd1
<0>[1641072.856004] Call Trace:
<4>[1641072.856004]  [<c06d075f>] input_event+0x24/0x69
<4>[1641072.856004]  [<f8098c00>] snd_jack_report+0x70/0x8d [snd]
<4>[1641072.856004]  [<f862132e>] snd_hda_input_jack_report+0x7a/0x8e [snd_hda_codec]
<4>[1641072.856004]  [<f872dcd1>] cxt5051_init+0x6f/0xea [snd_hda_codec_conexant]
<4>[1641072.856004]  [<f8621c51>] hda_call_codec_resume+0xa5/0xba [snd_hda_codec]
<4>[1641072.856004]  [<f861f369>] snd_hda_power_up+0x46/0x5c [snd_hda_codec]
<4>[1641072.856004]  [<f861f3b9>] codec_exec_verb+0x3a/0xc7 [snd_hda_codec]
<4>[1641072.856004]  [<f861f482>] snd_hda_codec_write+0x3c/0x43 [snd_hda_codec]
<4>[1641072.856004]  [<f861f4b9>] set_pincfg+0x30/0x45 [snd_hda_codec]
<4>[1641072.856004]  [<f861f507>] restore_pincfgs+0x39/0x46 [snd_hda_codec]
<4>[1641072.856004]  [<f861fa0a>] snd_hda_codec_free+0x6c/0x1f8 [snd_hda_codec]
<4>[1641072.856004]  [<f861fbdb>] snd_hda_bus_free+0x45/0x7c [snd_hda_codec]
<4>[1641072.856004]  [<f861fdb9>] snd_hda_bus_dev_free+0x17/0x19 [snd_hda_codec]<4>[1641072.856004]  [<f80979a4>] snd_device_free+0x91/0xde [snd]
<4>[1641072.856004]  [<f8097c9c>] snd_device_free_all+0x68/0x80 [snd]
<4>[1641072.856004]  [<f80936e3>] snd_card_do_free+0x4e/0xdf [snd]
<4>[1641072.856004]  [<f8094160>] snd_card_free+0x89/0x94 [snd]
<4>[1641072.856004]  [<c044fcee>] ? wake_up_bit+0x20/0x20
<4>[1641072.856004]  [<f86ccddf>] azx_remove+0x13/0x1f [snd_hda_intel]
<4>[1641072.856004]  [<c05de80d>] pci_device_remove+0x2c/0x74
<4>[1641072.856004]  [<c066371d>] __device_release_driver+0x66/0x9c
<4>[1641072.856004]  [<c0663770>] device_release_driver+0x1d/0x28
<4>[1641072.856004]  [<c0662caf>] driver_unbind+0x4d/0x7b
<4>[1641072.856004]  [<c0662c62>] ? store_drivers_probe+0x33/0x33
<4>[1641072.856004]  [<c06627fb>] drv_attr_store+0x24/0x28
<4>[1641072.856004]  [<c05263a6>] sysfs_write_file+0xb3/0xec
<4>[1641072.856004]  [<c05262f3>] ? sysfs_poll+0x73/0x73
<4>[1641072.856004]  [<c04df254>] vfs_write+0x87/0xde
<4>[1641072.856004]  [<c04e678e>] ? path_put+0x1a/0x1d
<4>[1641072.856004]  [<c04df428>] sys_write+0x40/0x62
<4>[1641072.856004]  [<c07c751f>] sysenter_do_call+0x12/0x28
<0>[1641072.856004] Code: d0 fe ff ff eb 05 bf f0 ff ff ff b8 14 ce 9e c0 e8 a2
19 0f 00 89 f8 5b 5e 5f 5d c3 55 89 e5 53 3e 8d 74 26 00 31 db 39 c8 77 0c <0f>
a3 02 19 c0 31 db 85 c0 0f 95 c3 89 d8 5b 5d c3 55 89 e5 57
<0>[1641072.856004] EIP: [<c06cf531>] is_event_supported+0xf/0x20 SS:ESP 0068:c42a3d4c
<0>[1641072.856004] CR2: 0000000000000018
