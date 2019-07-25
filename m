From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 06/40] soundwire: intel: prevent possible dereference in hw_params
Date: Thu, 25 Jul 2019 18:39:58 -0500
Message-ID: <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This should not happen in production systems but we should test for
all callback arguments before invoking the config_stream callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 68832e613b1e..497879dd9c0d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -509,7 +509,7 @@ static int intel_config_stream(struct sdw_intel *sdw,
 			       struct snd_soc_dai *dai,
 			       struct snd_pcm_hw_params *hw_params, int link_id)
 {
-	if (sdw->res->ops && sdw->res->ops->config_stream)
+	if (sdw->res->ops && sdw->res->ops->config_stream && sdw->res->arg)
 		return sdw->res->ops->config_stream(sdw->res->arg,
 				substream, dai, hw_params, link_id);
 
-- 
2.20.1
