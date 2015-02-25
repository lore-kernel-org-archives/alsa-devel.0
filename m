From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch] ASoC: max98357a: Use standard DAI names
Date: Tue, 24 Feb 2015 22:39:04 -0800
Message-ID: <1424846344-23665-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Use the standard naming convention for the codec DAI.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---

based on next/topic/max98357a branch

 sound/soc/codecs/max98357a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 4ee23fbc4e1237268ae104319a9cfe4fc369934e..bf3e933ee895752352e90f610195f39fc6cc058f 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -85,9 +85,9 @@ static struct snd_soc_dai_ops max98357a_dai_ops = {
 };
 
 static struct snd_soc_dai_driver max98357a_dai_driver = {
-	.name = "max98357a",
+	.name = "HiFi",
 	.playback = {
-		.stream_name	= "max98357a-playback",
+		.stream_name	= "HiFi Playback",
 		.formats	= SNDRV_PCM_FMTBIT_S16 |
 					SNDRV_PCM_FMTBIT_S24 |
 					SNDRV_PCM_FMTBIT_S32,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
