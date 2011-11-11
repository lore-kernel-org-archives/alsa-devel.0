From: David Henningsson <david.henningsson@canonical.com>
Subject: First test of the hda-jack branch
Date: Fri, 11 Nov 2011 17:23:32 +0100
Message-ID: <4EBD4C04.3090406@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030403010104080501020808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 0550D103838
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 17:23:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030403010104080501020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

After having some troubles with the kernel scripts (on the Ubuntu side) 
I've managed to try out your test/hda-jack branch. I'm attaching a patch 
I had to apply to make the modules load properly.

After having applied the attached patch, I get stuck at an OOPS, which I 
don't have time to troubleshoot further today. I'm attaching the OOPS 
log as well (alsa-info for the system I'm testing on is the same as I 
sent you a few days ago).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic


--------------030403010104080501020808
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Jack-Export-required-functions-from-hda_jac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Jack-Export-required-functions-from-hda_jac.pa";
 filename*1="tch"

>From ff857234c28f423dff43f2a7ed0ab3b2ea69a764 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 11 Nov 2011 17:13:15 +0100
Subject: [PATCH] ALSA: HDA: Jack: Export required functions from hda_jack.c

These two functions are being used by the codec-idt and codec-hdmi
modules, so they need to be exported properly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 1389958..eac002d 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -87,6 +87,7 @@ snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
 	jack->tag = codec->jacktbl.used;
 	return jack;
 }
+EXPORT_SYMBOL_HDA(snd_hda_jack_tbl_new);
 
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 static void snd_hda_input_jack_free(struct hda_codec *codec);
@@ -224,6 +225,7 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	jack->kctl = kctl;
 	return 0;
 }
+EXPORT_SYMBOL_HDA(snd_hda_jack_add_kctl);
 
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid, int idx,
 			 const struct auto_pin_cfg *cfg)
-- 
1.7.5.4



--------------030403010104080501020808
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[   17.249226] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to D0
[   17.249239] snd_hda_intel 0000:00:1b.0: power state changed by ACPI to D0
[   17.249252] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   17.249353] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
[   17.249393] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   17.249400] ALSA hda_intel.c:2775 chipset global capabilities = 0x4401
[   17.249418] ALSA hda_intel.c:1175 Clearing TCSEL
[   17.278073] ALSA hda_intel.c:1021 codec_mask = 0x9
[   17.281330] ALSA hda_intel.c:1484 codec #0 probed OK
[   17.281396] ALSA hda_intel.c:1484 codec #3 probed OK
[   17.302729] ALSA patch_sigmatel.c:5622 hda_codec: 92HD81B1X5: BIOS auto-probing.
[   17.302906] ALSA patch_sigmatel.c:5635 mute LED gpio 1 polarity 0
[   17.302914] ALSA hda_codec.c:4917 autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0) type:speaker
[   17.302918] ALSA hda_codec.c:4921    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   17.302922] ALSA hda_codec.c:4925    hp_outs=1 (0xb/0x0/0x0/0x0/0x0)
[   17.302925] ALSA hda_codec.c:4926    mono: mono_out=0x0
[   17.302927] ALSA hda_codec.c:4930    inputs:
[   17.302931] ALSA hda_codec.c:4934  Mic=0xa
[   17.302933] ALSA hda_codec.c:4936 
[   17.303160] ALSA patch_sigmatel.c:3123 stac92xx: dac_nids=1 (0x13/0x0/0x0/0x0/0x0)
[   17.303392] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
[   17.303918] Linux video capture interface: v2.00
[   17.304759] uvcvideo: Found UVC 1.00 device HP Webcam [2 MP Fixed] (04f2:b1ac)
[   17.312696] ALSA patch_sigmatel.c:4135 stac_gpio_set msk 1 dir 1 gpio 1
[   17.318851] BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
[   17.318917] IP: [<ffffffffa018544c>] snd_kctl_jack_report+0xc/0x30 [snd]
[   17.318976] PGD a2a8d067 PUD a2a8c067 PMD 0 
[   17.319013] Oops: 0000 [#1] SMP 
[   17.319041] CPU 3 
[   17.319056] Modules linked in: snd_hda_codec_hdmi uvcvideo(+) videodev snd_hda_codec_idt v4l2_compat_ioctl32 snd_hda_intel(+) snd_hda_codec snd_hwdep snd_pcm snd_rawmidi binfmt_misc snd_seq_midi_event snd_seq psmouse serio_raw intel_ips arc4 hp_accel lis3lv02d snd_seq_device snd_timer input_polldev ath9k mac80211 ath9k_common ath9k_hw ath snd cfg80211 soundcore snd_page_alloc mei(C) lp parport wmi i915 r8169 drm_kms_helper ahci drm libahci i2c_algo_bit video
[   17.319399] 
[   17.319412] Pid: 475, comm: modprobe Tainted: G         C  3.0.0-12-generic #20-Ubuntu Hewlett-Packard HP ProBook 4520s/1413
[   17.319492] RIP: 0010:[<ffffffffa018544c>]  [<ffffffffa018544c>] snd_kctl_jack_report+0xc/0x30 [snd]
[   17.319561] RSP: 0018:ffff8800afa8bb88  EFLAGS: 00010246
[   17.319599] RAX: 0000000000000000 RBX: ffff8800b1b35828 RCX: ffff8800b17b6428
[   17.319649] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880035e4e428
[   17.319699] RBP: ffff8800afa8bb88 R08: 0000000000000020 R09: 0000000000000000
[   17.319748] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   17.319797] R13: ffff8800a0a70028 R14: 000000000000000a R15: 0000000000000001
[   17.319848] FS:  00007fd24a8b1720(0000) GS:ffff8800b6cc0000(0000) knlGS:0000000000000000
[   17.319904] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   17.319944] CR2: 0000000000000078 CR3: 00000000afad0000 CR4: 00000000000006e0
[   17.319993] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.320042] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   17.320092] Process modprobe (pid: 475, threadinfo ffff8800afa8a000, task ffff880035e0dc80)
[   17.320148] Stack:
[   17.320163]  ffff8800afa8bbb8 ffffffffa02e7208 000000000000000a ffff8800a2be2028
[   17.320219]  0000000000000001 ffff8800a0a70028 ffff8800afa8bc08 ffffffffa0316fee
[   17.320275]  ffff8800a0a70828 0000000000000002 ffff8800afa8bc38 ffff8800a0a70028
[   17.320331] Call Trace:
[   17.320358]  [<ffffffffa02e7208>] snd_hda_jack_report_sync+0x48/0x90 [snd_hda_codec]
[   17.320417]  [<ffffffffa0316fee>] stac92xx_init+0x6be/0x820 [snd_hda_codec_idt]
[   17.320472]  [<ffffffffa02e69f0>] snd_hda_codec_build_controls+0x30/0x60 [snd_hda_codec]
[   17.320532]  [<ffffffffa02e6a58>] snd_hda_build_controls+0x38/0x90 [snd_hda_codec]
[   17.320589]  [<ffffffffa02bda93>] azx_probe+0x99c/0xa36 [snd_hda_intel]
[   17.320639]  [<ffffffff8130f32c>] local_pci_probe+0x5c/0xd0
[   17.320680]  [<ffffffff81310b39>] __pci_device_probe+0xf9/0x100
[   17.320723]  [<ffffffff812e9c3a>] ? kobject_get+0x1a/0x30
[   17.320761]  [<ffffffff81310b7a>] pci_device_probe+0x3a/0x60
[   17.320805]  [<ffffffff813ce4e8>] really_probe+0x68/0x190
[   17.320843]  [<ffffffff813ce775>] driver_probe_device+0x45/0x70
[   17.320885]  [<ffffffff813ce84b>] __driver_attach+0xab/0xb0
[   17.320925]  [<ffffffff813ce7a0>] ? driver_probe_device+0x70/0x70
[   17.320970]  [<ffffffff813ce7a0>] ? driver_probe_device+0x70/0x70
[   17.321014]  [<ffffffff813cd5dc>] bus_for_each_dev+0x5c/0x90
[   17.321054]  [<ffffffff813ce2ae>] driver_attach+0x1e/0x20
[   17.321093]  [<ffffffff813cdf00>] bus_add_driver+0x1a0/0x270
[   17.321135]  [<ffffffffa030d000>] ? 0xffffffffa030cfff
[   17.321172]  [<ffffffff813cedb6>] driver_register+0x76/0x140
[   17.321212]  [<ffffffffa030d000>] ? 0xffffffffa030cfff
[   17.323078]  [<ffffffff81310816>] __pci_register_driver+0x56/0xd0
[   17.324999]  [<ffffffff8103b103>] ? set_memory_nx+0x43/0x50
[   17.326918]  [<ffffffffa030d01e>] alsa_card_azx_init+0x1e/0x1000 [snd_hda_intel]
[   17.326927]  [<ffffffff81002042>] do_one_initcall+0x42/0x180
[   17.326931]  [<ffffffff8109ff2e>] sys_init_module+0xbe/0x230
[   17.326937]  [<ffffffff815f22c2>] system_call_fastpath+0x16/0x1b
[   17.326939] Code: 89 63 4c 48 c7 43 78 00 00 00 00 48 89 d8 4c 8b 65 f0 48 8b 5d e8 4c 8b 6d f8 c9 c3 0f 1f 00 55 48 89 e5 66 66 66 66 90 0f b6 d2 
[   17.326955]  39 56 78 74 12 48 89 56 78 48 8d 56 10 be 01 00 00 00 e8 bc 
[   17.326964] RIP  [<ffffffffa018544c>] snd_kctl_jack_report+0xc/0x30 [snd]
[   17.326977]  RSP <ffff8800afa8bb88>
[   17.326979] CR2: 0000000000000078
[   17.344773] init: failsafe main process (759) killed by TERM signal


--------------030403010104080501020808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030403010104080501020808--
