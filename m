From: <vm.rod25@gmail.com>
Subject: [PATCH v3 3/9] davinci: ASoC support for
	Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 12:21:52 -0500
Message-ID: <1287076912-4411-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id EF780103B91
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 19:21:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds ASoC support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 sound/soc/davinci/Kconfig       |    5 +++--
 sound/soc/davinci/davinci-evm.c |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6bbf001..72c6752 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -76,8 +76,9 @@ config  SND_DA830_SOC_EVM
 	  DA830/OMAP-L137 EVM
 
 config  SND_DA850_SOC_EVM
-	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
+	tristate "SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard"
+	depends on SND_DAVINCI_SOC && (MACH_DAVINCI_DA850_EVM || \
+			MACH_OMAPL138_HAWKBOARD)
 	select SND_DAVINCI_SOC_MCASP
 	select SND_SOC_TLV320AIC3X
 	help
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 97f74d6..73093eb 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -59,7 +59,8 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 		sysclk = 12288000;
 
 	else if (machine_is_davinci_da830_evm() ||
-				machine_is_davinci_da850_evm())
+				machine_is_davinci_da850_evm() ||
+				machine_is_omapl138_hawkboard())
 		sysclk = 24576000;
 
 	else
@@ -311,7 +312,8 @@ static int __init evm_init(void)
 	} else if (machine_is_davinci_da830_evm()) {
 		evm_snd_dev_data = &da830_evm_snd_devdata;
 		index = 1;
-	} else if (machine_is_davinci_da850_evm()) {
+	} else if (machine_is_davinci_da850_evm() ||
+			machine_is_omapl138_hawkboard()) {
 		evm_snd_dev_data = &da850_evm_snd_devdata;
 		index = 0;
 	} else
-- 
1.6.0.5
