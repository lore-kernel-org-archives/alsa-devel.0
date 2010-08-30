From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 1/1] ASoC: OpenRD Client : Fix naming breakage
	due to multicomponent support
Date: Mon, 30 Aug 2010 16:00:05 +0200
Message-ID: <20100830140015.356460045@rtp-net.org>
References: <20100830140004.266980003@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id A58CD103807
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 16:01:33 +0200 (CEST)
Content-Disposition: inline; filename=conversion_fixes.patch
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

multicomponent support added/changed some device name but added some typos,
breaking existing OpenRD Client support.


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: sound-2.6/arch/arm/mach-kirkwood/common.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/common.c	2010-08-23 10:13:13.000000000 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/common.c	2010-08-23 10:13:14.000000000 +0200
@@ -905,7 +905,7 @@
 };
 
 static struct platform_device kirkwood_pcm_device = {
-	.name		= "kirkwood-pcm",
+	.name		= "kirkwood-pcm-audio",
 	.id		= -1,
 };
 
Index: sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-openrd.c	2010-08-23 10:11:33.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c	2010-08-23 10:13:14.000000000 +0200
@@ -66,7 +66,7 @@
 	.stream_name = "CS42L51 HiFi",
 	.cpu_dai_name = "kirkwood-i2s",
 	.platform_name = "kirkwood-pcm-audio",
-	.codec_dai_name = "cs42l51_hifi",
+	.codec_dai_name = "cs42l51-hifi",
 	.codec_name = "cs42l51-codec.0-004a",
 	.ops = &openrd_client_ops,
 },
Index: sound-2.6/sound/soc/codecs/cs42l51.c
===================================================================
--- sound-2.6.orig/sound/soc/codecs/cs42l51.c	2010-08-30 15:56:38.000000000 +0200
+++ sound-2.6/sound/soc/codecs/cs42l51.c	2010-08-30 15:56:53.000000000 +0200
@@ -622,7 +622,7 @@
 
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
-		.name = "cs42L51-codec",
+		.name = "cs42l51-codec",
 		.owner = THIS_MODULE,
 	},
 	.id_table = cs42l51_id,
