From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Tue, 6 Dec 2005 18:10:54 +0100
Message-ID: <ad58c49f0c69900416ba2191417d3ce4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 696A1196
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2005 18:10:54 +0100 (MET)
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
Last Modified:              12-06-2005 18:10 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
