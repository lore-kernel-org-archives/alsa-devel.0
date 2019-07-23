From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Introduce
	snd_sof_dsp_get_bar_index ops" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:14 +0100 (BST)
Message-ID: <20190723112914.335DB2742BAC@ypsilon.sirena.org.uk>
References: <20190722141402.7194-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEC82F8049C
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:15 +0200 (CEST)
In-Reply-To: <20190722141402.7194-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Introduce snd_sof_dsp_get_bar_index ops

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

>From ce8234a6357ec8f81b977d8536ff941dbd4162f3 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Mon, 22 Jul 2019 09:13:47 -0500
Subject: [PATCH] ASoC: SOF: Introduce snd_sof_dsp_get_bar_index ops

FW encapsulates information about section types (e.g DRAM, IRAM)
inside module block header. This information can be used in order
to correctly load the section to the appropriate place in memory.

SOF Linux driver needs to know for each platform how to map the
section type with the corresponding memory BAR. So, this patch
introduces get_bar_index, a new operation inside snd_sof_dsp_ops.

Intel platforms, usually load all the section in a contiguous memory
area (usually denoted by sdev->mmio_bar) so things are relatively
simple there. Anyhow, on i.MX8 IRAM and DRAM for example are mapped
to distinct BARs.

By default, if no get_bar function is provided the core implementation
will always return sdev->mmio_bar so that there will be no need for
a change to existing Intel code.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-7-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ops.h      | 19 +++++++++++++++++++
 sound/soc/sof/sof-priv.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index b1c27615b805..8fda42748f39 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -100,6 +100,25 @@ static inline int snd_sof_dsp_post_fw_run(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+/* misc */
+
+/**
+ * snd_sof_dsp_get_bar_index - Maps a section type with a BAR index
+ *
+ * @sdev: sof device
+ * @type: section type as described by snd_sof_fw_blk_type
+ *
+ * Returns the corresponding BAR index (a positive integer) or -EINVAL
+ * in case there is no mapping
+ */
+static inline int snd_sof_dsp_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+{
+	if (sof_ops(sdev)->get_bar_index)
+		return sof_ops(sdev)->get_bar_index(sdev, type);
+
+	return sdev->mmio_bar;
+}
+
 /* power management */
 static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index fa5cb7d2a660..a6ec9115a9fb 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -196,6 +196,9 @@ struct snd_sof_dsp_ops {
 	int (*trace_trigger)(struct snd_sof_dev *sdev,
 			     int cmd); /* optional */
 
+	/* misc */
+	int (*get_bar_index)(struct snd_sof_dev *sdev,
+			     u32 type); /* optional */
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
 	int num_drv;
-- 
2.20.1
