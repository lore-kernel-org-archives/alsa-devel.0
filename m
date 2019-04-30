From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/19] ASoC: SOF: Intel: hda: set I2S slave
	before enabling DSP
Date: Tue, 30 Apr 2019 18:09:22 -0500
Message-ID: <20190430230934.4321-8-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7978FF8971A
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:00 +0200 (CEST)
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

By default, the I2S ports are configured in master mode during
DSP powerup sequences, the FS and BCLK lines will be driven on
startup, even when the topology file explicitly requires the
SSP to be slave.

This may be problematic for external components configured in
master mode who don't expect the Intel SOC/PCH to drive. Fix by
configuring the SSP as slave before the SSP outputs are enabled
to avoid this transient behavior.

When the topology file configures the SSP as clock master, the
initial slave configuration will be overridden.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 11 +++++++++++
 sound/soc/sof/intel/hda.h        |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 6a44bc349e44..6427f0b3a2f1 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -84,6 +84,7 @@ static int cl_dsp_init(struct snd_sof_dev *sdev, const void *fwdata,
 	const struct sof_intel_dsp_desc *chip = hda->desc;
 	unsigned int status;
 	int ret;
+	int i;
 
 	/* step 1: power up corex */
 	ret = hda_dsp_core_power_up(sdev, chip->cores_mask);
@@ -92,6 +93,16 @@ static int cl_dsp_init(struct snd_sof_dev *sdev, const void *fwdata,
 		goto err;
 	}
 
+	/* DSP is powered up, set all SSPs to slave mode */
+	for (i = 0; i < chip->ssp_count; i++) {
+		snd_sof_dsp_update_bits_unlocked(sdev, HDA_DSP_BAR,
+						 chip->ssp_base_offset
+						 + i * SSP_DEV_MEM_SIZE
+						 + SSP_SSC1_OFFSET,
+						 SSP_SET_SLAVE,
+						 SSP_SET_SLAVE);
+	}
+
 	/* step 2: purge FW request */
 	snd_sof_dsp_write(sdev, HDA_DSP_BAR, chip->ipc_req,
 			  chip->ipc_req_mask | (HDA_DSP_IPC_PURGE_FW |
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index b2cf6fa15575..3799a3518106 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -349,6 +349,12 @@
 #define APL_SSP_COUNT		6
 #define CNL_SSP_COUNT		3
 
+/* SSP Registers */
+#define SSP_SSC1_OFFSET		0x4
+#define SSP_SET_SCLK_SLAVE	BIT(25)
+#define SSP_SET_SFRM_SLAVE	BIT(24)
+#define SSP_SET_SLAVE		(SSP_SET_SCLK_SLAVE | SSP_SET_SFRM_SLAVE)
+
 #define HDA_IDISP_CODEC(x) ((x) & BIT(2))
 
 struct sof_intel_dsp_bdl {
-- 
2.17.1
