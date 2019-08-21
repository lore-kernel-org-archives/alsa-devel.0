From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 07/11] soundwire: intel: improve .config_stream callback, add .free_stream
Date: Wed, 21 Aug 2019 15:05:17 -0500
Message-ID: <20190821200521.17283-8-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rander Wang <rander.wang@linux.intel.com>

We need the link_id as a parameter for the config callback, and we
also need a matching free callback in case any resources need to be
released.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 19 +++++++++++++++++--
 include/linux/soundwire/sdw_intel.h |  4 +++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0001f433e848..529d7bc693d1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -578,17 +578,31 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 static int intel_config_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
-			       struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
 {
 	struct sdw_intel_link_res *res = sdw->res;
 
 	if (res->ops && res->ops->config_stream && res->arg)
 		return res->ops->config_stream(res->arg,
-				substream, dai, hw_params, link_id);
+					       substream, dai, hw_params,
+					       link_id, alh_stream_id);
 
 	return -EIO;
 }
 
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+{
+	if (sdw->res->ops && sdw->res->ops->free_stream && sdw->res->arg)
+		return sdw->res->ops->free_stream(sdw->res->arg,
+						  substream, dai, link_id);
+
+	return 0;
+}
+
 /*
  * bank switch routines
  */
@@ -718,6 +732,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_config_stream(sdw, substream, dai, params,
+				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
 		goto error;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index c9427cb6020b..c5a2caf3a9d5 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -12,7 +12,9 @@
  */
 struct sdw_intel_ops {
 	int (*config_stream)(void *arg, void *substream,
-			     void *dai, void *hw_params, int stream_num);
+			     void *dai, void *hw_params,
+			     int link_id, int alh_stream_id);
+	int (*free_stream)(void *arg, void *substream, void *dai, int link_id);
 };
 
 /**
-- 
2.20.1
