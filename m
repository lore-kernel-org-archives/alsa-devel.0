From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Fix oopses in snd-hda-intel from alsa
	v1.0.18rc3
Date: Fri, 12 Sep 2008 02:43:02 -0300
Message-ID: <200809120243.02486.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE43243ED
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 07:43:10 +0200 (CEST)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9C82B3EA7
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 01:43:22 -0400 (EDT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id iUhKnSHXY8As for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 01:43:21 -0400 (EDT)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id D47A43EA6
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 01:43:21 -0400 (EDT)
Received: from [172.21.225.6] (unknown [172.21.225.6])
	by fox.conectiva (Postfix) with ESMTP id E6B732F2BD
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2008 02:43:02 -0300 (BRT)
Content-Disposition: inline
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

Fixes the following oopses and other likewise possible ones:

BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<f8cc5917>] :snd_hda_intel:snd_hda_spdif_out_switch_put+0x97/0x130
*pde = 00000000
Oops: 0000 [#1] SMP
Modules linked in: snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device ipv6 snd_pcm_oss snd_mixer_oss coretemp it87 hwmon_vid binfmt_misc loop nls_utf8 ntfs dm_mirror dm_log dm_mod floppy cpufreq_ondemand cpufreq_conservative cpufreq_powersave acpi_cpufreq freq_table snd_hda_intel snd_pcm ub ppdev snd_timer evdev snd_page_alloc r8169 snd_hwdep usbhid snd mii iTCO_wdt button thermal iTCO_vendor_support i2c_i801 processor parport_pc parport serio_raw i2c_core usb_storage intel_agp sr_mod rtc_cmos ff_memless agpgart soundcore sg ata_piix ahci libata dock sd_mod scsi_mod crc_t10dif raid456 async_xor async_memcpy async_tx xor raid0 ext3 jbd uhci_hcd ohci_hcd ehci_hcd usbcore [last unloaded: scsi_wait_scan]

Pid: 3730, comm: alsactl Not tainted (2.6.27-desktop-0.rc6.2mnb #1)
EIP: 0060:[<f8cc5917>] EFLAGS: 00010246 CPU: 3
EIP is at snd_hda_spdif_out_switch_put+0x97/0x130 [snd_hda_intel]
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000003
ESI: f7b86200 EDI: 00000001 EBP: f6d8bd94 ESP: f6d8bd68
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process alsactl (pid: 3730, ti=f6d8a000 task=f731d6a0 task.ti=f6d8a000)
Stack: 0000070d 00000001 00000000 00000001 00000006 f7b86380 00065a80 00000001
       f6c35a80 f69d8c00 f8bd12d0 f6d8bda4 f8bd106a f6c35a80 f69d8c00 f6d8bdb4
       f8bd1318 f69d8c00 f711da00 f6d8bf4c f8bcfa59 f6d8bf04 bf893e30 f6cdc8c0
Call Trace:
 [<f8bd12d0>] ? slave_put+0x0/0x60 [snd]
 [<f8bd106a>] ? slave_put_val+0x2a/0xa0 [snd]
 [<f8bd1318>] ? slave_put+0x48/0x60 [snd]
 [<f8bcfa59>] ? snd_ctl_ioctl+0xc99/0xe70 [snd]
 [<c01b0317>] ? dput+0x87/0x130
 [<c0207e40>] ? ccs_capable+0x30/0x1f0
 [<f8bcedc0>] ? snd_ctl_ioctl+0x0/0xe70 [snd]
 [<c01a928e>] ? vfs_ioctl+0x5e/0xa0
 [<c01a4805>] ? putname+0x25/0x40
 [<c01a932e>] ? do_vfs_ioctl+0x5e/0x2e0
 [<c019a617>] ? do_sys_open+0xc7/0xf0
 [<c01a9613>] ? sys_ioctl+0x63/0x70
 [<c0103e1b>] ? sysenter_do_call+0x12/0x2f
 =======================
Code: b7 45 ee 0f b7 c9 0f b6 f9 89 4d e0 31 c9 89 7c 24 04 89 45 e4 89 c2 89 f0 c7 04 24 0d 07 00 00 e8 3f f7 ff ff 8b 9e 9c 01 00 00 <0f> b7 03 66 85 c0 74 23 90 0f b7 d0 31 c9 83 c3 02 89 f0 89 7c
EIP: [<f8cc5917>] snd_hda_spdif_out_switch_put+0x97/0x130 [snd_hda_intel] SS:ESP 0068:f6d8bd68
---[ end trace 1e63c3510a780bec ]---

BUG: unable to handle kernel NULL pointer dereference at 00000000
IP: [<f8cb07d5>] :snd_hda_intel:setup_dig_out_stream+0xf5/0x140
*pde = 00000000
Oops: 0000 [#1] SMP
Modules linked in: nfs lockd nfs_acl sunrpc af_packet radeon drm snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device ipv6 snd_pcm_oss snd_mixer_oss coretemp it87 hwmon_vid binfmt_misc loop nls_utf8 ntfs dm_mirror dm_log dm_mod floppy cpufreq_ondemand cpufreq_conservative cpufreq_powersave acpi_cpufreq freq_table ppdev evdev snd_hda_intel thermal snd_pcm snd_timer r8169 snd_page_alloc ub snd_hwdep intel_agp mii snd i2c_i801 button usbhid parport_pc agpgart i2c_core parport serio_raw processor soundcore iTCO_wdt rtc_cmos ff_memless iTCO_vendor_support sr_mod usb_storage sg ata_piix ahci libata dock sd_mod scsi_mod crc_t10dif raid456 async_xor async_memcpy async_tx xor raid0 ext3 jbd uhci_hcd ohci_hcd ehci_hcd usbcore [last unloaded: scsi_wait_scan]

Pid: 5139, comm: artsd Not tainted (2.6.27-desktop-0.rc6.2mnb #1)
EIP: 0060:[<f8cb07d5>] EFLAGS: 00210202 CPU: 2
EIP is at setup_dig_out_stream+0xf5/0x140 [snd_hda_intel]
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000003
ESI: f6d54600 EDI: 00000006 EBP: f5afbcd8 ESP: f5afbcc0
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process artsd (pid: 5139, ti=f5afa000 task=f6b50000 task.ti=f5afa000)
Stack: 0000070d 00000000 00000005 00000031 f7022050 f6d54600 f5afbd04 f8cb0a8d
       00000031 0000e008 00000005 f6d54780 f8ceb39c 00000002 00000031 f6d55500
       f5afbd60 f5afbd18 f8cba051 00000031 f7066d00 f7066d00 f5afbd70 f8cae925
Call Trace:
 [<f8cb0a8d>] ? snd_hda_multi_out_analog_prepare+0x1fd/0x240 [snd_hda_intel]
 [<f8cba051>] ? alc880_playback_pcm_prepare+0x21/0x30 [snd_hda_intel]
 [<f8cae925>] ? azx_pcm_prepare+0x345/0x3c0 [snd_hda_intel]
 [<f8c17d5c>] ? snd_pcm_do_prepare+0xc/0x20 [snd_pcm]
 [<f8c178ab>] ? snd_pcm_action_single+0x2b/0x60 [snd_pcm]
 [<f8c18a8b>] ? snd_pcm_action_nonatomic+0x6b/0x70 [snd_pcm]
 [<f8c1b437>] ? snd_pcm_common_ioctl1+0x607/0x1720 [snd_pcm]
 [<c0182f6f>] ? handle_mm_fault+0x11f/0x7e0
 [<c012a0c0>] ? default_wake_function+0x0/0x10
 [<c03820f8>] ? unlock_kernel+0x28/0x2f
 [<f8bc8688>] ? snd_open+0xd8/0x150 [snd]
 [<c011cef0>] ? do_page_fault+0x330/0x870
 [<c017d7a2>] ? vma_prio_tree_insert+0x22/0xc0
 [<c0185f89>] ? vma_link+0xa9/0xf0
 [<f8c1c988>] ? snd_pcm_playback_ioctl1+0x38/0x3e0 [snd_pcm]
 [<c018699e>] ? mmap_region+0x2be/0x4b0
 [<c0207e40>] ? ccs_capable+0x30/0x1f0
 [<f8c1cd76>] ? snd_pcm_playback_ioctl+0x46/0x50 [snd_pcm]
 [<f8c1cd30>] ? snd_pcm_playback_ioctl+0x0/0x50 [snd_pcm]
 [<c01a928e>] ? vfs_ioctl+0x5e/0xa0
 [<c01a932e>] ? do_vfs_ioctl+0x5e/0x2e0
 [<c01a9613>] ? sys_ioctl+0x63/0x70
 [<c0103e1b>] ? sysenter_do_call+0x12/0x2f
 [<c0380000>] ? schedule+0x760/0x940
 =======================
Code: b4 26 00 00 00 00 81 e2 fe 00 00 00 0f b7 f8 89 54 24 04 31 c9 89 fa 89 f0 c7 04 24 0d 07 00 00 e8 91 eb ff ff 8b 9e 9c 01 00 00 <0f> b7 03 66 85 c0 0f 84 2e ff ff ff 8d b4 26 00 00 00 00 0f b7
EIP: [<f8cb07d5>] setup_dig_out_stream+0xf5/0x140 [snd_hda_intel] SS:ESP 0068:f5afbcc0
---[ end trace d44a3a67f9b19615 ]---

---

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 696d77e..531364d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1462,14 +1462,15 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 					  AC_VERB_SET_DIGI_CONVERT_2,
 					  val >> 8);
 
-		for (d = codec->slave_dig_outs; *d; d++) {
-			snd_hda_codec_write_cache(codec, *d, 0,
+		if (codec->slave_dig_outs)
+			for (d = codec->slave_dig_outs; *d; d++) {
+				snd_hda_codec_write_cache(codec, *d, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
-			snd_hda_codec_write_cache(codec, *d, 0,
+				snd_hda_codec_write_cache(codec, *d, 0,
 					  AC_VERB_SET_DIGI_CONVERT_2,
 					  val >> 8);
-		}
+			}
 	}
 
 	mutex_unlock(&codec->spdif_mutex);
@@ -1507,8 +1508,9 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
 
-		for (d = codec->slave_dig_outs; *d; d++)
-			snd_hda_codec_write_cache(codec, *d, 0,
+		if (codec->slave_dig_outs)
+			for (d = codec->slave_dig_outs; *d; d++)
+				snd_hda_codec_write_cache(codec, *d, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
 		/* unmute amp switch (if any) */
@@ -1664,8 +1666,9 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1, val);
 
-		for (d = codec->slave_dig_outs; *d; d++)
-			snd_hda_codec_write_cache(codec, *d, 0,
+		if (codec->slave_dig_outs)
+			for (d = codec->slave_dig_outs; *d; d++)
+				snd_hda_codec_write_cache(codec, *d, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1, val);
 	}
 	mutex_unlock(&codec->spdif_mutex);
@@ -2617,9 +2620,10 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
 			    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
 
-		for (d = codec->slave_dig_outs; *d; d++)
-			snd_hda_codec_write(codec, *d, 0,
-					AC_VERB_SET_DIGI_CONVERT_1,
+		if (codec->slave_dig_outs)
+			for (d = codec->slave_dig_outs; *d; d++)
+				snd_hda_codec_write(codec, *d, 0,
+				    AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
 	}
 	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
@@ -2628,9 +2632,10 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & 0xff);
 
-		for (d = codec->slave_dig_outs; *d; d++)
-			snd_hda_codec_write(codec, *d, 0,
-					AC_VERB_SET_DIGI_CONVERT_1,
+		if (codec->slave_dig_outs)
+			for (d = codec->slave_dig_outs; *d; d++)
+				snd_hda_codec_write(codec, *d, 0,
+				    AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & 0xff);
 	}
 


-- 
[]'s
Herton
