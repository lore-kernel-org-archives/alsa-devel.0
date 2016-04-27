From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: arizona: call wm_adsp2_remove when codec driver is removed
Date: Wed, 27 Apr 2016 14:58:28 +0100
Message-ID: <1461765509-9431-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461765509-9431-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ensure that the wm_adsp driver cleans up when the codec driver
is removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 5 +++++
 sound/soc/codecs/wm5102.c  | 4 ++++
 sound/soc/codecs/wm5110.c  | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index e7c25d4..e34e9a6 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1274,10 +1274,15 @@ static int cs47l24_probe(struct platform_device *pdev)
 
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
index fcc460f..5891c34 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2098,10 +2098,14 @@ static int wm5102_probe(struct platform_device *pdev)
 
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
index ca42cfd..88fc924 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2437,10 +2437,16 @@ static int wm5110_probe(struct platform_device *pdev)
 
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
1.9.1
