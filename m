From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: usb-usx2y: playback fails with Tascam US122 on kernel
	3.14
Date: Wed, 6 Aug 2014 17:43:00 +0100
Message-ID: <1799623.GgHbzoqWFu@arial>
References: <4546801.Z4WD7yaEHq@arial>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hillend.cent.gla.ac.uk (hillend.cent.gla.ac.uk [130.209.16.102])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB54261615
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 18:43:01 +0200 (CEST)
Received: from cas05.campus.gla.ac.uk ([130.209.14.38])
 by hillend.cent.gla.ac.uk with esmtp (Exim 4.72)
 (envelope-from <Nicholas.Bailey@glasgow.ac.uk>) id 1XF4In-0003TI-Ey
 for alsa-devel@alsa-project.org; Wed, 06 Aug 2014 17:43:01 +0100
In-Reply-To: <4546801.Z4WD7yaEHq@arial>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 26 June 2014 15:51:54 Dr Nicholas J Bailey wrote:
> I am having trouble with the US122 in playback and duplex mode. In capture
> mode, it is working.
> 
> This problem occurs on (at least)
> Linux arial 3.14-1-686-pae #1 SMP Debian 3.14.7-1 (2014-06-16) i686
> GNU/Linux
> 
Further information:

Using this kernel:

Linux arial 3.14-2-686-pae #1 SMP Debian 3.14.13-2 (2014-07-24) i686 GNU/Linux

trying to use the US-122 Tascam box results in the following showing up in 
dmesg. I have unplugged and reconnected the box twice to get the LEDs to light 
up. This has been the normal behaviour for as long as I can remember. You can 
only use the Tascam as capture device on this kernel.

Using this kernel:

Linux arial 3.10.11 #1 SMP Wed Oct 2 19:26:59 BST 2013 i686 GNU/Linux

the US-122 works fine for simultaneous capture and playback.

I've looked at the difference in the source code between 3.10 and 4.14 and 
there is very little in the usb-usx2y alsa module. Is there some midi-related 
change I should know about?

I understand that the US-122 is a usb-1.1 device and I have the ehci module 
loaded, but it was there too with the older kernel and that worked fine.

Nick/.



dmesg with 3.14:

[  132.609303] usb 2-1.6: new full-speed USB device number 5 using ehci-pci
[  132.702208] usb 2-1.6: New USB device found, idVendor=1604, idProduct=8006
[  132.702213] usb 2-1.6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  133.179541] usb 2-1.6: USB disconnect, device number 5
[  134.913706] usb 2-1.6: new full-speed USB device number 6 using ehci-pci
[  135.006569] usb 2-1.6: New USB device found, idVendor=1604, idProduct=8007
[  135.006575] usb 2-1.6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  136.966582] usbcore: registered new interface driver snd-usb-usx2y
[  158.528140] usb 2-1.6: USB disconnect, device number 6
[  160.006047] usb 2-1.6: new full-speed USB device number 7 using ehci-pci
[  160.098682] usb 2-1.6: New USB device found, idVendor=1604, idProduct=8006
[  160.098688] usb 2-1.6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  160.320463] usb 2-1.6: USB disconnect, device number 7
[  162.054420] usb 2-1.6: new full-speed USB device number 8 using ehci-pci
[  162.147079] usb 2-1.6: New USB device found, idVendor=1604, idProduct=8007
[  162.147085] usb 2-1.6: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[  165.468486] ------------[ cut here ]------------
[  165.468538] WARNING: CPU: 0 PID: 0 at /build/linux-
sud87B/linux-3.14.13/include/linux/kref.h:47 usb_get_urb+0x34/0x40 [usbcore]()
[  165.468542] Modules linked in: snd_usb_usx2y snd_usbmidi_lib snd_rawmidi 
hid_generic hidp hid btusb bnep bluetooth 6lowpan_iphc snd_hrtimer snd_seq 
snd_seq_device cpufreq_conservative cpufreq_powersave cpufreq_userspace 
cpufreq_stats nfsd auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc 
uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core videodev media arc4 
ath9k ath9k_common ath9k_hw ath mac80211 joydev cfg80211 snd_hda_codec_hdmi 
msi_wmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
snd_hda_codec iTCO_wdt iTCO_vendor_support mei_me snd_hwdep snd_pcm snd_timer 
shpchp battery psmouse mei snd lpc_ich wmi intel_powerclamp coretemp pcspkr 
i2c_i801 mfd_core ac serio_raw soundcore intel_ips evdev acpi_cpufreq 
processor kvm_intel kvm loop msi_laptop sparse_keymap rfkill fuse parport_pc 
ppdev lp parport autofs4 ext4 crc16 mbcache jbd2 sg sd_mod crc_t10dif 
crct10dif_generic crct10dif_common sr_mod cdrom crc32c_intel ahci libahci 
libata scsi_mod ehci_pci i915 ehci_hcd i2c_algo_bit drm_kms_helper r8169 mii 
drm usbcore usb_common i2c_core fan thermal video thermal_sys button
[  165.468651] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14-2-686-pae #1 
Debian 3.14.13-2
[  165.468654] Hardware name: Micro-Star International Calpella platform/To be 
filled by O.E.M., BIOS E1681IG6 VER.109 07/21/2010
[  165.468658]  00000009 c142f0e4 00000000 c105069e c1503c0c 00000000 00000000 
f836acbc
[  165.468668]  0000002f f8359ba4 f8359ba4 ec050ac0 f6ea4770 f6ce0000 f7409f14 
c105075b
[  165.468677]  00000009 00000000 f8359ba4 ec050ac0 f8357da2 00000000 00000015 
00000000
[  165.468686] Call Trace:
[  165.468699]  [<c142f0e4>] ? dump_stack+0x3e/0x4e
[  165.468708]  [<c105069e>] ? warn_slowpath_common+0x7e/0xa0
[  165.468733]  [<f8359ba4>] ? usb_get_urb+0x34/0x40 [usbcore]
[  165.468751]  [<f8359ba4>] ? usb_get_urb+0x34/0x40 [usbcore]
[  165.468757]  [<c105075b>] ? warn_slowpath_null+0x1b/0x20
[  165.468775]  [<f8359ba4>] ? usb_get_urb+0x34/0x40 [usbcore]
[  165.468794]  [<f8357da2>] ? usb_hcd_submit_urb+0x22/0x9d0 [usbcore]
[  165.468803]  [<c10806ca>] ? enqueue_task_fair+0x44a/0xf80
[  165.468810]  [<c1224b20>] ? cpumask_next_and+0x20/0x30
[  165.468816]  [<c10831b5>] ? load_balance+0xd5/0x770
[  165.468823]  [<c10160c8>] ? sched_clock+0x8/0x10
[  165.468830]  [<f95627b0>] ? usX2Y_urb_submit.isra.2+0x30/0x60 
[snd_usb_usx2y]
[  165.468837]  [<f95629a9>] ? i_usX2Y_urb_complete+0x179/0x570 
[snd_usb_usx2y]
[  165.468856]  [<f8356a39>] ? __usb_hcd_giveback_urb+0x59/0xd0 [usbcore]
[  165.468874]  [<f8357575>] ? usb_giveback_urb_bh+0x75/0xb0 [usbcore]
[  165.468882]  [<c1054b38>] ? tasklet_hi_action+0xc8/0xe0
[  165.468888]  [<c1054f61>] ? __do_softirq+0xc1/0x230
[  165.468895]  [<c1054ea0>] ? cpu_callback+0x150/0x150
[  165.468898]  <IRQ>  [<c10552ad>] ? irq_exit+0x7d/0x90
[  165.468909]  [<c10112da>] ? do_IRQ+0x3a/0xc0
[  165.468917]  [<c143ad6c>] ? common_interrupt+0x2c/0x34
[  165.468924]  [<c10a007b>] ? rcu_barrier_callback+0xb/0x20
[  165.468932]  [<c1339b18>] ? cpuidle_enter_state+0x38/0xd0
[  165.468937]  [<c1339c3e>] ? cpuidle_idle_call+0x8e/0x1b0
[  165.468943]  [<c1017915>] ? arch_cpu_idle+0x5/0x20
[  165.468950]  [<c10997bc>] ? cpu_startup_entry+0x17c/0x1e0
[  165.468956]  [<c15f9a84>] ? start_kernel+0x364/0x369
[  165.468961]  [<c15f9529>] ? repair_env_string+0x4d/0x4d
[  165.468965] ---[ end trace 8980d639cec05ef6 ]---
