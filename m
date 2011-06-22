From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 2/2] ASoC: imx: add missing module informations
Date: Wed, 22 Jun 2011 22:21:49 +0200
Message-ID: <20110622204442.159395380@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 159CD2437A
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 22:48:02 +0200 (CEST)
Content-Disposition: inline; filename=audio_modules_aliases.patch
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

- add some modules aliases
- add module license to avoid tainted kernel when loading the imx-pcm-audio
  driver

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: sound-2.6/sound/soc/imx/imx-pcm-dma-mx2.c
===================================================================
--- sound-2.6.orig/sound/soc/imx/imx-pcm-dma-mx2.c	2011-06-22 15:09:06.000000000 +0200
+++ sound-2.6/sound/soc/imx/imx-pcm-dma-mx2.c	2011-06-22 15:36:36.000000000 +0200
@@ -337,3 +337,5 @@ static void __exit snd_imx_pcm_exit(void
 	platform_driver_unregister(&imx_pcm_driver);
 }
 module_exit(snd_imx_pcm_exit);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx-pcm-audio");
Index: sound-2.6/sound/soc/imx/imx-ssi.c
===================================================================
--- sound-2.6.orig/sound/soc/imx/imx-ssi.c	2011-06-22 15:09:06.000000000 +0200
+++ sound-2.6/sound/soc/imx/imx-ssi.c	2011-06-22 15:36:36.000000000 +0200
@@ -775,4 +775,4 @@ module_exit(imx_ssi_exit);
 MODULE_AUTHOR("Sascha Hauer, <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("i.MX I2S/ac97 SoC Interface");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:imx-ssi");
