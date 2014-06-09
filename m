From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: arizona: Add DVFS handling for sample rate
	control
Date: Mon, 9 Jun 2014 16:03:56 +0100
Message-ID: <20140609150356.GD5229@opensource.wolfsonmicro.com>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140609150013.GA5229@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some codecs need to boost DVFS for higher sample rates.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1b14105..7e33d1b 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1135,7 +1135,7 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	int base = dai->driver->base;
-	int i, sr_val;
+	int i, sr_val, ret;
 
 	/*
 	 * We will need to be more flexible than this in future,
@@ -1151,6 +1151,26 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	}
 	sr_val = i;
 
+	switch (priv->arizona->type) {
+	case WM5102:
+	case WM8997:
+		if (arizona_sr_vals[sr_val] >= 88200)
+			ret = arizona_dvfs_up(priv->arizona,
+					      ARIZONA_DVFS_SR1_RQ);
+		else
+			ret = arizona_dvfs_down(priv->arizona,
+						ARIZONA_DVFS_SR1_RQ);
+
+		if (ret != 0) {
+			arizona_aif_err(dai, "Failed to change DVFS %d\n", ret);
+			return ret;
+		}
+		break;
+
+	default:
+		break;
+	}
+
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		snd_soc_update_bits(codec, ARIZONA_SAMPLE_RATE_1,
-- 
1.7.2.5
