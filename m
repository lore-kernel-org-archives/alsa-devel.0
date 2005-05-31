From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001147]: snd_intel_hda crashes when the module is loaded
Date: Tue, 31 May 2005 16:22:58 +0200
Message-ID: <f5bcf6ed5828b692c5660b3edd04a07f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89699172
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 16:22:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1147> 
======================================================================
Reported By:                Katagia
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1147
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Suse Linux 9.3
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-31-2005 16:21 CEST
Last Modified:              05-31-2005 16:22 CEST
======================================================================
Summary:                    snd_intel_hda crashes when the module is loaded
Description: 
May 29 15:06:44 Notebook kernel: snd: unsupported module, tainting
kernel.
May 29 15:06:44 Notebook kernel: snd_page_alloc: unsupported module,
tainting kernel.
May 29 15:06:44 Notebook kernel: snd_timer: unsupported module, tainting
kernel.
May 29 15:06:45 Notebook kernel: snd_pcm: unsupported module, tainting
kernel.
May 29 15:06:45 Notebook kernel: snd_hda_codec: unsupported module,
tainting kernel.
May 29 15:06:45 Notebook kernel: snd_hda_intel: unsupported module,
tainting kernel.
May 29 15:06:45 Notebook kernel: PCI: No IRQ known for interrupt pin A
of device 0000:00:1b.0. Please try using pci=biosirq.
May 29 15:06:45 Notebook kernel:
ALSA /tmp/2/alsa-driver-1.0.9/alsa-kernel/pci/hda/hda_intel.c:1331:
hda-intel: unable to grab IRQ 0
May 29 15:06:45 Notebook kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May 29 15:06:45 Notebook kernel:  printing eip:
May 29 15:06:45 Notebook kernel: e04b2415
May 29 15:06:45 Notebook kernel: *pde = 00000000
May 29 15:06:45 Notebook kernel: Oops: 0000
[https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1]
May 29 15:06:45 Notebook kernel: Modules linked in: snd_hda_intel
snd_hda_codec snd_pcm snd_timer snd_page_alloc snd soundcore
cpufreq_userspace speedstep_
centrino freq_table thermal processor fan button battery ac usbserial
parport_pc lp parport eeprom i2c_sensor nvram af_packet pcmcia tg3
ipw2200 firmware_c
lass ieee80211 yenta_socket rsrc_nonstatic pcmcia_core ieee80211_crypt
tun intel_agp agpgart i2c_i801 i2c_core video1394 ohci1394 raw1394
ieee1394 capabili
ty ext3 jbd twofish cryptoloop edd evdev joydev sg st sd_mod sr_mod
scsi_mod usbhid uhci_hcd ohci_hcd ehci_hcd usbcore ipv6 nls_iso8859_1
nls_cp437 vfat fa
t dm_mod reiserfs ide_cd cdrom ide_disk piix ide_core
May 29 15:06:45 Notebook kernel: CPU:    0
May 29 15:06:45 Notebook kernel: EIP:    0060:[<e04b2415>]    Tainted: G
U VLI
May 29 15:06:45 Notebook kernel: EFLAGS: 00010286
(2.6.11.4-20a-default)
May 29 15:06:45 Notebook kernel: EIP is at azx_stream_stop+0x5/0x40
[snd_hda_intel]
May 29 15:06:45 Notebook kernel: eax: dc020000   ebx: 00000000   ecx:
ffffffff   edx: dc020024
May 29 15:06:45 Notebook kernel: esi: 00000007   edi: dc020000   ebp:
00000000   esp: d6949ee0
May 29 15:06:45 Notebook kernel: ds: 007b   es: 007b   ss: 0068
May 29 15:06:45 Notebook kernel: Process modprobe (pid: 8955,
threadinfo=d6948000 task=dcc9ba60)
May 29 15:06:45 Notebook kernel: Stack: dc020024 00000007 e04b2eed
fffffff0 dc020000 c17d1c00 e04b3196 d3de0000
May 29 15:06:45 Notebook kernel:        000000d0 00000006 d1f38c00
c02ece0e d3de0000 00000000 00000001 c17d1c00
May 29 15:06:45 Notebook kernel:        e04b32e6 d6949f28 00000000
e04b5d40 c17d1c00 ffffffed 00000000 c01dafa2
May 29 15:06:45 Notebook kernel: Call Trace:
May 29 15:06:45 Notebook kernel:  [<e04b2eed>] azx_free+0x1d/0x100
[snd_hda_intel]
May 29 15:06:45 Notebook kernel:  [<e04b3196>] azx_create+0x1b6/0x2a0
[snd_hda_intel]
May 29 15:06:45 Notebook kernel:  [<e04b32e6>] azx_probe+0x66/0x170
[snd_hda_intel]
May 29 15:06:45 Notebook kernel:  [<c01dafa2>] pci_device_probe_static
+0x32/0x50
May 29 15:06:45 Notebook kernel:  [<c01dafe7>] __pci_device_probe
+0x27/0x40
May 29 15:06:45 Notebook kernel:  [<c01db01b>] pci_device_probe
+0x1b/0x40
May 29 15:06:46 Notebook kernel:  [<c0234fd1>] driver_probe_device
+0x21/0x60
May 29 15:06:46 Notebook kernel:  [<c02350fd>] driver_attach+0x4d/0x80
May 29 15:06:46 Notebook kernel:  [<c023551d>] bus_add_driver+0x6d/0xa0
May 29 15:06:47 Notebook kernel:  [<c0235a18>] driver_register+0x28/0x30
May 29 15:06:47 Notebook kernel:  [<c01db1d9>] pci_register_driver
+0x49/0x60
May 29 15:06:47 Notebook kernel:  [<c012e9a4>] sys_init_module
+0x104/0x180
May 29 15:06:47 Notebook kernel:  [<c0102c49>] sysenter_past_esp
+0x52/0x79
May 29 15:06:47 Notebook kernel: Code: 2d 88 d9 b8 01 00 00 00 0f b6 7e
20 d3 e0 09 c7 89 f8 88 46 20 8b 52 1c 8a 02 83 c8 1e 88 02 5b 5e 5f c3
8d 76 00 56
 53 8b 5a 1c <8a> 0b 81 e1 e1 00 00 00 88 0b 8b 4a 1c c6 41 03 1c 8b 58
0c 8a
May 29 15:06:47 Notebook kernel:  <4>snd_mixer_oss: unsupported module,
tainting kernel.
May 29 15:06:48 Notebook kernel: snd_pcm_oss: unsupported module,
tainting kernel.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-31-05 16:22 
----------------------------------------------------------------------
Already fixed on CVS.

But the driver won't work for your device unless you adjust/fix the ACPI. 
It's above the scope of ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-05 16:21 Katagia        New Issue                                    
05-31-05 16:21 Katagia        Distribution              => Suse Linux 9.3  
05-31-05 16:21 Katagia        Kernel Version            => 2.6.11          
05-31-05 16:22 tiwai          Status                   assigned => resolved
05-31-05 16:22 tiwai          Resolution               open => fixed       
05-31-05 16:22 tiwai          Note Added: 0004835                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
