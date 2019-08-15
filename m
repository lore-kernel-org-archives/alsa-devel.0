From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: ipc: add ALH parameters" to the
	asoc tree
Date: Thu, 15 Aug 2019 18:14:21 +0100 (BST)
Message-ID: <20190815171421.9C3B12742BE9@ypsilon.sirena.org.uk>
References: <20190815155032.29181-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com
 [209.85.208.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 465D0F8049A
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 19:14:23 +0200 (CEST)
Received: by mail-ed1-f97.google.com with SMTP id z51so2672850edz.13
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 10:14:23 -0700 (PDT)
In-Reply-To: <20190815155032.29181-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: ipc: add ALH parameters

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3a9477a06c6acb4234407b59999835a6f12f889d Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 15 Aug 2019 10:50:30 -0500
Subject: [PATCH] ASoC: SOF: ipc: add ALH parameters

The only configuration parameter is the ALH stream ID. No range
checking is done by the driver, the firmware should check that the
stream is valid for a specific hardware.

Bump the ABI Minor number to keep the alignment with SOF firmware

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190815155032.29181-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/dai-intel.h | 9 +++++++++
 include/sound/sof/dai.h       | 1 +
 include/uapi/sound/sof/abi.h  | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai-intel.h b/include/sound/sof/dai-intel.h
index a81afd3fbd41..b03e2ec08694 100644
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
index 3d174e20aa53..da9825ad41d4 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -70,6 +70,7 @@ struct sof_ipc_dai_config {
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
