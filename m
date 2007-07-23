From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] Fix Kconfig entry for
	SND_S3C24XX_SOC_NEO1973_WM8753
Date: Mon, 23 Jul 2007 10:38:08 +0200
Message-ID: <85hcnvzf9r.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.duckcorp.org (orfeo.duckcorp.org [195.5.254.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 330CE2447F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 10:38:12 +0200 (CEST)
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
Cc: laforge@openmoko.org
List-Id: alsa-devel@alsa-project.org

--=-=-=


SND_S3C24XX_SOC_NEO1973_WM8753 depends on MACH_GTA01 but the Kconfig
entry which is going to be merged is MACH_NEO1973_GTA01.

signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=asoc_neo1973_kconfig_fix.patch

---
 sound/soc/s3c24xx/Kconfig |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/sound/soc/s3c24xx/Kconfig
===================================================================
--- linux-2.6.orig/sound/soc/s3c24xx/Kconfig	2007-07-23 10:15:13.000000000 +0200
+++ linux-2.6/sound/soc/s3c24xx/Kconfig	2007-07-23 10:18:07.000000000 +0200
@@ -18,7 +18,7 @@ config SND_S3C2443_SOC_AC97
 	
 config SND_S3C24XX_SOC_NEO1973_WM8753
 	tristate "SoC I2S Audio support for NEO1973 - WM8753"
-	depends on SND_S3C24XX_SOC && MACH_GTA01
+	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01
 	select SND_S3C24XX_SOC_I2S
 	select SND_SOC_WM8753
 	help

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
