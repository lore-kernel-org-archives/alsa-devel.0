From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/6] ASoC: core: add support to snd_soc_dai_get_sdw_stream()
Date: Fri,  7 Jun 2019 09:56:38 +0100
Message-ID: <20190607085643.932-2-srinivas.kandagatla@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On platforms which have smart speaker amplifiers connected via
soundwire and modeled as aux devices in ASoC, in such usecases machine
driver should be able to get sdw master stream from dai so that it can
use the runtime stream to setup slave streams.

soundwire already as a set function, get function would provide more
flexibility to above configurations.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index f5d70041108f..9f90b936fd9a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
 			void *stream, int direction);
+	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -385,4 +386,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
 		return -ENOTSUPP;
 }
 
+static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai, int direction)
+{
+	if (dai->driver->ops->get_sdw_stream)
+		return dai->driver->ops->get_sdw_stream(dai, direction);
+	else
+		return NULL;
+
+}
+
 #endif
-- 
2.21.0
