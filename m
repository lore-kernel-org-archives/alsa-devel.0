From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 05/35] ASoC: Intel: Skylake: Reload libraries
	on D0 entry for CNL
Date: Thu, 22 Aug 2019 21:03:55 +0200
Message-ID: <20190822190425.23001-6-cezary.rojewski@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9405F804CB
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 21:04:49 +0200 (CEST)
In-Reply-To: <20190822190425.23001-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

As libraries are lost in D3, they need to be reloaded on D0 entry.
Cannonlake's library load process is equivalent to Broxton's, thus reuse
the existing one.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     |  3 ++-
 sound/soc/intel/skylake/cnl-sst.c     | 11 +++++++++++
 sound/soc/intel/skylake/skl-sst-dsp.h |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 5bece3a6d741..cc9507d4702b 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -45,7 +45,7 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
 }
 
-static int
+int
 bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 {
 	struct snd_dma_buffer dmab;
@@ -88,6 +88,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 	skl_release_library(linfo, lib_count);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bxt_load_library);
 
 /*
  * First boot sequence has some extra steps. Core 0 waits for power
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 8984653d925d..a2b3bce631fc 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -179,6 +179,16 @@ static int cnl_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 			return ret;
 		}
 
+		if (cnl->lib_count > 1) {
+			ret = ctx->fw_ops.load_library(ctx, cnl->lib_info,
+						cnl->lib_count);
+			if (ret < 0) {
+				dev_err(ctx->dev,
+					"reload libs failed: %d\n", ret);
+				return ret;
+			}
+		}
+
 		cnl->cores.state[core_id] = SKL_DSP_RUNNING;
 		return ret;
 	}
@@ -273,6 +283,7 @@ static const struct skl_dsp_fw_ops cnl_fw_ops = {
 	.set_state_D3 = cnl_set_dsp_D3,
 	.load_fw = cnl_load_base_firmware,
 	.get_fw_errcode = cnl_get_errno,
+	.load_library = bxt_load_library,
 };
 
 static struct sst_ops cnl_ops = {
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 4da240582454..06979652985c 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -228,6 +228,8 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 		struct skl_dev **dsp);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_dev *skl);
+int bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo,
+		int lib_count);
 
 int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 				unsigned int offset, int index);
-- 
2.17.1
