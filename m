From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Add support for PM ops in
	bxt-rt298
Date: Mon, 13 Jun 2016 17:59:04 +0530
Message-ID: <1465820944-14774-8-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F225C2654ED
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:44 +0200 (CEST)
In-Reply-To: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

We need card to be early suspended and late resumed, so use prepare and
complete for card suspend and resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
1.9.1
