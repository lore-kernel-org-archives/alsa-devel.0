From: Li Bo <liboat@gmail.com>
Subject: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
	limit for S/PDIF streams.
Date: Mon, 5 Oct 2009 22:27:43 +0800
Message-ID: <16685ee0910050727k409b03fdj1b03afd9c9521db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 78FF41038AD
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:43 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2792157fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:43 -0700 (PDT)
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

[ALSA] HDA VIA: Add 48K sample rate limit for S/PDIF streams.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:11:02.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:11:04.000000000 +0800
@@ -1228,6 +1228,7 @@
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 	/* NID is set in via_build_pcms */
 	.ops = {
 		.open = via_dig_playback_pcm_open,
@@ -1241,6 +1242,7 @@
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 };

 static int via_build_controls(struct hda_codec *codec)
@@ -2042,6 +2044,7 @@
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 	/* NID is set in via_build_pcms */
 	.ops = {
 		.open = via_dig_playback_pcm_open,
@@ -2657,6 +2660,7 @@
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 	/* NID is set in via_build_pcms */
 	.ops = {
 		.open = via_dig_playback_pcm_open,
@@ -3137,6 +3141,7 @@
 	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 	/* NID is set in via_build_pcms */
 	.ops = {
 		.open = via_dig_playback_pcm_open,
@@ -3581,6 +3586,7 @@
 	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
 	/* NID is set in via_build_pcms */
 	.ops = {
 		.open = via_dig_playback_pcm_open,
