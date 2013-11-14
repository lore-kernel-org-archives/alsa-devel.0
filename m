From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/20] ASoC: davinci: Kconfig: Remove help
	section for SND_DAVINCI_SOC
Date: Thu, 14 Nov 2013 11:35:17 +0200
Message-ID: <1384421737-4467-2-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B72B261A11
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:42 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The help text is misleading and the prompt itself explains the purpose of
this config section.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 95970f5..fb91826 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,11 +1,6 @@
 config SND_DAVINCI_SOC
 	tristate "SoC Audio for the TI DAVINCI or AM33XX chip"
 	depends on ARCH_DAVINCI || SOC_AM33XX
-	help
-	  Platform driver for daVinci or AM33xx
-	  Say Y or M if you want to add support for codecs attached to
-	  the DAVINCI AC97, I2S, or McASP interface. You will also need
-	  to select the audio interfaces to support below.
 
 config SND_DAVINCI_SOC_I2S
 	tristate
-- 
1.8.4.2
