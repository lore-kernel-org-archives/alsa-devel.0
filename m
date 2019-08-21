From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 1/5] ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
Date: Wed, 21 Aug 2019 15:17:16 -0500
Message-ID: <20190821201720.17768-2-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Janusz Jankowski <janusz.jankowski@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

ALH was inserted in the wrong place during integration, add after DMIC
to mirror the file used by SOF firmware.

No functional change, just text move in the same file to better track
changes, if any.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai-intel.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index 5f1ef5565be6..04e48227f542 100644
--- a/include/sound/sof/dai-intel.h
+++ b/include/sound/sof/dai-intel.h
@@ -87,6 +87,15 @@ struct sof_ipc_dai_hda_params {
 	uint32_t link_dma_ch;
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
 /* DMIC Configuration Request - SOF_IPC_DAI_DMIC_CONFIG */
 
 /* This struct is defined per 2ch PDM controller available in the platform.
@@ -179,13 +188,4 @@ struct sof_ipc_dai_dmic_params {
 	struct sof_ipc_dai_dmic_pdm_ctrl pdm[0];
 } __packed;
 
-/* ALH Configuration Request - SOF_IPC_DAI_ALH_CONFIG */
-struct sof_ipc_dai_alh_params {
-	struct sof_ipc_hdr hdr;
-	uint32_t stream_id;
-
-	/* reserved for future use */
-	uint32_t reserved[15];
-} __packed;
-
 #endif
-- 
2.20.1
