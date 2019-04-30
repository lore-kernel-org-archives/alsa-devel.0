From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 06/19] ASoC: SOF: Intel: hda: add SSP info to
	the chip info struct
Date: Tue, 30 Apr 2019 18:09:21 -0500
Message-ID: <20190430230934.4321-7-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4A9CF896EC
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:59 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

add SSP info of APL and CNL, to the sof_intel_dsp_desc
structure. The max SSP count the platform support and
the SSP base address.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/apl.c  | 2 ++
 sound/soc/sof/intel/cnl.c  | 2 ++
 sound/soc/sof/intel/hda.h  | 4 ++++
 sound/soc/sof/intel/shim.h | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 8c6282606944..026dde839621 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -105,5 +105,7 @@ const struct sof_intel_dsp_desc apl_chip_info = {
 	.ipc_ack_mask = HDA_DSP_REG_HIPCIE_DONE,
 	.ipc_ctl = HDA_DSP_REG_HIPCCTL,
 	.rom_init_timeout	= 150,
+	.ssp_count = APL_SSP_COUNT,
+	.ssp_base_offset = APL_SSP_BASE_OFFSET,
 };
 EXPORT_SYMBOL(apl_chip_info);
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 36ae9b88d0dc..3afd96d9c925 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -246,5 +246,7 @@ const struct sof_intel_dsp_desc cnl_chip_info = {
 	.ipc_ack_mask = CNL_DSP_REG_HIPCIDA_DONE,
 	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
 	.rom_init_timeout	= 300,
+	.ssp_count = CNL_SSP_COUNT,
+	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 };
 EXPORT_SYMBOL(cnl_chip_info);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index c4550f2e493d..b2cf6fa15575 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -345,6 +345,10 @@
 /* Host Device Memory Size of a Single SSP */
 #define SSP_DEV_MEM_SIZE	0x1000
 
+/* SSP Count of the Platform */
+#define APL_SSP_COUNT		6
+#define CNL_SSP_COUNT		3
+
 #define HDA_IDISP_CODEC(x) ((x) & BIT(2))
 
 struct sof_intel_dsp_bdl {
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 11fd77cb4e6d..f7a3f62e45d4 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -162,6 +162,8 @@ struct sof_intel_dsp_desc {
 	int ipc_ack_mask;
 	int ipc_ctl;
 	int rom_init_timeout;
+	int ssp_count;			/* ssp count of the platform */
+	int ssp_base_offset;		/* base address of the SSPs */
 };
 
 extern const struct snd_sof_dsp_ops sof_tng_ops;
-- 
2.17.1
