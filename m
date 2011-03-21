From: Jan Losinski <losinski@wh2.tu-dresden.de>
Subject: Problem and dirty Fix for hda-intel on ALC892
Date: Mon, 21 Mar 2011 12:37:02 +0100
Message-ID: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5459454145981827804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atlantis.wh2.tu-dresden.de (atlantis.wh2.tu-dresden.de
	[141.30.228.39]) by alsa0.perex.cz (Postfix) with ESMTP id E422B24133
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:37:01 +0100 (CET)
Received: from localhost (x41a105b.wh16.tu-dresden.de [141.30.216.67])
	by atlantis.wh2.tu-dresden.de (Postfix) with ESMTPSA id AC3DF83D0B8
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:37:00 +0100 (CET)
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


--===============5459454145981827804==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Since last week I compiled 2.6.38 on my Desktop. After booting I noticed
a regression at the sound stuff. The surround speaker where no longer
controlled by the master volume control. I can control it separately,
but not with the master control that controls the front, center and
LFE volume.

After some debugging I found some differencies at module-loading output
in the kernel log and in the output from alsactl store command. The
dmesg and the diff of the alsactl output can be found at the end of this
message.

After that I tried to understand the hda-codec code and debugged there
with a lot of printks and reboots. It takes another couple of hours to
find out that the index of the surround volume and switch was 0 at pre
2.6.38 and is now 1. So I wrote a dirty hack to fix this (please ignore
the debugging printks):

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index ae5c5d5..d3fd6d2 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -3819,7 +3819,16 @@ int snd_hda_add_new_ctls(struct hda_codec *codec, struct snd_kcontrol_new *knew)
                                kctl->id.device = addr;
                        if (idx > 0)
                                kctl->id.index = idx;
+
+                       snd_printk(KERN_INFO "PRE snd_hda_ctl_add - addr = %d, idx = %d, kctl->id.name = %s, kctl->id.index = %d, kctl->id.device = %d, kctl->count = %d",
+                                       addr, idx, kctl->id.name, kctl->id.index, kctl->id.device, kctl->count);
                        err = snd_hda_ctl_add(codec, 0, kctl);
+                       snd_printk(KERN_INFO "PASSED snd_hda_ctl_add - err = %d, addr = %d, idx = %d, kctl->id.name = %s, kctl->id.index = %d, kctl->id.device = %d, kctl->count = %d",
+                                       err, addr, idx, kctl->id.name, kctl->id.index, kctl->id.device, kctl->count);
+                       if (strncmp("Surround Playback Switch", kctl->id.name, strlen("Surround Playback Switch")))
+                               kctl->id.index = 0;
+                       if (strncmp("Surround Playback Volume", kctl->id.name, strlen("Surround Playback Volume")))
+                               kctl->id.index = 0;
                        if (!err)
                                break;
                        /* try first with another device index corresponding to

At all I dont understand what I've exactly done. I also know that this
is not a real solution, because it will break the code for many other
plattforms. So I hope someone can convert this to a real fix cor can
guide me to make such one.

The platform is a ASUS M4A89GTD-PRO/USB3 Board. If any further
information needed, please tell me.

Thanks,
Jan Losinski


dmesg of 2.6.37
 HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 hda_intel: position_fix set to 1 for device 1043:8410
 ALSA sound/pci/hda/hda_intel.c:2532: chipset global capabilities = 0x4401
 ALSA sound/pci/hda/hda_intel.c:913: codec_mask = 0x1
 ALSA sound/pci/hda/hda_intel.c:1351: codec #0 probed OK
 ALSA sound/pci/hda/patch_realtek.c:1524: SKU: Nid=0x1d sku_cfg=0x4005e601
 ALSA sound/pci/hda/patch_realtek.c:1526: SKU: port_connectivity=0x1
 ALSA sound/pci/hda/patch_realtek.c:1527: SKU: enable_pcbeep=0x0
 ALSA sound/pci/hda/patch_realtek.c:1528: SKU: check_sum=0x00000005
 ALSA sound/pci/hda/patch_realtek.c:1529: SKU: customization=0x000000e6
 ALSA sound/pci/hda/patch_realtek.c:1530: SKU: external_amp=0x0
 ALSA sound/pci/hda/patch_realtek.c:1531: SKU: platform_type=0x0
 ALSA sound/pci/hda/patch_realtek.c:1532: SKU: swap=0x0
 ALSA sound/pci/hda/patch_realtek.c:1533: SKU: override=0x1
 hda_codec: ALC892: BIOS auto-probing.
 ALSA sound/pci/hda/hda_codec.c:4633: autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
 ALSA sound/pci/hda/hda_codec.c:4637:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
 ALSA sound/pci/hda/hda_codec.c:4641:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
 ALSA sound/pci/hda/hda_codec.c:4642:    mono: mono_out=0x0
 ALSA sound/pci/hda/hda_codec.c:4645:    dig-out=0x11/0x1e
 ALSA sound/pci/hda/hda_codec.c:4646:    inputs:
 ALSA sound/pci/hda/hda_codec.c:4650:  Rear Mic=0x18
 ALSA sound/pci/hda/hda_codec.c:4650:  Front Mic=0x19
 ALSA sound/pci/hda/hda_codec.c:4650:  Line=0x1a
 ALSA sound/pci/hda/hda_codec.c:4652:
 ALSA sound/pci/hda/patch_realtek.c:1581: realtek: No valid SSID, checking pincfg 0x4005e601 for NID 0x1d
 ALSA sound/pci/hda/patch_realtek.c:1597: realtek: Enabling init ASM_ID=0xe601 CODEC_ID=10ec0892
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Side Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Speaker Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mono Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Line-Out Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Side Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Speaker Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mono Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Line-Out Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM Playback Switch, skipped


dmesg of 2.6.38
 HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
 hda_intel: position_fix set to 1 for device 1043:8410
 ALSA sound/pci/hda/hda_intel.c:2535: chipset global capabilities = 0x4401
 ALSA sound/pci/hda/hda_intel.c:913: codec_mask = 0x1
 ALSA sound/pci/hda/hda_intel.c:1353: codec #0 probed OK
 ALSA sound/pci/hda/patch_realtek.c:1527: SKU: Nid=0x1d sku_cfg=0x4005e601
 ALSA sound/pci/hda/patch_realtek.c:1529: SKU: port_connectivity=0x1
 ALSA sound/pci/hda/patch_realtek.c:1530: SKU: enable_pcbeep=0x0
 ALSA sound/pci/hda/patch_realtek.c:1531: SKU: check_sum=0x00000005
 ALSA sound/pci/hda/patch_realtek.c:1532: SKU: customization=0x000000e6
 ALSA sound/pci/hda/patch_realtek.c:1533: SKU: external_amp=0x0
 ALSA sound/pci/hda/patch_realtek.c:1534: SKU: platform_type=0x0
 ALSA sound/pci/hda/patch_realtek.c:1535: SKU: swap=0x0
 ALSA sound/pci/hda/patch_realtek.c:1536: SKU: override=0x1
 hda_codec: ALC892: BIOS auto-probing.
 ALSA sound/pci/hda/hda_codec.c:4633: autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
 ALSA sound/pci/hda/hda_codec.c:4637:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
 ALSA sound/pci/hda/hda_codec.c:4641:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
 ALSA sound/pci/hda/hda_codec.c:4642:    mono: mono_out=0x0
 ALSA sound/pci/hda/hda_codec.c:4645:    dig-out=0x11/0x1e
 ALSA sound/pci/hda/hda_codec.c:4646:    inputs:
 ALSA sound/pci/hda/hda_codec.c:4650:  Rear Mic=0x18
 ALSA sound/pci/hda/hda_codec.c:4650:  Front Mic=0x19
 ALSA sound/pci/hda/hda_codec.c:4650:  Line=0x1a
 ALSA sound/pci/hda/hda_codec.c:4652:
 ALSA sound/pci/hda/patch_realtek.c:1584: realtek: No valid SSID, checking pincfg 0x4005e601 for NID 0x1d
 ALSA sound/pci/hda/patch_realtek.c:1600: realtek: Enabling init ASM_ID=0xe601 CODEC_ID=10ec0892
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Surround Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Side Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Speaker Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mono Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Line-Out Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM Playback Volume, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Surround Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Side Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Speaker Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Mono Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave Line-Out Playback Switch, skipped
 ALSA sound/pci/hda/hda_codec.c:2164: Cannot find slave PCM Playback Switch, skipped



Diff of alsactl store output:
--- store.27	2011-03-17 15:17:19.850768983 +0100
+++ store.28	2011-03-17 15:19:46.996710838 +0100
@@ -29,8 +29,9 @@
 		comment.dbmax 0
 		iface MIXER
 		name 'Surround Playback Volume'
-		value.0 64
-		value.1 64
+		index 1
+		value.0 38
+		value.1 38
 	}
 	control.4 {
 		comment.access 'read write'
@@ -38,6 +39,7 @@
 		comment.count 2
 		iface MIXER
 		name 'Surround Playback Switch'
+		index 1
 		value.0 true
 		value.1 true
 	}
@@ -130,7 +132,6 @@
 		comment.dbmax 1200
 		iface MIXER
 		name 'Front Mic Playback Volume'
-		index 1
 		value.0 0
 		value.1 0
 	}
@@ -140,7 +141,6 @@
 		comment.count 2
 		iface MIXER
 		name 'Front Mic Playback Switch'
-		index 1
 		value.0 false
 		value.1 false
 	}
@@ -173,7 +173,7 @@
 		comment.dbmin 0
 		comment.dbmax 3000
 		iface MIXER
-		name 'Rear Mic Boost'
+		name 'Rear Mic Boost Volume'
 		value.0 0
 		value.1 0
 	}
@@ -185,8 +185,7 @@
 		comment.dbmin 0
 		comment.dbmax 3000
 		iface MIXER
-		name 'Front Mic Boost'
-		index 1
+		name 'Front Mic Boost Volume'
 		value.0 0
 		value.1 0
 	}
@@ -314,7 +313,7 @@
 		comment.count 1
 		iface MIXER
 		name 'Master Playback Switch'
-		value true
+		value false
 	}
 	control.32 {
 		comment.access 'read write user'


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2HOF4ACgkQ1Hv7AMjH+2HEcwCg1vahEmDC8byVRGctc4DogjMr
tcMAn3Ru84la2H2tVPB903/tV6Q/4l2n
=Y33F
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--===============5459454145981827804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5459454145981827804==--
