From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Problem with the new BEEP framework and HP dv6
Date: Mon, 21 Dec 2009 18:47:30 +0200
Message-ID: <4B2FA6A2.706@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 425C124394
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 17:47:32 +0100 (CET)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by lider.pardus.org.tr (Postfix) with ESMTPSA id D261AA7AC09
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 18:41:29 +0200 (EET)
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

Hi,

Before the new CONFIG_SND_HDA_INPUT_BEEP_MODE is introduced, I was patching the alsa-driver package
with a very trivial patch which was setting the default of enable_beep to 0.

I created another patch to completely disable beep stuff for the new BEEP_MODE stuff. It seemed to work
fine on my computer but triggered NULL pointer dereference on an HP dv6:

Index: alsa-driver/configure
===================================================================
--- alsa-driver.orig/configure
+++ alsa-driver/configure
@@ -15945,7 +15945,7 @@ alsa_check_kconfig_option () {
     if ( test "$CONFIG_SND_PCI" = "y" -o "$CONFIG_SND_PCI" = "m" ) &&
       ( test "$CONFIG_SND_HDA_INTEL" = "y" -o "$CONFIG_SND_HDA_INTEL" = "m" ) &&
       ( test "$CONFIG_SND_HDA_INPUT_BEEP" = "y" -o "$CONFIG_SND_HDA_INPUT_BEEP" = "m" ); then
-      CONFIG_SND_HDA_INPUT_BEEP_MODE="1"
+      CONFIG_SND_HDA_INPUT_BEEP_MODE="0"
     fi
   if alsa_check_kconfig_option "hda-input-jack"; then
     if ( test "$CONFIG_SND_PCI" = "y" -o "$CONFIG_SND_PCI" = "m" ) &&
@@ -18366,7 +18366,7 @@ _ACEOF
 fi
 if test -n "$CONFIG_SND_HDA_INPUT_BEEP_MODE"; then
   cat >>confdefs.h <<_ACEOF
-#define CONFIG_SND_HDA_INPUT_BEEP_MODE 1
+#define CONFIG_SND_HDA_INPUT_BEEP_MODE 0
 _ACEOF
 
 fi
Index: alsa-driver/sound/pci/hda/Kconfig
===================================================================
--- alsa-driver.orig/sound/pci/hda/Kconfig
+++ alsa-driver/sound/pci/hda/Kconfig
@@ -41,7 +41,7 @@ config SND_HDA_INPUT_BEEP
 config SND_HDA_INPUT_BEEP_MODE
 	int "Digital beep registration mode (0=off, 1=on, 2=mute sw on/off)"
 	depends on SND_HDA_INPUT_BEEP=y
-	default "1"
+	default "0"
 	range 0 2
 	help
 	  Set 0 to disable the digital beep interface for HD-audio by default.
Index: alsa-driver/sound/pci/hda/hda_intel.c
===================================================================
--- alsa-driver.orig/sound/pci/hda/hda_intel.c
+++ alsa-driver/sound/pci/hda/hda_intel.c
@@ -98,7 +98,7 @@ MODULE_PARM_DESC(patch, "Patch file for 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 module_param_array(beep_mode, int, NULL, 0444);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
-			    "(0=off, 1=on, 2=mute switch on/off) (default=1).");
+			    "(0=off, 1=on, 2=mute switch on/off) (default=0).");
 #endif
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE



I really don't know if I mistakenly modified the code path with those modified #defines, but I'm sure that
the patch correctly disables beep device on my Realtek ALC883 codec.

Here's the stack trace of the patched alsa-driver:

[   14.516122] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   14.516178] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   14.569087] BUG: unable to handle kernel NULL pointer dereference at 00000032
[   14.569527] IP: [<f8f35b2b>] stac92xx_parse_auto_config+0x616/0xd5f [snd_hda_codec_idt]
[   14.570007] *pde = 00000000 
[   14.570014] Oops: 0002 [#1] SMP 
[   14.570014] last sysfs file: /sys/module/snd_hda_codec/initstate
[   14.570014] Modules linked in: snd_hda_codec_idt snd_hda_intel(+) snd_hda_codec snd_seq_dummy snd_hwdep snd_seq_oss arc4 snd_seq_midi_event ecb snd_seq snd_seq_device iwlagn iwlcore snd_pcm_oss snd_mixer_oss snd_pcm intel_agp rfkill agpgart btusb uvcvideo snd_timer mac80211 snd jmb38x_ms r8169 video iTCO_wdt videodev memstick v4l1_compat iTCO_vendor_support soundcore mii output pcspkr joydev snd_page_alloc wmi cfg80211 hp_accel bluetooth lis3lv02d brd usb_storage firewire_ohci firewire_core sdhci_pci sdhci mmc_core led_class ohci1394 ieee1394 ahci libata
[   14.570014] 
[   14.570014] Pid: 175, comm: modprobe Not tainted (2.6.30.9-128 #1) HP Pavilion dv6 Notebook PC
[   14.570014] EIP: 0060:[<f8f35b2b>] EFLAGS: 00010246 CPU: 0
[   14.570014] EIP is at stac92xx_parse_auto_config+0x616/0xd5f [snd_hda_codec_idt]
[   14.570014] EAX: 00000000 EBX: 00000026 ECX: 00000001 EDX: 00000026
[   14.570014] ESI: f6a20000 EDI: f6a23800 EBP: f6ae9de8 ESP: f6ae9d7c
[   14.570014]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   14.570014] Process modprobe (pid: 175, ti=f6ae8000 task=f694be30 task.ti=f6ae8000)
[   14.570014] Stack:
[   14.570014]  00000400 f6ac11a4 00210000 f6ac1000 f6a23a74 f6a23800 00000000 f6a23800
[   14.570014]  f6a23800 00000007 0007070d 0000000d f6ae9dcc f8ecb558 00000000 00000000
[   14.570014]  2063694d 6b63614a 646f4d20 00000065 f6ae9de0 f8ecc3ff f6a23800 00000009
[   14.570014] Call Trace:
[   14.578754]  [<f8ecb558>] ? get_alloc_hash+0x41/0x7c [snd_hda_codec]
[   14.578754]  [<f8ecc3ff>] ? snd_hda_codec_write_cache+0x5c/0x66 [snd_hda_codec]
[   14.578754]  [<f8f37b14>] ? patch_stac92hd71bxx+0x5ce/0x624 [snd_hda_codec_idt]
[   14.578754]  [<f8ece8b6>] ? snd_hda_codec_configure+0x253/0x2fe [snd_hda_codec]
[   14.578754]  [<f8f0530f>] ? azx_probe+0x802/0x8ca [snd_hda_intel]
[   14.578754]  [<f8f0496c>] ? azx_send_cmd+0x0/0x136 [snd_hda_intel]
[   14.578754]  [<f8f047a9>] ? azx_get_response+0x0/0x1c3 [snd_hda_intel]
[   14.578754]  [<f8f03fe6>] ? azx_attach_pcm_stream+0x0/0x148 [snd_hda_intel]
[   14.578754]  [<f8f03c99>] ? azx_bus_reset+0x0/0x56 [snd_hda_intel]
[   14.578754]  [<f8f03b50>] ? azx_power_notify+0x0/0x57 [snd_hda_intel]
[   14.578754]  [<c029ae28>] ? local_pci_probe+0xe/0x10
[   14.578754]  [<c029b842>] ? pci_device_probe+0x43/0x66
[   14.578754]  [<c030e0fb>] ? really_probe+0x6a/0xf5
[   14.578754]  [<c030e1a2>] ? driver_probe_device+0x1c/0x1f
[   14.578754]  [<c030e1e8>] ? __driver_attach+0x43/0x5f
[   14.578754]  [<c030db8a>] ? bus_for_each_dev+0x3d/0x67
[   14.578754]  [<c030dfe3>] ? driver_attach+0x14/0x16
[   14.578754]  [<c030e1a5>] ? __driver_attach+0x0/0x5f
[   14.578754]  [<c030d61a>] ? bus_add_driver+0xa2/0x1c9
[   14.578754]  [<c030e42b>] ? driver_register+0x8b/0xeb
[   14.578754]  [<c029bb6d>] ? __pci_register_driver+0x38/0x93
[   14.578754]  [<c01453d1>] ? __blocking_notifier_call_chain+0x40/0x4c
[   14.578754]  [<f8f0b000>] ? alsa_card_azx_init+0x0/0x19 [snd_hda_intel]
[   14.578754]  [<f8f0b017>] ? alsa_card_azx_init+0x17/0x19 [snd_hda_intel]
[   14.578754]  [<c0101139>] ? do_one_initcall+0x4c/0x13a
[   14.578754]  [<c01531f9>] ? sys_init_module+0x87/0x18b
[   14.578754]  [<c01031d4>] ? sysenter_do_call+0x12/0x28
[   14.578754] Code: 06 f5 ff ff 85 c0 0f 88 b6 06 00 00 8b 45 a0 89 da e8 c2 c9 f9 ff 85 c0 0f 88 a4 06 00 00 8b 4d a0 89 da 8b 41 68 b9 01 00 00 00 <80> 48 32 04 8b 45 a0 e8 fc 79 f9 ff 8b 5d a0 83 7b 68 00 74 2f 
[   14.578754] EIP: [<f8f35b2b>] stac92xx_parse_auto_config+0x616/0xd5f [snd_hda_codec_idt] SS:ESP 0068:f6ae9d7c
[   14.578754] CR2: 0000000000000032
[   14.810381] ---[ end trace af42daf6416d16f0 ]---

---

Note that I just tried 1.0.22 without this patch on that dv6 and I wasn't able to get any sound even the modules were correctly loaded. I checked the mixer levels they were OK. I'll try to dig into this with alsa-info but the main question now is how should I cleanly disable BEEP device?

Thanks,
Ozan
