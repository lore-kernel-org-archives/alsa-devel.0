From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 03/11] soundwire: intel: remove playback/capture stream_name
Date: Wed, 21 Aug 2019 15:05:13 -0500
Message-ID: <20190821200521.17283-4-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We will create dai widget in SOF.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d5563cfc6549..883289a04c82 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -922,14 +922,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			return -ENOMEM;
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
-			dais[i].playback.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Tx%d",
-					  cdns->instance, i);
-			if (!dais[i].playback.stream_name) {
-				kfree(dais[i].name);
-				return -ENOMEM;
-			}
-
 			dais[i].playback.channels_min = 1;
 			dais[i].playback.channels_max = max_ch;
 			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
@@ -937,15 +929,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
-			dais[i].capture.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Rx%d",
-					  cdns->instance, i);
-			if (!dais[i].capture.stream_name) {
-				kfree(dais[i].name);
-				kfree(dais[i].playback.stream_name);
-				return -ENOMEM;
-			}
-
 			dais[i].capture.channels_min = 1;
 			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
-- 
2.20.1
