From: fab <fab@gnux.info>
Subject: NULL pointer dereference
Date: Mon, 20 Jun 2005 14:33:44 +0200
Message-ID: <20050620123344.GA20286@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
testing the latest cvs version to see if I can make the internal speaker
working as in realtek's drivers (after having upgraded my kernel), I got it
(and I get it as soon as I load the sound module):

hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e0a52a74
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: snd_hda_intel snd_hda_codec snd_pcm snd_timer snd snd_page_alloc md5 ipv6 saa7134 soundcore joydev evdev parport_pc 
parport video_buf v4l2_common v4l1_compat i2c_core ir_common videodev unix
CPU:    0
EIP:    0060:[<e0a52a74>]    Not tainted VLI
EFLAGS: 00010293   (2.6.12) 
EIP is at alc880_auto_fill_dac_nids+0x44/0xc0 [snd_hda_codec]
eax: fffffffe   ebx: dc05e348   ecx: 00000000   edx: 00000000
esi: dc05e200   edi: 00000000   ebp: d831f000   esp: d9647df8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 9025, threadinfo=d9646000 task=ded1caa0)
Stack: 00000000 00000000 00000000 00000000 dc05e200 dc05e348 00000006 e0a530a4 
       dc05e200 dc05e348 dc05e200 d831f000 e0a533c7 d831f000 e0a5e1e0 000000d0 
       00000f00 00000005 00000000 d831f000 e0a531b0 00000000 e0a4ead6 d831f000 
Call Trace:
 [<e0a530a4>] alc880_parse_auto_config+0x34/0x100 [snd_hda_codec]
 [<e0a533c7>] patch_alc880+0x217/0x270 [snd_hda_codec]
 [<e0a531b0>] patch_alc880+0x0/0x270 [snd_hda_codec]
 [<e0a4ead6>] snd_hda_codec_new+0x1a6/0x230 [snd_hda_codec]
 [<e09cf92f>] azx_codec_create+0xbf/0xd0 [snd_hda_intel]
 [<e09cf140>] azx_send_cmd+0x0/0x80 [snd_hda_intel]
 [<e09cf270>] azx_get_response+0x0/0x90 [snd_hda_intel]
 [<c01d3ee8>] sprintf+0x28/0x30
 [<e09d0753>] azx_probe+0xf3/0x1b0 [snd_hda_intel]
 [<c01dd472>] pci_device_probe_static+0x52/0x70
 [<c01dd4cc>] __pci_device_probe+0x3c/0x50
 [<c01dd50c>] pci_device_probe+0x2c/0x50
 [<c0224acf>] driver_probe_device+0x2f/0x80
 [<c0224c1c>] driver_attach+0x5c/0xa0
 [<c022518d>] bus_add_driver+0x9d/0xd0
 [<c01dd650>] pci_device_shutdown+0x0/0x30
 [<c01dd7be>] pci_register_driver+0x6e/0x90
 [<e097b00f>] alsa_card_azx_init+0xf/0x11 [snd_hda_intel]
 [<c0138928>] sys_init_module+0x148/0x1f0
 [<c0103185>] syscall_call+0x7/0xb
Code: 8b 13 31 ff 39 d7 7d 52 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 0f b7 44 7b 04 8d 48 ec 66 83 f9 03 77 13 8b 56 3c 83 e8 16 
<66> 89 04 7a c7 04 8c 01 00 00 00 8b 13 47 39 d7 7c da 31 ff 39 

------------------------------------

My system is :
Linux version 2.6.12 (root@medion) (version gcc 3.3.5 (Debian 1:3.3.5-13)) #1 Mon Jun 20 10:23:36 CEST 2005

Hope this helps.

Fabien Devaux.

PS: realtek's drivers are ok with.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
