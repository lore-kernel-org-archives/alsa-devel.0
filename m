From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v8 3/4] ASoC: arizona: Add DVFS handling for
	sample rate control
Date: Tue,  2 Jun 2015 11:53:35 +0100
Message-ID: <1433242416-14958-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29A962617A5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:55:42 +0200 (CEST)
In-Reply-To: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The WM8997 and WM5102 codecs need to boost DVFS for higher sample rates.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index b2d8b04..5939ce4 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1394,7 +1394,7 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
 	int base = dai->driver->base;
-	int i, sr_val;
+	int i, sr_val, ret;
 
 	/*
 	 * We will need to be more flexible than this in future,
@@ -1410,6 +1410,23 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
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
