From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: cs53l30: Do not ignore errors if mclk is specified
Date: Thu, 28 Jul 2016 15:43:01 -0700
Message-ID: <1469745781-31057-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the clock is specified, there could be other errors besides
the EPROBE_DEFER so don't ignore them.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 2c0d9c4..227c556 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -999,8 +999,8 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 	/* Check if MCLK provided */
 	cs53l30->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(cs53l30->mclk)) {
-		if (PTR_ERR(cs53l30->mclk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		if (PTR_ERR(cs53l30->mclk) != -ENOENT) {
+			ret = PTR_ERR(cs53l30->mclk);
 			goto error;
 		}
 		/* Otherwise mark the mclk pointer to NULL */
-- 
2.1.4
