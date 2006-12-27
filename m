From: risc@volumehost.com
Subject: BUG in >=1.0.13rc1
Date: Wed, 27 Dec 2006 16:00:22 -0600
Message-ID: <20061227220022.GB28449@volumehost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I own a toshiba L35 laptop, with a ATI SB450 sound card in it.

This card functions "adequately" with alsa 1.0.12.
it gets the "
ALSA /usr/src/alsa-driver-1.0.12/pci/hda/hda_codec.c:213: hda_codec: invalid dep_range_val 0:7fff
" errors scrolling off the screen, as reported by others,
and plays through the speakers only. this laptop has a mic (untested) and a headphone jack. plugging headphones in does stop the speakers, but dosent produce sound through the headphones.

however, switching to 1.0.13rc1 or newer (tried up to 1.0.14rc1) causes a kernel panic right after those errors stop.
sound does not function in these versions.

I've tried the disable_msi=1 option, however, i was not getting a "nobody cared" message before, and turning this option on does nothing.
So, i'm thinking this dosent have to do with the MSI changes recently.

the panic is as follows:
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f8b7b4e8
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nfs nfsd exportfs lockd nfs_acl sunrpc ipv6 dm_snapshot dm_mirror dm_mod usbhid uhci_hcd usbkbd orinoco_cs orinoco hermes tsdev joydev pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core i2c_piix4 shpchp pci_hotplug psmouse ati_agp agpgart i2c_core evdev serio_raw pcspkr rtc ext3 jbd mbcache ide_cd cdrom 8139cp sd_mod 8139too mii atiixp ehci_hcd ohci_hcd sata_sil usbcore libata scsi_mod generic ide_core thermal processor fan
CPU:    0
EIP:    0060:[<f8b7b4e8>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18 #1) 
EIP is at get_input_type+0x67/0x85 [snd_hda_codec]
eax: 00000007   ebx: dfd169c0   ecx: 00000001   edx: 00000000
esi: 00000000   edi: f8b836c5   ebp: f7bce880   esp: f5017d3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2367, ti=f5016000 task=f75ba000 task.ti=f5016000)
Stack: 00000001 f8b7bea2 0000032d dfd16a40 dfd169c0 dfd169e4 f50e2800 00000000 
       00000286 00000000 ffffe000 f5017d84 f5746ec0 00010000 00000002 c01b769c 
       f57468c0 c0185edb 0000032d 00008000 f57468c0 c0186316 f5746ec0 f5746940 
Call Trace:
 [<f8b7bea2>] build_generic_controls+0x1ed/0x2c9 [snd_hda_codec]
 [<c01b769c>] idr_get_new+0xa/0x26
 [<c0185edb>] proc_register+0x6e/0xfa
 [<c0186316>] create_proc_entry+0x87/0x9a
 [<f8a43757>] snd_create_proc_entry+0x8/0x14 [snd]
 [<f8a437fd>] snd_info_register+0x9a/0x9f [snd]
 [<f8b3eef1>] snd_pcm_lib_preallocate_pages+0xbf/0xd8 [snd_pcm]
 [<f8b3ef39>] snd_pcm_lib_preallocate_pages_for_all+0x2f/0x4c [snd_pcm]
 [<f8a54a9d>] create_codec_pcm+0xd8/0xf5 [snd_hda_intel]
 [<f8b7b0e0>] snd_hda_build_controls+0x16/0x67 [snd_hda_codec]
 [<f8a55311>] azx_probe+0x71d/0x72f [snd_hda_intel]
 [<f8a54604>] azx_send_cmd+0x0/0xd6 [snd_hda_intel]
 [<f8a54504>] azx_get_response+0x0/0x100 [snd_hda_intel]
 [<c01c1420>] pci_match_device+0x10/0xac
 [<c02107d4>] __driver_attach+0x0/0x5d
 [<c01c1508>] pci_device_probe+0x36/0x57
 [<c0210735>] driver_probe_device+0x42/0x8b
 [<c021080c>] __driver_attach+0x38/0x5d
 [<c0210256>] bus_for_each_dev+0x33/0x55
 [<c021069f>] driver_attach+0x11/0x13
 [<c02107d4>] __driver_attach+0x0/0x5d
 [<c020ff6f>] bus_add_driver+0x64/0xfd
 [<c01c1644>] __pci_register_driver+0x47/0x63
 [<c01358f5>] sys_init_module+0x16c3/0x1846
 [<c0102c7b>] syscall_call+0x7/0xb
Code: f9 02 b8 4c 35 b8 f8 eb 17 ba 51 35 b8 f8 eb 35 83 e1 0f ba 54 35 b8 f8 83 f9 02 b8 5e 35 b8 f8 0f 45 d0 eb 20 f6 43 15 10 74 03 <83> 0a 04 83 e1 0f ba 62 35 b8 f8 83 f9 02 b8 6c 35 b8 f8 eb e0 
EIP: [<f8b7b4e8>] get_input_type+0x67/0x85 [snd_hda_codec] SS:ESP 0068:f5017d3c

lspci is as follows:
00:00.0 Host bridge: ATI Technologies Inc Unknown device 5a31 (rev 01)
00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (rev 80)
00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (rev 80)
00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller (rev 80)
00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller (rev 80)
00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 82)
00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI (rev 80)
00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge (rev 80)
00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (rev 80)
01:05.0 VGA compatible controller: ATI Technologies Inc RC410 [Radeon Xpress 200M]
09:01.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
09:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
09:04.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
(ignore the second TI cardbus controller, its a replacement wireless card)

the kernel .config is stolen from debian's 2.6.18-3-686 package, and the source is debian's linux-source-2.6.18.

i'm on list for the duration of this issue.

Julia Longtin <risc@volumehost.com>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
