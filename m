From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] soc/sh: let SND_SOC_PCM_SH7760 depend on
	SH_DMABRG
Date: Thu, 7 Jun 2007 11:39:02 +0200
Message-ID: <20070607093902.GA1672@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 035E024579
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2007 11:39:02 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org


Let SND_SOC_PCM_SH7760 depend on SH_DMABRG rather than select'ing it.
Gets rid of the Kbuild warning about SH_DMABRG being undefined on non-sh
builds.


Signed-off-by:  Manuel Lauss <mano@roarinelk.homelinux.net>


--- linux-2.6.22-rc4-mm2/sound/soc/sh/Kconfig~	2007-06-07 11:09:30.000000000 +0200
+++ linux-2.6.22-rc4-mm2/sound/soc/sh/Kconfig	2007-06-07 11:09:30.000000000 +0200
@@ -2,8 +2,7 @@ menu "SoC Audio support for SuperH"
 
 config SND_SOC_PCM_SH7760
 	tristate "SoC Audio support for Renesas SH7760"
-	depends on CPU_SUBTYPE_SH7760 && SND_SOC
-	select SH_DMABRG
+	depends on CPU_SUBTYPE_SH7760 && SND_SOC && SH_DMABRG
 	help
 	  Enable this option for SH7760 AC97/I2S audio support.
