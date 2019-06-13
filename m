From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: uapi: align comments with firmware
	files" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:07 +0100 (BST)
Message-ID: <20190613190607.A5CF7440046@finisterre.sirena.org.uk>
References: <20190612165705.1858-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57C8AF8975D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:08 +0200 (CEST)
In-Reply-To: <20190612165705.1858-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: uapi: align comments with firmware files

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b943f798011346589bd9ae994e5755e776756a31 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 12 Jun 2019 11:57:02 -0500
Subject: [PATCH] ASoC: SOF: uapi: align comments with firmware files

No functional change, just mirror firmware comment changes

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/topology.h | 4 ++--
 include/sound/sof/trace.h    | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 4978999fd362..41dcabf89899 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -84,9 +84,9 @@ struct sof_ipc_buffer {
 struct sof_ipc_comp_config {
 	struct sof_ipc_cmd_hdr hdr;
 	uint32_t periods_sink;	/**< 0 means variable */
-	uint32_t periods_source;	/**< 0 means variable */
+	uint32_t periods_source;/**< 0 means variable */
 	uint32_t reserved1;	/**< reserved */
-	uint32_t frame_fmt;		/**< SOF_IPC_FRAME_ */
+	uint32_t frame_fmt;	/**< SOF_IPC_FRAME_ */
 	uint32_t xrun_action;
 
 	/* reserved for future use */
diff --git a/include/sound/sof/trace.h b/include/sound/sof/trace.h
index 2187ff7d07ce..9257d5473d97 100644
--- a/include/sound/sof/trace.h
+++ b/include/sound/sof/trace.h
@@ -66,7 +66,9 @@ struct sof_ipc_dma_trace_posn {
 #define SOF_IPC_PANIC_WFI			(SOF_IPC_PANIC_MAGIC | 0xa)
 #define SOF_IPC_PANIC_ASSERT			(SOF_IPC_PANIC_MAGIC | 0xb)
 
-/* panic info include filename and line number */
+/* panic info include filename and line number
+ * filename array will not include null terminator if fully filled
+ */
 struct sof_ipc_panic_info {
 	struct sof_ipc_hdr hdr;
 	uint32_t code;			/* SOF_IPC_PANIC_ */
-- 
2.20.1
