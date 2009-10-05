From: Li Bo <liboat@gmail.com>
Subject: [PATCH 12/31] HDA patch_via.c: Add VIA_JACK_EVENT
	process in via_unsol_event.
Date: Mon, 5 Oct 2009 22:26:22 +0800
Message-ID: <16685ee0910050726t5808289eve198bd4ef7c96d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id D3566103803
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:26:22 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so1164080fge.2
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:26:22 -0700 (PDT)
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

[ALSA] HDA VIA: Add VIA_JACK_EVENT process in via_unsol_event.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:10:05.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:10:13.000000000 +0800
@@ -124,6 +124,7 @@

 #define VIA_HP_EVENT		0x01
 #define VIA_GPIO_EVENT		0x02
+#define VIA_JACK_EVENT		0x04

 enum {
 	VIA_CTL_WIDGET_VOL,
@@ -1408,10 +1409,12 @@
 				  unsigned int res)
 {
 	res >>= 26;
-	if (res == VIA_HP_EVENT)
+	if (res & VIA_HP_EVENT)
 		via_hp_automute(codec);
-	else if (res == VIA_GPIO_EVENT)
+	if (res & VIA_GPIO_EVENT)
 		via_gpio_control(codec);
+	if (res & VIA_JACK_EVENT)
+		set_jack_power_state(codec);
 }

 static int via_init(struct hda_codec *codec)
@@ -1873,7 +1876,8 @@
 };

 static struct hda_verb vt1709_uniwill_init_verbs[] = {
-	{0x20, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x20, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
 	{ }
 };

@@ -2509,7 +2513,15 @@
 };

 static struct hda_verb vt1708B_uniwill_init_verbs[] = {
-	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x1d, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1e, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x22, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x23, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };

@@ -3004,7 +3016,15 @@
 };

 static struct hda_verb vt1708S_uniwill_init_verbs[] = {
-	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x1d, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1e, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x22, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x23, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };

@@ -3443,8 +3463,12 @@
 };

 static struct hda_verb vt1702_uniwill_init_verbs[] = {
-	{0x01, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_GPIO_EVENT},
-	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };
