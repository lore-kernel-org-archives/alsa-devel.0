From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 2/7] ASoC: Intel: uapi: Add new tokens for
	module common data
Date: Wed, 23 Aug 2017 19:33:49 +0530
Message-ID: <20170823140354.792-3-guneshwor.o.singh@intel.com>
References: <20170823140354.792-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 12B99267766
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:04:13 +0200 (CEST)
In-Reply-To: <20170823140354.792-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The module private data can be modelled independent of its instances so
that it can be reused by the module instances. So move module data to
common manifest which can be referenced by the module instances.

This requires new tokens to be defined to accommodate these changes. The
new tokens will specify buffer sizes, DSP cycles and respective indexes
corresponding to the pcm params in the topology manifest so that driver
need not compute them.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 include/uapi/sound/snd_sst_tokens.h | 92 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index dedb2056160d..f691e421f5e8 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -163,8 +163,71 @@
  *
  * %SKL_TKN_U32_DMA_BUF_SIZE:	DMA buffer size in millisec
  *
+ * %SKL_TKN_U32_PIPE_DIR:       Specifies pipe direction. Can be
+ *                              playback/capture.
+ *
+ * %SKL_TKN_U32_NUM_CONFIGS:    Number of pipe configs
+ *
+ * %SKL_TKN_U32_PATH_MEM_PGS:   Size of memory (in pages) required for pipeline
+ *                              and its data
+ *
+ * %SKL_TKN_U32_PIPE_CONFIG_ID: Config id for the modules in the pipe
+ *                              and PCM params supported by that pipe
+ *                              config. This is used as index to fill
+ *                              up the pipe config and module config
+ *                              structure.
+ *
+ * %SKL_TKN_U32_CFG_FREQ:
+ * %SKL_TKN_U8_CFG_CHAN:
+ * %SKL_TKN_U8_CFG_BPS:         PCM params (freq, channels, bits per sample)
+ *                              supported for each of the pipe configs.
+ *
+ * %SKL_TKN_CFG_MOD_RES_ID:     Module's resource index for each of the
+ *                              pipe config
+ *
+ * %SKL_TKN_CFG_MOD_FMT_ID:     Module's interface index for each of the
+ *                              pipe config
+ *
+ * %SKL_TKN_U8_NUM_MOD:         Number of modules in the manifest
+ *
+ * %SKL_TKN_MM_U8_MOD_IDX:      Current index of the module in the manifest
+ *
+ * %SKL_TKN_MM_U8_NUM_RES:      Number of resources for the module
+ *
+ * %SKL_TKN_MM_U8_NUM_INTF:     Number of interfaces for the module
+ *
+ * %SKL_TKN_MM_U32_RES_ID:      Resource index for the resource info to
+ *                              be filled into.
+ *                              A module can support multiple resource
+ *                              configuration and is represnted as a
+ *                              resource table. This index is used to
+ *                              fill information into appropriate index.
+ *
+ * %SKL_TKN_MM_U32_CPS:         DSP cycles per second
+ *
+ * %SKL_TKN_MM_U32_DMA_SIZE:    Allocated buffer size for gateway DMA
+ *
+ * %SKL_TKN_MM_U32_CPC:         DSP cycles allocated per frame
+ *
+ * %SKL_TKN_MM_U32_RES_PIN_ID:  Resource pin index in the module
+ *
+ * %SKL_TKN_MM_U32_INTF_PIN_ID: Interface index in the module
+ *
+ * %SKL_TKN_MM_U32_PIN_BUF:     Buffer size of the module pin
+ *
+ * %SKL_TKN_MM_U32_FMT_ID:      Format index for each of the interface/
+ *                              format information to be filled into.
+ *
+ * %SKL_TKN_MM_U32_NUM_IN_FMT:  Number of input formats
+ * %SKL_TKN_MM_U32_NUM_OUT_FMT: Number of output formats
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
+ *
+ * Tokens defined can be used either in the manifest or widget private data.
+ *
+ * SKL_TKN_MM is used as a suffix for all tokens that represent
+ * module data in the manifest.
  */
 enum SKL_TKNS {
 	SKL_TKN_UUID = 1,
@@ -218,7 +281,34 @@ enum SKL_TKNS {
 	SKL_TKL_U32_D0I3_CAPS, /* Typo added at v4.10 */
 	SKL_TKN_U32_D0I3_CAPS = SKL_TKL_U32_D0I3_CAPS,
 	SKL_TKN_U32_DMA_BUF_SIZE,
-	SKL_TKN_MAX = SKL_TKN_U32_DMA_BUF_SIZE,
+
+	SKL_TKN_U32_PIPE_DIRECTION,
+	SKL_TKN_U32_PIPE_CONFIG_ID,
+	SKL_TKN_U32_NUM_CONFIGS,
+	SKL_TKN_U32_PATH_MEM_PGS,
+
+	SKL_TKN_U32_CFG_FREQ,
+	SKL_TKN_U8_CFG_CHAN,
+	SKL_TKN_U8_CFG_BPS,
+	SKL_TKN_CFG_MOD_RES_ID,
+	SKL_TKN_CFG_MOD_FMT_ID,
+	SKL_TKN_U8_NUM_MOD,
+
+	SKL_TKN_MM_U8_MOD_IDX,
+	SKL_TKN_MM_U8_NUM_RES,
+	SKL_TKN_MM_U8_NUM_INTF,
+	SKL_TKN_MM_U32_RES_ID,
+	SKL_TKN_MM_U32_CPS,
+	SKL_TKN_MM_U32_DMA_SIZE,
+	SKL_TKN_MM_U32_CPC,
+	SKL_TKN_MM_U32_RES_PIN_ID,
+	SKL_TKN_MM_U32_INTF_PIN_ID,
+	SKL_TKN_MM_U32_PIN_BUF,
+	SKL_TKN_MM_U32_FMT_ID,
+	SKL_TKN_MM_U32_NUM_IN_FMT,
+	SKL_TKN_MM_U32_NUM_OUT_FMT,
+
+	SKL_TKN_MAX = SKL_TKN_MM_U32_NUM_OUT_FMT,
 };
 
 #endif
-- 
2.14.1
