From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH v4] ASoC: samsung: i2s: Null pointer dereference on samsung_i2s_remove
Date: Tue, 15 Aug 2017 15:19:54 +0300
Message-ID: <1502799594-596-1-git-send-email-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
performs pri_dai->sec_dai dereference in any case.

The patch removes useless reinitialization of sec_dai at
samsung_i2s_remove(), because resources are under devm control.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
v2: Drop initialization of sec_dai by NULL at samsung_i2s_remove
as Sylwester Nawrocki suggest.
---
v3: Fix typo in the comment
---
v4: Change comment based on Krzysztof review.
---
 sound/soc/samsung/i2s.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index af3ba4d..6f896e3 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1376,13 +1376,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
-	struct i2s_dai *pri_dai, *sec_dai;
+	struct i2s_dai *pri_dai;
 
 	pri_dai = dev_get_drvdata(&pdev->dev);
-	sec_dai = pri_dai->sec_dai;
-
-	pri_dai->sec_dai = NULL;
-	sec_dai->pri_dai = NULL;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.7.4
