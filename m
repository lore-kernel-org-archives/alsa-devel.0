From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 21/21] ASoC: SOF: Intel: ssp: BCLK delay
	parameter
Date: Mon, 22 Jul 2019 09:14:02 -0500
Message-ID: <20190722141402.7194-22-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 746FCF804CF
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:26 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Janusz Jankowski <janusz.jankowski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Janusz Jankowski <janusz.jankowski@linux.intel.com>

Some codecs require BCLK to be on for some time, before sending
any data. SOF can enable BCLK and then wait for guaranteed time,
before starting DMA on SSP start.

Signed-off-by: Janusz Jankowski <janusz.jankowski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-intel.h   | 3 +++
 include/uapi/sound/sof/abi.h    | 2 +-
 include/uapi/sound/sof/tokens.h | 1 +
 sound/soc/sof/topology.c        | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 4bb8ee138ba7..a81afd3fbd41 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -76,6 +76,9 @@ struct sof_ipc_dai_ssp_params {
 	uint16_t tdm_per_slot_padding_flag;
 	uint32_t clks_control;
 	uint32_t quirks;
+	uint32_t bclk_delay;	/* guaranteed time (ms) for which BCLK
+				 * will be driven, before sending data
+				 */
 } __packed;
 
 /* HDA Configuration Request - SOF_IPC_DAI_HDA_CONFIG */
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 4a9c24434f42..dff70a42445a 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 8
+#define SOF_ABI_MINOR 9
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index dc1b27daaac6..6435240cef13 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -75,6 +75,7 @@
 #define SOF_TKN_INTEL_SSP_FRAME_PULSE_WIDTH	503
 #define SOF_TKN_INTEL_SSP_QUIRKS		504
 #define SOF_TKN_INTEL_SSP_TDM_PADDING_PER_SLOT	505
+#define SOF_TKN_INTEL_SSP_BCLK_DELAY		506
 
 /* DMIC */
 #define SOF_TKN_INTEL_DMIC_DRIVER_VERSION	600
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 432ae343f960..12b7d900b9c2 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -748,6 +748,9 @@ static const struct sof_topology_token ssp_tokens[] = {
 		get_token_u16,
 		offsetof(struct sof_ipc_dai_ssp_params,
 			 tdm_per_slot_padding_flag), 0},
+	{SOF_TKN_INTEL_SSP_BCLK_DELAY, SND_SOC_TPLG_TUPLE_TYPE_WORD,
+		get_token_u32,
+		offsetof(struct sof_ipc_dai_ssp_params, bclk_delay), 0},
 
 };
 
-- 
2.20.1
