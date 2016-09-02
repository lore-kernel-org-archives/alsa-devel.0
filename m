From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: ux500: fix spelling mistake "Unsopported" -> "Unsupported"
Date: Fri,  2 Sep 2016 16:25:07 +0100
Message-ID: <20160902152507.31311-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Luis de Bethencourt <luis@debethencourt.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in dev_err messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/ux500/ux500_msp_dai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 6d5698b..b343efd 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -187,7 +187,7 @@ static int setup_clocking(struct snd_soc_dai *dai,
 
 	default:
 		dev_err(dai->dev,
-			"%s: Error: Unsopported inversion (fmt = 0x%x)!\n",
+			"%s: Error: Unsupported inversion (fmt = 0x%x)!\n",
 			__func__, fmt);
 
 		return -EINVAL;
@@ -218,7 +218,7 @@ static int setup_clocking(struct snd_soc_dai *dai,
 		break;
 
 	default:
-		dev_err(dai->dev, "%s: Error: Unsopported master (fmt = 0x%x)!\n",
+		dev_err(dai->dev, "%s: Error: Unsupported master (fmt = 0x%x)!\n",
 			__func__, fmt);
 
 		return -EINVAL;
@@ -374,7 +374,7 @@ static int setup_msp_config(struct snd_pcm_substream *substream,
 		break;
 
 	default:
-		dev_err(dai->dev, "%s: Error: Unsopported format (%d)!\n",
+		dev_err(dai->dev, "%s: Error: Unsupported format (%d)!\n",
 			__func__, fmt);
 		return -EINVAL;
 	}
-- 
2.9.3
