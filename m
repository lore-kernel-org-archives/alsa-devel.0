From: zhejiang <zhe.jiang@intel.com>
Subject: [patch] ALC262 Input source bug on HP_BPC and
	HP_BPC_D7000
Date: Thu, 30 Aug 2007 14:16:06 +0800
Message-ID: <1188454566.26648.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 570C710396C
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 08:18:01 +0200 (CEST)
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

I have a HP BPC D7000 machine and run fedora6 + alsa-1.0.14 on it.
I found that when I used the front mic,I needed to choose the "Input
source " as "Line" to record.
Then I read the source code of alsa-1.0.14 and alsa-hg-20080828.
I found that the capture_source items is wrong.
I tried to fix and test them. It works well on my machine.

When i read the source code, I found that the capture_source items of
alc262_HP_capture_source[] are not suitable.In this patch,I fixed them,
but i don't have the machine to test them.

--- a/alsa-driver-hg20070828/alsa-kernel/pci/hda/patch_realtek.c
2007-08-24 08:00:06.000000000 +0800
+++ b/alsa-driver-hg20070828/alsa-kernel/pci/hda/patch_realtek.c
2007-08-29 12:47:30.000000000 +0800
@@ -7706,13 +7706,23 @@
 	.num_items = 5,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "Front Mic", 0x3 },
+		{ "Front Mic", 0x1 },
 		{ "Line", 0x2 },
 		{ "CD", 0x4 },
 		{ "AUX IN", 0x6 },
 	},
 };
 
+static struct hda_input_mux alc262_HP_D7000_capture_source = {
+	.num_items = 4,
+	.items = {
+		{ "Mic", 0x0 },
+		{ "Front Mic", 0x2 },
+		{ "Line", 0x1 },
+		{ "CD", 0x4 },
+	},
+};
+
 /* mute/unmute internal speaker according to the hp jack and mute state
*/
 static void alc262_fujitsu_automute(struct hda_codec *codec, int force)
 {
@@ -8313,7 +8323,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
-		.input_mux = &alc262_HP_capture_source,
+		.input_mux = &alc262_HP_D7000_capture_source,
 	},
 	[ALC262_HP_BPC_D7000_WL] = {
 		.mixers = { alc262_HP_BPC_WildWest_mixer,
@@ -8324,7 +8334,7 @@
 		.hp_nid = 0x03,
 		.num_channel_mode = ARRAY_SIZE(alc262_modes),
 		.channel_mode = alc262_modes,
-		.input_mux = &alc262_HP_capture_source,
+		.input_mux = &alc262_HP_D7000_capture_source,
 	},
 	[ALC262_BENQ_ED8] = {
 		.mixers = { alc262_base_mixer },
