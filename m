From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 2/2] ASoC: max98357a: Remove use of DRV_NAME
Date: Tue, 17 Feb 2015 00:53:12 -0800
Message-ID: <1424163192-665-2-git-send-email-kwestfie@codeaurora.org>
References: <1424163192-665-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1424163192-665-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Remove use of DRV_NAME define.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
for fix/max98357a branch

changes from v2:
 - split patch into logical changes
 - rebased to new branch

changes from v1:
 - matched subject line to subsystem style

 sound/soc/codecs/max98357a.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index e9e6efbc21dd527299fb459ec01903fa8c24dae2..4ee23fbc4e1237268ae104319a9cfe4fc369934e 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -26,8 +26,6 @@
 #include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 
-#define DRV_NAME "max98357a"
-
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
@@ -87,9 +85,9 @@ static struct snd_soc_dai_ops max98357a_dai_ops = {
 };
 
 static struct snd_soc_dai_driver max98357a_dai_driver = {
-	.name = DRV_NAME,
+	.name = "max98357a",
 	.playback = {
-		.stream_name	= DRV_NAME "-playback",
+		.stream_name	= "max98357a-playback",
 		.formats	= SNDRV_PCM_FMTBIT_S16 |
 					SNDRV_PCM_FMTBIT_S24 |
 					SNDRV_PCM_FMTBIT_S32,
@@ -127,7 +125,7 @@ static int max98357a_platform_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id max98357a_device_id[] = {
-	{ .compatible = "maxim," DRV_NAME, },
+	{ .compatible = "maxim,max98357a" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, max98357a_device_id);
@@ -135,7 +133,7 @@ MODULE_DEVICE_TABLE(of, max98357a_device_id);
 
 static struct platform_driver max98357a_platform_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "max98357a",
 		.of_match_table = of_match_ptr(max98357a_device_id),
 	},
 	.probe	= max98357a_platform_probe,
@@ -145,4 +143,3 @@ module_platform_driver(max98357a_platform_driver);
 
 MODULE_DESCRIPTION("Maxim MAX98357A Codec Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
