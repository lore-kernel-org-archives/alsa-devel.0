From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] ASoC: Intel: remove select on non-existing SND_SOC_INTEL_COMMON
Date: Wed, 17 Jan 2018 19:43:24 +0100
Message-ID: <20180117184324.3475-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: alsa-devel@alsa-project.org

SND_SST_ATOM_HIFI2_PLATFORM_PCI select SND_SOC_INTEL_COMMON which do not
exists anymore.
So remove this select.

Fixes: c6059879be29 ("ASoC: Intel: Fix Kconfig with top-level selector")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b0bd1938b71e..f2c9e8c5970a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -77,7 +77,6 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
 	depends on X86 && PCI
 	select SND_SST_IPC_PCI
 	select SND_SOC_COMPRESS
-	select SND_SOC_INTEL_COMMON
 	help
 	  If you have a Intel Medfield or Merrifield/Edison platform, then
 	  enable this option by saying Y or m. Distros will typically not
-- 
2.13.6
