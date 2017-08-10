From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] ASoC: samsung: i2s: Null pointer dereference on samsung_i2s_remove
Date: Thu, 10 Aug 2017 18:56:39 +0300
Message-ID: <1502380599-13535-1-git-send-email-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
permorms pri_dai->sec_dai dereference in any case.

The patch adds sec_dai check on Null before derefence at
samsung_i2s_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 sound/soc/samsung/i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index af3ba4d..6beeea8 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1382,7 +1382,8 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	sec_dai = pri_dai->sec_dai;
 
 	pri_dai->sec_dai = NULL;
-	sec_dai->pri_dai = NULL;
+	if (sec_dai)
+		sec_dai->pri_dai = NULL;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.7.4
