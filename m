From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Add support for PM ops in
	bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 10:03:30 +0530
Message-ID: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8403F2605E1
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 06:27:10 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

We need card to be early suspended and late resumed, so use
prepare and complete for card suspend and resume.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3774b117d365..df5f269a9b67 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -441,11 +441,30 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static void broxton_complete(struct device *dev)
+{
+	snd_soc_resume(dev);
+}
+
+#else
+#define broxton_complete NULL
+#endif
+
+static const struct dev_pm_ops broxton_pm_ops = {
+	.prepare = snd_soc_suspend,
+	.complete = broxton_complete,
+	.freeze = snd_soc_suspend,
+	.thaw = snd_soc_resume,
+	.poweroff = snd_soc_poweroff,
+	.restore = snd_soc_resume,
+};
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
 		.name = "bxt_da7219_max98357a_i2s",
-		.pm = &snd_soc_pm_ops,
+		.pm = &broxton_pm_ops,
 	},
 };
 module_platform_driver(broxton_audio)
-- 
1.9.1
