From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] Sound: soc: samsung - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:34:19 +0530
Message-ID: <1485752659-30185-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130050433epcas3p158c643fc3cba0b3b616dc24a50e11bc0@epcas3p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: alsa-devel@alsa-project.org

of_device_get_match_data could return NULL, and so can cause
a NULL pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 sound/soc/samsung/i2s.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 7825bff..b5acce2 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1224,8 +1224,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	const struct samsung_i2s_dai_data *i2s_dai_data;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		i2s_dai_data = of_device_get_match_data(&pdev->dev);
+		if (!i2s_dai_data) {
+			dev_err(&pdev->dev, "no device match found\n");
+			return -ENODEV;
+		}
+	}
 	else
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
-- 
1.7.9.5
