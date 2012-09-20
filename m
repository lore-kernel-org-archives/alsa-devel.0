From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH v2 1/3] ASoC: fsl: add PPC_MPC52xx dependency
	to SND_POWERPC_SOC
Date: Thu, 20 Sep 2012 10:36:43 -0400
Message-ID: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 6723C265B4D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 16:37:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

mpc52xx socs do not define FSL_SOC but need SND_POWERPC_SOC defined to build
ASoC drivers.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
Changes since v1:
Patch was "powerpc/52xx: define FSL_SOC"
Changed from defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a
dependency of SND_POWERPC_SOC as per Anatolij Gustschin's comment.

 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d701330..4563b28 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -6,7 +6,7 @@ config SND_SOC_FSL_UTILS
 
 menuconfig SND_POWERPC_SOC
 	tristate "SoC Audio for Freescale PowerPC CPUs"
-	depends on FSL_SOC
+	depends on FSL_SOC || PPC_MPC52xx
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the PowerPC CPUs.
-- 
1.7.2.5
