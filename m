From: Li Bo <liboat@gmail.com>
Subject: [PATCH 28/31] HDA patch_via.c:
	vt1708_control_templates[] -> via_control_templates[].
Date: Mon, 5 Oct 2009 22:28:35 +0800
Message-ID: <16685ee0910050728t694b1d1av45663aa8246527ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id C911B1038AA
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:28:35 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2792157fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:28:35 -0700 (PDT)
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

[ALSA] HDA VIA: vt1708_control_templates[] -> via_control_templates[].

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:14:04.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:14:10.000000000 +0800
@@ -336,7 +336,7 @@
 			.put = bind_pin_switch_put,			\
 			.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }

-static struct snd_kcontrol_new vt1708_control_templates[] = {
+static struct snd_kcontrol_new via_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
 	ANALOG_INPUT_MUTE,
@@ -399,7 +399,7 @@
 	knew = snd_array_new(&spec->kctls);
 	if (!knew)
 		return -ENOMEM;
-	*knew = vt1708_control_templates[type];
+	*knew = via_control_templates[type];
 	knew->name = kstrdup(name, GFP_KERNEL);
 	if (!knew->name)
 		return -ENOMEM;
