From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: implement runtime idle for
	CNL/APL" to the asoc tree
Date: Sat,  6 Jul 2019 12:24:57 +0100 (BST)
Message-ID: <20190706112457.278882743807@ypsilon.sirena.org.uk>
References: <20190702132428.13129-4-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99643F8013F
 for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2019 13:25:01 +0200 (CEST)
In-Reply-To: <20190702132428.13129-4-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: implement runtime idle for CNL/APL

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

>From 87a6fe80d56be85bda093c4dd8a3e6535bda7e4a Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Tue, 2 Jul 2019 16:24:28 +0300
Subject: [PATCH] ASoC: SOF: Intel: implement runtime idle for CNL/APL

Implement runtime idle for CNL/APL devices using similar runtime
PM idle logic as the Intel AZX HDA driver. If any HDA codecs are
powered when runtime suspend request comes, return -EBUSY. By doing
this, strict ordering is enforced between HDA codec and the HDA
controller.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20190702132428.13129-4-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/apl.c     |  1 +
 sound/soc/sof/intel/cnl.c     |  1 +
 sound/soc/sof/intel/hda-dsp.c | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 43d1c9f31ec4..fd2e26d79796 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -93,6 +93,7 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.resume			= hda_dsp_resume,
 	.runtime_suspend	= hda_dsp_runtime_suspend,
 	.runtime_resume		= hda_dsp_runtime_resume,
+	.runtime_idle		= hda_dsp_runtime_idle,
 	.set_hw_params_upon_resume = hda_dsp_set_hw_params_upon_resume,
 };
 EXPORT_SYMBOL(sof_apl_ops);
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 3840f81767fa..f2b392998f20 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -251,6 +251,7 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 	.resume			= hda_dsp_resume,
 	.runtime_suspend	= hda_dsp_runtime_suspend,
 	.runtime_resume		= hda_dsp_runtime_resume,
+	.runtime_idle		= hda_dsp_runtime_idle,
 	.set_hw_params_upon_resume = hda_dsp_set_hw_params_upon_resume,
 };
 EXPORT_SYMBOL(sof_cnl_ops);
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index f2c5a12db930..91de4785b6a3 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -418,6 +418,19 @@ int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 	return hda_resume(sdev);
 }
 
+int hda_dsp_runtime_idle(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *hbus = sof_to_bus(sdev);
+
+	if (hbus->codec_powered) {
+		dev_dbg(sdev->dev, "some codecs still powered (%08X), not idle\n",
+			(unsigned int)hbus->codec_powered);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev, int state)
 {
 	/* stop hda controller and power dsp off */
-- 
2.20.1
