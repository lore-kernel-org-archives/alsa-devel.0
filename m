From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Amstrad Delta: fix const related build
	error
Date: Tue, 1 Feb 2011 10:38:29 +0100
Message-ID: <201102011038.29330.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 28A9E103926
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 10:59:05 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The Amstrad Delta ASoC driver used to override the digital_mute() 
callback, expected to be not provided by the on-board CX20442 CODEC 
driver, with its own implementation. While this is still posssible when 
substituting the whole empty snd_soc_dai_driver.ops member (the CX20442 
case), replacing snd_soc_dai_ops.digital_mute only is no longer correct 
after the snd_soc_dai_driver.ops member has been constified, and results 
in build error.

Drop this actually not used code path in hope the CX20442 driver never 
provides its own snd_soc_dai_ops structure.

Created and tested against linux-2.6.38-rc2

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Please consider queuing this patch for the current rc cycle.

 sound/soc/omap/ams-delta.c |    2 --
 1 file changed, 2 deletions(-)

--- git/sound/soc/omap/ams-delta.c.orig	2011-01-31 19:49:29.000000000 
+0100
+++ git/sound/soc/omap/ams-delta.c	2011-01-31 23:24:45.000000000 +0100
@@ -507,8 +507,6 @@ static int ams_delta_cx20442_init(struct
 	/* Set up digital mute if not provided by the codec */
 	if (!codec_dai->driver->ops) {
 		codec_dai->driver->ops = &ams_delta_dai_ops;
-	} else if (!codec_dai->driver->ops->digital_mute) {
-		codec_dai->driver->ops->digital_mute = ams_delta_digital_mute;
 	} else {
 		ams_delta_ops.startup = ams_delta_startup;
 		ams_delta_ops.shutdown = ams_delta_shutdown;
