From: Li Bo <liboat@gmail.com>
Subject: [PATCH 29/31] HDA patch_via.c: Change PW4 connect
	select default to to MW0.
Date: Mon, 5 Oct 2009 22:28:38 +0800
Message-ID: <16685ee0910050728j7e948ffelddd60650944d93e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D5551039A8
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:28:39 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2792157fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:28:39 -0700 (PDT)
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

[ALSA] HDA VIA: Change PW4 connect select default to to MW0.

According to customer request, hp should be default to redirected mode,
i.e. PW4 connect select default to to MW0.

, i.e. PW4 should be default to MW0.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:14:10.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:14:16.000000000 +0800
@@ -1505,8 +1505,8 @@
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	
-	/* Setup default input to PW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Setup default input MW0 to PW4 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* power down jack detect function */
@@ -2641,8 +2641,8 @@
 	{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},

-	/* Set input of PW4 as AOW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Set input of PW4 as MW0 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
@@ -3196,7 +3196,7 @@
 	{0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},

 	/* Setup default input to PW4 */
-	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x1d, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* PW10 Input enable */
