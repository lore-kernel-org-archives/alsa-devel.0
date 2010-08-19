From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Multi-component: Use a more adequate
	name for the CX20442 codec DAI
Date: Thu, 19 Aug 2010 15:15:50 +0200
Message-ID: <201008191515.51877.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C247F24387
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 15:16:32 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

In the process of unification of codec DAI names while implementing 
multi-component, the CX20442 codec DAI has been renamed to "cx20442-hifi". 
This new name seems not adequate for a 8kHz voice codec.

Use a better name, "cx20442-voice", as suggested by Liam Girdwood.

Created against git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git 
commit 5dcba5d6741d4533e0ef696507f93f2a4c738efb dated 12 Aug 2010.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- git/sound/soc/codecs/cx20442.c.orig	2010-08-19 14:48:27.000000000 +0200
+++ git/sound/soc/codecs/cx20442.c	2010-08-19 15:01:55.000000000 +0200
@@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(v253_ops);
  */
 
 static struct snd_soc_dai_driver cx20442_dai = {
-	.name = "cx20442-hifi",
+	.name = "cx20442-voice",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
--- git/sound/soc/omap/ams-delta.c.orig	2010-08-19 14:48:28.000000000 +0200
+++ git/sound/soc/omap/ams-delta.c	2010-08-19 15:02:05.000000000 +0200
@@ -584,7 +584,7 @@ static struct snd_soc_dai_link ams_delta
 	.name = "CX20442",
 	.stream_name = "CX20442",
 	.cpu_dai_name ="omap-mcbsp-dai.0",
-	.codec_dai_name = "cx20442-hifi",
+	.codec_dai_name = "cx20442-voice",
 	.init = ams_delta_cx20442_init,
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "cx20442-codec",
