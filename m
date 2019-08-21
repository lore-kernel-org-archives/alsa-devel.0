From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 02/11] soundwire: remove DAI_ID_RANGE definitions
Date: Wed, 21 Aug 2019 15:05:12 -0500
Message-ID: <20190821200521.17283-3-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

There is no reason to reserve a range of DAI IDs for SoundWire. This
is not scalable and it's better to let the ASoC core allocate the
dai->id when registering a component.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 2 --
 include/linux/soundwire/sdw.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c95222f18c75..d5563cfc6549 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -952,8 +952,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
 
-		dais[i].id = SDW_DAI_ID_RANGE_START + i;
-
 		if (pcm)
 			dais[i].ops = &intel_pcm_dai_ops;
 		else
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index be9fe08d4e9c..db974003fe13 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -40,9 +40,6 @@ struct sdw_slave;
 
 #define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
 
-#define SDW_DAI_ID_RANGE_START		100
-#define SDW_DAI_ID_RANGE_END		200
-
 enum {
 	SDW_PORT_DIRN_SINK = 0,
 	SDW_PORT_DIRN_SOURCE,
-- 
2.20.1
