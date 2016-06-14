From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add support for PM ops in
	bxt-rt298" to the asoc tree
Date: Tue, 14 Jun 2016 16:08:55 +0100
Message-ID: <E1bCpxX-0001QR-QC@finisterre>
References: <1465820944-14774-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7158D26145E
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:12 +0200 (CEST)
In-Reply-To: <1465820944-14774-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add support for PM ops in bxt-rt298

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3513798ca4bceae7cb66a7f430160f60f788cede Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Jun 2016 17:59:04 +0530
Subject: [PATCH] ASoC: Intel: Add support for PM ops in bxt-rt298

We need card to be early suspended and late resumed, so use prepare and
complete for card suspend and resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 8b956500414b..2ef33b113bb5 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -454,10 +454,33 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
 }
 
+/*
+ * we want the card to be suspend first and then platform driver. This
+ * allows the DAPM to tear down pipelines on suspend and then platform shuts
+ * down the DSP. For this use .prepare for suspending card
+ *
+ * Similarly, use complete to let DSP download firmware first and then sync
+ * DAPM and restore pipelines to DSP
+ */
+static void broxton_rt298_complete(struct device *dev)
+{
+	snd_soc_resume(dev);
+}
+
+static const struct dev_pm_ops broxton_pm_ops = {
+	.prepare = snd_soc_suspend,
+	.complete = broxton_rt298_complete,
+	.freeze = snd_soc_suspend,
+	.thaw = snd_soc_resume,
+	.poweroff = snd_soc_poweroff,
+	.restore = snd_soc_resume,
+};
+
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
 		.name = "bxt_alc298s_i2s",
+		.pm = &broxton_pm_ops,
 	},
 };
 module_platform_driver(broxton_audio)
-- 
2.8.1
