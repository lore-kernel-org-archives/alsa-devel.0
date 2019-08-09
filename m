From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Remove call to
	snd_sof_dsp_mailbox_init" to the asoc tree
Date: Fri,  9 Aug 2019 13:31:52 +0100 (BST)
Message-ID: <20190809123152.2DA1F27430D6@ypsilon.sirena.org.uk>
References: <20190807150203.26359-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A210CF805A9
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 14:31:54 +0200 (CEST)
In-Reply-To: <20190807150203.26359-2-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Remove call to snd_sof_dsp_mailbox_init

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

>From 0b76f512c206dd7c3f7761b24826887af80204c6 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 7 Aug 2019 10:01:58 -0500
Subject: [PATCH] ASoC: SOF: Remove call to snd_sof_dsp_mailbox_init

This is reserved for some historical reason, we didn't enable memory
windows for byt/bdw at the beginning, to make it compatible, we get
those mailbox offsets from fw_ready struct firstly, and then update them
if they existed in the following memory windows, to make sure the
mailbox still can be used if no memory windows are created.

With this change all platforms have the same implementation for
xxx_fw_ready function so that we can refactor it in a common file.

Suggested-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190807150203.26359-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/bdw.c | 5 -----
 sound/soc/sof/intel/byt.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 4bb9636da990..94be024a99eb 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -455,11 +455,6 @@ static int bdw_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
 	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
 		       sizeof(*fw_ready));
 
-	snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
-				 fw_ready->dspbox_size,
-				 fw_ready->hostbox_offset,
-				 fw_ready->hostbox_size);
-
 	/* make sure ABI version is compatible */
 	ret = snd_sof_ipc_valid(sdev);
 	if (ret < 0)
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 000d576f6a8d..cb8f02ee09f2 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -237,11 +237,6 @@ static int byt_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
 	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
 		       sizeof(*fw_ready));
 
-	snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
-				 fw_ready->dspbox_size,
-				 fw_ready->hostbox_offset,
-				 fw_ready->hostbox_size);
-
 	/* make sure ABI version is compatible */
 	ret = snd_sof_ipc_valid(sdev);
 	if (ret < 0)
-- 
2.20.1
