From: "\"Eric Millbrandt" <emillbrandt@dekaresearch.com>"
Subject: [PATCH v2 1/7] ASoC: fsl: add PPC_MPC52xx dependency
	to SND_POWERPC_SOC
Date: Wed, 19 Sep 2012 10:51:25 -0400
Message-ID: <1348066285-87741-1-git-send-email-emillbrandt@dekaresearch.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 178222651F4
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 16:52:11 +0200 (CEST)
In-Reply-To: <y>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Millbrandt <emillbrandt@dekaresearch.com>

mpc52xx socs need to define SND_POWERPC_SOC to build ASoC drivers.

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
