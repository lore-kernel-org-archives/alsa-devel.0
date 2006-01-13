From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Fri, 13 Jan 2006 01:11:08 +0100
Message-ID: <8603c80c62f798288b8de2df773dfd10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD3E4159
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 01:11:08 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001517.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              01-12-2006 21:04 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
======================================================================

----------------------------------------------------------------------
 jwoithe - 12-05-05 07:12 
----------------------------------------------------------------------
This sounds exactly like what I saw with a Fujitsu S7020 laptop earlier
this year.  The ALC260 sound chip has about a dozen identical audio I/O
pins which are somewhat arbitarily labeled as "CD" and "Line" (etc) by the
manufacturer.  While some system integrators go along with these labels,
others do not.  To fix the problem one must deduce which chip pins are
physically connected to the various I/O plugs on the laptop and then
define a mapping for that laptop in patch_realtek.c.  Once this is done
alsa mixer application (alsamixer for example) will do the right thing.

I went through this process by trial and error for the S7020 earlier this
year.  Essentially I defined a large number of mixer controls and hooked
one to each of the output widgets on the ALC260 (having the ALC260
datasheet is very helpful here).  When the resulting driver was loaded I
then used alsamixer to work out what each control/widget did (if
anything).  Finally I used the resultant information to define mixer
layout and initialisation details for the S7020.
  
There may be a better (streamlined) way of doing this but the above was
quick and worked for me.  Takashi may well have an easier way. :)

If you want more details contact me via the ALSA mailing list.

----------------------------------------------------------------------
 timmy - 12-05-05 19:35 
----------------------------------------------------------------------
I have exactly the same problem, with an Acer Travelmate 4064WLMi,
unfortunately. I even tried with the driver Realtek have, with no luck.

----------------------------------------------------------------------
 tiwai - 12-06-05 15:52 
----------------------------------------------------------------------
Could you try the latest ALSA CVS version?

----------------------------------------------------------------------
 robertw - 12-06-05 18:10 
----------------------------------------------------------------------
I tried the cvs version right after your notice, but I ran into
kernel-error

Dec  6 16:38:40 localhost kernel: [4294943.513000] ACPI: PCI Interrupt
0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
Dec  6 16:38:40 localhost kernel: [4294943.633000] e03de3e7
Dec  6 16:38:40 localhost kernel: [4294943.633000] Modules linked in:
snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd soundcore snd_page_alloc rfcomm l2cap bluetooth speedstep_centrino
cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave
cpufreq_ondemand cpufreq_conservative pcmcia yenta_socket rsrc_nonstatic
pcmcia_core video tc1100_wmi sony_acpi pcc_acpi hotkey dev_acpi
i2c_acpi_ec button battery container ac ipv6 af_packet dm_mod joydev tsdev
evdev eeprom i2c_sensor i2c_i801 i2c_core psmouse mousedev parport_pc lp
parport md ext3 jbd mbcache thermal processor fan 8139too 8139cp mii
ehci_hcd uhci_hcd usbcore ide_cd cdrom ide_disk ide_generic piix ide_core
unix vesafb capability commoncap vga16fb vgastate softcursor cfbimgblt
cfbfillrect
cfbcopyarea fbcon tileblit font bitblit
Dec  6 16:38:40 localhost kernel: [4294943.633000] CPU:    0
Dec  6 16:38:40 localhost kernel: [4294943.633000] EIP:   
0060:[pg0+537064423/1069872128]    Not tainted VLI
Dec  6 16:38:40 localhost kernel: [4294943.633000] EFLAGS: 00010206  
(2.6.12-10-686)
Dec  6 16:38:40 localhost kernel: [4294943.633000] EIP is at
alc_build_pcms+0xb7/0xf0 [snd_hda_codec]
Dec  6 16:38:40 localhost kernel: [4294943.633000] eax: 00000000   ebx:
d1e97400   ecx: 0000000c   edx: 00000000
Dec  6 16:38:40 localhost kernel: [4294943.633000] esi: 00000000   edi:
d1e974ec   ebp: d1e974e8   esp: ce07fe68
Dec  6 16:38:40 localhost kernel: [4294943.633000] ds: 007b   es: 007b  
ss: 0068
Dec  6 16:38:40 localhost kernel: [4294943.633000] Process modprobe (pid:
6738, threadinfo=ce07e000 task=dc91aa20)
Dec  6 16:38:40 localhost kernel: [4294943.633000] Stack: 00000000
00000000 dc8a14c0 df5f1800 dc8a14c8 e03db86e dc8a14c0 00000001
Dec  6 16:38:40 localhost kernel: [4294943.633000]        00000000
df4f179c df4f1780 00000000 cfa07400 df5f1800 00000000 e0375046
Dec  6 16:38:40 localhost kernel: [4294943.633000]        df4f1780
e0374140 e0374270 00000000 00000001 00000000 cfa07400 df5f1800
Dec  6 16:38:40 localhost kernel: [4294943.633000] Call Trace:
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+537053294/1069872128] snd_hda_build_pcms+0x3e/0xc0 [snd_hda_codec]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+536633414/1069872128] azx_pcm_create+0x16/0x1b0 [snd_hda_intel]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+536629568/1069872128] azx_send_cmd+0x0/0x80 [snd_hda_intel]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+536629872/1069872128] azx_get_response+0x0/0x90 [snd_hda_intel]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+536635871/1069872128] azx_probe+0x8f/0x100 [snd_hda_intel]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pci_device_probe_static+82/111] pci_device_probe_static+0x52/0x6f
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[__pci_device_probe+59/78] __pci_device_probe+0x3b/0x4e
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pci_device_probe+44/86] pci_device_probe+0x2c/0x56
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[driver_probe_device+47/122] driver_probe_device+0x2f/0x7a
Dec  6 16:38:40 localhost kernel: [4294943.633000]  [driver_attach+77/140]
driver_attach+0x4d/0x8c
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[bus_add_driver+152/217] bus_add_driver+0x98/0xd9
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pci_register_driver+101/131] pci_register_driver+0x65/0x83
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[pg0+535519247/1069872128] alsa_card_azx_init+0xf/0x11 [snd_hda_intel]
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[sys_init_module+286/412] sys_init_module+0x11e/0x19c
Dec  6 16:38:40 localhost kernel: [4294943.633000] 
[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Dec  6 16:38:40 localhost kernel: [4294943.633000] Code: 07 66 83 7b 64 00
74 4a 8b 44 24 18 83 c5 68 ff 40 44 8b 43 3c 89 45 00 66 83 7b 52 00 74 16
fc 8b 73 40 b9 0c 00 00 00 8d 7d 04 <f3> a5 0f b7 43 52 66 89 45 10 66 83
7b 64 00 74 16 fc 8b 73 44

----------------------------------------------------------------------
 tiwai - 12-06-05 20:07 
----------------------------------------------------------------------
Try the attached patch (right now committed to CVS).

----------------------------------------------------------------------
 tiwai - 12-06-05 20:09 
----------------------------------------------------------------------
Also, if the Oops is gone, please upload the contents of
/proc/asound/card0/codec#* files, together with /etc/asound.state after
running "alsactl store".

----------------------------------------------------------------------
 robertw - 12-06-05 22:51 
----------------------------------------------------------------------
I got the oops again ..

Here the data from the 1.0.10-release

/proc/asound/card0/codec#0:

Codec: Realtek ALC260
Address: 0
Vendor Id: 0x10ec0260
Subsystem Id: 0x1025160d
Revision Id: 0x100400
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x23 0x23] [0x23 0x23] [0x23 0x23] [0x23 0x23] [0x23
0x23] [0x23 0x23] [0x23 0x23]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x12 0x13 0x14* 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 8
     0x12 0x13 0x14* 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals:  [0x18 0x18] [0x41 0x41] [0x41 0x41] [0xa3 0xa3] [0x41
0x41] [0x41 0x41] [0xa3 0xa3] [0xa3 0xa3]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=0
  Amp-Out vals:  [0x3c]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP
  Pin Default 0x0121111f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01a19932: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x01813130: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0xb7830131: [Fixed] Line In at Oth Mobile-In
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0814: OUT
  Pin Default 0xb7430120: [Fixed] SPDIF Out at Oth Mobile-In
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x0824: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono

/proc/asound/card0/codec#1

Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x1025008f
Revision Id: 0x90000

/etc/asound.state

state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 64'
                iface MIXER
                name 'Front Playback Volume'
                value.0 64
                value.1 64
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Front Playback Switch'
                value.0 true
                value.1 true
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'CD Playback Volume'
                value.0 65
                value.1 65
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'CD Playback Switch'
                value.0 true
                value.1 true
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'Line Playback Volume'
                value.0 65
                value.1 65
        }
        control.6 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Line Playback Switch'
                value.0 true
                value.1 true
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'Mic Playback Volume'
                value.0 24
                value.1 24
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Mic Playback Switch'
                value.0 true
                value.1 true
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'Front Mic Playback Volume'
                value.0 65
                value.1 65
        }
        control.10 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Front Mic Playback Switch'
                value.0 true
                value.1 true
        }
        control.11 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value.0 65
                value.1 65
        }
        control.12 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'PC Speaker Playback Switch'
                value.0 true
                value.1 true
        }
        control.13 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 64'
                iface MIXER
                name 'Headphone Playback Volume'
                value.0 64
                value.1 64
        }
        control.14 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Headphone Playback Switch'
                value.0 true
                value.1 true
        }
        control.15 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 65'
                iface MIXER
                name 'Mono Playback Volume'
                value 60
        }
        control.16 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mono Playback Switch'
                value true
        }
        control.17 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                value.0 35
                value.1 35
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 true
                value.1 true
        }
        control.19 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 'Front Mic'
                comment.item.2 Line
                comment.item.3 CD
                iface MIXER
                name 'Capture Source'
                value Mic
        }
        control.20 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 255
                value.1 255
        }
}

----------------------------------------------------------------------
 tiwai - 12-07-05 14:59 
----------------------------------------------------------------------
How about the attached additional patch?  Please build with
--with-debug=full configure option for debugging.

----------------------------------------------------------------------
 robertw - 12-07-05 23:10 
----------------------------------------------------------------------
I tried again the cvs-version of ~ 20:00 CET. This time the module behaves
fine. This time two cards showed up, one analog and one digital. Alsamixer
changed a bit:

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Front Left: Playback 64 [100%] [on]
  Front Right: Playback 64 [100%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Front Left: Playback 255 [100%]
  Front Right: Playback 255 [100%]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Front Left: Playback 65 [100%] [on]
  Front Right: Playback 65 [100%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Front Left: Playback 24 [37%] [on]
  Front Right: Playback 24 [37%] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 35 [100%] [on]
  Front Right: Capture 35 [100%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Input Source',0
  Capabilities:
  Mono:
Simple mixer control 'Input Source',1
  Capabilities:
  Mono:

aplay can play a file, but no output. With your second patch applied
against this cvs-version, everything is the same, but aplay couldn't play
anything:

$ aplay test.wav
ALSA lib pcm_dmix.c:802:(snd_pcm_dmix_open) unable to open slave
aplay: main:533: audio open error: Invalid argument

dmesg says:

Dec  7 23:04:23 localhost kernel: [4334412.498000] ALSA
/home/robert/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:3024:
hda_codec: Unknown model for ALC260
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536786703/1069872128] snd_pcm_hw_constraints_complete+0x2af/0x3a0
[snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536787479/1069872128] snd_pcm_open_file+0xd7/0x190 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536788024/1069872128] snd_pcm_open+0xe8/0x160 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[default_wake_function+0/18] default_wake_function+0x0/0x12
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [cdev_get+43/92]
cdev_get+0x2b/0x5c
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536787718/1069872128] snd_pcm_playback_open+0x36/0x40 [snd_pcm]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536564094/1069872128] snd_open+0x7e/0x1a0 [snd]
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[pg0+536563968/1069872128] snd_open+0x0/0x1a0 [snd]
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [chrdev_open+141/326]
chrdev_open+0x8d/0x146
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [dentry_open+411/511]
dentry_open+0x19b/0x1ff
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [filp_open+92/97]
filp_open+0x5c/0x61
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [get_unused_fd+35/176]
get_unused_fd+0x23/0xb0
Dec  7 23:04:27 localhost kernel: [4334416.735000]  [sys_open+91/255]
sys_open+0x5b/0xff
Dec  7 23:04:27 localhost kernel: [4334416.735000] 
[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75

The first line is also present with the plain cvs-version

You could also contact me more directly: robert@xenim.de (mail & jabber)

----------------------------------------------------------------------
 tiwai - 12-08-05 17:19 
----------------------------------------------------------------------
The line number in dmesg doesn't match with my code, so your code is likely
still older than mine.  Could you update the CVS tree?

Also, please upload the codec and asound.state files instead of pasting
them.

----------------------------------------------------------------------
 robertw - 12-08-05 22:05 
----------------------------------------------------------------------
the Files uploaded now are from the current cvs-build.

dmesg still says:
[4300337.794000] ALSA
/home/robert/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:3029:
hda_codec: Unknown model for ALC260

----------------------------------------------------------------------
 tiwai - 12-09-05 15:09 
----------------------------------------------------------------------
OK, then you still have no sound, right?  What outputs do your device have?
 Did you get the same kernel error messages?

The internal speaker and headphone jack?

----------------------------------------------------------------------
 robertw - 12-09-05 16:35 
----------------------------------------------------------------------
I have two build-in speakers (for stereo), headphone, microphone, and a
line-in jack. All these jacks are at the front.

This is exactly the notebook I have:
http://www.mediaonline.de/shop/product_5000_5000_-3_141114

The kernel does only say the one line about "unknown model".

And yes, I can still hear nothing.

----------------------------------------------------------------------
 tiwai - 12-09-05 17:03 
----------------------------------------------------------------------
Which output did you check?  From the codec dump, the only available output
is only the headphone.
For testing, run "aplay -vv foo.wav" and see whether VU meter works.

----------------------------------------------------------------------
 robertw - 12-09-05 17:17 
----------------------------------------------------------------------
I always tested the buildin speaker and the headphones jack.

aplay shows a vu meter

[...]
Max peak (1880 samples): 07917 (0x1eed) #####                24%
Max peak (1880 samples): 08754 (0x2232) ######               26%
[...]

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:11 
----------------------------------------------------------------------
Please try the latest CVS again, many hda-intel bugs are likely to be
fixed.

----------------------------------------------------------------------
 robertw - 01-02-06 21:55 
----------------------------------------------------------------------
I tried again today, but still the same: The driver loads, but no sound.

dmesg says:

[4321385.309000] ALSA
/home/robert/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:3030:
hda_codec: Unknown model for ALC260

----------------------------------------------------------------------
 tiwai - 01-04-06 17:29 
----------------------------------------------------------------------
Specify "model=fujitsu" module option with ALSA 1.0.11rc2 or CVS.

----------------------------------------------------------------------
 robertw - 01-04-06 22:16 
----------------------------------------------------------------------
I tried CVS and the 1.0.11rc2-version. Nothing new here:

[4300394.183000] ALSA
/home/robert/Desktop/alsa-driver-1.0.11rc2/pci/hda/../../alsa-kernel/pci/hda/patch_realtek.c:3030:
hda_codec: Unknown model for ALC260

So I edited a bit in alsa-kernel/pci/hda/patch_realtek.c:

------------
        /*if (board_config < 0 || board_config >= ALC260_MODEL_LAST) {
                snd_printd(KERN_INFO "hda_codec: Unknown model for
ALC260\n");
                board_config = ALC260_AUTO;
        }

        if (board_config == ALC260_AUTO) {
                * automatic parse from the BIOS config *
                err = alc260_parse_auto_config(codec);
                if (err < 0) {
                        alc_free(codec);
                        return err;
                } else if (! err) {
                        printk(KERN_INFO "hda_codec: Cannot set up
configuration from BIOS.  Using base mode...\n");
                        board_config = ALC260_BASIC;
                }
        }*/
        board_config = ALC260_FUJITSU_S702X;
----------
This are lines 3029 until 3045

With this litte changes, I have sound output on the line-out-jack
(controlled in alsamixer with 'headphones') and of course no warning in
dmesg. But I still have no sound through the internal speakers or the
headphones-jack.

EDIT: The mic-jack does also work



----------------------------------------------------------------------
 lobstaj - 01-11-06 23:38 
----------------------------------------------------------------------
I have an Acer Extensa (probably 6702WLMi) with an Realtek ALC260 and I
have the same problem. But with robertw's above change, I also got sound
from the line-out jack, not from headphone out nor from the internal
speakers. I didn't test the mic in though. At least there is some sound
now... :-)

----------------------------------------------------------------------
 rlrevell - 01-11-06 23:48 
----------------------------------------------------------------------
Did you try 'modprobe snd-hda-intel model=fujitsu' like tiwai suggested? 
It looks like you did not (all the patch does is set this).

----------------------------------------------------------------------
 lobstaj - 01-12-06 00:20 
----------------------------------------------------------------------
Yes, I have tried. If model=fujitsu is supposed to do the same, then it
just doesn't work. I get different mixer controls and sound with one, but
not the other.

----------------------------------------------------------------------
 rlrevell - 01-12-06 00:26 
----------------------------------------------------------------------
Can you cat /sys/module/snd_hda_intel/parameters/model to make sure it is
seeing the "fujitsu" option?

----------------------------------------------------------------------
 mytux - 01-12-06 01:20 
----------------------------------------------------------------------
I have an Acer 1643WLMi, with a Realtek ALC260.
Exactly the same here : with CVS of 2006-01-12 i also got sound from the
line-out jack, not from headphone out nor from the internal speakers.

I tried with modprobe snd-hda-intel model=fujitsu and it's the same.

cat /sys/module/snd_hda_intel/parameters/model gives me "fujitsu"



----------------------------------------------------------------------
 robertw - 01-12-06 14:13 
----------------------------------------------------------------------
I tried again with the current CVS (12.01.2005 14:00 MEZ).

When I do "modprobe snd-hda-intel model=fujitsu" I get the usual "3032:
hda_codec: Unknown model for ALC260"

"cat /sys/module/snd_hda_intel/parameters/model" says "<NULL>"

Is there somewhere such a model-description, which does what jwoithe at
the very beginning suggested?

----------------------------------------------------------------------
 lobstaj - 01-12-06 14:43 
----------------------------------------------------------------------
Now I've also tried to cat /sys/module/snd_hda_intel/parameters/model and
it says "<NULL>", no matter whether I pass the option or not (tried with
the modification and without).

----------------------------------------------------------------------
 rlrevell - 01-12-06 21:04 
----------------------------------------------------------------------
If /sys/module/snd_hda_intel/parameters/model says "NULL" you are not doing
it right.  Make sure to unload ALL snd-* modules before modprobing the new
ones.  Make sure you modprobe from the command line to eliminate the
possibility of modutils bugs.  Make sure you don't already have ALSA
drivers built into the kernel.  Etc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
12-06-05 15:52 tiwai          Note Added: 0006925                          
12-06-05 18:10 robertw        Note Added: 0006930                          
12-06-05 20:07 tiwai          Note Added: 0006934                          
12-06-05 20:08 tiwai          File Added: alc-cvs-fix.diff                    
12-06-05 20:09 tiwai          Note Added: 0006935                          
12-06-05 22:51 robertw        Note Added: 0006938                          
12-07-05 14:59 tiwai          Note Added: 0006941                          
12-07-05 15:00 tiwai          File Added: alc-cvs-fix2.diff                    
12-07-05 23:10 robertw        Note Added: 0006952                          
12-08-05 17:19 tiwai          Note Added: 0006957                          
12-08-05 22:01 robertw        File Added: codec#0                          
12-08-05 22:02 robertw        File Added: codec#1                          
12-08-05 22:03 robertw        File Added: asound.state                     
12-08-05 22:05 robertw        Note Added: 0006963                          
12-09-05 15:09 tiwai          Note Added: 0006966                          
12-09-05 16:35 robertw        Note Added: 0006967                          
12-09-05 17:03 tiwai          Note Added: 0006969                          
12-09-05 17:17 robertw        Note Added: 0006970                          
12-14-05 13:22 mytux          Issue Monitored: mytux                       
12-19-05 02:11 rlrevell       Note Added: 0007077                          
01-02-06 21:55 robertw        Note Added: 0007391                          
01-04-06 17:29 tiwai          Note Added: 0007441                          
01-04-06 22:00 robertw        Note Added: 0007453                          
01-04-06 22:16 robertw        Note Edited: 0007453                         
01-11-06 23:38 lobstaj        Note Added: 0007572                          
01-11-06 23:48 rlrevell       Note Added: 0007573                          
01-12-06 00:20 lobstaj        Note Added: 0007575                          
01-12-06 00:26 rlrevell       Note Added: 0007576                          
01-12-06 01:16 mytux          Note Added: 0007577                          
01-12-06 01:20 mytux          Note Edited: 0007577                         
01-12-06 14:13 robertw        Note Added: 0007586                          
01-12-06 14:43 lobstaj        Note Added: 0007587                          
01-12-06 16:45 eudoxos        Issue Monitored: eudoxos                     
01-12-06 21:04 rlrevell       Note Added: 0007591                          
01-13-06 01:11 rlrevell       Relationship added       duplicate of 0001517
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
