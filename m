From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/17] soundwire: intel: prevent possible dereference in hw_params
Date: Mon,  5 Aug 2019 19:55:06 -0500
Message-ID: <20190806005522.22642-2-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This should not happen in production systems but we should test for
all callback arguments before invoking the config_stream callback.

Update the prototype to clarify that the first argument is mandatory.

Also use local variable instead of multiple dereferences to improve
readability.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 6 ++++--
 include/linux/soundwire/sdw_intel.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3d9ca6479e94..a906789c7f78 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -498,8 +498,10 @@ static int intel_config_stream(struct sdw_intel *sdw,
 			       struct snd_soc_dai *dai,
 			       struct snd_pcm_hw_params *hw_params, int link_id)
 {
-	if (sdw->res->ops && sdw->res->ops->config_stream)
-		return sdw->res->ops->config_stream(sdw->res->arg,
+	struct sdw_intel_link_res *res = sdw->res;
+
+	if (res->ops && res->ops->config_stream && res->arg)
+		return res->ops->config_stream(res->arg,
 				substream, dai, hw_params, link_id);
 
 	return -EIO;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 4d70da45363d..c9427cb6020b 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -8,6 +8,7 @@
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
  * @config_stream: configure the stream with the hw_params
+ * the first argument containing the context is mandatory
  */
 struct sdw_intel_ops {
 	int (*config_stream)(void *arg, void *substream,
-- 
2.20.1
