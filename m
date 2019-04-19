From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/2] soundwire: fix SOUNDWIRE_BUS option
Date: Fri, 19 Apr 2019 14:46:48 -0500
Message-ID: <20190419194649.18467-2-pierre-louis.bossart@linux.intel.com>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

The existing Kconfig can lead to the following warning:

WARNING: unmet direct dependencies detected for REGMAP_SOUNDWIRE
  Depends on [m]: SOUNDWIRE_BUS [=m]
  Selected by [y]:
  - SND_SOC_RT700_SDW [=y] && SOUND [=y] && !UML && SND [=y] &&
    SND_SOC [=y] && SOUNDWIRE [=y]
  Selected by [m]:
  - SOUNDWIRE_BUS [=m] && SOUNDWIRE [=y]

Remove wrong-way link between SOUNDWIRE_BUS and REGMAP_SOUNDWIRE

SOUNDWIRE_BUS can be selected independendly by the SOC driver
(e.g. SOUNDWIRE_INTEL) or the codec driver (via REGMAP_SOUNDWIRE).

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
