From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 3/3] ALSA: VIA HDA: Create a master amplifier
 control for VT1718S.
Date: Mon, 20 Jun 2011 14:17:56 +0800
Message-ID: <4DFEE614.5090300@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id D21F0103879
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 08:17:58 +0200 (CEST)
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
Subject: ALSA: VIA HDA: Create a master amplifier control for VT1718S.

Create a master volume and mute control of playback for VT1718S.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2011-06-20 13:49:00.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2011-06-20 14:01:15.000000000 +0800
@@ -4465,6 +4465,19 @@
 			if (err < 0)
 				return err;
 		} else if (i == AUTO_SEQ_FRONT) {
+			/* add control to mixer index 0 */
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "Master Front Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(0x21, 3, 5,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "Master Front Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(0x21, 3, 5,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
 			/* Front */
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(
