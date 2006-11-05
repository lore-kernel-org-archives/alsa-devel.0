From: enigma_0Z <enigma.0za@gmail.com>
Subject: Re: Conexant test code.
Date: Sun, 5 Nov 2006 17:52:49 -0500
Message-ID: <a6f0b350611051452r7082ea98m1a5c43c9e4d63f2b@mail.gmail.com>
References: <1162633963.24604.163.camel@razman>
	<454DEAFA.3030509@cse.unsw.edu.au>
	<b12092cb0611050603v89aa3c9vd19cb0ad173e5ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b12092cb0611050603v89aa3c9vd19cb0ad173e5ad7@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Just adding my results...

HP dv6000z does not work at all...

Loading driver as so:

--code--
modprobe snd-hda-intel disable_msi=1
--code--

Yields no sound, athough I can launch alsamixer and whatnot

Loading the driver as so:

--code--
modprobe snd-hda-intel disable_msi=1 model=test
--code--

causes a(lsa)mixer to freeze on launch, kill will not kill processes.

dmesg:

--code--
[17199716.196000] ACPI: PCI interrupt for device 0000:00:10.1 disabled
[17199802.688000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA]
-> GSI 18 (level, high) -> IRQ 58
[17199802.688000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[17199802.812000] ALSA
/home/enigma/src/build/alsa/test/alsa-driver-1.0.13/pci/hda/hda_codec.c:1741:
hda_codec: model 'test' is selected
[17199802.892000] hda_codec: num_steps = 0 for NID=0x17
[17199803.024000] BUG: unable to handle kernel paging request at
virtual address fffffff8
[17199803.024000]  printing eip:
[17199803.024000] f8eca71e
[17199803.024000] *pde = 00002067
[17199803.024000] Oops: 0000 [#1]
[17199803.024000] Modules linked in: snd_hda_intel snd_hda_codec
snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_oss snd_seq_midi_event
snd_seq snd_timer snd_seq_device snd soundcore
snd_page_alloc ipv6 rfcomm hidp l2cap bluetooth powernow_k8
cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave
cpufreq_ondemand cpufreq_conservative video tc1100_wmi s
bs sony_acpi pcc_acpi i2c_ec hotkey dev_acpi button battery container
ac asus_acpi nls_utf8 ntfs ext2 dm_mod md_mod ndiswrapper sr_mod sbp2
parport_pc lp parport joydev af_packe
t nvidia tsdev psmouse sg agpgart serio_raw evdev sdhci mmc_core
i2c_core rtc shpchp pci_hotplug usbhid ext3 jbd ehci_hcd ohci1394
ieee1394 ohci_hcd usbcore forcedeth ide_generi
c ide_cd cdrom generic sd_mod amd74xx sata_nv libata scsi_mod thermal
processor fan fbcon tileblit font bitblit softcursor vesafb capability
commoncap
[17199803.024000] CPU:    0
[17199803.024000] EIP:    0060:[<f8eca71e>]    Tainted: P      VLI
[17199803.024000] EFLAGS: 00010297   (2.6.17-10-386 #2)
[17199803.024000] EIP is at snd_hda_ch_mode_info+0x2e/0x50 [snd_hda_codec]
[17199803.024000] eax: ffffffff   ebx: 00000000   ecx: 00000000   edx: d6151e0c
[17199803.024000] esi: f1fdcbd4   edi: ed156560   ebp: d6151e0c   esp: d6151dcc
[17199803.024000] ds: 007b   es: 007b   ss: 0068
[17199803.024000] Process alsactl (pid: 17349, threadinfo=d6150000
task=ec7f4540)
[17199803.024000] Stack: 00000246 f8ed8c98 ed156414 f8ed6c58 00000000
ed156414 f8aec977 d6151e38
[17199803.024000]        de352814 d6151f44 c0165443 bfaf40a0 e65d86d4
00000001 c016572f d6151e38
[17199803.024000]        00000001 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[17199803.024000] Call Trace:
[17199803.024000]  <f8ed6c58> conexant_ch_mode_info+0x18/0x20
[snd_hda_codec]  <f8aec977> snd_ctl_ioctl+0x4f7/0xc60 [snd]
[17199803.024000]  <c0165443> do_lookup+0x53/0x160  <c016572f>
permission+0xbf/0xd0
[17199803.024000]  <c0148023> __handle_mm_fault+0x1e3/0x840
<c0156b05> nameidata_to_filp+0x35/0x40
[17199803.024000]  <c0156b60> do_filp_open+0x50/0x60  <f8aec480>
snd_ctl_ioctl+0x0/0xc60 [snd]
[17199803.024000]  <c0169bef> do_ioctl+0x1f/0x70  <c02c7ba9>
do_page_fault+0x3d9/0x6e0
[17199803.024000]  <c0169c9c> vfs_ioctl+0x5c/0x270  <c0169f22>
sys_ioctl+0x72/0x90
[17199803.024000]  <c0102dbb> sysenter_past_esp+0x54/0x79
[17199803.024000] Code: 8b 44 24 10 3b 42 54 c7 42 40 03 00 00 00 c7
42 48 01 00 00 00 89 42 50 77 06 83 e8 01 89 42 54 8b 42 54 c7 44 24
04 98 8c ed f8 <8b> 04 c1 89 44 24 08 8
d 42 58 89 04 24 e8 30 21 30 c7 31 c0 83
[17199803.024000] EIP: [<f8eca71e>] snd_hda_ch_mode_info+0x2e/0x50
[snd_hda_codec] SS:ESP 0068:d6151dcc
--code--

/proc/asound/card0/codec#0:

--code--
Codec: Conexant CXT5045
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x103c30b7
Revision Id: 0x100100
Default PCM: rates 0x140, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa2 0xa2]
  Pincap 0x0810014: OUT EAPD Detect
  Pin Default 0x92170010: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x01214020: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x21447040: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Yellow
  Pin-ctls: 0x00:
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
  Pin Default 0x97a70050: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x00:
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330060: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Power: 0x0
  Connection: 5
     0x19 0x14 0x12 0x11 0x15
Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x040, bits 0x06, types 0x5
Node 0x19 [Audio Output] wcaps 0xc11: Stereo
  PCM: rates 0x540, bits 0x0e, types 0x1
  Power: 0x0
Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Power: 0x0
  Connection: 5
     0x17* 0x14 0x12 0x11 0x15
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
--code--

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
