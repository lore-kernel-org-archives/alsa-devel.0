From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 7/7] ASoC: SOF: Intel: load hda codec
	module also for HDMI/DP
Date: Thu, 29 Aug 2019 16:53:48 +0300
Message-ID: <20190829135348.23569-8-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F28B1F89891
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:26 +0200 (CEST)
In-Reply-To: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Handle all HDA codecs in the same way and remove exceptions
for HDMI/DP.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 11 ++++-------
 sound/soc/sof/intel/hda.h       |  5 +++--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index b8b37f082309..3eb3e1505481 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -74,11 +74,8 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 	if (ret < 0)
 		return ret;
 
-	/* use legacy bus only for HDA codecs, idisp uses ext bus */
-	if ((resp & 0xFFFF0000) != IDISP_VID_INTEL) {
-		hdev->type = HDA_DEV_LEGACY;
-		hda_codec_load_module(&hda_priv->codec);
-	}
+	hdev->type = HDA_DEV_LEGACY;
+	hda_codec_load_module(&hda_priv->codec);
 
 	return 0;
 #else
@@ -117,7 +114,7 @@ int hda_codec_probe_bus(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL(hda_codec_probe_bus);
 
-#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)
+#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
 void hda_codec_i915_get(struct snd_sof_dev *sdev)
 {
@@ -166,6 +163,6 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL(hda_codec_i915_exit);
 
-#endif /* CONFIG_SND_SOC_HDAC_HDMI */
+#endif /* CONFIG_SND_HDA_CODEC_HDMI */
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 75b096050fa2..1cf8b039a21a 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -559,7 +559,8 @@ int hda_codec_probe_bus(struct snd_sof_dev *sdev);
 
 #endif /* CONFIG_SND_SOC_SOF_HDA */
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA) && IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA) && \
+	IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
 void hda_codec_i915_get(struct snd_sof_dev *sdev);
 void hda_codec_i915_put(struct snd_sof_dev *sdev);
@@ -573,7 +574,7 @@ static inline void hda_codec_i915_put(struct snd_sof_dev *sdev)  { }
 static inline int hda_codec_i915_init(struct snd_sof_dev *sdev) { return 0; }
 static inline int hda_codec_i915_exit(struct snd_sof_dev *sdev) { return 0; }
 
-#endif /* CONFIG_SND_SOC_SOF_HDA && CONFIG_SND_SOC_HDAC_HDMI */
+#endif /* CONFIG_SND_SOC_SOF_HDA && CONFIG_SND_HDA_CODEC_HDMI */
 
 /*
  * Trace Control.
-- 
2.17.1
