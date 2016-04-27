From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: call wm_adsp2_remove when codec driver is removed" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:57 +0100
Message-ID: <E1avSQT-0004OJ-FA@debutante>
References: <1461765509-9431-2-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765509-9431-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: call wm_adsp2_remove when codec driver is removed

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

>From 401cf1466a59139ec1805e2171d43a32be92f89c Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 27 Apr 2016 14:58:28 +0100
Subject: [PATCH] ASoC: arizona: call wm_adsp2_remove when codec driver is
 removed

Ensure that the wm_adsp driver cleans up when the codec driver
is removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 5 +++++
 sound/soc/codecs/wm5102.c  | 4 ++++
 sound/soc/codecs/wm5110.c  | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 576087bda330..29313780a38a 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1238,10 +1238,15 @@ static int cs47l24_probe(struct platform_device *pdev)
 
 static int cs47l24_remove(struct platform_device *pdev)
 {
+	struct cs47l24_priv *cs47l24 = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	wm_adsp2_remove(&cs47l24->core.adsp[1]);
+	wm_adsp2_remove(&cs47l24->core.adsp[2]);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a8b3e3f701f9..7a539e0529c0 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2093,10 +2093,14 @@ static int wm5102_probe(struct platform_device *pdev)
 
 static int wm5102_remove(struct platform_device *pdev)
 {
+	struct wm5102_priv *wm5102 = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	wm_adsp2_remove(&wm5102->core.adsp[0]);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 83ba70fe16e6..dd87af1ffa23 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2435,10 +2435,16 @@ static int wm5110_probe(struct platform_device *pdev)
 
 static int wm5110_remove(struct platform_device *pdev)
 {
+	struct wm5110_priv *wm5110 = platform_get_drvdata(pdev);
+	int i;
+
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	for (i = 0; i < WM5110_NUM_ADSP; i++)
+		wm_adsp2_remove(&wm5110->core.adsp[i]);
+
 	return 0;
 }
 
-- 
2.8.0.rc3
