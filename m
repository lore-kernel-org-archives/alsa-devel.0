From: albox@free.fr
Subject: support for Medion laptops
Date: Fri, 04 May 2007 02:46:25 +0200
Message-ID: <1178239585.463a8261456fc@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa0.perex.cz (Postfix) with ESMTP id DF11E243D6
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 02:46:25 +0200 (CEST)
Received: from imp3-g19.free.fr (imp3-g19.free.fr [212.27.42.3])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 757FC42EBC
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 02:46:25 +0200 (CEST)
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
I installed Ubuntu Feisty a few days ago and my sound card driver doesn't work
anymore. It was working perfectly before updating to Feisty but I'm not sure the
problem comes from the update since I was not using the last ALSA version but an
older one patched with a patch released by Tobin Davis a few months ago
(something else could have been changed in the ALSA source code since then) :

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig    2006-10-08
10:58:28.000000000
 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c    2006-10-09
10:50:03.000000000 -0700
@@ -112,6 +112,7 @@
     ALC883_6ST_DIG,
     ALC888_DEMO_BOARD,
     ALC883_ACER,
+    ALC883_MEDION,
     ALC883_AUTO,

     ALC883_MODEL_LAST,
 };
@@ -5080,6 +5081,8 @@
       .config = ALC883_ACER },
     { .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
       .config = ALC883_ACER },
+    { .pci_subvendor = 0x161f, .pci_subdevice = 0xd82b,

+      .modelname = "medion", .config = ALC883_MEDION }
     { .modelname = "auto", .config = ALC883_AUTO },
     {}
 };
@@ -5167,6 +5170,20 @@
         .channel_mode = alc883_3ST_2ch_modes,
         .input_mux = &alc883_capture_source,

     },
+    [ALC883_MEDION] = {
+        .mixers = { alc883_base_mixer,
+                alc883_chmode_mixer },
+        .init_verbs = { alc883_init_verbs,
+                alc882_eapd_verbs },
+        .num_dacs = ARRAY_SIZE(alc883_dac_nids),

+        .dac_nids = alc883_dac_nids,
+        .num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+        .adc_nids = alc883_adc_nids,
+        .num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+        .channel_mode = alc883_sixstack_modes,

+        .input_mux = &alc883_capture_source,
+    }
+
 };

You can find some parts of the emails about this subject on this web page :
http://www.spinics.net/lists/alsa-devel/msg04396.html

The driver (Developement release 1.0.14rc3) can detect my sound card but I can't
figure out what's wrong. Can anybody help me ?

$ dmesg | grep alsa
[   20.468000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x3
[   20.648000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:1768:
hda_codec: model 'medion' is selected for config 161f:2054 (Medion laptop)
[   21.376000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245:
si3054: cannot initialize. EXT MID = 0000
[   21.384000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257:
Link Frame Detect(FDT) is not ready (line status: 0000)
[   76.256000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[   76.256000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[   76.264000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[   76.272000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
[   76.280000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[   76.292000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[   76.300000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[   76.308000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
[   76.320000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
[   76.332000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[   76.332000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[   76.344000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[   76.356000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
[   76.364000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[   76.376000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[   76.384000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[   76.392000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
[   76.408000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
[   76.592000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[   76.592000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[   76.600000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[   76.608000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
[   76.616000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[  153.564000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[  153.572000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[  153.580000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
[  153.588000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
[  216.896000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[  216.896000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[  216.904000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[  216.912000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
[  216.920000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[  216.932000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[  216.940000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[  216.948000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
[  216.956000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
[  216.972000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[  216.972000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[  216.980000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[  216.988000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
[  216.996000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[  218.824000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[  218.832000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[  218.840000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
[  218.848000] ALSA
/home/alboot/Sources/alsa/alsa-driver-1.0.14rc3/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0


Thanks
