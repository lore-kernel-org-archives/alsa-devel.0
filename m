From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 9/9] AUDIO: Select DMA if I2S is configured
Date: Wed, 04 Mar 2009 00:49:34 +0000
Message-ID: <20090304005139.468566732@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 76A852440A
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/select-dma-from-kconfig.patch
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Select the relevant DMA implementation when the
sound driver is selected.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Index: linux.agit/sound/soc/s3c24xx/Kconfig
===================================================================
--- linux.agit.orig/sound/soc/s3c24xx/Kconfig	2009-02-26 18:07:22.000000000 +0000
+++ linux.agit/sound/soc/s3c24xx/Kconfig	2009-02-26 18:12:29.000000000 +0000
@@ -8,6 +8,7 @@ config SND_S3C24XX_SOC
 
 config SND_S3C24XX_SOC_I2S
 	tristate
+	select S3C2410_DMA
 
 config SND_S3C_I2SV2_SOC
 	tristate
@@ -15,13 +16,16 @@ config SND_S3C_I2SV2_SOC
 config SND_S3C2412_SOC_I2S
 	tristate
 	select SND_S3C_I2SV2_SOC
+	select S3C2410_DMA
 
 config SND_S3C64XX_SOC_I2S
 	tristate
 	select SND_S3C_I2SV2_SOC
+	select S3C64XX_DMA
 
 config SND_S3C2443_SOC_AC97
 	tristate
+	select S3C2410_DMA
 	select AC97_BUS
 	select SND_SOC_AC97_BUS
 	

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
