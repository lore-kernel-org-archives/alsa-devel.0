From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: fsl: Remove dependencies of boards for
	SND_SOC_EUKREA_TLV320
Date: Fri, 23 May 2014 15:11:01 +0400
Message-ID: <1400843461-24991-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp26.mail.ru (smtp26.mail.ru [94.100.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B2268261ACD
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 13:11:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

Eukrea-i.MX51 board was converted to use DT, ie we no longer have a
MACH_EUKREA_MBIMXSD51_BASEBOARD symbol.
Transformation of other boards planned for the near future, so this
patch removes all these dependencies and restricts build of this
driver to ARCH_MXC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/Kconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d262ec0..2989319 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -207,12 +207,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD51_BASEBOARD \
-		|| (OF && ARM)
-	depends on I2C
+	depends on ARCH_MXC && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
1.8.3.2
