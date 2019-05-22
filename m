From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 13/15] soundwire: Intel: add log for number of PCM and PDM PDIs
Date: Wed, 22 May 2019 14:47:29 -0500
Message-ID: <20190522194732.25704-14-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This information will be reflected in debugfs but it's easier to see
as a dmesg log.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4ac141730b13..92be6ad84e8d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -263,6 +263,9 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 	config->pcm_out = (pcm_cap & SDW_SHIM_PCMSCAP_OSS) >>
 					SDW_REG_SHIFT(SDW_SHIM_PCMSCAP_OSS);
 
+	dev_dbg(sdw->cdns.dev, "PCM cap bd:%d in:%d out:%d\n",
+		config->pcm_bd, config->pcm_in, config->pcm_out);
+
 	/* PDM Stream Capability */
 	pdm_cap = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
 
@@ -272,6 +275,9 @@ static void intel_pdi_init(struct sdw_intel *sdw,
 					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_ISS);
 	config->pdm_out = (pdm_cap & SDW_SHIM_PDMSCAP_OSS) >>
 					SDW_REG_SHIFT(SDW_SHIM_PDMSCAP_OSS);
+
+	dev_dbg(sdw->cdns.dev, "PDM cap bd:%d in:%d out:%d\n",
+		config->pdm_bd, config->pdm_in, config->pdm_out);
 }
 
 static int
-- 
2.20.1
