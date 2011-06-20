From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/3] ALSA: VIA HDA: Modify initial verbs list
	for VT1718S.
Date: Mon, 20 Jun 2011 14:14:37 +0800
Message-ID: <4DFEE54D.5030000@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 43AB6103865
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 08:14:42 +0200 (CEST)
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
Cc: tiwai@suse.de, haraldwelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Modify initial verbs list for VT1718S.

Remove some invalid initial verbs and correct some wrong initial verbs 
for VT1718S codec.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2011-06-20 13:25:07.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2011-06-20 13:31:19.000000000 +0800
@@ -4286,9 +4286,6 @@
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
-
-	/* Setup default input of Front HP to MW9 */
-	{0x28, AC_VERB_SET_CONNECT_SEL, 0x1},
 	/* PW9 PW10 Output enable */
 	{0x2d, AC_VERB_SET_PIN_WIDGET_CONTROL, AC_PINCTL_OUT_EN},
 	{0x2e, AC_VERB_SET_PIN_WIDGET_CONTROL, AC_PINCTL_OUT_EN},
@@ -4297,10 +4294,10 @@
 	/* Enable Boost Volume backdoor */
 	{0x1, 0xf88, 0x8},
 	/* MW0/1/2/3/4: un-mute index 0 (AOWx), mute index 1 (MW9) */
-	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
@@ -4310,8 +4307,6 @@
 	/* set MUX1 = 2 (AOW4), MUX2 = 1 (AOW3) */
 	{0x34, AC_VERB_SET_CONNECT_SEL, 0x2},
 	{0x35, AC_VERB_SET_CONNECT_SEL, 0x1},
-	/* Unmute MW4's index 0 */
-	{0x1c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ }
 };
