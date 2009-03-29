From: Dmitri Seletski <drjoms@gmail.com>
Subject: hda-intel failure to install drivers
Date: Sun, 29 Mar 2009 19:14:21 +0100
Message-ID: <49CFBA7D.105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080703000505080005060700"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id E034F1037F5
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Mar 2009 20:14:25 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 4so349610eyg.56
	for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2009 11:14:24 -0700 (PDT)
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

This is a multi-part message in MIME format.
--------------080703000505080005060700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

Please check out txt attachment.

Reason I have decided to go with source code from alsa web page - i have
issues with microphone. Basically i can record, but it only records
white noise. However, i didn't come across any issues with playing
sounds. Even DS 5.1 was working!

Anyway, alsalog describes what i did do generally.
alsaconf.log  describes what has happened when i was using  alsaconf
2>>alasaconf.log


Any ideas anyone?
For time being i shall use kernel modules...

Regards
Dmitri

--------------080703000505080005060700
Content-Type: text/plain;
 name="alsa.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.log"

cd /usr/src/linux
make
mount /boot
cp arch/x86_64/boot/bzImage /boot/vanilla.2.6.28.9

*now i have fresh kernel and all necessary modules, i have soundcore.ko as one of modules, no other alsa module is compiled in or as module
/dev/snd is already created
*


reboot

./configure --with-cards=hda-intel --with-isapnp=no
make
make install-modules

modprobe snd-hda-intel
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hda_codec (/lib/modules/2.6.28.9/kernel/sound/pci/hda/snd-hda-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel (/lib/modules/2.6.28.9/kernel/sound/pci/hda/snd-hda-intel.ko): Unknown symbol in module, or unknown parameter (see dmesg)


*relevant part of dmesg*

[   26.548089] i2c-adapter i2c-8: adapter [NVIDIA i2c adapter ] registered
[   26.548099] i2c-adapter i2c-9: adapter [NVIDIA i2c adapter ] registered
[   88.000269] Clocksource tsc unstable (delta = -277240031 ns)
[  301.259242] snd: Unknown symbol unregister_sound_special
[  301.260119] snd: Unknown symbol register_sound_special_device
[  301.262749] snd_timer: Unknown symbol snd_info_register
[  301.262896] snd_timer: Unknown symbol snd_info_create_module_entry
[  301.263059] snd_timer: Unknown symbol snd_info_free_entry
[  301.263722] snd_timer: Unknown symbol snd_verbose_printk
[  301.263899] snd_timer: Unknown symbol snd_iprintf
[  301.264124] snd_timer: Unknown symbol snd_ecards_limit
[  301.264623] snd_timer: Unknown symbol snd_oss_info_register
[  301.264768] snd_timer: Unknown symbol snd_unregister_device
[  301.264972] snd_timer: Unknown symbol snd_device_new
[  301.265616] snd_timer: Unknown symbol snd_register_device_for_dev
[  301.266908] snd_pcm: Unknown symbol snd_info_register
[  301.267054] snd_pcm: Unknown symbol snd_info_create_module_entry
[  301.267197] snd_pcm: Unknown symbol snd_ctl_unregister_ioctl_compat
[  301.267981] snd_pcm: Unknown symbol snd_timer_notify
[  301.268160] snd_pcm: Unknown symbol snd_timer_interrupt
[  301.268545] snd_pcm: Unknown symbol snd_info_free_entry
[  301.268689] snd_pcm: Unknown symbol snd_add_device_sysfs_file
[  301.268865] snd_pcm: Unknown symbol snd_info_get_str
[  301.269605] snd_pcm: Unknown symbol snd_verbose_printk
[  301.269924] snd_pcm: Unknown symbol snd_ctl_register_ioctl
[  301.270067] snd_pcm: Unknown symbol snd_card_file_add
[  301.270598] snd_pcm: Unknown symbol snd_iprintf
[  301.270831] snd_pcm: Unknown symbol snd_major
[  301.271211] snd_pcm: Unknown symbol snd_unregister_device
[  301.271800] snd_pcm: Unknown symbol snd_timer_new
[  301.271944] snd_pcm: Unknown symbol snd_device_new
[  301.272228] snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
[  301.272877] snd_pcm: Unknown symbol snd_lookup_minor_data
[  301.273021] snd_pcm: Unknown symbol snd_ctl_register_ioctl_compat
[  301.273215] snd_pcm: Unknown symbol snd_info_create_card_entry
[  301.273706] snd_pcm: Unknown symbol snd_power_wait
[  301.273869] snd_pcm: Unknown symbol snd_device_free
[  301.274150] snd_pcm: Unknown symbol snd_card_file_remove
[  301.274618] snd_pcm: Unknown symbol snd_register_device_for_dev
[  301.274920] snd_pcm: Unknown symbol snd_device_register
[  301.275073] snd_pcm: Unknown symbol snd_info_get_line
[  301.275982] snd_hwdep: Unknown symbol snd_info_register
[  301.276127] snd_hwdep: Unknown symbol snd_info_create_module_entry
[  301.276521] snd_hwdep: Unknown symbol snd_ctl_unregister_ioctl_compat
[  301.276667] snd_hwdep: Unknown symbol snd_info_free_entry
[  301.276835] snd_hwdep: Unknown symbol snd_unregister_oss_device
[  301.276993] snd_hwdep: Unknown symbol snd_verbose_printk
[  301.277137] snd_hwdep: Unknown symbol snd_register_oss_device
[  301.277792] snd_hwdep: Unknown symbol snd_ctl_register_ioctl
[  301.277937] snd_hwdep: Unknown symbol snd_card_file_add
[  301.278109] snd_hwdep: Unknown symbol snd_iprintf
[  301.278579] snd_hwdep: Unknown symbol snd_major
[  301.278769] snd_hwdep: Unknown symbol snd_unregister_device
[  301.278962] snd_hwdep: Unknown symbol snd_device_new
[  301.279146] snd_hwdep: Unknown symbol snd_ctl_unregister_ioctl
[  301.279732] snd_hwdep: Unknown symbol snd_lookup_oss_minor_data
[  301.279887] snd_hwdep: Unknown symbol snd_lookup_minor_data
[  301.280032] snd_hwdep: Unknown symbol snd_ctl_register_ioctl_compat
[  301.280189] snd_hwdep: Unknown symbol snd_card_file_remove
[  301.280748] snd_hwdep: Unknown symbol snd_register_device_for_dev
[  301.281899] snd_hda_codec: Unknown symbol snd_ctl_add
[  301.282114] snd_hda_codec: Unknown symbol snd_card_proc_new
[  301.282530] snd_hda_codec: Unknown symbol snd_add_device_sysfs_file
[  301.282758] snd_hda_codec: Unknown symbol snd_ctl_remove
[  301.282902] snd_hda_codec: Unknown symbol snd_ctl_find_id
[  301.283127] snd_hda_codec: Unknown symbol snd_verbose_printk
[  301.283819] snd_hda_codec: Unknown symbol snd_ctl_new1
[  301.284027] snd_hda_codec: Unknown symbol snd_component_add
[  301.284173] snd_hda_codec: Unknown symbol snd_ctl_make_virtual_master
[  301.284678] snd_hda_codec: Unknown symbol snd_iprintf
[  301.284837] snd_hda_codec: Unknown symbol snd_ctl_boolean_mono_info
[  301.285165] snd_hda_codec: Unknown symbol snd_hwdep_new
[  301.285861] snd_hda_codec: Unknown symbol snd_device_new
[  301.286044] snd_hda_codec: Unknown symbol _snd_ctl_add_slave
[  301.286576] snd_hda_codec: Unknown symbol snd_pci_quirk_lookup
[  301.286860] snd_hda_codec: Unknown symbol snd_device_free
[  301.287004] snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_step
[  301.287223] snd_hda_codec: Unknown symbol snd_pcm_format_width
[  301.288530] snd_hda_intel: Unknown symbol snd_pcm_new
[  301.288674] snd_hda_intel: Unknown symbol snd_pcm_limit_hw_rates
[  301.288826] snd_hda_intel: Unknown symbol snd_card_register
[  301.288969] snd_hda_intel: Unknown symbol snd_card_free
[  301.289112] snd_hda_intel: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
[  301.289830] snd_hda_intel: Unknown symbol snd_hda_bus_new
[  301.290176] snd_hda_intel: Unknown symbol snd_hda_build_pcms
[  301.290562] snd_hda_intel: Unknown symbol snd_pcm_set_sync
[  301.290750] snd_hda_intel: Unknown symbol snd_verbose_printk
[  301.290894] snd_hda_intel: Unknown symbol snd_hda_codec_new
[  301.291648] snd_hda_intel: Unknown symbol snd_hda_queue_unsol_event
[  301.291837] snd_hda_intel: Unknown symbol snd_hda_power_up
[  301.291997] snd_hda_intel: Unknown symbol snd_pcm_sgbuf_get_chunk_size
[  301.292162] snd_hda_intel: Unknown symbol snd_pcm_lib_malloc_pages
[  301.292788] snd_hda_intel: Unknown symbol snd_pcm_lib_ioctl
[  301.292943] snd_hda_intel: Unknown symbol snd_pcm_lib_free_pages
[  301.293097] snd_hda_intel: Unknown symbol snd_hda_power_down
[  301.293241] snd_hda_intel: Unknown symbol snd_hda_calc_stream_format
[  301.293819] snd_hda_intel: Unknown symbol snd_pcm_set_ops
[  301.294033] snd_hda_intel: Unknown symbol snd_hda_suspend
[  301.294219] snd_hda_intel: Unknown symbol snd_device_new
[  301.294686] snd_hda_intel: Unknown symbol snd_pcm_sgbuf_ops_page
[  301.294887] snd_hda_intel: Unknown symbol snd_pcm_suspend_all
[  301.295036] snd_hda_intel: Unknown symbol snd_card_disconnect
[  301.295180] snd_hda_intel: Unknown symbol snd_hda_resume
[  301.295744] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_integer
[  301.295933] snd_hda_intel: Unknown symbol snd_hda_build_controls
[  301.296559] snd_hda_intel: Unknown symbol snd_pci_quirk_lookup
[  301.296901] snd_hda_intel: Unknown symbol snd_card_create
[  301.297046] snd_hda_intel: Unknown symbol snd_pcm_period_elapsed
[  301.297190] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_step





*relevant part of  "lspci -vv"*
00:0e.1 Audio device: nVidia Corporation MCP55 High Definition Audio (rev a2)
	Subsystem: ASUSTeK Computer Inc. Device 81f2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Count=1/1 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fixed+
	Kernel modules: snd-hda-intel

--------------080703000505080005060700
Content-Type: text/plain;
 name="alsaconf.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsaconf.log"

WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ad1889 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-ad1889.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ali5451 (/lib/modules/2.6.28.9/kernel/sound/pci/ali5451/snd-ali5451.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_als300 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-als300.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_sb_common (/lib/modules/2.6.28.9/kernel/sound/isa/sb/snd-sb-common.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_als4000 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-als4000.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_asihpi (/lib/modules/2.6.28.9/kernel/sound/pci/asihpi/snd-asihpi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_atiixp (/lib/modules/2.6.28.9/kernel/sound/pci/snd-atiixp.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_atiixp_modem (/lib/modules/2.6.28.9/kernel/sound/pci/snd-atiixp-modem.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_au8810 (/lib/modules/2.6.28.9/kernel/sound/pci/au88x0/snd-au8810.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_au8820 (/lib/modules/2.6.28.9/kernel/sound/pci/au88x0/snd-au8820.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_au8830 (/lib/modules/2.6.28.9/kernel/sound/pci/au88x0/snd-au8830.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_aw2 (/lib/modules/2.6.28.9/kernel/sound/pci/aw2/snd-aw2.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_azt3328 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-azt3328.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_bt87x (/lib/modules/2.6.28.9/kernel/sound/pci/snd-bt87x.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ca0106 (/lib/modules/2.6.28.9/kernel/sound/pci/ca0106/snd-ca0106.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_cmipci (/lib/modules/2.6.28.9/kernel/sound/pci/snd-cmipci.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_cs4281 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-cs4281.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_cs46xx (/lib/modules/2.6.28.9/kernel/sound/pci/cs46xx/snd-cs46xx.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_sb_common (/lib/modules/2.6.28.9/kernel/sound/isa/sb/snd-sb-common.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_sb16_dsp (/lib/modules/2.6.28.9/kernel/sound/isa/sb/snd-sb16-dsp.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_cs5530 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-cs5530.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_darla20 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-darla20.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_darla24 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-darla24.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_echo3g (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-echo3g.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_util_mem (/lib/modules/2.6.28.9/kernel/sound/synth/snd-util-mem.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_emu10k1 (/lib/modules/2.6.28.9/kernel/sound/pci/emu10k1/snd-emu10k1.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_emu10k1x (/lib/modules/2.6.28.9/kernel/sound/pci/emu10k1/snd-emu10k1x.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ens1370 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-ens1370.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ens1371 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-ens1371.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_es1938 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-es1938.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_es1968 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-es1968.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_fm801 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-fm801.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_gina20 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-gina20.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_gina24 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-gina24.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hda_codec (/lib/modules/2.6.28.9/kernel/sound/pci/hda/snd-hda-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel (/lib/modules/2.6.28.9/kernel/sound/pci/hda/snd-hda-intel.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hdsp (/lib/modules/2.6.28.9/kernel/sound/pci/rme9652/snd-hdsp.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hdspm (/lib/modules/2.6.28.9/kernel/sound/pci/rme9652/snd-hdspm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_oxygen_lib (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-oxygen-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hifier (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-hifier.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_i2c (/lib/modules/2.6.28.9/kernel/sound/i2c/snd-i2c.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_cs8427 (/lib/modules/2.6.28.9/kernel/sound/i2c/snd-cs8427.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ak4xxx_adda (/lib/modules/2.6.28.9/kernel/sound/i2c/other/snd-ak4xxx-adda.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ice17xx_ak4xxx (/lib/modules/2.6.28.9/kernel/sound/pci/ice1712/snd-ice17xx-ak4xxx.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ice1712 (/lib/modules/2.6.28.9/kernel/sound/pci/ice1712/snd-ice1712.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_i2c (/lib/modules/2.6.28.9/kernel/sound/i2c/snd-i2c.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pt2258 (/lib/modules/2.6.28.9/kernel/sound/i2c/other/snd-pt2258.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ak4114 (/lib/modules/2.6.28.9/kernel/sound/i2c/other/snd-ak4114.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ak4xxx_adda (/lib/modules/2.6.28.9/kernel/sound/i2c/other/snd-ak4xxx-adda.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ice17xx_ak4xxx (/lib/modules/2.6.28.9/kernel/sound/pci/ice1712/snd-ice17xx-ak4xxx.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ice1724 (/lib/modules/2.6.28.9/kernel/sound/pci/ice1712/snd-ice1724.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_indigo (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-indigo.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_indigodj (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-indigodj.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_indigoio (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-indigoio.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_intel8x0 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-intel8x0.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_intel8x0m (/lib/modules/2.6.28.9/kernel/sound/pci/snd-intel8x0m.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_korg1212 (/lib/modules/2.6.28.9/kernel/sound/pci/korg1212/snd-korg1212.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_layla20 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-layla20.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_layla24 (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-layla24.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_maestro3 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-maestro3.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_mia (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-mia.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_mixart (/lib/modules/2.6.28.9/kernel/sound/pci/mixart/snd-mixart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_mona (/lib/modules/2.6.28.9/kernel/sound/pci/echoaudio/snd-mona.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_nm256 (/lib/modules/2.6.28.9/kernel/sound/pci/nm256/snd-nm256.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_oxygen_lib (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-oxygen-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_oxygen (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-oxygen.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pcxhr (/lib/modules/2.6.28.9/kernel/sound/pci/pcxhr/snd-pcxhr.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pdplus (/lib/modules/2.6.28.9/kernel/sound/pci/pdplus/snd-pdplus.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_riptide (/lib/modules/2.6.28.9/kernel/sound/pci/riptide/snd-riptide.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_rme32 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-rme32.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_rme96 (/lib/modules/2.6.28.9/kernel/sound/pci/snd-rme96.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_rme9652 (/lib/modules/2.6.28.9/kernel/sound/pci/rme9652/snd-rme9652.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_sonicvibes (/lib/modules/2.6.28.9/kernel/sound/pci/snd-sonicvibes.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_util_mem (/lib/modules/2.6.28.9/kernel/sound/synth/snd-util-mem.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_trident (/lib/modules/2.6.28.9/kernel/sound/pci/trident/snd-trident.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_via82xx (/lib/modules/2.6.28.9/kernel/sound/pci/snd-via82xx.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_via82xx_modem (/lib/modules/2.6.28.9/kernel/sound/pci/snd-via82xx-modem.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_oxygen_lib (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-oxygen-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_virtuoso (/lib/modules/2.6.28.9/kernel/sound/pci/oxygen/snd-virtuoso.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_vx_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/vx/snd-vx-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_vx222 (/lib/modules/2.6.28.9/kernel/sound/pci/vx222/snd-vx222.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi (/lib/modules/2.6.28.9/kernel/sound/acore/snd-rawmidi.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart (/lib/modules/2.6.28.9/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_hwdep (/lib/modules/2.6.28.9/kernel/sound/acore/snd-hwdep.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_opl3_lib (/lib/modules/2.6.28.9/kernel/sound/drivers/opl3/snd-opl3-lib.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_ac97_codec (/lib/modules/2.6.28.9/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_ymfpci (/lib/modules/2.6.28.9/kernel/sound/pci/ymfpci/snd-ymfpci.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_midi_event (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-midi-event.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_seq_oss (/lib/modules/2.6.28.9/kernel/sound/acore/seq/oss/snd-seq-oss.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mixer_oss (/lib/modules/2.6.28.9/kernel/sound/acore/oss/snd-mixer-oss.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_pcm (/lib/modules/2.6.28.9/kernel/sound/acore/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pcm_oss (/lib/modules/2.6.28.9/kernel/sound/acore/oss/snd-pcm-oss.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_mixer_oss (/lib/modules/2.6.28.9/kernel/sound/acore/oss/snd-mixer-oss.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd (/lib/modules/2.6.28.9/kernel/sound/acore/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_seq_device (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq-device.ko): Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer (/lib/modules/2.6.28.9/kernel/sound/acore/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_seq (/lib/modules/2.6.28.9/kernel/sound/acore/seq/snd-seq.ko): Unknown symbol in module, or unknown parameter (see dmesg)
amixer: Mixer attach default error: No such file or directory
/usr/sbin/alsactl: save_state:1501: No soundcards found...

--------------080703000505080005060700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080703000505080005060700--
