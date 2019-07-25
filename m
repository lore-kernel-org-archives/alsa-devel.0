From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ASoC: SOF: Makefile - fix the top-level kernel
	module names (add snd- prefix)
Date: Thu, 25 Jul 2019 13:08:08 +0200
Message-ID: <20190725110808.19938-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C24EFF800E8
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 13:08:34 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use the proper module name. The objs assignments are already there.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>0
---
 sound/soc/sof/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
index 8f14c9d2950b..d2f7a1bc09a1 100644
--- a/sound/soc/sof/Makefile
+++ b/sound/soc/sof/Makefile
@@ -11,8 +11,8 @@ obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
 obj-$(CONFIG_SND_SOC_SOF_NOCODEC) += snd-sof-nocodec.o
 
 
-obj-$(CONFIG_SND_SOC_SOF_ACPI) += sof-acpi-dev.o
-obj-$(CONFIG_SND_SOC_SOF_PCI) += sof-pci-dev.o
+obj-$(CONFIG_SND_SOC_SOF_ACPI) += snd-sof-acpi-dev.o
+obj-$(CONFIG_SND_SOC_SOF_PCI) += snd-sof-pci-dev.o
 
 obj-$(CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL) += intel/
 obj-$(CONFIG_SND_SOC_SOF_XTENSA) += xtensa/
-- 
2.20.1
