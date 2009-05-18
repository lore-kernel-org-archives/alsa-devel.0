From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Add debug trace for bias level
	transitions
Date: Mon, 18 May 2009 16:05:58 +0100
Message-ID: <1242659158-1701-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C6A0103836
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:06:11 +0200 (CEST)
In-Reply-To: <1242659158-1701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A standard way of making sure we know when the bias level changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4ca5e56..39a63f9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -110,6 +110,24 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret = 0;
 
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		dev_dbg(socdev->dev, "Setting full bias\n");
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		dev_dbg(socdev->dev, "Setting bias prepare\n");
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		dev_dbg(socdev->dev, "Setting standby bias\n");
+		break;
+	case SND_SOC_BIAS_OFF:
+		dev_dbg(socdev->dev, "Setting bias off\n");
+		break;
+	default:
+		dev_err(socdev->dev, "Setting invalid bias %d\n", level);
+		return -EINVAL;
+	}
+
 	if (card->set_bias_level)
 		ret = card->set_bias_level(card, level);
 	if (ret == 0 && codec->set_bias_level)
-- 
1.6.3.1
