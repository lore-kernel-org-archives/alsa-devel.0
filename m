From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: add 2-channel mode to Intel
	ALC889/ALC889A models
Date: Thu, 30 Jul 2009 14:36:35 +0800
Message-ID: <20090730063635.GA5525@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 80B9F244C8
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 08:36:40 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This 2-channel mode is useful in that it will broadcast
a 2-channel audio stream to all front/side/... ports.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_realtek.c |   44 ++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 19 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_realtek.c
+++ sound-2.6/sound/pci/hda/patch_realtek.c
@@ -6682,18 +6682,27 @@ static struct hda_channel_mode alc883_3S
 };
 
 /*
+ * 2ch mode
+ */
+static struct hda_verb alc889_ch2_intel_init[] = {
+	{ 0x14, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x19, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x16, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ } /* end */
+};
+
+/*
  * 6ch mode
  */
 static struct hda_verb alc889_ch6_intel_init[] = {
-	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x14, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x19, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ 0x16, AC_VERB_SET_CONNECT_SEL, 0x02 },
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x03 },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
 	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
 	{ } /* end */
 };
@@ -6702,21 +6711,18 @@ static struct hda_verb alc889_ch6_intel_
  * 8ch mode
  */
 static struct hda_verb alc889_ch8_intel_init[] = {
-	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{ 0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x14, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x19, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ 0x16, AC_VERB_SET_CONNECT_SEL, 0x02 },
+	{ 0x17, AC_VERB_SET_CONNECT_SEL, 0x03 },
+	{ 0x1a, AC_VERB_SET_CONNECT_SEL, 0x03 },
 	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
 	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
-	{ 0x1a, AC_VERB_SET_CONNECT_SEL, 0x03 },
 	{ } /* end */
 };
 
-static struct hda_channel_mode alc889_8ch_intel_modes[2] = {
+static struct hda_channel_mode alc889_8ch_intel_modes[3] = {
+	{ 2, alc889_ch2_intel_init },
 	{ 6, alc889_ch6_intel_init },
 	{ 8, alc889_ch8_intel_init },
 };
