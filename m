From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Introduce
	snd_sof_dsp_get_mailbox_offset" to the asoc tree
Date: Fri,  9 Aug 2019 13:31:51 +0100 (BST)
Message-ID: <20190809123151.7BDB527430B7@ypsilon.sirena.org.uk>
References: <20190807150203.26359-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8E42F801A4
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 14:31:53 +0200 (CEST)
In-Reply-To: <20190807150203.26359-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: Introduce snd_sof_dsp_get_mailbox_offset

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

>From bb9c93f58cb66049cb5a5570cc476d9a8a97f491 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 7 Aug 2019 10:01:59 -0500
Subject: [PATCH] ASoC: SOF: Introduce snd_sof_dsp_get_mailbox_offset

This will allow us to export mailbox offset in order to
read the fw_ready message from.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190807150203.26359-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ops.h      | 9 +++++++++
 sound/soc/sof/sof-priv.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 793c1aea0c53..c820606f19a1 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -119,6 +119,15 @@ static inline int snd_sof_dsp_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return sdev->mmio_bar;
 }
 
+static inline int snd_sof_dsp_get_mailbox_offset(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->get_mailbox_offset)
+		return sof_ops(sdev)->get_mailbox_offset(sdev);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
 /* power management */
 static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 1cec3f23f9cd..3aefb8ec3ef9 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -198,6 +198,8 @@ struct snd_sof_dsp_ops {
 	/* misc */
 	int (*get_bar_index)(struct snd_sof_dev *sdev,
 			     u32 type); /* optional */
+	int (*get_mailbox_offset)(struct snd_sof_dev *sdev);/* mandatory for common loader code */
+
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
 	int num_drv;
-- 
2.20.1
