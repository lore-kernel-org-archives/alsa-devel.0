From: Li Bo <liboat@gmail.com>
Subject: [PATCH 22/31] HDA patch_via.c: Move backdoor verbs to
	vt17xx_volume_init_verb
Date: Mon, 5 Oct 2009 22:27:59 +0800
Message-ID: <16685ee0910050727m4d9010cfs9bba66188b0f49eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E1231038AF
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:28:00 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10052327bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:28:00 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Move backdoor verbs to vt17xx_volume_init_verb

As init verbs, vt17xx_volume_init_verb is a better place to hold them.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:11:17.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:11:22.000000000 +0800
@@ -3042,6 +3042,8 @@
 	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* Enable Mic Boost Volume backdoor */
 	{0x1, 0xf98, 0x1},
+	/* don't bybass mixer */
+	{0x1, 0xf88, 0xc0},
 	{ }
 };

@@ -3502,6 +3504,10 @@
 	/* PW6 PW7 Output enable */
 	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{0x1C, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	/* mixer enable */
+	{0x1, 0xF88, 0x3},
+	/* GPIO 0~2 */
+	{0x1, 0xF82, 0x3F},
 	{ }
 };

@@ -3746,8 +3752,6 @@
 {
 	struct via_spec *spec;
 	int err;
-	unsigned int response;
-	unsigned char control;

 	/* create a codec specific record */
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -3792,18 +3796,6 @@
 	spec->loopback.amplist = vt1702_loopbacks;
 #endif

-	/* Open backdoor */
-	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF8C, 0);
-	control = (unsigned char)(response & 0xff);
-	control |= 0x3;
-	snd_hda_codec_write(codec,  codec->afg, 0, 0xF88, control);
-
-	/* Enable GPIO 0&1 for volume&mute control */
-	/* Enable GPIO 2 for DMIC-DATA */
-	response = snd_hda_codec_read(codec, codec->afg, 0, 0xF84, 0);
-	control = (unsigned char)((response >> 16) & 0x3f);
-	snd_hda_codec_write(codec,  codec->afg, 0, 0xF82, control);
-
 	return 0;
 }
