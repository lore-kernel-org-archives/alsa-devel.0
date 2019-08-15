From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/4] ASoC: SOF: ipc: add ALH parameters
Date: Thu, 15 Aug 2019 10:50:30 -0500
Message-ID: <20190815155032.29181-3-pierre-louis.bossart@linux.intel.com>
References: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 591ADF80290
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 17:55:39 +0200 (CEST)
In-Reply-To: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The only configuration parameter is the ALH stream ID. No range
checking is done by the driver, the firmware should check that the
stream is valid for a specific hardware.

Bump the ABI Minor number to keep the alignment with SOF firmware

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-intel.h | 9 +++++++++
 include/sound/sof/dai.h       | 1 +
 include/uapi/sound/sof/abi.h  | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 1ab52fd63ceb..5f1ef5565be6 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -179,4 +179,13 @@ struct sof_ipc_dai_dmic_params {
 	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
 } __packed;
 
+/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
+struct sof_ipc_dai_alh_params {
+	struct sof_ipc_hdr hdr;
+	uint32_t stream_id;
+
+	/* reserved for future use */
+	uint32_t reserved[15];
+} __packed;
+
 #endif
diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 6b296df242bd..0f1235022146 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -72,6 +72,7 @@ struct sof_ipc_dai_config {
 		struct sof_ipc_dai_ssp_params ssp;
 		struct sof_ipc_dai_dmic_params dmic;
 		struct sof_ipc_dai_hda_params hda;
+		struct sof_ipc_dai_alh_params alh;
 	};
 } __packed;
 
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index dff70a42445a..a0fe0d4c4b66 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 9
+#define SOF_ABI_MINOR 10
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
-- 
2.20.1
