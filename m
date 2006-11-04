From: Anders <andersosterholt@gmail.com>
Subject: Re: Conexant test code.
Date: Sat, 4 Nov 2006 23:55:26 +0000 (UTC)
Message-ID: <loom.20061105T004916-522@post.gmane.org>
References: <1162633963.24604.163.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Conexant 5047, HP DV3000.

Only difference I see from patch 7 is Headphone mixer is renamed to Main.

Same issues with headphones not muting speakers and scratchy sound.

I'd like to try model=test, but I still get a bunch of Unknown symbols and
unknown parameter model. Am I doing something wrong? Need to compile a kernel
with debugging enabled? I am using ./configure --with-debug=full
--with-cards=hda-intel

lspci -s 0:1b -vn
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 103c:30b2
        Flags: bus master, fast devsel, latency 0, IRQ 74
        Memory at d4340000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

root@anders-laptop:~/Desktop/alsa/alsa-driver-1.0.13# modprobe snd-hda-intel
root@anders-laptop:~/Desktop/alsa/alsa-driver-1.0.13# dmesg
[17182639.584000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[17182653.732000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) ->
IRQ 66
[17182653.732000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17182654.888000] ALSA
/home/anders/Desktop/alsa/alsa-driver-1.0.13/pci/hda/\
../../alsa-kernel/pci/hda/hda_intel.c:540:
hda_intel: azx_get_response timeout, switching to polling mode...

root@anders-laptop:~/Desktop/alsa/alsa-driver-1.0.13# /etc/init.d/alsasound
stop; dmesg -c; modprobe snd-hda-intel model=test
Shutting down sound driver: done
[17182639.584000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[17182653.732000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) ->
IRQ 66
[17182653.732000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17182654.888000] ALSA
/home/anders/Desktop/alsa/alsa-driver-1.0.13/pci/hda/\
../../alsa-kernel/pci/hda/hda_intel.c:540:
hda_intel: azx_get_response timeout, switching to polling mode...
[17182741.976000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
FATAL: Error inserting snd
(/lib/modules/2.6.17-10-generic/kernel/sound/acore/snd.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd
WARNING: Error inserting snd_timer
(/lib/modules/2.6.17-10-generic/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd
(/lib/modules/2.6.17-10-generic/kernel/sound/acore/snd.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd
WARNING: Error inserting snd_timer
(/lib/modules/2.6.17-10-generic/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pcm
(/lib/modules/2.6.17-10-generic/kernel/sound/acore/snd-pcm.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd_pcm
WARNING: Error inserting snd_hda_codec
(/lib/modules/2.6.17-10-generic/kernel/sound/pci/hda/snd-hda-codec.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_hda_intel
(/lib/modules/2.6.17-10-generic/kernel/sound/pci/hda/snd-hda-intel.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

root@anders-laptop:~/Desktop/alsa/alsa-driver-1.0.13# dmesg
[17182742.056000] snd: Unknown parameter `model'
[17182742.056000] snd_timer: Unknown symbol snd_verbose_printd
[17182742.056000] snd_timer: Unknown symbol snd_hidden_kzalloc
[17182742.056000] snd_timer: Unknown symbol snd_info_register
[17182742.056000] snd_timer: Unknown symbol snd_info_create_module_entry
[17182742.056000] snd_timer: Unknown symbol snd_info_free_entry
[17182742.056000] snd_timer: Unknown symbol snd_hidden_kfree
[17182742.056000] snd_timer: Unknown symbol snd_verbose_printk
[17182742.056000] snd_timer: Unknown symbol snd_iprintf
[17182742.056000] snd_timer: Unknown symbol snd_ecards_limit
[17182742.056000] snd_timer: Unknown symbol snd_oss_info_register
[17182742.056000] snd_timer: Unknown symbol snd_unregister_device
[17182742.056000] snd_timer: Unknown symbol snd_hidden_kstrdup
[17182742.056000] snd_timer: Unknown symbol snd_device_new
[17182742.056000] snd_timer: Unknown symbol snd_hidden_kmalloc
[17182742.056000] snd_timer: Unknown symbol snd_register_device
[17182742.068000] snd: Unknown parameter `model'
[17182742.072000] snd_timer: Unknown symbol snd_verbose_printd
[17182742.072000] snd_timer: Unknown symbol snd_hidden_kzalloc
[17182742.072000] snd_timer: Unknown symbol snd_info_register
[17182742.072000] snd_timer: Unknown symbol snd_info_create_module_entry
[17182742.072000] snd_timer: Unknown symbol snd_info_free_entry
[17182742.072000] snd_timer: Unknown symbol snd_hidden_kfree
[17182742.072000] snd_timer: Unknown symbol snd_verbose_printk
[17182742.072000] snd_timer: Unknown symbol snd_iprintf
[17182742.072000] snd_timer: Unknown symbol snd_ecards_limit
[17182742.072000] snd_timer: Unknown symbol snd_oss_info_register
[17182742.072000] snd_timer: Unknown symbol snd_unregister_device
[17182742.072000] snd_timer: Unknown symbol snd_hidden_kstrdup
[17182742.072000] snd_timer: Unknown symbol snd_device_new
[17182742.072000] snd_timer: Unknown symbol snd_hidden_kmalloc
[17182742.072000] snd_timer: Unknown symbol snd_register_device
[17182742.076000] snd_pcm: Unknown symbol snd_verbose_printd
[17182742.076000] snd_pcm: Unknown symbol snd_hidden_kzalloc
[17182742.076000] snd_pcm: Unknown symbol snd_info_register
[17182742.076000] snd_pcm: Unknown symbol snd_info_create_module_entry
[17182742.076000] snd_pcm: Unknown symbol snd_timer_notify
[17182742.076000] snd_pcm: Unknown symbol snd_timer_interrupt
[17182742.076000] snd_pcm: Unknown symbol snd_info_free_entry
[17182742.076000] snd_pcm: Unknown symbol snd_add_device_sysfs_file
[17182742.076000] snd_pcm: Unknown symbol snd_info_get_str
[17182742.076000] snd_pcm: Unknown symbol snd_hidden_kcalloc
[17182742.076000] snd_pcm: Unknown symbol snd_hidden_kfree
[17182742.076000] snd_pcm: Unknown symbol snd_verbose_printk
[17182742.076000] snd_pcm: Unknown symbol snd_ctl_register_ioctl
[17182742.076000] snd_pcm: Unknown symbol snd_card_file_add
[17182742.076000] snd_pcm: Unknown symbol snd_iprintf
[17182742.076000] snd_pcm: Unknown symbol snd_major
[17182742.076000] snd_pcm: Unknown symbol snd_unregister_device
[17182742.076000] snd_pcm: Unknown symbol snd_timer_new
[17182742.076000] snd_pcm: Unknown symbol snd_device_new
[17182742.076000] snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
[17182742.076000] snd_pcm: Unknown symbol snd_lookup_minor_data
[17182742.076000] snd_pcm: Unknown symbol snd_info_create_card_entry
[17182742.076000] snd_pcm: Unknown symbol snd_power_wait
[17182742.076000] snd_pcm: Unknown symbol snd_hidden_kmalloc
[17182742.076000] snd_pcm: Unknown symbol snd_device_free
[17182742.076000] snd_pcm: Unknown symbol snd_card_file_remove
[17182742.076000] snd_pcm: Unknown symbol snd_device_register
[17182742.076000] snd_pcm: Unknown symbol snd_register_device
[17182742.076000] snd_pcm: Unknown symbol snd_info_get_line
[17182742.080000] snd_hda_codec: Unknown symbol snd_verbose_printd
[17182742.080000] snd_hda_codec: Unknown symbol snd_hidden_kzalloc
[17182742.080000] snd_hda_codec: Unknown symbol snd_ctl_add
[17182742.080000] snd_hda_codec: Unknown symbol snd_card_proc_new
[17182742.080000] snd_hda_codec: Unknown symbol snd_hidden_kcalloc
[17182742.080000] snd_hda_codec: Unknown symbol snd_hidden_kfree
[17182742.080000] snd_hda_codec: Unknown symbol snd_ctl_find_id
[17182742.080000] snd_hda_codec: Unknown symbol snd_verbose_printk
[17182742.080000] snd_hda_codec: Unknown symbol snd_ctl_new1
[17182742.080000] snd_hda_codec: Unknown symbol snd_component_add
[17182742.080000] snd_hda_codec: Unknown symbol snd_iprintf
[17182742.080000] snd_hda_codec: Unknown symbol snd_ctl_elem_read
[17182742.080000] snd_hda_codec: Unknown symbol snd_ctl_elem_write
[17182742.080000] snd_hda_codec: Unknown symbol snd_hidden_kstrdup
[17182742.080000] snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_list
[17182742.080000] snd_hda_codec: Unknown symbol snd_device_new
[17182742.080000] snd_hda_codec: Unknown symbol snd_hidden_kmalloc
[17182742.080000] snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_step
[17182742.080000] snd_hda_codec: Unknown symbol snd_pcm_format_width
[17182742.084000] snd_hda_intel: Unknown symbol snd_verbose_printd
[17182742.084000] snd_hda_intel: Unknown symbol snd_hidden_kzalloc
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_new
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_limit_hw_rates
[17182742.084000] snd_hda_intel: Unknown symbol snd_card_register
[17182742.084000] snd_hda_intel: Unknown symbol snd_card_free
[17182742.084000] snd_hda_intel: Unknown symbol
snd_pcm_lib_preallocate_pages_for_all
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_bus_new
[17182742.084000] snd_hda_intel: Unknown symbol snd_hidden_kcalloc
[17182742.084000] snd_hda_intel: Unknown symbol snd_hidden_kfree
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_build_pcms
[17182742.084000] snd_hda_intel: Unknown symbol snd_verbose_printk
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_codec_new
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_queue_unsol_event
[17182742.084000] snd_hda_intel: Unknown symbol snd_card_new
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_lib_malloc_pages
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_lib_ioctl
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_lib_free_pages
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_calc_stream_format
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_set_ops
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_suspend
[17182742.084000] snd_hda_intel: Unknown symbol snd_device_new
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_suspend_all
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_resume
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_integer
[17182742.084000] snd_hda_intel: Unknown symbol snd_hda_build_controls
[17182742.084000] snd_hda_intel: Unknown symbol snd_hidden_kmalloc
[17182742.084000] snd_hda_intel: Unknown symbol snd_pcm_period_elapsed

root@anders-laptop:~/Desktop/alsa/alsa-driver-1.0.13# \
cat /proc/asound/card0/codec#0
Codec: Conexant CXT5047
Address: 0
Vendor Id: 0x14f15047
Subsystem Id: 0x103c30b2
Revision Id: 0x100000
Default PCM: rates 0x040, bits 0x02, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0e 0x0e]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x8e 0x8e] [0x80 0x80]
[0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
  Connection: 6
     0x19 0x14 0x15 0x1a* 0x16 0x10
Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9e 0x9e]
  Pincap 0x081001c: OUT HP EAPD Detect
  Pin Default 0x0221101f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 3
     0x19* 0x10 0x16
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP Detect
  Pin Default 0x02a1102e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 2
     0x19* 0x16
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x0833c: IN OUT HP Detect
  Pin Default 0x40000180: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x21: IN
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x16 [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x0860: IN
  Pin Default 0x94330121: [Fixed] CD at Int Right
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Power: 0x0
Node 0x17 [Pin Complex] wcaps 0x400481: Stereo
  Pincap 0x08324: IN Detect
  Pin Default 0x95a70122: [Fixed] Mic at Int Top
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x21: IN
  Power: 0x0
Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x04440131: [Jack] SPDIF Out at Ext Right
    Conn = RCA, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
  Connection: 1
     0x11
Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x80 0x80] [0x17 0x17]
  Power: 0x0
  Connection: 4
     0x10 0x1b 0x1a 0x16
Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0
  Amp-Out vals:  [0x03 0x03]
  Power: 0x0
  Connection: 3
     0x15 0x14 0x17*
Node 0x1b [Audio Selector] wcaps 0x300501: Stereo
  Power: 0x0
  Connection: 2
     0x14* 0x15
Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  PCM: rates 0x040, bits 0x02, types 0x1
  Power: 0x0
Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Pincap 0x08314: OUT Detect
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 3
     0x1c 0x19* 0x16
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono

-- 
Anders


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
