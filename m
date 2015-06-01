From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v7 3/4] ASoC: arizona: Add DVFS handling for sample rate control
Date: Mon,  1 Jun 2015 14:04:50 +0100
Message-ID: <1433163891-10084-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The WM8997 and WM5102 codecs need to boost DVFS for higher sample rates.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 69965ae..f4f3022 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1393,7 +1393,7 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	int base = dai->driver->base;
-	int i, sr_val;
+	int i, sr_val, ret;
 
 	/*
 	 * We will need to be more flexible than this in future,
@@ -1409,6 +1409,23 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	}
 	sr_val = i;
 
+	switch (priv->arizona->type) {
+	case WM5102:
+	case WM8997:
+		if (arizona_sr_vals[sr_val] >= 88200)
+			ret = arizona_dvfs_up(codec, ARIZONA_DVFS_SR1_RQ);
+		else
+			ret = arizona_dvfs_down(codec, ARIZONA_DVFS_SR1_RQ);
+
+		if (ret) {
+			arizona_aif_err(dai, "Failed to change DVFS %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		switch (priv->arizona->type) {
-- 
1.7.2.5
