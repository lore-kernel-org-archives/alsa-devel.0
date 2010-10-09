From: <vm.rod25@gmail.com>
Subject: [PATCH v1 3/6] ASoC: davinci: ASoC support for
	Omapl138-Hawkboard
Date: Fri,  8 Oct 2010 20:17:21 -0500
Message-ID: <1286587041-1430-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 70360103803
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 03:16:25 +0200 (CEST)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o991GOw9023838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Fri, 8 Oct 2010 20:16:24 -0500
Received: from emcc1.sasken-mty.naucm.ext.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o991GNqO010273
	for <alsa-devel@alsa-project.org>; Fri, 8 Oct 2010 20:16:23 -0500 (CDT)
Received: from localhost.localdomain
	(victor-desktop.sasken-mty.naucm.ext.ti.com [10.87.230.94])
	by emcc1.sasken-mty.naucm.ext.ti.com (8.13.8+Sun/8.13.8) with ESMTP id
	o991GNsf026814
	for <alsa-devel@alsa-project.org>; Fri, 8 Oct 2010 20:16:23 -0500 (CDT)
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

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds ASoC support for the Hawkboard-L138 system
It is under the machine name "omapl138_hawkboard".
This system is based on the da850 davinci CPU architecture.

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 sound/soc/davinci/Kconfig       |    5 +++--
 sound/soc/davinci/davinci-evm.c |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6bbf001..d6cb394 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -76,8 +76,9 @@ config  SND_DA830_SOC_EVM
 	  DA830/OMAP-L137 EVM
 
 config  SND_DA850_SOC_EVM
-	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
+	tristate "SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard"
+	depends on SND_DAVINCI_SOC&& (MACH_DAVINCI_DA850_EVM \
+					|| MACH_OMAPL138_HAWKBOARD)
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
