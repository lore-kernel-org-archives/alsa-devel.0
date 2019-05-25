From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: cx2072x: fix spelling mistake "configued" -> "configured"
Date: Sat, 25 May 2019 21:32:44 +0100
Message-ID: <20190525203244.7829-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fit it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index e8e6fd2e97b6..f25376789c5c 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -933,7 +933,7 @@ static int cx2072x_hw_params(struct snd_pcm_substream *substream,
 		return frame_size;
 
 	if (cx2072x->mclk_rate == 0) {
-		dev_err(dev, "Master clock rate is not configued\n");
+		dev_err(dev, "Master clock rate is not configured\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1
