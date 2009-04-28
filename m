From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/17] ASoC: Set the MPC5200 i2s driver to
	BROKEN status.
Date: Tue, 28 Apr 2009 16:23:38 +0100
Message-ID: <1240932222-3718-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25C90103891
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:46 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Jon Smirl <jonsmirl@gmail.com>

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 9fc9082..e7dd79a 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -21,7 +21,7 @@ config SND_SOC_MPC8610_HPCD
 
 config SND_SOC_MPC5200_I2S
 	tristate "Freescale MPC5200 PSC in I2S mode driver"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
+	depends on PPC_MPC52xx && PPC_BESTCOMM && BROKEN
 	select SND_SOC_OF_SIMPLE
 	select PPC_BESTCOMM_GEN_BD
 	help
-- 
1.6.2.4
