From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH v2] Scarlett mixer interface inclusion
Date: Tue, 21 Oct 2014 14:46:26 -0500
Message-ID: <1413920787-4877-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 35D00260600
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 21:46:51 +0200 (CEST)
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
Cc: robin@gareus.org, tiwai@suse.de, clemens@ladisch.de, th55@gmx.de, david.henningsson@canonical.com, Chris J Arges <chris.j.arges@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a followup to David Henningsson's PATCH [1] to include the work of
Tobias Hoffman and Robin Gareus in getting the Scarlett mixer interface
working. I've read through the comments and tried to include fixes where
appropriate. 

Overall, I'd like to get a good base commit and start working on other commits
that address any major structual changes such as making functions more generic
or any other cleanup.

I've tested this on my Scarlett 18i8 mixer and it does work, however there
are still a few issues which need to be fixed:

1) When loading a device one gets the following messages:
snd-usb-audio 1-1.1:1.0: control 2:0:0:Master Playback Switch:0 is already present
snd-usb-audio: probe of 1-1.1:1.3 failed with error -5

2) When unloading a device there are numerous sysfs_remove_group issues:
usb 1-1.1: USB disconnect, device number 6
------------[ cut here ]------------
WARNING: CPU: 0 PID: 54 at /build/buildd/linux-3.16.0/fs/sysfs/group.c:219 sysfs_remove_group+0x99/0xa0()
sysfs group ffffffff82cbd6e0 not found for kobject 'midi1'
Modules linked in: snd_usb_audio(OE) snd_usbmidi_lib(OE) ctr ccm xt_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack xt_tcpudp bridge stp llc iptable_filter ip_tables x_tables arc4 iwldvm snd_hda_codec_hdmi mac80211 snd_hda_codec_conexant snd_hda_codec_generic iwlwifi snd_hda_intel uvcvideo snd_hda_controller videobuf2_vmalloc snd_hda_codec videobuf2_memops videobuf2_core snd_hwdep v4l2_common snd_pcm intel_rapl x86_pkg_temp_thermal videodev intel_powerclamp media coretemp kvm_intel bnep kvm btusb rfcomm cfg80211 joydev bluetooth serio_raw 6lowpan_iphc thinkpad_acpi nvram snd_seq_midi lpc_ich snd_seq_midi_event snd_rawmidi shpchp snd_seq mei_me snd_seq_device snd_timer mei snd soundcore parport_pc
 ppdev mac_hid lp parport binfmt_misc nls_iso8859_1 dm_crypt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd i915 psmouse ahci libahci firewire_ohci sdhci_pci firewire_core sdhci crc_itu_t i2c_algo_bit e1000e drm_kms_helper drm ptp pps_core wmi video
CPU: 0 PID: 54 Comm: khubd Tainted: G           OE 3.16.0-23-generic #30-Ubuntu
Hardware name: LENOVO 4177CTO/4177CTO, BIOS 83ET76WW (1.46 ) 07/05/2013
 0000000000000009 ffff880407b4f920 ffffffff8277fcbc ffff880407b4f968
 ffff880407b4f958 ffffffff8206fd8d 0000000000000000 ffffffff82cbd6e0
 ffff880405c7b410 0000000000000001 ffff8803eb059cf8 ffff880407b4f9b8
Call Trace:
 [<ffffffff8277fcbc>] dump_stack+0x45/0x56
 [<ffffffff8206fd8d>] warn_slowpath_common+0x7d/0xa0
 [<ffffffff8206fdfc>] warn_slowpath_fmt+0x4c/0x50
 [<ffffffff82256538>] ? kernfs_find_and_get_ns+0x48/0x60
 [<ffffffff8225a259>] sysfs_remove_group+0x99/0xa0
 [<ffffffff824d6927>] dpm_sysfs_remove+0x57/0x60
 [<ffffffff824cb625>] device_del+0x45/0x1d0
 [<ffffffff824cb7ce>] device_unregister+0x1e/0x70
 [<ffffffff824cb89c>] device_destroy+0x3c/0x50
 [<ffffffffc045f34b>] sound_remove_unit+0x5b/0x90 [soundcore]
 [<ffffffffc045f3aa>] unregister_sound_special+0x2a/0x30 [soundcore]
 [<ffffffffc04cc9b0>] snd_unregister_oss_device+0x60/0x100 [snd]
 [<ffffffffc0550ca9>] snd_rawmidi_dev_disconnect+0x119/0x160 [snd_rawmidi]
 [<ffffffffc04cc14c>] __snd_device_disconnect.part.1+0x1c/0x60 [snd]
 [<ffffffffc04cc437>] snd_device_disconnect_all+0x47/0x60 [snd]
 [<ffffffffc04c59f7>] snd_card_disconnect+0x147/0x1f0 [snd]
 [<ffffffffc09cf5a8>] usb_audio_disconnect+0x78/0x1a0 [snd_usb_audio]
 [<ffffffff825867b4>] usb_unbind_interface+0x74/0x2b0
 [<ffffffff824cf76f>] __device_release_driver+0x7f/0xf0
 [<ffffffff824cf803>] device_release_driver+0x23/0x30
 [<ffffffff824cf0f8>] bus_remove_device+0x108/0x180
 [<ffffffff824cb709>] device_del+0x129/0x1d0
 [<ffffffff82583f21>] usb_disable_device+0x91/0x290
 [<ffffffff82578688>] usb_disconnect+0x98/0x2f0
 [<ffffffff8257a6cf>] hub_port_connect+0x7f/0xac0
 [<ffffffff8257b9a3>] hub_events+0x893/0xda0
 [<ffffffff8257beed>] hub_thread+0x3d/0x160
 [<ffffffff820b9590>] ? prepare_to_wait_event+0x100/0x100
 [<ffffffff8257beb0>] ? hub_events+0xda0/0xda0
 [<ffffffff82094aeb>] kthread+0xdb/0x100
 [<ffffffff82094a10>] ? kthread_create_on_node+0x1c0/0x1c0
 [<ffffffff82787c3c>] ret_from_fork+0x7c/0xb0
 [<ffffffff82094a10>] ? kthread_create_on_node+0x1c0/0x1c0
---[ end trace 7a8cdc4a9c65ddf5 ]---

However this issue occured even without the patch applied.

Please follow up with additional comments and review and I'll be happy to
incorporate them into the next patch version.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/081986.html


Chris J Arges (1):
  Scarlett mixer interface for 6i6, 18i6, 18i8 and 18i20

 sound/usb/Makefile                 |    1 +
 sound/usb/mixer.c                  |   27 +-
 sound/usb/quirks-table.h           |   51 --
 sound/usb/scarlett/scarlettmixer.c | 1264 ++++++++++++++++++++++++++++++++++++
 sound/usb/scarlett/scarlettmixer.h |    6 +
 5 files changed, 1293 insertions(+), 56 deletions(-)
 create mode 100644 sound/usb/scarlett/scarlettmixer.c
 create mode 100644 sound/usb/scarlett/scarlettmixer.h

-- 
2.1.0
