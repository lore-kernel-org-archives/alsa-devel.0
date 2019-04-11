From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] soundwire: fix SOUNDWIRE_BUS option
Date: Thu, 11 Apr 2019 14:28:14 -0500
Message-ID: <20190411192814.10663-3-pierre-louis.bossart@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

SOUNDWIRE_BUS can be selected independendly by the SOC driver
(e.g. SOUNDWIRE_INTEL) or the codec driver (via REGMAP_SOUNDWIRE).

Remove wrong-way link between SOUNDWIRE_BUS and REGMAP_SOUNDWIRE

Fixes: 6c49b32d3c09 ('soundwire: select REGMAP_SOUNDWIRE')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 84876a74874f..d382d80d2fe1 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -18,7 +18,6 @@ comment "SoundWire Devices"
 
 config SOUNDWIRE_BUS
 	tristate
-	select REGMAP_SOUNDWIRE
 
 config SOUNDWIRE_CADENCE
 	tristate
-- 
2.17.1
