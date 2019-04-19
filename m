From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Fri, 19 Apr 2019 14:46:49 -0500
Message-ID: <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org

The mechanism should be

config CODEC_XYX_SDW
       depends on SOUNDWIRE
       select REGMAP_SOUNDWIRE

config REGMAP_SOUNDWIRE
       select SOUNDWIRE_BUS

SOUNDWIRE_BUS can be independently selected by the SOC driver. The SOC
driver should not know or care about REGMAP_SOUNDWIRE.

Fixes: 7c22ce6e2184 ('03fc8746f7915b5a391d8227f7e1')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61e..c12e3f1fb110 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,7 @@ config REGMAP_IRQ
 
 config REGMAP_SOUNDWIRE
 	tristate
-	depends on SOUNDWIRE_BUS
+	select SOUNDWIRE_BUS
 
 config REGMAP_SCCB
 	tristate
-- 
2.17.1
