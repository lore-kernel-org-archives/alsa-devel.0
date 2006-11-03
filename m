From: "Andrew L. Neporada" <nepal@asplinux.ru>
Subject: [PATCH] Clevo M540JE,
	M550JE laptops (Nvidia MCP51 chipset, ALC883	codec)
Date: Fri, 03 Nov 2006 16:47:56 +0300
Message-ID: <1162561676.22293.16.camel@leeloo.asplinux.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ISK/aHgCbEcrSKAnGbRR"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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


--=-ISK/aHgCbEcrSKAnGbRR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

We need to enable External Amplifier on this laptops. This patch basicly
adds laptop-eapd model to ALC883 codec.



--=-ISK/aHgCbEcrSKAnGbRR
Content-Disposition: attachment; filename=clevo.patch
Content-Type: text/x-patch; name=clevo.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-1.0.13/alsa-kernel/Documentation/ALSA-Configuration.txt.orig	2006-09-29 15:40:32.000000000 +0400
+++ alsa-driver-1.0.13/alsa-kernel/Documentation/ALSA-Configuration.txt	2006-11-03 15:43:44.000000000 +0300
@@ -822,6 +822,7 @@ Prior to version 0.9.0rc4 options had a 
 	  3stack-6ch-dig 3-jack 6-channel with SPDIF I/O
 	  6stack-dig-demo  6-jack digital for Intel demo board
 	  acer		Acer laptops (Travelmate 3012WTMi, Aspire 5600, etc)
+	  laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE, M550JE)
 	  auto		auto-config reading BIOS (default)
 
 	ALC861/660
--- alsa-driver-1.0.13/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-09-29 15:40:36.000000000 +0400
+++ alsa-driver-1.0.13/alsa-kernel/pci/hda/patch_realtek.c	2006-11-03 15:32:17.000000000 +0300
@@ -112,6 +112,7 @@ enum {
 	ALC883_6ST_DIG,
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
+	ALC883_LAPTOP_EAPD,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -5080,6 +5081,9 @@ static struct hda_board_config alc883_cf
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
 	  .config = ALC883_ACER },
+	{ .modelname = "laptop-eapd", .config = ALC883_LAPTOP_EAPD },
+	{ .pci_subvendor = 0x1558, .pci_subdevice = 0,
+	  .config = ALC883_LAPTOP_EAPD }, /* Clevo */
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5167,6 +5171,18 @@ static struct alc_config_preset alc883_p
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_LAPTOP_EAPD] = {
+		.mixers = { alc883_base_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs, alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+	},
 };
 
 

--=-ISK/aHgCbEcrSKAnGbRR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-ISK/aHgCbEcrSKAnGbRR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-ISK/aHgCbEcrSKAnGbRR--
